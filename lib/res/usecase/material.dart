import 'dart:async';

// import 'package:flutter_tex/flutter_tex.dart';
import 'package:conditioning/res/source/source.dart';
import 'package:flutter/material.dart';

///
/// this file contains:
///
/// custom widgets:
/// [CustomFabExpandable]
/// [CustomFabExpandableHorizontal] TODO: migrate into a [CustomFabExpandableHorizontal]
///
/// [CustomLaTex]
/// [CustomColumn]
/// [CustomOverlay]
/// [CustomValueBuilderWidget], [CustomStreamBuilderWidget]
///
/// [CustomAnimatedContainer], [CustomAnimatedSwitcher]
/// [CustomAnimatedListController]
/// [CustomAnimatedPositioned], [CustomAnimatedPositionedStack]
/// [CustomFormField]
///
///
/// original widgets
/// [PesPen], [NavigationSudoku], [LeaderShip], [Preference],
///
/// sample widgets:
/// [SampleCircleRotateFlipper], [SampleCircleColorFilter]
///
///
///
///
///
///
///

class CustomFabExpandable extends StatefulWidget {
  const CustomFabExpandable({
    super.key,
    required this.openIcon,
    required this.childrenIcons,
    this.childrenIconsStackAlignment = Alignment.bottomRight,
    this.iconSize = const Coordinate.ofXY(56.0, 56.0),
    this.closeIcon = Icons.close,
    this.maxDistance,
  });

  static final CustomFabExpandable template = CustomFabExpandable(
    openIcon: Icons.add,
    childrenIcons: <IconData, VoidCallback>{
      Icons.baby_changing_station: kVoidCallback,
      Icons.check: kVoidCallback,
      Icons.oil_barrel: kVoidCallback,
    },
  );

  final Coordinate iconSize;
  final IconData openIcon;
  final Map<IconData, VoidCallback> childrenIcons;
  final Alignment childrenIconsStackAlignment;
  final IconData closeIcon;
  final double? maxDistance;

  @override
  State<CustomFabExpandable> createState() => _CustomFabExpandableState();
}

class _CustomFabExpandableState extends State<CustomFabExpandable>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;
  bool _shouldAnimate = false;

  @override
  Widget build(BuildContext context) {
    final alignment = widget.childrenIconsStackAlignment;
    final iconSize = widget.iconSize;

    return SizedBox.expand(
      child: MyAnimation(
        ani: ani,
        mation: MationStack(
          alignment: alignment,
          deviateAlignment: false,
          children: <Widget, Mations>{
            ..._elementButtons(alignment.toFabExpandableDirection, iconSize),
            _closeButton(iconSize): Mations.empty,
            _openButton(iconSize): Mations.empty,
          },
        ),
        child: KSizedBox.none,
      ),
    );
  }

  Ani get ani => Ani(
        updateListener: (controller) {
          if (_shouldAnimate) {
            isOpen
                ? controller
                    .forward()
                    .then((_) => setState(() => _shouldAnimate = false))
                : controller
                    .reverse()
                    .then((_) => setState(() => _shouldAnimate = false));
          }
        },
      );

  void _toggle() => setState(() {
        isOpen = !isOpen;
        _shouldAnimate = true;
      });

  /// instead of [VMationTransition.fadeIn], i use [AnimatedOpacity] for better performance.
  Widget _ignoredSized({
    required bool ignoring,
    required bool show,
    required Coordinate iconSize,
    required Widget child,
  }) =>
      IgnorePointer(
        ignoring: ignoring,
        child: AnimatedOpacity(
          opacity: show ? 1.0 : 0.0,
          duration: KDuration.milli500,
          child: SizedBox(
            width: iconSize.dx,
            height: iconSize.dy,
            child: child,
          ),
        ),
      );

  /// open button
  Widget _openButton(Coordinate iconSize) => _ignoredSized(
        ignoring: isOpen || _shouldAnimate,
        show: !isOpen,
        iconSize: iconSize,
        child: FloatingActionButton(
          splashColor: Colors.white,
          onPressed: _toggle,
          child: Icon(widget.openIcon),
        ),
      );

  /// close button
  Widget _closeButton(Coordinate iconSize) => _ignoredSized(
        ignoring: !isOpen || _shouldAnimate,
        show: isOpen,
        iconSize: iconSize,
        child: Material(
          elevation: 4.0,
          shape: KBorder.circle,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: _toggle,
            splashFactory: InkSparkle.splashFactory,
            child: Padding(
              padding: KEdgeInsets.all_10,
              child: Icon(widget.closeIcon),
            ),
          ),
        ),
      );

  /// element buttons
  Map<Widget, Mations> _elementButtons(
    double direction,
    Coordinate iconSize,
  ) {
    final iconConfiguration = widget.childrenIcons;
    final amount = iconConfiguration.length;
    final maxDistance = widget.maxDistance ?? amount * 0.6;

    final step = KRadian.angle_90 / (amount - 1);
    direction -= step;

    return iconConfiguration.fold(
      <Widget, Mations>{},
      (map, entry) {
        direction += step;
        return map
          ..putIfAbsent(
            _ignoredSized(
                ignoring: !isOpen,
                show: isOpen,
                iconSize: iconSize,
                child: ElevatedButton(
                  onPressed: entry.value,
                  child: Icon(entry.key),
                )),
            () => Mations(
              controllers: [
                MationTransition<double>.fade(VTweenDouble.double_0_1),
                MationTransition<Offset>.translate(
                  Offset.fromDirection(direction, maxDistance).tweenFromZero,
                ),
              ],
            ),
          );
      },
    );
  }
}

class CustomFabExpandableHorizontal extends StatefulWidget {
  const CustomFabExpandableHorizontal({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomFabExpandableHorizontal> createState() =>
      _CustomFabExpandableHorizontalState();
}

class _CustomFabExpandableHorizontalState
    extends State<CustomFabExpandableHorizontal> with TickerProviderStateMixin {
  AnimationController? animationController;
  List animation = [];
  List icons = [
    Icons.home,
    Icons.settings,
    Icons.location_city,
  ];
  List colors = [Colors.green, Colors.blueGrey, Colors.purple];
  OverlayEntry? overlayEntry;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: KDuration.second1);
    for (int i = 3; i > 0; i--) {
      animation.add(Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animationController!,
          curve: Interval(0.2 * i, 1.0, curve: Curves.ease))));
    }
  }

  _showOverLay() async {
    RenderBox? renderBox =
        globalKey.currentContext!.findRenderObject() as RenderBox?;
    Offset offset = renderBox!.localToGlobal(Offset.zero);

    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        bottom: renderBox.size.height + 16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < animation.length; i++)
              ScaleTransition(
                scale: animation[i],
                child: FloatingActionButton(
                  onPressed: () =>
                      context.showSnackbarWithMessage(message: 'press'),
                  backgroundColor: colors[i],
                  mini: true,
                  child: Icon(
                    icons[i],
                  ),
                ),
              )
          ],
        ),
      ),
    );
    animationController!.addListener(() {
      overlayState.setState(() {});
    });
    animationController!.forward();
    overlayState.insert(overlayEntry!);

    await Future.delayed(const Duration(seconds: 5))
        .whenComplete(() => animationController!.reverse())
        .whenComplete(() => overlayEntry!.remove());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Overlay'),
      ),
      floatingActionButton: FloatingActionButton(
        key: globalKey,
        onPressed: _showOverLay,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText._(
    this.data, {
    super.key,
    this.style,
  });

  final String data;
  final TextStyle? style;

  //...

  factory CustomText.ofDouble(
    double value, {
    Key? key,
    int fixed = 0,
    TextStyle? style,
  }) =>
      CustomText._(
        value.toStringAsFixed(fixed),
        key: key,
        style: style,
      );

  factory CustomText.ofDuration(
    Duration value, {
    Key? key,
    bool toDayMinuteSecond = true,
    String splitter = ':',
    TextStyle? style,
  }) =>
      CustomText._(
        value.toStringDayMinuteSecond(splitter: splitter),
        key: key,
        style: style,
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      key: key,
      style: style,
    );
  }
}

// class CustomLaTex extends StatelessWidget {
//   const CustomLaTex(
//     this.string, {
//     super.key,
//     this.engine = const TeXViewRenderingEngine.katex(),
//     this.style,
//   });
//
//   final String string;
//   final TeXViewRenderingEngine? engine;
//   final TeXViewStyle? style;
//
//   factory CustomLaTex.advance(
//     String string, {
//     TeXViewStyle? style,
//   }) =>
//       CustomLaTex(
//         string,
//         engine: const TeXViewRenderingEngine.mathjax(),
//         style: style,
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return TeXView(
//       renderingEngine: engine,
//       style: style,
//       child: TeXViewDocument(
//         r"$$"
//         "$string"
//         r"$$",
//       ),
//     );
//   }
// }

class CustomColumn extends StatelessWidget {
  const CustomColumn({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    required this.children,
  });

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  factory CustomColumn.operationColumnForm({
    MainAxisAlignment columnAlignment = MainAxisAlignment.center,
    required Widget valueA,
    required Icon operator,
    required Widget valueB,
    required Divider divider,
    required Widget result,
  }) =>
      CustomColumn(
        mainAxisAlignment: columnAlignment,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          valueA,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [operator, valueB],
          ),
          divider,
          result,
        ],
      );

  // factory CustomColumn.operateDoubleInColumnForm()

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}

class CustomOverlay extends StatefulWidget {
  const CustomOverlay({required this.child}) : super(key: null);

  final Widget child;

  @override
  State<CustomOverlay> createState() => CustomOverlayState();

  static CustomOverlayState of(BuildContext context) =>
      context.findAncestorStateOfType()!;

  ///
  /// TODO: encapsulate [CustomOverlayState] functions, maybe migrate with [ItemModificationOption]
  ///
  static bool? insertOrAB({
    required CustomOverlayState overlay,
    required MyOverlayEntry entry,
    required bool isB,
  }) {
    if (overlay.hasEntry) {
      overlay.update(entry);
      return !isB;
    } else {
      overlay.insert(entry);
      return null;
    }
  }
}

class CustomOverlayState extends State<CustomOverlay>
    with SingleTickerProviderStateMixin {
  final List<MyOverlayEntry> myEntries = [];

  OverlayState get _overlayState => Overlay.of(context);

  bool get hasEntry => myEntries.isNotEmpty;

  @override
  Widget build(BuildContext context) => widget.child;

  /// insert
  void insert(MyOverlayEntry myEntry, {VoidCallback? listener}) {
    final key = myEntry.key;
    if (myEntries.any((element) => element.key == key)) {
      throw CustomError("instead of 'insert', please use 'update'");
    } else {
      myEntries.add(myEntry);
      _overlayState.insert(myEntry.overlayEntry);
      if (listener != null) {
        myEntry.overlayEntry.addListener(listener);
      }
    }
  }

  /// update
  void update(MyOverlayEntry myEntry) {
    try {
      myEntries
          .firstWhere((e) => e.key == myEntry.key)
          .overlayEntry
          .markNeedsBuild();
    } catch (_) {
      throw OverlayEntryNotExistError();
    }
  }

  /// remove last
  void removeLast() {
    try {
      myEntries.last.controller!
          .reverse()
          .then((_) => myEntries.removeLast().overlayEntry.remove());
    } catch (_) {
      throw OverlayEntriesEmptyError();
    }
  }

  /// remove
  void remove(MyOverlayEntry? myEntry) {
    if (myEntry != null && myEntries.contains(myEntry)) {
      myEntry.controller!.reverse().then((_) => myEntry.overlayEntry.remove());
    } else {
      throw OverlayEntryNotExistError();
    }
  }
}

/// custom value widget
class CustomValueBuilderWidget<T> extends StatefulWidget {
  const CustomValueBuilderWidget({
    super.key,
    required this.value,
    required this.builder,
    required this.child,
  });

  final T value;
  final ValueWidgetBuilder<T> builder;
  final Widget child;

  @override
  State<CustomValueBuilderWidget<T>> createState() =>
      _CustomValueBuilderWidgetState<T>();
}

class _CustomValueBuilderWidgetState<T>
    extends State<CustomValueBuilderWidget<T>> {
  late final ValueNotifier<T> _notifier;

  @override
  void initState() {
    _notifier = ValueNotifier(widget.value);
    super.initState();
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomValueBuilderWidget<T> oldWidget) {
    _notifier.value = widget.value;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      key: ValueKey(_notifier),
      valueListenable: _notifier,
      builder: widget.builder,
      child: widget.child,
    );
  }
}

class CustomStreamBuilderWidget<T> extends StatelessWidget {
  const CustomStreamBuilderWidget({
    super.key,
    this.initialData,
    this.waitingDataBuilder,
    this.activeBuilder,
    this.doneConnectBuilder,
    this.noneConnectionBuilder = _defaultNoneConnectedBuilder,
    required this.controller,
    required this.stream,
    required this.builder,
    required this.child,
  });

  final T? initialData;
  final Stream<T> stream;
  final ValueWidgetBuilder<T?> builder;
  final ValueWidgetBuilder<T?>? activeBuilder;
  final ValueWidgetBuilder<T?>? waitingDataBuilder;
  final ValueWidgetBuilder<T?>? doneConnectBuilder;
  final WidgetBuilder noneConnectionBuilder;
  final Widget child;

  // TODO: condense above in here
  final StreamController<T> controller;

  static Widget _defaultNoneConnectedBuilder(BuildContext context) =>
      KProgressIndicator.circular;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: initialData,
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw StreamError(snapshot.error, stackTrace: snapshot.stackTrace);
        } else {
          final status = snapshot.connectionState;
          final data = snapshot.data;
          final c = switch (status) {
            ConnectionState.none => noneConnectionBuilder(context),
            ConnectionState.waiting =>
              waitingDataBuilder?.call(context, data, child),
            ConnectionState.active => activeBuilder?.call(context, data, child),
            ConnectionState.done =>
              doneConnectBuilder?.call(context, data, child),
          };
          return c ?? builder(context, data, child);
        }
      },
    );
  }
}

///
/// animated widgets
///

class CustomAnimatedContainer extends StatelessWidget {
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Decoration? decorationForeground;
  final Decoration? decorationBackground;
  final Duration animationDuration;
  final Curve animationCurve;
  final VoidCallback? animationOnEnd;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final AlignmentGeometry? childAlignment;
  final Size? size;
  final Widget child;

  const CustomAnimatedContainer({
    super.key,
    this.size,
    this.padding,
    this.margin,
    this.decorationForeground,
    this.decorationBackground,
    this.animationDuration = KDuration.second1,
    this.animationCurve = Curves.fastOutSlowIn,
    this.animationOnEnd,
    this.childAlignment,
    this.transform,
    this.transformAlignment,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: key,
      width: size?.width,
      height: size?.height,
      padding: padding,
      margin: margin,
      foregroundDecoration: decorationForeground,
      decoration: decorationBackground,
      duration: animationDuration,
      curve: animationCurve,
      onEnd: animationOnEnd,
      transform: transform,
      transformAlignment: transformAlignment,
      alignment: childAlignment,
      child: child,
    );
  }
}

// animated switcher
class CustomAnimatedSwitcher extends StatelessWidget {
  const CustomAnimatedSwitcher({
    super.key,
    required this.child,
    this.duration = KDuration.milli500,
    this.durationReverse = KDuration.milli500,
    this.curveSwitchIn = Curves.linear,
    this.curveSwitchOut = Curves.linear,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder,
  });

  final Duration duration;
  final Duration durationReverse;
  final Curve curveSwitchIn;
  final Curve curveSwitchOut;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;
  final AnimatedSwitcherLayoutBuilder layoutBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: durationReverse,
      switchInCurve: curveSwitchIn,
      switchOutCurve: curveSwitchOut,
      transitionBuilder: transitionBuilder,
      layoutBuilder: layoutBuilder,
      child: child,
    );
  }
}

///
/// animated list
///

// animated list controller
class CustomAnimatedListController extends StatefulWidget {
  const CustomAnimatedListController({
    required this.listKey,
    required this.modification,
    required this.list,
  }) : super(key: listKey);

  final GlobalKey<AnimatedListState> listKey;
  final AnimatedListModification modification;
  final List<AnimatedListItem> list;

  @override
  State<CustomAnimatedListController> createState() =>
      _CustomAnimatedListControllerState();
}

class _CustomAnimatedListControllerState
    extends State<CustomAnimatedListController> {
  ///
  /// TODO :figure out if needs to [setState] by [listState] or directly [setState]
  ///
  AnimatedListState get listState => widget.listKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final modification = widget.modification;
    return AnimatedList(
      key: widget.key,
      initialItemCount: widget.list.length,
      itemBuilder: modification.itemPlan(
        items: widget.list,
        listState: listState,
        modification: modification,
      ),
    );
  }
}

// animated positioned
class CustomAnimatedPositioned extends StatelessWidget {
  const CustomAnimatedPositioned({
    super.key,
    required this.position,
    required this.child,
    this.curve = Curves.fastOutSlowIn,
    this.duration = KDuration.second1,
    this.onEnd,
  });

  final Positioned position;
  final Curve curve;
  final Duration duration;
  final VoidCallback? onEnd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final rect = position.rect;
    if (rect == null) {
      return AnimatedPositioned(
        key: key,
        left: position.left,
        top: position.top,
        right: position.right,
        bottom: position.bottom,
        curve: curve,
        duration: duration,
        onEnd: onEnd,
        child: child,
      );
    } else {
      return AnimatedPositioned.fromRect(
        key: key,
        rect: rect,
        curve: curve,
        duration: duration,
        onEnd: onEnd,
        child: child,
      );
    }
  }
}

// animated positioned stack
class CustomAnimatedPositionedStack extends StatelessWidget {
  const CustomAnimatedPositionedStack({
    super.key,
    required this.border,
    required this.children,
    this.childrenAlignment = Alignment.center,
  });

  final Coordinate border;
  final List<CustomAnimatedPositioned> children;
  final Alignment childrenAlignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: border.dx,
      height: border.dy,
      child: Stack(
        alignment: childrenAlignment,
        children: children,
      ),
    );
  }
}

class CustomFormField extends StatefulWidget {
  const CustomFormField({Key? key}) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField>
    with TickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus) {
    //   } else {
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      decoration: KInputDecoration.collapsed.copyWith(labelText: 'field'),
    );
  }
}

///
///
/// ---------------------------------------------------------------------------- original widgets
///
///

class LeaderShip extends StatefulWidget {
  const LeaderShip({
    super.key,
    required this.leaderBuilder,
    required this.followerStream,
    this.followOnOverlay = true,
  });

  final LeaderBuilder leaderBuilder;
  final Stream<FollowerBuilder> followerStream;
  final bool followOnOverlay;

  @override
  State<LeaderShip> createState() => _LeaderShipState();
}

class _LeaderShipState extends State<LeaderShip> {
  final LayerLink _layerLink = LayerLink();

  StreamSubscription<FollowerBuilder>? _followerSubscription;

  @override
  void didUpdateWidget(covariant LeaderShip oldWidget) {
    _followerSubscription?.cancel();
    _followerSubscription = widget.followerStream.listen((builder) {
      final follower = builder(_layerLink);
      final overlay = context.overlay;

      final state = follower.state;
      switch (state) {
        case FollowerState.join:
          overlay.insert(follower.getOverlayEntryController(context));
          break;
        case FollowerState.leave:
          overlay.remove(follower.overlayEntryController);
          break;
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) =>
      widget.leaderBuilder(_layerLink).toCompositedTransformTarget;
}

///
/// "Pes" means Positioned, Expand, Shrink;
/// "Pen" means Penetration,
///

class PesPen extends StatefulWidget {
  const PesPen({
    Key? key,
    required this.pesView,
    required this.pesItem,
    required this.child,
  }) : super(key: key);
  final Widget pesView;
  final PesItem? pesItem;
  final Widget child;

  @override
  State<PesPen> createState() => _PesPenState();
}

class _PesPenState extends State<PesPen> with SingleTickerProviderStateMixin {
  late final double _windowWidth;
  late final double _windowHeight;
  late final Offset _maxWindowOffset;
  late final GlobalKey _stickyKey;
  late final AnimationController _controller;
  late final Animation _animation;

  late PesItem? _item;
  late double _itemWidth;
  late double _itemHeight;
  late PesState _pesState;

  // Offset _itemCenterOffset = Offset.zero;
  Offset _itemCornerAOffset = Offset.zero;
  Offset _itemCornerBOffset = Offset.zero;
  bool _expandOver = false;
  double _fraction = 0.0;

  @override
  void initState() {
    final windowSize = vDevice.windowSize;
    _windowWidth = windowSize.width;
    _windowHeight = windowSize.height;
    _maxWindowOffset = Offset(windowSize.width, windowSize.height);
    _stickyKey = GlobalKey();
    _controller = AnimationController(
      vsync: this,
      duration: KDuration.milli500,
    );
    _animation = VTweenDouble.double_0_1
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease))
      ..addListener(() => _fraction = _animation.value);

    _pesState = PesState.inPool;
    _item = null;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PesPen oldWidget) {
    if (widget.pesItem != oldWidget.pesItem) {
      _pesState = PesState.inPosition;
      _controller.forward();
      _item = widget.pesItem!;
      _itemCornerAOffset = _item!.itemZeroOffset;
      _itemCornerBOffset = _item!.itemSize.diagonalPosition(_itemCornerAOffset);

      // _itemCenterOffset = ((_itemCornerAOffset + _itemCornerBOffset) / 2)
      //     .adjustScaffold(_stickyKey);

      _itemWidth = _item!.itemSize.width;
      _itemHeight = _item!.itemSize.height;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _stickyKey,
      children: [
        widget.child,
        IgnorePointer(
          ignoring:
              _pesState == PesState.inPosition || _pesState == PesState.inPool,
          child: AnimatedOpacity(
            curve: Curves.easeOut,
            opacity: _pesState == PesState.expand ? 1.0 : 0.0,
            duration: KDuration.second1,
            child: Stack(children: [_pan, _pes]),
          ),
        ),
      ],
    );
  }

  ///
  /// TODO: migrate to [MationClipper]
  ///
  Widget get _pan => GestureDetector(
        onTap: _shrink,
        child: ClipPath(
          clipper: MyClipper.reClipOf(FSizeToPath.rRect(
            /// from itemCenter to windowSize
            // cornerA: _itemCenterOffset * (1 - _fraction),
            // cornerB: _itemCenterOffset + (_maxWindowOffset - _itemCenterOffset) * _fraction,

            /// from itemCorner to windowSize
            cornerA: _itemCornerAOffset * (1 - _fraction),
            cornerB: _itemCornerBOffset +
                (_maxWindowOffset - _itemCornerBOffset) * _fraction,
          )),
          child: Container(color: KColor.blackO_06),
        ),
      );

  Widget get _pes => AnimatedPositioned(
        curve: Curves.easeInQuart,
        left: _pesTargetPosition('left'),
        top: _pesTargetPosition('top'),
        width: _pesTargetPosition('width'),
        height: _pesTargetPosition('height'),
        duration: _pesTargetDuration(_pesState),
        child: Material(
          borderRadius: KBorderRadius.allCircular_10,
          child: Card(
            borderOnForeground: false,
            elevation: 50.0,
            child: AnimatedOpacity(
              curve: Curves.easeOut,
              opacity: _expandOver ? 1.0 : 0.0,
              duration: _expandOver ? KDuration.milli500 : KDuration.milli100,
              child: Stack(
                children: [
                  widget.pesView,
                  Positioned(
                    child: IconButton(
                      onPressed: _shrink,
                      icon: KIcon.cancelSharp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onEnd: () {
          switch (_pesState) {
            case PesState.inPosition:
              setState(() => _pesState = PesState.expand);
              break;
            case PesState.expand:
              setState(() => _expandOver = true);
              break;
            case PesState.shrink:
              setState(() => _pesState = PesState.inPool);
              break;
            case PesState.inPool:
              break;
          }
        },
      );

  double _pesTargetPosition(String where) => _item == null
      ? 0.0
      : switch (_pesState) {
          PesState.inPosition => 0.0,
          PesState.inPool => 0.0,
          PesState.shrink => switch (where) {
              'left' => _itemCornerAOffset.dx,
              'top' => _itemCornerAOffset.dy,
              'width' => _itemWidth,
              'height' => _itemHeight,
              _ => throw UnimplementedError(),
            },
          PesState.expand => switch (where) {
              'left' => (_windowWidth - _itemWidth) / 4,
              'top' => _windowHeight * 1 / 16,
              // (_windowWidth/2 - (_windowWidth - item.itemLeft)/4) * 2;
              'width' => _windowWidth - (_windowWidth - _itemWidth) / 2,
              'height' => _windowHeight * 7 / 8,
              _ => throw UnimplementedError(),
            },
        };

  Duration _pesTargetDuration(PesState state) => switch (state) {
        PesState.inPool || PesState.inPosition => KDuration.milli10,
        PesState.expand => KDuration.milli500,
        PesState.shrink => KDuration.milli500,
      };

  void _shrink() => setState(() {
        _expandOver = false;
        _controller.reverse();
        _pesState = PesState.shrink;
      });
}

class NavigationSudoku extends StatelessWidget {
  const NavigationSudoku({
    Key? key,
    this.curve = KCurveFRFlipped.fastOutSlowIn,
    required this.isNavIn,
    required this.navDirection,
    required this.child,
  }) : super(key: key);
  final bool isNavIn;
  final Direction2DVector navDirection;
  final CurveFR curve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MyAnimation(
      ani: KAniInitForward.second1,
      mation: MationTransition.translate(navDirection.tweenOf(isNavIn, curve)),
      child: child,
    );
  }
}

class Preference extends StatefulWidget {
  const Preference({
    super.key,
    this.theme,
    this.appColor,
    this.animations,
    required this.child,
  });

  final ThemeData? theme;
  final MainColor? appColor;
  final PreferAnimations? animations;
  final Widget child;

  @override
  State<Preference> createState() => PreferenceState();

  static PreferenceState of(BuildContext context) =>
      context.findAncestorStateOfType<PreferenceState>()!;
}

class PreferenceState extends State<Preference> {
  ThemeData? _theme;
  late MainColor _appColor;

  set setTheme(ThemeData data) => setState(() => _theme = data);
  set setAppColor(MainColor mainColor) => _appColor = mainColor;

  ThemeData? get theme => _theme;

  MainColor get appColor => _appColor;

  final Map<PreferAnimationPlacement, PreferAnimation> animations = {};

  @override
  void initState() {
    _update(super.initState);
  }

  @override
  void didUpdateWidget(covariant Preference oldWidget) =>
      _update(() => super.didUpdateWidget(oldWidget));

  void _update(void Function() doneUpdate) {
    _theme = widget.theme;
    _appColor = widget.appColor ?? MainColor.blue;
    // final a = widget.animations;
    // animations.addAll(Map.fromEntries(
    //   PreferAnimationPlacement.values.map(
    //     (type) => MapEntry(type, a[type] ?? type.defaultPreference),
    //   ),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomOverlay(
      child: widget.child,
    );
  }
}

///
///
/// ---------------------------------------------------------------------------- sample widgets
///
///

class SampleCircleRotateFlipper extends StatefulWidget {
  const SampleCircleRotateFlipper({Key? key}) : super(key: key);

  @override
  State<SampleCircleRotateFlipper> createState() =>
      _SampleCircleRotateFlipperState();
}

class _SampleCircleRotateFlipperState extends State<SampleCircleRotateFlipper> {
  bool _isFlipped = true;
  MyTween<Coordinate> _tweenClockwise = VTweenCoordinateRadian.z_0_90;
  MyTween<Coordinate> _tweenFlip = VTweenCoordinate.zero;

  void _statusListenerFlip(AnimationStatus status) =>
      status.listenWhenCompleted(() => setState(() {
            _isFlipped = true;
            _tweenClockwise = _tweenClockwise.follow(
              _tweenClockwise.end + KCoordinateRadian.angleZ_90,
            );
          }));

  void _statusListenerClockwise(AnimationStatus status) =>
      status.listenWhenCompleted(() => setState(() {
            _isFlipped = false;
            _tweenFlip = _tweenFlip.follow(
              _tweenFlip.end + KCoordinateRadian.angleY_180,
            );
          }));

  @override
  Widget build(BuildContext context) {
    return FAnimationTransformRowTransformClipper.rotateHalfCircleFlip(
      tweenRotate: _tweenClockwise,
      tweenFlip: _tweenFlip,
      statusListenerRotate: _statusListenerClockwise,
      statusListenerFlip: _statusListenerFlip,
      isFlipped: _isFlipped,
    );
  }
}

///
/// TODO:
/// 1. try all [BlendMode] value
/// 2. try all [ColorFilter] constructor
///
class SampleCircleColorFilter extends StatefulWidget {
  const SampleCircleColorFilter({Key? key}) : super(key: key);

  @override
  State<SampleCircleColorFilter> createState() =>
      _SampleCircleColorFilterState();
}

class _SampleCircleColorFilterState extends State<SampleCircleColorFilter> {
  Color _color = VColor.randomWithAlpha;

  @override
  Widget build(BuildContext context) {
    final size = context.mediaSize;
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: MyClipper.reClipNeverOf(
            FSizeToPath.circleFromSize(
              center: FSizeToOffset.xy_whHalf,
              radius: FSizeToDouble.widthQuarter,
            ),
          ),
          child: TweenAnimationBuilder(
            tween: ColorTween(begin: VColor.randomWithAlpha, end: _color),
            onEnd: () => setState(() => _color = VColor.randomWithAlpha),
            duration: KDuration.second1,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Image.asset(KStringAssetImage.wallpaper),
            ),
            builder: (context, Color? color, child) => ColorFiltered(
              colorFilter: ColorFilter.mode(
                color!,
                BlendMode.saturation,
                // BlendMode.clear,
                // BlendMode.src,
                // BlendMode.dst,
                // ...
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
