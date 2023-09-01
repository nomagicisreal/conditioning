part of todo1;

class SearchingBar extends StatefulWidget {
  const SearchingBar({
    Key? key,
    required this.backgroundColor,
    required this.child,
  }) : super(key: key);
  final Color backgroundColor;
  final Widget child;

  @override
  State<SearchingBar> createState() => _SearchingBarState();
}

class _SearchingBarState extends State<SearchingBar>
    with SingleTickerProviderStateMixin {
  final FocusNode _searchingFocusNode = FocusNode();
  late final double _searchingBarHeight;
  late final double _searchingBarTopPadding;
  late final Color _searchingColor;
  late final Color _pageColor;
  late final Color _backgroundColor;
  late final Offset _maxWindowOffset;
  late bool _isExpand;

  @override
  void initState() {
    _maxWindowOffset = vDevice.windowSize.toOffset;
    _isExpand = false;
    _backgroundColor = widget.backgroundColor;
    _pageColor = _backgroundColor.plusAllRGB(30);
    _searchingColor = _backgroundColor.plusAllRGB(50);

    final appBarHeight = AppBar().preferredSize.height;
    _searchingBarHeight = appBarHeight * 4 / 5;
    _searchingBarTopPadding = appBarHeight / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: Size.fromHeight(_searchingBarHeight),
        child: Stack(
          children: [
            widget.child,
            AnimatedPositioned(
              curve: Curves.fastLinearToSlowEaseIn,
              top: _isExpand ? 0.0 : _searchingBarTopPadding,
              left: _isExpand ? 0.0 : _maxWindowOffset.dx / 6,
              right: _isExpand
                  ? _maxWindowOffset.dx
                  : _maxWindowOffset.dx * 1 / 24,
              height: _isExpand ? _maxWindowOffset.dy : _searchingBarHeight,
              duration: KDuration.milli500,
              child: Container(
                decoration: VBoxDecorationStyled.style1Of(
                  context: context,
                  color: _backgroundColor,
                ),
                child: _searchingPage(),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.fastLinearToSlowEaseIn,
              top: _searchingBarTopPadding,
              left: _isExpand
                  ? _maxWindowOffset.dx / 10
                  : _maxWindowOffset.dx / 6,
              right: _maxWindowOffset.dx / 10,
              height: _searchingBarHeight,
              duration: KDuration.milli300,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: KBorderRadius.allCircular_10,
                  color: _searchingColor,
                ),
                child: Focus(
                  child: SizedBox(
                    width: 50,
                    child: Padding(
                      padding: KEdgeInsets.onlyLeft_8,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "search",
                          icon: InkWell(
                            child: AnimatedOpacity(
                              opacity: _isExpand ? 1.0 : 0.0,
                              duration: KDuration.milli300,
                              child: KIcon.arrowLeftward,
                            ),
                            onTap: () => setState(() {
                              if (_isExpand) {
                                _isExpand = false;
                                _searchingFocusNode.unfocus();
                              }

                              // TODO
                              _pageColor = _pageColor;
                            }),
                          ),
                        ),
                        focusNode: _searchingFocusNode,
                      ),
                    ),
                  ),
                  onFocusChange: (hasFocus) {
                    if (hasFocus && !_isExpand) {
                      setState(() => _isExpand = true);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchingPage() => Container(
        padding: KEdgeInsets.symH_10,
        decoration: KBoxDecorationBorderRadius.circularAll_10,
        child: AnimatedOpacity(
          opacity: _isExpand ? 1.0 : 0.0,
          duration: KDuration.milli300,
          child: Container(decoration: KBoxDecorationStyled.borderBottom),
        ),
      );
}
