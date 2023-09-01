part of todo1;

///
/// this file contains:
/// [Penetration]
/// [PenetrationType]
/// [PenetrationClip]
///
///

class Penetration extends StatefulWidget {
  const Penetration({Key? key}) : super(key: key);

  @override
  State<Penetration> createState() => _PenetrationState();
}

class _PenetrationState extends State<Penetration> {
  bool _enableSpotlight = false;
  Offset _spotlightCenter = Offset.zero;
  double _spotlightRadius = 0.0;

  final GlobalKey _button1Key = GlobalKey();
  final GlobalKey _button2Key = GlobalKey();
  final GlobalKey _button3Key = GlobalKey();

  void _requireSpotlight(GlobalKey key) {
    if (_enableSpotlight) {
      _enableSpotlight = false;
    } else {
      final renderBox = key.currentContext!.renderBox;
      final size = renderBox.size;
      _spotlightCenter = size.center(renderBox.localToGlobal(Offset.zero));
      _spotlightRadius = size.height >= size.width ? size.height : size.width;
      _enableSpotlight = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PenetrationClip(
      enabled: _enableSpotlight,
      center: _spotlightCenter,
      radius: _spotlightRadius,
      unFocusedAreaOnTap: () =>
          context.showSnackbarWithMessage(message: 'spotlight circle'),
      child: Scaffold(
        appBar: AppBar(),
        drawer: KDrawer.none,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  key: _button1Key,
                  onPressed: () =>
                      setState(() => _requireSpotlight(_button1Key)),
                  icon: KIcon.email,
                ),
                IconButton(
                  key: _button2Key,
                  onPressed: () =>
                      setState(() => _requireSpotlight(_button2Key)),
                  icon: KIcon.password,
                ),
                IconButton(
                  key: _button3Key,
                  onPressed: () =>
                      setState(() => _requireSpotlight(_button3Key)),
                  icon: KIcon.accountBox,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              // _spotlight = !_spotlight;
            });
          },
          child: KIcon.add,
        ),
      ),
    );
  }
}

enum PenetrationType {
  penetration,
  spotlight,
}

class PenetrationClip extends StatefulWidget {
  // final PenetrationType type;

  /// circle
  final Offset center;
  final double radius;

  /// rect
  // final Offset cornerA;
  // final Offset cornerB;

  final Widget child;
  final bool enabled;
  final Widget? descriptionWidget;
  final Color? unFocusedColor;
  final GestureTapCallback? unFocusedAreaOnTap;

  const PenetrationClip({
    Key? key,
    required this.child,
    required this.enabled,
    required this.center,
    required this.radius,
    // required this.cornerA,
    // required this.cornerB,
    this.descriptionWidget,
    this.unFocusedColor,
    this.unFocusedAreaOnTap,
  }) : super(key: key);

  @override
  PenetrationClipState createState() => PenetrationClipState();
}

class PenetrationClipState extends State<PenetrationClip>
    with SingleTickerProviderStateMixin {
  GlobalKey stickyKey = GlobalKey();
  late AnimationController _controller;
  late Animation _animation;
  late Tween _tween;
  late double _fraction;
  late Offset _center;
  late Offset _maxWindowOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: KDuration.second1);
    _fraction = 0.0;
    _animation = VTweenDouble.double_0_1
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease))
      ..addListener(() => setState(() => _fraction = _animation.value));

    _maxWindowOffset = vDevice.windowSize.toOffset;

    _center = Offset.zero;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PenetrationClip oldWidget) {
    // _center = ((widget.cornerA + widget.cornerB) / 2).adjustScaffold(stickyKey);

    if (widget.enabled) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: stickyKey,
      children: widget.enabled
          ? <Widget>[
              widget.child,
              GestureDetector(
                child: ClipPath(
                  // clipper: RectangleClipper(
                  //   cornerA: _center * (1-_fraction),
                  // cornerB: (_center * (1 - _fraction)) + (_maxWindowOffset * _fraction),
                  // cornerB: _center + (_maxWindowOffset - _center) * _fraction,
                  // ),
                  child: Stack(
                    children: [
                      Container(
                        color: widget.unFocusedColor ?? KColor.blackO_06,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if (widget.unFocusedAreaOnTap != null) {
                    widget.unFocusedAreaOnTap!();
                  }
                },
              ),
            ]
          : <Widget>[widget.child],
    );
  }

// final GlobalKey _stickyKey = GlobalKey();
// late AnimationController _controller;
// late Animation _animation;
// double _fraction = 0.0;
//
// @override
// void initState() {
//   super.initState();
//   _controller = AnimationController(
//     duration: const Duration(seconds: 1),
//     vsync: this,
//   );
//   _fraction = 0.0;
//   _animation = Tween(begin: 0.0, end: 1.0)
//       .animate(CurvedAnimation(parent: _controller, curve: Curves.ease))
//     ..addListener(() {
//       setState(() {
//         _fraction = _animation.value;
//       });
//     })
//     ..addStatusListener((status) {
//     });
// }
//
// @override
// void dispose() {
//   _controller.dispose();
//   super.dispose();
// }
//
// @override
// void didUpdateWidget(SpotlightClipper oldWidget) {
//   if (widget.enabled) {
//     _controller.forward();
//   } else {
//     _controller.reverse();
//   }
//   super.didUpdateWidget(oldWidget);
// }
//
// @override
// Widget build(BuildContext context) {
//   return Stack(
//     key: _stickyKey,
//     children: _fraction > 0.1
//         ? <Widget>[
//       widget.child,
//       GestureDetector(
//         child: ClipPath(
//           clipper: InvertedCircleClipper(
//             center: widget.center.adjustScaffold(_stickyKey),
//             radius: widget.radius * (1.0 / _fraction),
//           ),
//           child: Container(
//             color: widget.unFocusedColor ??
//                 const Color.fromRGBO(0, 0, 0, 0.6),
//           ),
//         ),
//         onTap: () {
//           if (widget.unFocusedAreaOnTap != null) {
//             widget.unFocusedAreaOnTap!();
//           }
//         },
//       ),
//     ]
//         : <Widget>[widget.child],
//   );
// }
}
