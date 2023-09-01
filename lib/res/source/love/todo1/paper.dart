part of todo1;

///
/// this file contains:
///
/// widget:
/// [PenPesPractice]
/// [PenPaperView]
/// [PenPaper]
///
/// class, enum:
/// [PaperState]
/// [Paper]
///
///
///


class PenPesPractice extends StatefulWidget {
  const PenPesPractice({Key? key}) : super(key: key);

  @override
  State<PenPesPractice> createState() => _PenPesPracticeState();
}

class _PenPesPracticeState extends State<PenPesPractice> {
  final Map<int, GlobalKey> _itemMap = <int, GlobalKey>{};
  late Paper? _paper;

  @override
  void initState() {
    for (var i = 0; i < 20; i++) {
      _itemMap.putIfAbsent(i, () => GlobalKey());
    }
    _paper = null;

    super.initState();
  }

  void _itemOnTap(int index, GlobalKey key) {
    final renderBox = key.currentContext!.renderBox;
    _paper = Paper(
      itemZeroOffset: renderBox.localToGlobal(Offset.zero),
      itemSize: renderBox.size,
      itemIndex: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PenPaper(
      pesItem: _paper,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: KEdgeInsets.all_32,
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => Material(
                key: _itemMap[index],
                child: InkWell(
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: KEdgeInsets.all_20,
                    decoration: KBoxDecoration.blueGrey,
                  ),
                  onTap: () => setState(
                        () => _itemOnTap(
                      index,
                      _itemMap[index]!,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// penetration paper view
class PenPaperView extends StatefulWidget {
  const PenPaperView({Key? key}) : super(key: key);

  @override
  State<PenPaperView> createState() => _PenPaperViewState();
}

class _PenPaperViewState extends State<PenPaperView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return Text('wow $index');
        },
      ),
    );
  }
}

// penetration paper
class PenPaper extends StatefulWidget {
  const PenPaper({
    Key? key,
    required this.child,
    required this.pesItem,
  }) : super(key: key);
  final Widget child;
  final Paper? pesItem;

  @override
  State<PenPaper> createState() => _PenPaperState();
}

class _PenPaperState extends State<PenPaper>
    with SingleTickerProviderStateMixin {
  final GlobalKey _stickyKey = GlobalKey();
  final GlobalKey _itemKey = GlobalKey();
  late final double _windowWidth;
  late final double _windowHeight;
  late final Offset _maxWindowOffset;
  late final AnimationController _controller;
  late final Animation _animation;

  late Paper? _item;
  late double _itemWidth;
  late double _itemHeight;
  late Offset _itemCornerAOffset;
  late Offset _itemCornerBOffset;
  late Offset _itemCenterOffset;
  late PaperState _pesState;
  late bool _expandOver;
  late double _fraction;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: KDuration.milli300,
    );
    _maxWindowOffset = vDevice.windowSize.toOffset;
    _windowWidth = _maxWindowOffset.dx;
    _windowHeight = _maxWindowOffset.dy;
    _animation = VTweenDouble.double_0_1
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease))
      ..addListener(() => setState(() => _fraction = _animation.value));

    _item = null;
    _pesState = PaperState.positioned;
    _expandOver = false;
    _fraction = 0.0;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PenPaper oldWidget) {
    _pesState = PaperState.positioned;
    if (widget.pesItem != null) {
      _item = widget.pesItem!;
      final size = _item!.itemSize;
      _itemWidth = size.width;
      _itemHeight = size.height;

      _itemCornerAOffset = _item!.itemZeroOffset;
      _itemCornerBOffset = size
          .diagonalPosition(_itemCornerAOffset)
          .adjustScaffold(_stickyKey);
      _itemCenterOffset =
          size.center(_itemCornerAOffset).adjustScaffold(_stickyKey);
      _controller.forward();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// TODO: separate [_penetration], [_paper],
  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _stickyKey,
      children: [
        widget.child,
        _penetration,
        _paper,
      ],
    );
  }

  Widget get _penetration => widget.pesItem != null
      ? GestureDetector(
    child: ClipPath(
      // clipper: Clipper(
      //   cornerA: _itemCenterOffset * (1 - _fraction),
      //   cornerB: _itemCenterOffset +
      //       (_maxWindowOffset - _itemCenterOffset) * _fraction,
      // ),
      child: Container(color: const Color.fromRGBO(0, 0, 0, 0.6)),
    ),
    onTap: () => setState(() {
      _controller.reverse();
      _pesState = PaperState.shrink;
    }),
  )
      : Container();

// TODO: replace (width, height) with (right, bottom)
  Widget get _paper => AnimatedPositioned(
    curve: Curves.easeInQuart,
    left: _paperPosition('left'),
    top: _paperPosition('top'),
    width: _paperPosition('width'),
    height: _paperPosition('height'),
    duration: _positionedDuration(_pesState),
    child: IgnorePointer(
      ignoring: _pesState == PaperState.positioned,
      child: AnimatedOpacity(
        curve: Curves.easeOut,
        opacity: _pesState == PaperState.expand ? 1.0 : 0.0,
        duration: KDuration.milli700,
        child: Material(
          borderRadius: KBorderRadius.allCircular_10,
          child: InkWell(
            key: _itemKey,
            child: Card(
              borderOnForeground: false,
              elevation: 50.0,
              child: AnimatedOpacity(
                curve: Curves.easeOut,
                opacity: _expandOver ? 1.0 : 0.0,
                duration: KDuration.milli500,
                child: const PenPaperView(),
              ),
            ),
          ),
        ),
      ),
    ),
    onEnd: () {
      switch (_pesState) {
        case PaperState.positioned:
          setState(() => _pesState = PaperState.expand);
          break;
        case PaperState.expand:
          setState(() => _expandOver = true);
          break;
        case PaperState.shrink:
          setState(() => _pesState = PaperState.inPool);
          break;
        case PaperState.inPool:
          setState(() => _expandOver = false);
          break;
      }
    },
  );

  double _paperPosition(String what) {
    if (widget.pesItem != null) {
      switch (_pesState) {
        case PaperState.positioned:
        case PaperState.shrink:
          switch (what) {
            case 'left':
              return _itemCornerAOffset.dx;

            case 'top':
              return _itemCornerAOffset.dy;

            case 'width':
              return _itemWidth;

            case 'height':
              return _itemHeight;
          }
          break;
        case PaperState.expand:
          switch (what) {
            case 'left':
              return (_windowWidth - _itemWidth) / 4;

            case 'top':
              return _windowHeight * 1 / 32;

          // (_windowWidth/2 - (_windowWidth - item.itemLeft)/4) * 2;
            case 'width':
              return _windowWidth - (_windowWidth - _itemWidth) / 2;

            case 'height':
              return _windowHeight * 15 / 16;
          }
          break;
        case PaperState.inPool:
          return 0.0;
      }
      throw UnimplementedError(what);
    } else {
      return 0.0;
    }
  }

  Duration _positionedDuration(PaperState state) {
    switch (state) {
      case PaperState.positioned:
        return const Duration(microseconds: 10);
      case PaperState.expand:
        return const Duration(milliseconds: 500);
      case PaperState.shrink:
        return const Duration(milliseconds: 500);
      case PaperState.inPool:
        return const Duration(microseconds: 10);
    }
  }
}


// paper
enum PaperState {
  inPool,
  positioned,
  expand,
  shrink,
  // TODO: writable
}

// paper
class Paper {
  final Offset itemZeroOffset;
  final Size itemSize;
  final int itemIndex;

  const Paper({
    required this.itemZeroOffset,
    required this.itemSize,
    required this.itemIndex,
  });
}