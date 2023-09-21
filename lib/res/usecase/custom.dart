part of usecase;

///
/// this file contains:
/// [CustomText]
/// [CustomColumn]
/// [CustomValueBuilderWidget], [CustomStreamBuilderWidget]
/// [CustomOverlay]
///
/// [CustomAnimatedContainer], [CustomAnimatedSwitcher]
/// [CustomAnimatedListController]
/// [CustomAnimatedPositioned], [CustomAnimatedPositionedStack]
/// [CustomFormField]
///
///
/// original widgets
/// [Preference],
/// [PesPen], [LeaderShip]
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

class CustomText extends StatelessWidget {
  const CustomText._(
    this.data, {
    super.key,
    this.style,
  });

  final String data;
  final TextStyle? style;

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

  //...

  @override
  Widget build(BuildContext context) {
    return Text(data, key: key, style: style);
  }
}

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
    this.noneConnectionBuilder = FWidgetBuilder.progressing,
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: initialData,
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw StreamError(
            "\n error: ${snapshot.error}\n${snapshot.stackTrace}",
          );
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
  const CustomFormField({super.key});

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
      decoration: KDecorationInput.collapsed.copyWith(labelText: 'field'),
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
          overlay.insert(follower.overlayEntryOf(context));
          break;
        case FollowerState.leave:
          follower.overlayEntry!.remove();
          break;
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) =>
      widget.leaderBuilder(_layerLink).toCompositedTransformTarget;
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
  void initState() => _update(super.initState);

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
    doneUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

///
///
/// ---------------------------------------------------------------------------- sample widgets
///
///

class SampleCircleRotateFlipper extends StatefulWidget {
  const SampleCircleRotateFlipper({super.key});

  @override
  State<SampleCircleRotateFlipper> createState() =>
      _SampleCircleRotateFlipperState();
}

class _SampleCircleRotateFlipperState extends State<SampleCircleRotateFlipper> {
  bool _isFlipped = true;
  Between<Coordinate> _clockwise = FBetweenCoordinateRadian.z_0_90;
  Between<Coordinate> _flip = FBetweenCoordinate.zero;

  @override
  Widget build(BuildContext context) {
    return FMyClipperMationTransformRowTransform.rotateHalfCircleFlip(
      tweenRotate: _clockwise,
      tweenFlip: _flip,
      statusListenerRotate: setStateOfAnimationStatusCompleted(() {
        _isFlipped = false;
        _flip = _flip.followPlus(KRadianCoordinate.angleY_180);
      }),
      statusListenerFlip: setStateOfAnimationStatusCompleted(() {
        _isFlipped = true;
        _clockwise = _clockwise.followPlus(KRadianCoordinate.angleZ_90);
      }),
      isFlipped: _isFlipped,
    );
  }
}

///
/// 1. TODO: try all [BlendMode] value for color filter
/// 2. try all [ColorFilter] constructor
///
class SampleCircleColorFilter extends StatefulWidget {
  const SampleCircleColorFilter({super.key});

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
            (size) => Path()
              ..addOval(Rect.fromCircle(
                center: size.center(Offset.zero),
                radius: size.width / 4,
              )),
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
