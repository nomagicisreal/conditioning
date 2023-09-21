part of source;

///
/// this file contains:
/// [MyAnimation]
/// [MyAnimationSin]
/// [MyAnimationPenetration]
///
/// [Ani]
///   [AniProgress]
///     [AniProgressBool]
///     [AniProgressTernary]
///
/// [MationBase]
///   [Mation]
///     [_MationTransformBase]
///     [MationTransition]
///       [MationTransitionDouble]
///       [MationTransitionOffset]
///       [MationTransitionAlign]
///       [MationTransitionDecoration]
///       ...
///     [MationClipper]
///     [MationPainter]
///   [Mations]
///     [MationTransform]
///
/// TODO: MationText, MationList, Mation[LeaderShip]
/// [AnimationControllerExtension]
///
///
///
///

class MyAnimation extends StatefulWidget {
  const MyAnimation.ofBuilder({
    super.key,
    this.ani = KAniInitForwardAndUpdateForwardOrReverse.second1,
    this.builder = kWidgetBuilder,
    required this.mation,
  });

  MyAnimation({
    super.key,
    this.ani = KAniInitForwardAndUpdateForwardOrReverse.second1,
    Widget child = KSizedBox.none,
    required this.mation,
  }) : builder = FWidgetBuilder.of(child);

  final MationBase mation;
  final Ani ani;
  final WidgetBuilder builder;

  @override
  State<MyAnimation> createState() => MyAnimationState();

  static MyAnimationState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAnimationState>()!;
}

class MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    final setting = widget.ani;

    controller = setting.initialize(this);
    final listener = setting.initialStatusListener;
    if (listener != FAnimationStatusListener.listenNothing) {
      controller.addStatusListener(listener);
    }

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MyAnimation oldWidget) {
    controller.isAnimating
        ? widget.ani.onAnimating(
            controller,
            controller.status == AnimationStatus.forward,
          )
        : widget.ani.listenUpdate(controller);

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => _builder(context);

  WidgetBuilder get _builder => widget.mation.plan(
        controller: controller,
        builder: widget.builder,
      );
}

///
/// [MyAnimationSin.shaker]
/// [MyAnimationSin.flicker]
/// [MyAnimationSin.slider]
///
///

class MyAnimationSin extends StatelessWidget {
  const MyAnimationSin._({
    super.key,
    required this.duration,
    required this.initializer,
    required this.updateListener,
    required this.mation,
    required this.child,
  });

  factory MyAnimationSin.shaker({
    Key? key,
    Alignment alignment = Alignment.center,
    bool adjustStart = true,
    DurationFR duration = KDurationFR.second1,
    AnimationControllerInitializer initializer = FAni.initialize,
    Processor<AnimationController> updateListener = FAni.processNothing,
    required int times,
    required double amplitudeRadian,
    required Widget child,
  }) =>
      MyAnimationSin._(
        key: key,
        duration: duration ~/ 2,
        initializer: initializer,
        updateListener: updateListener,
        mation: MationTransitionDouble.rotate(
          0,
          amplitudeRadian / KRadian.angle_360,
          curve: CurveFR.constant(MyCurve.sinPeriodOf(times)),
          alignment: alignment,
        ),
        child: child,
      );

  factory MyAnimationSin.flicker({
    Key? key,
    DurationFR duration = KDurationFR.second1,
    AnimationControllerInitializer initializer = FAni.initialize,
    Processor<AnimationController> updateListener = FAni.processNothing,
    required int times,
    required double amplitudeOpacity,
    required Widget child,
  }) =>
      MyAnimationSin._(
        key: key,
        duration: duration ~/ 2,
        initializer: initializer,
        updateListener: updateListener,
        mation: MationTransitionDouble.fade(
          1.0,
          amplitudeOpacity,
          curve: CurveFR.constant(MyCurve.sinPeriodOf(times)),
        ),
        child: child,
      );

  factory MyAnimationSin.slider({
    Key? key,
    DurationFR duration = KDurationFR.second1,
    AnimationControllerInitializer initializer = FAni.initialize,
    Processor<AnimationController> updateListener = FAni.processNothing,
    required int times,
    required Offset amplitudePosition,
    required Widget child,
  }) =>
      MyAnimationSin._(
        key: key,
        duration: duration,
        initializer: initializer,
        updateListener: updateListener,
        mation: MationTransitionOffset(
          Offset.zero,
          amplitudePosition,
          curve: CurveFR.constant(MyCurve.sinPeriodOf(times)),
        ),
        child: child,
      );

  final DurationFR duration;
  final AnimationControllerInitializer initializer;
  final Processor<AnimationController> updateListener;
  final MationBase mation;
  final Widget child;

  @override
  Widget build(BuildContext context) => MyAnimation(
        ani: Ani(
          duration: duration,
          initializer: initializer,
          updateProcess: updateListener,
        ),
        mation: mation,
        child: child,
      );
}

class MyAnimationPenetration extends StatelessWidget {
  const MyAnimationPenetration({
    super.key,
    this.ani = KAniUpdateForwardOrReverse.second1_onAnimatingBack,
    this.opacityEnd = 1.0,
    this.curveFade = KCurveFR.fastOutSlowIn_easeOutQuad,
    this.curveClipper = KCurveFR.fastOutSlowIn_easeOutQuad,
    this.clip = Clip.antiAlias,
    this.color = Colors.black54,
    this.child,
    required this.onTap,
    required this.rect,
    required this.path,
  });

  final Ani ani;
  final double opacityEnd;
  final CurveFR curveFade;
  final CurveFR curveClipper;
  final Clip clip;
  final Color color;
  final Widget? child;
  final Between<Rect> rect;
  final PathFromRectSize path;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyAnimation(
        ani: ani,
        mation: Mations<dynamic, Mation>([
          MationClipper(
            BetweenPath<Rect>.fromTween(
              rect,
              curve: curveClipper,
              lerp: (rect) => (size) => path(rect, size),
            ),
            behavior: clip,
          ),
          MationTransitionDouble.fade(
            0.0,
            opacityEnd,
            curve: curveFade,
          ),
        ]),
        child: ColoredBox(color: color, child: child),
      ),
    );
  }
}

///
/// the named constructors or mation setting:
///
/// [Ani.initForward]
/// [Ani.initForwardReset]
/// [Ani.initRepeat]
/// [Ani.initForwardAndUpdateReverse]
/// [Ani.initForwardAndUpdateRepeat]
/// [Ani.initForwardAndUpdateResetForward]
/// [Ani.initForwardAndUpdateForwardOrReverse]
/// [Ani.initForwardResetAndUpdateForwardReset]
///
///
class Ani {
  final DurationFR duration;
  final AnimationControllerInitializer initializer;
  final AnimationStatusListener initialStatusListener;
  final Processor<AnimationController> updateProcess;
  final AnimatingProcessor onAnimating;

  AnimationController initialize(TickerProvider ticker) =>
      initializer(ticker, duration.forward, duration.reverse);

  void listenUpdate(AnimationController c) => updateProcess(c);

  const Ani({
    this.duration = KDurationFR.second1,
    this.initializer = FAni.initialize,
    this.initialStatusListener = FAnimationStatusListener.listenNothing,
    this.updateProcess = FAni.processNothing,
    this.onAnimating = FOnAnimatingProcessor.nothing,
  });

  /// init

  const Ani.initForward({
    this.duration = KDurationFR.second1,
    this.initialStatusListener = FAnimationStatusListener.listenNothing,
    this.updateProcess = FAni.processNothing,
    this.onAnimating = FOnAnimatingProcessor.nothing,
  }) : initializer = FAni.initializeForward;

  const Ani.initForwardReset({
    this.duration = KDurationFR.second1,
    this.initialStatusListener = FAnimationStatusListener.listenNothing,
    this.updateProcess = FAni.processNothing,
    this.onAnimating = FOnAnimatingProcessor.nothing,
  }) : initializer = FAni.initializeForwardReset;

  const Ani.initRepeat({
    bool reverseEnable = false,
    this.duration = KDurationFR.second1,
    this.initialStatusListener = FAnimationStatusListener.listenNothing,
    this.updateProcess = FAni.processNothing,
    this.onAnimating = FOnAnimatingProcessor.nothing,
  }) : initializer = reverseEnable
            ? FAni.initializeRepeatReverse
            : FAni.initializeRepeat;

  const Ani.initForwardAndUpdateReverse({
    this.duration = KDurationFR.second1,
    this.initialStatusListener = FAnimationStatusListener.listenNothing,
    this.onAnimating = FOnAnimatingProcessor.nothing,
  })  : initializer = FAni.initializeForward,
        updateProcess = FAni.processReverse;

  const Ani.initForwardAndUpdateRepeat({
    bool reverseEnable = false,
    this.duration = KDurationFR.second1,
    this.initialStatusListener = FAnimationStatusListener.listenNothing,
    this.onAnimating = FOnAnimatingProcessor.nothing,
  })  : initializer = FAni.initializeForward,
        updateProcess =
            reverseEnable ? FAni.processRepeat : FAni.processRepeatReverse;

  const Ani.initForwardAndUpdateResetForward({
    this.duration = KDurationFR.second1,
    this.initialStatusListener = FAnimationStatusListener.listenNothing,
    this.onAnimating = FOnAnimatingProcessor.nothing,
  })  : initializer = FAni.initializeForward,
        updateProcess = FAni.processResetForward;

  const Ani.initForwardAndUpdateForwardOrReverse({
    this.duration = KDurationFR.second1,
    this.initialStatusListener = FAnimationStatusListener.listenNothing,
    this.onAnimating = FOnAnimatingProcessor.nothing,
  })  : initializer = FAni.initializeForward,
        updateProcess = FAni.processForwardOrReverse;

  const Ani.initForwardResetAndUpdateForwardReset({
    this.duration = KDurationFR.second1,
    this.initialStatusListener = FAnimationStatusListener.listenNothing,
    this.onAnimating = FOnAnimatingProcessor.nothing,
  })  : initializer = FAni.initializeForwardReset,
        updateProcess = FAni.processForwardReset;

  /// update

  const Ani.updateForwardOrReverse({
    this.duration = KDurationFR.second1,
    this.initializer = FAni.initialize,
    this.initialStatusListener = FAnimationStatusListener.listenNothing,
    this.onAnimating = FOnAnimatingProcessor.nothing,
  }) : updateProcess = FAni.processForwardOrReverse;
}

///
///
///
/// in short,
/// the value of [updateProcess] is the comparison result from [delegate] and [current].
///
/// See Also
///   * [AniProgressBool]
///   * [AniProgressTernary]
///
abstract class AniProgress extends Ani {
  final int delegate;
  int current = 0;

  @override
  Processor<AnimationController> get updateProcess =>
      throw UnimplementedError();

  AniProgress({
    super.initializer = FAni.initialize,
    super.initialStatusListener = FAnimationStatusListener.listenNothing,
    super.duration = KDurationFR.second1,
    super.updateProcess = FAni.processNothing,
    super.onAnimating = FOnAnimatingProcessor.nothing,
    required this.delegate,
  });
}

class AniProgressBool extends AniProgress {
  final Decider<AnimationController, bool> hear;
  final PredicatorComparison<int> comparison;

  @override
  Processor<AnimationController> get updateProcess =>
      hear(comparison(delegate, current));

  AniProgressBool({
    super.initializer = FAni.initialize,
    super.initialStatusListener = FAnimationStatusListener.listenNothing,
    super.duration = KDurationFR.second1,
    super.onAnimating = FOnAnimatingProcessor.nothing,
    this.hear = FAni.decideForward,
    this.comparison = FPredicatorComparison.alwaysTrue<int>,
    required super.delegate,
  });
}

class AniProgressTernary extends AniProgress {
  final Decider<AnimationController, bool?> hear;
  final TernaryPredicatorComparison<int> comparison;

  @override
  Processor<AnimationController> get updateProcess =>
      hear(comparison(delegate, current));

  AniProgressTernary({
    super.initializer = FAni.initialize,
    super.initialStatusListener = FAnimationStatusListener.listenNothing,
    super.duration = KDurationFR.second1,
    super.onAnimating = FOnAnimatingProcessor.nothing,

    // 1. delegate > progress, listen nothing
    // 2. delegate == progress, listen forward
    // 3. delegate < progress, listen reverse
    this.hear = FAni.decideForwardOrReverse,
    this.comparison = FTernaryPredicatorComparison.alwaysTrue<int>,
    required super.delegate,
  });

// AniProgressTernary.initForward(
//   super.delegate, {
//   super.initialStatusListener = FAnimationStatusListener.listenNothing,
//   super.duration = KDurationFR.second1,
//   super.onAnimating = FOnAnimatingListener.nothing,
//   this.hear = FAni.hearForwardOrReverse,
//   TernaryPredicatorComparison<int>? comparison,
// })  : comparison = comparison ?? FTernaryComparison.alwaysTrue<int>,
//       super.initForward();
}

///
///
///
/// [MationBase] can be [MyAnimation.mation] to trigger animation
///
/// See also:
///
///  * [Mation], which triggers 1 tween animation
///       [_MationTransformBase], which implements [Transform] animation to used in [MyAnimation]
///       [MationTransition], which implements animation of [AnimatedWidget] subclasses to used in [MyAnimation]
///       [MationClipper], which implements animation of [ClipPath] to used in [MyAnimation]
///       [MationPainter], which implements animation of [CustomPaint] to used in [MyAnimation]
///       ...
///  * [Mations], which trigger multiple tweens animations
///       [MationTransform]
///
///
///
///

sealed class MationBase<T> {
  const MationBase();

  ///
  ///
  /// if [AnimationsBuilder] specify type [T],
  /// compiler will check if all the [AnimationBuilder] is of type [T].
  /// there will be a type cast error when [AnimationsBuilder] fold different [AnimationBuilder]<[T]>.
  /// therefore, [AnimationBuilder] or [Animation] under [MationBase] should be defined in dynamic type.
  ///
  /// See Also
  ///   constant variables of [MationTransition].
  ///

  AnimationsBuilder get builder;

  Iterable<Animation> animationsOf(AnimationController controller);

  WidgetBuilder plan({
    required AnimationController controller,
    required WidgetBuilder builder,
  }) {
    final animations = animationsOf(controller);
    return switch (this) {
      MationTransition() => (context) =>
          this.builder(animations, builder(context)),
      _ => (context) => AnimatedBuilder(
            animation: controller,
            builder: (_, __) => this.builder(animations, builder(context)),
          ),
    };
  }
}

class Mation<T> extends MationBase<T> {
  final AnimationBuilder _builder;
  final Between<T> between;

  Mation(
    this.between, {
    AnimationBuilder builder = _animationBuilder,
  }) : _builder = builder;

  static Widget _animationBuilder(Animation animation, Widget child) => child;

  Animation<T> animationOf(AnimationController c) => between.animate(c);

  @override
  Iterable<Animation> animationsOf(AnimationController controller) =>
      [animationOf(controller)];

  @override
  AnimationsBuilder get builder =>
      (animations, child) => _builder(animations.first, child);

  Mation<T> map(Mapper<Mation<T>> mapper) => mapper(this);

  Mation<T> mapBetween(Mapper<Between<T>> mapper) => Mation(
        between,
        builder: _builder,
      );
}

enum MationTransformBaseType {
  translate,
  rotate,
  scale;

  OnMatrix4Animate get onAnimate => switch (this) {
        MationTransformBaseType.translate => FOnMatrix4Animate.translating,
        MationTransformBaseType.rotate => FOnMatrix4Animate.rotating,
        MationTransformBaseType.scale => FOnMatrix4Animate.scaling,
      };
}

///
///
/// The radian discussion here, follows these rules:
/// - "positive radian" is counterclockwise, going through 0 ~ 2π.
/// - [Direction3DIn6] is user perspective. ([Direction3DIn6.back] is user side, [Direction3DIn6.front] is screen side)
///
/// For example,
/// [Offset.fromDirection] radian 0 ~ 2π going through:
/// [Direction3DIn6.right], [Direction3DIn6.bottom], [Direction3DIn6.left], [Direction3DIn6.top], [Direction3DIn6.right] in sequence;
/// its axis is [Direction3DIn6.front] -> [Direction3DIn6.back] not [Direction3DIn6.back] -> [Direction3DIn6.front],
/// because it is not counterclockwise in user perspective ([Direction3DIn6.back] -> [Direction3DIn6.front]).
/// only if viewing the screen face from [Direction3DIn6.front] to [Direction3DIn6.back],
/// the rotation 0 ~ 2π will be counterclockwise; therefore,
/// the axis of [Offset.fromDirection] is [Direction3DIn6.front] -> [Direction3DIn6.back],
/// the [Direction3DIn6] below based on the concept above.
///
///
/// the coordinate of [_MationTransformBase] is based on dart coordinate system of rotation:
/// x axis is [Direction3DIn6.left] -> [Direction3DIn6.right] ([Matrix4.rotationX]),
/// y axis is [Direction3DIn6.top] -> [Direction3DIn6.bottom] ([Matrix4.rotationY]),
/// z axis is [Direction3DIn6.front] -> [Direction3DIn6.back] ([Matrix4.rotationZ], same with [Offset.fromDirection]),
///
/// and of translation:
/// x is negative from [Direction3DIn6.left] to positive [Direction3DIn6.right]
/// y is negative from [Direction3DIn6.top] to positive [Direction3DIn6.bottom]
/// z is negative from [Direction3DIn6.front] to positive [Direction3DIn6.back]
///
/// See Also:
///   * [MationTransform]
///   * [KOffsetDirection], [KCoordinateDirection]
///   * [Coordinate.transferToTransformOf], [Coordinate.fromDirection]
///
///
class _MationTransformBase extends Mation<Coordinate> {
  final OnMatrix4Animate onAnimate;
  final AlignmentGeometry? alignment;
  Matrix4 host;

  AnimationBuilder _transform(OnMatrix4Animate animate) =>
      ((animation, child) => Transform(
            transform: animate(host, animation.value),
            alignment: alignment,
            child: child,
          ));

  @override
  AnimationBuilder get _builder => _transform(onAnimate);

  _MationTransformBase(
    super.between, {
    Matrix4? host,
    this.alignment,
    required this.onAnimate,
  }) : host = host ?? Matrix4.identity();

  _MationTransformBase.scale(
    super.between, {
    Matrix4? host,
    this.alignment,
  })  : host = host ?? Matrix4.identity(),
        onAnimate = MationTransformBaseType.scale.onAnimate;

  _MationTransformBase.translate(
    super.between, {
    Matrix4? host,
    this.alignment,
  })  : host = host ?? Matrix4.identity(),
        onAnimate = MationTransformBaseType.translate.onAnimate;

  _MationTransformBase.rotate(
    super.between, {
    Matrix4? host,
    this.alignment,
  })  : host = host ?? Matrix4.identity(),
        onAnimate = MationTransformBaseType.rotate.onAnimate;

  @override
  _MationTransformBase mapBetween(Mapper<Between<Coordinate>> mapper) =>
      _MationTransformBase(
        mapper(between),
        host: host,
        alignment: alignment,
        onAnimate: onAnimate,
      );

  @override
  _MationTransformBase map(Mapper<Mation<Coordinate>> mapper) =>
      super.map(mapper) as _MationTransformBase;

  void link(Matrix4 host) => this..host = host;
}

///
///
/// [MationTransition]
///
/// See Also:
///   * [MationTransitionDouble] ...
///   * [MationTransitionOffset] ...
///   * [MationTransitionAlign] ...
///   * [MationTransitionDecoration] ...
///
///
abstract class MationTransition<T> extends Mation<T> {
  MationTransition(super.between, {required super.builder});

  ///
  /// these constants must be dynamic type, see the comment over [MationBase.builder]
  ///

  static const AnimationBuilder<dynamic> slide = _slide;
  static const AnimationBuilder<dynamic> decoration = _decoration;
  static const AnimationBuilder<dynamic> fade = _fade;
  static const AnimationBuilder<dynamic> silverFade = _silverFade;
  static const AnimationBuilder<dynamic> align = _align;
  static const AnimationBuilder<dynamic> defaultTextStyle = _defaultTextStyle;
  static const AnimationBuilder<dynamic> positioned = _positioned;

  static Widget _slide(Animation animation, Widget child) => SlideTransition(
        position: animation as Animation<Offset>,
        child: child,
      );

  static Widget _decoration(Animation animation, Widget child) =>
      DecoratedBoxTransition(
        decoration: animation as Animation<Decoration>,
        child: child,
      );

  static Widget _fade(Animation animation, Widget child) => FadeTransition(
        opacity: animation as Animation<double>,
        child: child,
      );

  static Widget _silverFade(Animation animation, Widget child) =>
      SliverFadeTransition(
        opacity: animation as Animation<double>,
        sliver: child,
      );

  static Widget _align(Animation animation, Widget child) => AlignTransition(
        alignment: animation as Animation<AlignmentGeometry>,
        child: child,
      );

  static Widget _defaultTextStyle(Animation animation, Widget child) =>
      DefaultTextStyleTransition(
        style: animation as Animation<TextStyle>,
        child: child,
      );

  static Widget _positioned(Animation animation, Widget child) =>
      PositionedTransition(
        rect: animation as Animation<RelativeRect>,
        child: child,
      );

  ///
  /// the builders with argument
  ///

  static AnimationBuilder rotationOf(Alignment alignment) =>
      (Animation animation, Widget child) => RotationTransition(
            turns: animation as Animation<double>,
            alignment: alignment,
            child: child,
          );

  static AnimationBuilder scaleOf(Alignment alignment) =>
      (Animation animation, Widget child) => ScaleTransition(
            scale: animation as Animation<double>,
            alignment: alignment,
            child: child,
          );

  static AnimationBuilder sizeOf(Axis? axis, double? axisAlignment) =>
      (Animation animation, Widget child) => SizeTransition(
            sizeFactor: animation as Animation<double>,
            axis: axis ?? Axis.vertical,
            axisAlignment: axisAlignment ?? 0.0,
            child: child,
          );

  static AnimationBuilder relativePositionedOf(Size size) =>
      (Animation animation, Widget child) => RelativePositionedTransition(
            rect: animation as Animation<Rect>,
            size: size,
            child: child,
          );
}

class MationTransitionDouble extends MationTransition<double> {
  MationTransitionDouble._(super.tween, {required super.builder});

  ///
  /// fade
  ///

  factory MationTransitionDouble.fade(
    double begin,
    double end, {
    CurveFR curve = KCurveFR.linear,
  }) =>
      MationTransitionDouble._(
        Between(begin: begin, end: end, curve: curve),
        builder: MationTransition.fade,
      );

  factory MationTransitionDouble.fadeIn({CurveFR curve = KCurveFR.linear}) =>
      MationTransitionDouble.fade(0, 1, curve: curve);

  factory MationTransitionDouble.fadeOut({CurveFR curve = KCurveFR.linear}) =>
      MationTransitionDouble.fade(1, 0, curve: curve);

  ///
  /// scale
  ///

  factory MationTransitionDouble.scale(
    double begin,
    double end, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
    Alignment alignment = Alignment.topLeft,
  }) =>
      MationTransitionDouble._(
        Between(begin: begin, end: end, curve: curve),
        builder: MationTransition.scaleOf(alignment),
      );

  factory MationTransitionDouble.scaleFromOneTo(
    double end, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
  }) =>
      MationTransitionDouble.scale(1, end, curve: curve);

  factory MationTransitionDouble.scaleToOneFrom(
    double begin, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
  }) =>
      MationTransitionDouble.scale(begin, 1, curve: curve);

  factory MationTransitionDouble.scaleBeginOrEndOne(
    double another, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
    required bool isEndOne,
  }) =>
      MationTransitionDouble.scale(
        isEndOne ? another : 1,
        isEndOne ? 1 : another,
        curve: curve,
      );

  ///
  /// rotate
  ///

  factory MationTransitionDouble.rotate(
    double begin,
    double end, {
    Alignment alignment = Alignment.center,
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
  }) =>
      MationTransitionDouble._(
        Between(
          begin: begin / KRadian.angle_360,
          end: end / KRadian.angle_360,
          curve: curve,
        ),
        builder: MationTransition.rotationOf(alignment),
      );

  factory MationTransitionDouble.rotateFromZeroTo(
    double end, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
    Alignment alignment = Alignment.center,
  }) =>
      MationTransitionDouble.rotate(
        0,
        end,
        alignment: alignment,
        curve: curve,
      );

  factory MationTransitionDouble.rotateToZeroFrom(
    double begin, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
    Alignment alignment = Alignment.center,
  }) =>
      MationTransitionDouble.rotate(
        begin,
        0,
        alignment: alignment,
        curve: curve,
      );

  factory MationTransitionDouble.rotateBeginOrEndZero(
    double another, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
    Alignment alignment = Alignment.center,
    required bool isEndZero,
  }) =>
      MationTransitionDouble.rotate(
        isEndZero ? another : 0,
        isEndZero ? 0 : another,
        alignment: alignment,
        curve: curve,
      );
}

class MationTransitionOffset extends MationTransition<Offset> {
  MationTransitionOffset(
    Offset begin,
    Offset end, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
  }) : super(
          Between(begin: begin, end: end, curve: curve),
          builder: MationTransition.slide,
        );

  factory MationTransitionOffset.fromZeroTo(
    Offset end, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
  }) =>
      MationTransitionOffset(Offset.zero, end, curve: curve);

  factory MationTransitionOffset.toZeroFrom(
    Offset begin, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
  }) =>
      MationTransitionOffset(begin, Offset.zero, curve: curve);

  factory MationTransitionOffset.ofDirection(
    double direction,
    (double, double) distance, {
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
  }) =>
      MationTransitionOffset(
        Offset.fromDirection(direction, distance.$1),
        Offset.fromDirection(direction, distance.$2),
        curve: curve,
      );
}

class MationTransitionAlign extends MationTransition<AlignmentGeometry> {
  MationTransitionAlign({
    required AlignmentGeometry begin,
    required AlignmentGeometry end,
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
  }) : super(
          Between(begin: begin, end: end, curve: curve),
          builder: MationTransition.align,
        );
}


///
///
///
///
/// See Also:
///   * [FOnLerp._decoration] to know the creation practice for now
///   * [BoxDecoration.lerp], [ShapeDecoration.lerp] to find arguments that can be interpolated.
///   * [FOnLerp._shapeBorder] to know the creation practice for now, not all [ShapeDecoration.shape] are interpolatable.
///   * [KBoxDecoration]
///
///
///
///
class MationTransitionDecoration extends MationTransition<Decoration> {
  MationTransitionDecoration({
    required Decoration begin,
    required Decoration end,
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
  }) : super(
          Between(begin: begin, end: end, curve: curve),
          builder: MationTransition.decoration,
        );
}

///
///
///
/// clipper, painter
///
///
///

class MationClipper extends Mation<Translator<Size, Path>> {
  final Clip behavior;

  MationClipper(
    BetweenPath pathBetween, {
    this.behavior = Clip.antiAlias,
  }) : super(pathBetween);

  @override
  AnimationBuilder get _builder => (animation, child) => ClipPath(
        clipper: MyClipper.reClipOf(animation.value),
        clipBehavior: behavior,
        child: child,
      );

  @override
  MationClipper mapBetween(Mapper<Between<Translator<Size, Path>>> mapper) =>
      MationClipper(between as BetweenPath, behavior: behavior);
}

class MationPainter extends Mation<Translator<Size, Path>> {
  final bool isComplex;
  final bool willChange;
  final CustomPainter? foregroundPainter;
  final Size size;
  final CanvasProcessor canvasListener;
  final PaintFromCanvasSize canvasSizeToPaint;

  MationPainter._(
    super.between, {
    required this.isComplex,
    required this.willChange,
    required this.foregroundPainter,
    required this.size,
    required this.canvasListener,
    required this.canvasSizeToPaint,
  });

  MationPainter.drawPathTweenWithPaint(
    BetweenPath pathBetween, {
    this.canvasSizeToPaint = FCanvasSizeToPaint.redFill,
  })  : isComplex = false,
        willChange = true,
        size = Size.zero,
        foregroundPainter = null,
        canvasListener = FCanvasProcessor.drawPathWithPaint,
        super(pathBetween);

  @override
  AnimationBuilder get _builder => (animation, child) => CustomPaint(
        painter: MyPainter.rePaintOf(
          paintFromCanvasSize: canvasSizeToPaint,
          sizeToPath: animation.value,
          canvasListener: canvasListener,
        ),
        foregroundPainter: foregroundPainter,
        size: size,
        isComplex: isComplex,
        willChange: willChange,
        child: child,
      );

  @override
  MationPainter mapBetween(Mapper<Between<Translator<Size, Path>>> mapper) =>
      MationPainter._(
        between,
        isComplex: isComplex,
        willChange: willChange,
        foregroundPainter: foregroundPainter,
        size: size,
        canvasListener: canvasListener,
        canvasSizeToPaint: canvasSizeToPaint,
      );
}

///
///
///
/// mations
///
///
///

class Mations<T, M extends Mation<T>> extends MationBase<T> {
  final List<M> _list;

  Mations(this._list);

  @override
  Iterable<Animation> animationsOf(AnimationController controller) =>
      _list.map((mation) => mation.animationOf(controller));

  @override
  AnimationsBuilder get builder {
    final builders = _list.map((m) => m._builder).toList(growable: false);
    return (animations, child) => animations.foldWithIndex(
          child,
          (child, animation, i) => builders[i](animation, child),
        );
  }

  int get length => _list.length;

  void add(M element) => _list.add(element);

  void addAll(Iterable<M> elements) => _list.addAll(elements);

  void insert(int index, M element) => _list.insert(index, element);

  void insertAll(int index, Iterable<M> elements) =>
      _list.insertAll(index, elements);

  void configure(Processor<Mations<T, M>> listener) => listener(this);
}

class MationTransform extends Mations<Coordinate, _MationTransformBase> {
  final double? distanceToObserver;

  Matrix4 get host => Matrix4.identity()..setDistance(distanceToObserver);

  MationTransform({
    Between<Coordinate>? translateBetween,
    Between<Coordinate>? rotateBetween,
    Between<Coordinate>? scaleBetween,
    AlignmentGeometry? translateAlignment,
    AlignmentGeometry? rotateAlignment,
    AlignmentGeometry? scaleAlignment,
    this.distanceToObserver,
  }) : super([
          if (translateBetween != null)
            _MationTransformBase.translate(
              translateBetween,
              alignment: translateAlignment,
            ),
          if (rotateBetween != null)
            _MationTransformBase.rotate(
              rotateBetween,
              alignment: rotateAlignment,
            ),
          if (scaleBetween != null)
            _MationTransformBase.scale(
              scaleBetween,
              alignment: scaleAlignment,
            ),
        ]);

  MationTransform.sequence(
    List<
            (
              MationTransformBaseType,
              Between<Coordinate>,
              AlignmentGeometry?,
            )>
        sequence, {
    this.distanceToObserver,
  }) : super(sequence.foldWithIndex(
          [],
          (list, item, i) => list
            ..add(_MationTransformBase(
              item.$2,
              onAnimate: item.$1.onAnimate,
              alignment: item.$3,
            )),
        ));

  @override
  List<_MationTransformBase> get _list =>
      super._list.mapToList((m) => m..link(host));
}

///
///
/// extension
///
///

extension AnimationControllerExtension on AnimationController {
  void forwardReset({double? from}) => forward(from: from).then((_) => reset());

  void resetForward({double? from}) => this
    ..reset()
    ..forward(from: from);
}