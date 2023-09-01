part of source;

///
/// this file contains:
/// [MyAnimation]
/// [MyAnimationShaker]
///
///
/// [Ani]
/// [MationBase]
///   [Mation]
///     [MationTransform]
///     [MationTransition]
///     [MationClipper]
///   [Mations]
///     [MationStack]
///       [MationStackTransform]
///     [MationTransformHost]
///
/// TODO: MationText, MationList
/// [AnimatedListModification]
/// [AnimatedListItem]
///
/// typedef:
/// [AnimationBuilder], [AnimationsBuilder]
///
/// extension:
/// [_AnimationBuilderListExtension]
/// [_AnimationsBuilderListExtension]
/// [_FOnMatrix4Animate]
/// [_FTransitionBuilder]
///
///
///

///
/// ani
///

class MyAnimation extends StatefulWidget {
  const MyAnimation({
    super.key,
    this.ani = KAniInitForwardAndUpdateFor.second1,
    required this.mation,
    this.child = KSizedBox.none,
  });

  final MationBase mation;
  final Ani ani;
  final Widget child;

  @override
  State<MyAnimation> createState() => MyAnimationState();

  static MyAnimationState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAnimationState>()!;
}

class MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late MationBase _mation;

  WidgetBuilder get _builder => _mation.plan(
        controller: animationController,
        child: widget.child,
      );

  @override
  void initState() {
    _mation = widget.mation;
    final setting = widget.ani;

    animationController = setting.initialize(this);

    final statusListener = setting.statusListener;
    if (statusListener != null) {
      animationController.addStatusListener(statusListener);
    }

    setting.listenInit(animationController);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MyAnimation oldWidget) {
    _mation = widget.mation;
    final setting = widget.ani;
    animationController.isAnimating
        ? setting.onAnimating?.call()
        : setting.listenUpdate(animationController);

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => _builder(context);
}

class MyAnimationShaker extends StatelessWidget {
  const MyAnimationShaker({
    super.key,
    this.alignment = Alignment.center,
    this.adjustStart = true,
    required this.trigger,
    required this.amplitudeRadian,
    required this.times,
    required this.duration,
    required this.child,
  });

  final bool trigger;
  final bool adjustStart;
  final AlignmentGeometry alignment;
  final double amplitudeRadian;
  final double times;
  final Duration duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MyAnimation(
      ani: Ani.initForwardResetAndUpdateForwardReset(
        forward: duration,
      ),
      mation: MationTransform.rotate(
        MyTween(
          begin: Coordinate.zero,
          end: Coordinate.ofZ(amplitudeRadian),
          curve: CurveFR(FCurveRadian.sinPeriodOf(times)),
        ),
        alignment: alignment,
      ),
      child: child,
    );
  }
}

///
/// the named constructors or mation setting:
///
/// [Ani.fr]
/// [Ani.initForward]
/// [Ani.initRepeat]
/// [Ani.initForwardOrReverse]
/// [Ani.initForwardOrReverseFR]
/// [Ani.initForwardAndUpdateFor]
/// [Ani.initForwardAndUpdateForFR]
///
///
class Ani {
  final Duration forward;
  final Duration reverse;
  final AnimationControllerInitializer initializer;
  final AnimationStatusListener? statusListener;
  final AnimationControllerListener initListener;
  final AnimationControllerListener updateListener;
  final VoidCallback? onAnimating;

  const Ani({
    this.onAnimating,
    this.statusListener,
    this.forward = KDuration.second1,
    this.reverse = KDuration.second1,
    this.initializer = KAniSetting.initialize,
    this.initListener = KAniSetting.listenNothing,
    this.updateListener = KAniSetting.listenNothing,
  });

  /// named constructors

  /// fr constructors are the shortcut for setting [forward], [reverse] with the same instance
  const Ani.fr({
    this.onAnimating,
    this.statusListener,
    this.initializer = KAniSetting.initialize,
    this.initListener = KAniSetting.listenNothing,
    this.updateListener = KAniSetting.listenNothing,
    required Duration duration,
  })  : forward = duration,
        reverse = duration;

  /// init forward
  const Ani.initForward({
    this.onAnimating,
    this.statusListener,
    this.forward = KDuration.second1,
    this.initializer = KAniSetting.initialize,
  })  : reverse = forward,
        initListener = KAniSetting.listenForward,
        updateListener = KAniSetting.listenNothing;

  /// init repeat
  const Ani.initRepeat({
    bool reverseEnable = false,
    this.onAnimating,
    this.statusListener,
    this.forward = KDuration.second1,
    this.reverse = KDuration.second1,
    this.initializer = KAniSetting.initialize,
  })  : initListener = reverseEnable
            ? KAniSetting.listenRepeatReverse
            : KAniSetting.listenRepeat,
        updateListener = KAniSetting.listenNothing;

  /// init forward or reverse
  const Ani.initForwardOrReverse({
    this.onAnimating,
    this.statusListener,
    this.forward = KDuration.second1,
    this.reverse = KDuration.second1,
    this.initializer = KAniSetting.initialize,
    this.updateListener = KAniSetting.listenNothing,
  }) : initListener = KAniSetting.listenForwardOrReverse;

  const Ani.initForwardOrReverseFR({
    this.onAnimating,
    this.statusListener,
    this.initializer = KAniSetting.initialize,
    this.updateListener = KAniSetting.listenNothing,
    required Duration duration,
  })  : forward = duration,
        reverse = duration,
        initListener = KAniSetting.listenForwardOrReverse;

  /// init forward, update repeat
  const Ani.initForwardAndUpdateRepeat({
    bool reverseEnable = false,
    this.onAnimating,
    this.statusListener,
    this.forward = KDuration.second1,
    this.reverse = KDuration.second1,
    this.initializer = KAniSetting.initialize,
  })  : initListener = KAniSetting.listenForward,
        updateListener = reverseEnable
            ? KAniSetting.listenRepeat
            : KAniSetting.listenRepeatReverse;

  /// init forward, update reset and forward
  const Ani.initForwardAndUpdateResetForward({
    this.onAnimating,
    this.statusListener,
    this.forward = KDuration.second1,
    this.initializer = KAniSetting.initialize,
  })  : reverse = forward,
        initListener = KAniSetting.listenForward,
        updateListener = KAniSetting.listenResetForward;

  /// init forward reset, update reset and forward
  const Ani.initForwardResetAndUpdateForwardReset({
    this.onAnimating,
    this.statusListener,
    this.forward = KDuration.second1,
    this.initializer = KAniSetting.initialize,
  })  : reverse = forward,
        initListener = KAniSetting.listenForwardReset,
        updateListener = KAniSetting.listenForwardReset;

  /// init forward, update forward or reverse
  const Ani.initForwardAndUpdateFor({
    this.onAnimating,
    this.statusListener,
    this.forward = KDuration.second1,
    this.reverse = KDuration.second1,
    this.initializer = KAniSetting.initialize,
  })  : initListener = KAniSetting.listenForward,
        updateListener = KAniSetting.listenForwardOrReverse;

  const Ani.initForwardAndUpdateForFR({
    this.onAnimating,
    this.statusListener,
    this.initializer = KAniSetting.initialize,
    required Duration duration,
  })  : forward = duration,
        reverse = duration,
        initListener = KAniSetting.listenForward,
        updateListener = KAniSetting.listenForwardOrReverse;

  AnimationController initialize(TickerProvider ticker) =>
      initializer(ticker, forward, reverse);

  void listenInit(AnimationController c) => initListener(c);

  void listenUpdate(AnimationController c) => updateListener(c);
}

///
/// mation
///

///
///
/// Belows class inherits [MationBase],
/// they can be as [MyAnimation.mation] to trigger 1 tween animation.
/// [Mation]
/// [MationTransform]
/// [MationTransition]
/// [MationClipper]
///
/// Belows class can be as [MyAnimation.mation] to trigger multi-tween animation
/// [Mations]
/// [MationStack]
/// [MationTransformHost]
/// [MationStackTransform]
///
/// there will be TypeCastError if
/// ```
/// Iterable<Animation<T>> toAnimations(AnimationController controller);
/// _AnimationsBuilder<T> get builder;
/// ```
/// because [Mations] may have different [T]
///
///
abstract class MationBase<T> {
  const MationBase();

  AnimationsBuilder get builder;

  Iterable<Animation> toAnimations(AnimationController controller);

  WidgetBuilder plan({
    required AnimationController controller,
    required Widget child,
  }) {
    final animations = toAnimations(controller);
    return switch (this) {
      MationTransition() => (context) => builder(animations, child),
      _ => (context) => AnimatedBuilder(
            animation: controller,
            builder: (_, __) => builder(animations, child),
          ),
    };
  }
}

/// ani controller
abstract class Mation<T> extends MationBase<T> {
  final AnimationBuilder _builder;
  final MyTween<T> tween;

  Mation(
    this.tween, {
    AnimationBuilder builder = _defaultBuilder,
  }) : _builder = builder;

  static const _defaultBuilder = _animationBuilder;

  static Widget _animationBuilder(Animation animation, Widget child) => child;

  Animation<T> _toAnimation(AnimationController controller) =>
      tween.animate(controller);

  @override
  Iterable<Animation> toAnimations(AnimationController controller) =>
      [_toAnimation(controller)];

  @override
  AnimationsBuilder get builder => (as, child) => _builder(as.first, child);

  Mation<T> map(MationMapper<T> mapper) => mapper(this);

  Mation<T> follow(MyTweenMapper<T> mapper);
}

///
/// many [Mation]
///

class Mations<A extends MationBase> extends MationBase {
  ///
  /// although all the [Mations] subclasses must have an [Iterable] ani setups,
  /// nullable [_setups] makes their instance being able to be constant without computation;
  /// see [MationStack.controllers] for example
  ///
  final Iterable<A>? _setups;

  Mations({
    required Iterable<A>? controllers,
  }) : _setups = controllers;

  static final Mations empty = Mations(controllers: []);

  Iterable<A> get controllers => _setups!;

  Iterable<Mation> get _flattedSetup {
    final controllers = this.controllers;

    return switch (controllers) {
      Iterable<Mation>() => controllers,
      Iterable<Mations<Mation>>() => (controllers as Iterable<Mations<Mation>>)
          .map((ms) => ms.controllers)
          .flat(),
      Iterable<Mations<Mations<Mation>>>() =>
        (controllers as Iterable<Mations<Mations<Mation>>>)
            .map((a1) => a1.controllers.map((a2) => a2.controllers).flat())
            .flat(),
      _ => throw UnimplementedError('$this'),
    } as Iterable<Mation>;
  }

  @override
  Iterable<Animation> toAnimations(AnimationController controller) =>
      _flattedSetup.map((setup) => setup._toAnimation(controller));

  @override
  AnimationsBuilder get builder => _flattedSetup
      .map((setup) => setup._builder)
      .toList(growable: false)
      .animate;

  ///
  /// these getters help subclasses to return [MationBase.builder]
  ///
  int get setupsLength => controllers.length;

  List<AnimationsBuilder> get _animationsBuilderList =>
      controllers.map((setup) => setup.builder).toList(growable: false);

  Iterable<int> get _animationsBuilderChunks {
    final setups = this.controllers;

    if (setups is Iterable<Mation>) {
      return Iterable.generate(setupsLength, (_) => 1);

      //
    } else if (setups is Iterable<Mations<Mation>>) {
      return (setups as Iterable<Mations<Mation>>)
          .map((iterable) => iterable.setupsLength);

      //
    } else if (setups is Iterable<Mations<Mations<Mation>>>) {
      throw UnimplementedError();

      //
    } else {
      throw UnimplementedError();
    }
  }

// TODO: foreachMap, foreachFollow
}

/// stacker
class MationStack<W extends Widget, A extends MationBase> extends Mations<A> {
  ///
  /// nullable properties makes inheritance more flexible, see [MationStackTransform]
  ///
  final Map<W, A>? _children;
  final AlignmentGeometry alignment;
  final bool deviateAlignment;

  Map<W, A> get children => _children ?? {};

  MationStack({
    required Map<W, A>? children,
    this.alignment = Alignment.topLeft,
    this.deviateAlignment = true,
  })  : _children = children,
        super(controllers: null);

  @override
  Iterable<A> get controllers => children.values;

  @override
  AnimationsBuilder get builder => stack();

  AnimationsBuilder stack({int skip = 0}) {
    final chunk = _animationsBuilderChunks.skip(skip);
    final builders = _animationsBuilderList.sublist(skip);
    final children = this.children.keys.toList(growable: false);

    Stack build(Iterable<Animation> animations) => _stack(
          animationsChunks: animations.chunk(chunk),
          animationsBuilders: builders,
          children: children,
        );

    /// check if deviate alignment
    if (deviateAlignment) {
      if (alignment is Alignment) {
        final deviate = (alignment as Alignment).deviateBuilder;
        return (animations, _) => deviate(build(animations));
      } else {
        throw UnimplementedError();
      }
    } else {
      return (animations, _) => build(animations);
    }
  }

  Stack _stack({
    required Iterable<Iterable<Animation>> animationsChunks,
    required List<AnimationsBuilder> animationsBuilders,
    required List<Widget> children,
  }) =>
      Stack(
        alignment: alignment,
        children: animationsBuilders.animate(animationsChunks, children),
      );
}

/// transformer
class MationTransform extends Mation<Coordinate> {
  final Matrix4 matrix4;
  final OnMatrix4Animate<Coordinate> computation;
  final AlignmentGeometry? alignment;

  MationTransform._(
    super.tween, {
    required this.matrix4,
    required this.computation,
    required this.alignment,
  });

  MationTransform(
    super.tween, {
    Matrix4? initialMatrix4,
    this.alignment,
    required this.computation,
  }) : matrix4 = initialMatrix4 ?? Matrix4.identity();

  MationTransform.scale(
    super.tween, {
    Matrix4? initialMatrix4,
    this.alignment,
  })  : matrix4 = initialMatrix4 ?? Matrix4.identity(),
        computation = _FOnMatrix4Animate.scaling();

  MationTransform.rotate(
    super.tween, {
    Matrix4? initialMatrix4,
    Coordinate rotated = Coordinate.zero,
    this.alignment,
  })  : matrix4 = initialMatrix4 ?? Matrix4.identity(),
        computation = _FOnMatrix4Animate.rotating(rotated: rotated),
        super();

  MationTransform.translate(
    super.tween, {
    Matrix4? initialMatrix4,
    this.alignment,
  })  : matrix4 = initialMatrix4 ?? Matrix4.identity(),
        computation = _FOnMatrix4Animate.translating(),
        super();

  AnimationBuilder _transform(OnMatrix4Animate<Coordinate> animate) =>
      ((animation, child) => Transform(
            transform: animate(matrix4, animation.value),
            alignment: alignment,
            child: child,
          ));

  @override
  AnimationBuilder get _builder => _transform(computation);

  @override
  MationTransform follow(MyTweenMapper<Coordinate> mapper) => MationTransform._(
        mapper(tween),
        matrix4: matrix4,
        alignment: alignment,
        computation: computation,
      );

  @override
  MationTransform map(MationMapper<Coordinate> mapper) =>
      super.map(mapper) as MationTransform;

  MationTransform link(
    Matrix4 matrix4,
    AlignmentGeometry alignment, {
    OnMatrix4Animate? computation,
  }) =>
      MationTransform._(
        tween,
        matrix4: matrix4,
        alignment: alignment,
        computation: computation ?? this.computation,
      );
}

/// transformer host
class MationTransformHost extends Mations<Mation<Coordinate>> {
  final Matrix4 matrix4;
  final AlignmentGeometry alignment;

  final Coordinate? _scaled;
  final Coordinate? _rotated;
  final Coordinate? _translated;

  final MationTransform? _scaling;
  final MationTransform? _rotating;
  final MationTransform? _translating;

  /// see [translationScale] for detail
  final double distanceToObserver;

  MationTransformHost({
    this.alignment = Alignment.center,
    Coordinate scaled = KCoordinate.cube_1,
    Coordinate rotated = Coordinate.zero,
    Coordinate translated = Coordinate.zero,
    this.distanceToObserver = defaultDistanceFromContentToObserver,
  })  : matrix4 = Matrix4.identity(),
        _scaled = scaled,
        _rotated = rotated,
        _translated = translated,
        _scaling = null,
        _rotating = null,
        _translating = null,
        super(controllers: null);

  MationTransformHost.transformable({
    this.alignment = Alignment.center,
    MationTransform? scaling,
    MationTransform? rotating,
    MationTransform? translating,
    this.distanceToObserver = defaultDistanceFromContentToObserver,
  })  : matrix4 = Matrix4.identity(),
        _scaled = null,
        _rotated = null,
        _translated = null,
        _scaling = scaling ?? VMationTransformScale.scale_1xyz,
        _rotating = rotating ?? VMationTransformRotate.none,
        _translating = translating ?? VMationTransformTranslate.none,
        super(controllers: null);

  static final MationTransformHost none = MationTransformHost();
  static const double defaultDistanceFromContentToObserver = 1000;

  MationTransform get scaling =>
      _scaling ??
      MationTransform.scale(
        MyTween.constant(_scaled!),
        alignment: alignment,
      );

  MationTransform get rotating =>
      _rotating ??
      MationTransform.rotate(
        MyTween.constant(_rotated!),
        alignment: alignment,
      );

  MationTransform get translating =>
      _translating ??
      MationTransform.translate(
        MyTween.constant(_translated!),
        alignment: alignment,
      );

  ///
  /// scaling when translating [Coordinate.dz]
  ///
  /// c: content    (on Coordinate.dz == 0)
  /// o: observer   (on Coordinate.dz == [defaultDistanceFromContentToObserver])
  ///
  /// - [translating.tween.begin] * [translating.tween.end] > 0 == true
  /// - proportion: (o - begin) : (o - end) = borderBegin : borderEnd
  ///
  /// sizeScale = sizeBegin / sizeEnd = (o - [translating.tween.begin])^2 / (o - [translating.tween.end])^2
  /// borderScale = [deltaBegin] / [deltaEnd]
  ///

  MationTransform get translationScale {
    final tween = translating.tween;
    final deltaBegin = distanceToObserver - tween.begin.dz;
    final deltaEnd = distanceToObserver - tween.end.dz;

    assert(
      /// delta == 0 is on observer
      deltaBegin > 0 && deltaEnd > 0,
      "try not to observe things on your eye or behind your head",
    );

    final scaleProportion = deltaBegin / deltaEnd;

    return MationTransform._(
      MyTween(
        begin: KCoordinate.cube_1,
        end: Coordinate.cube(scaleProportion),
      ),
      matrix4: Matrix4.identity(),
      alignment: translating.alignment,
      computation: _FOnMatrix4Animate.scaling(),
    );
  }

  @override
  Iterable<Mation<Coordinate>> get controllers => [
        scaling.link(matrix4, alignment),
        rotating.link(matrix4, alignment),
        translating.link(matrix4, alignment),
        translationScale.link(matrix4, alignment),
      ];
}

/// transformer host stacker
class MationStackTransform extends MationStack<Widget, MationTransformHost> {
  final MationTransformHost host;

  MationStackTransform({
    MationTransformHost? host,
    super.alignment,
    super.deviateAlignment,
    super.children,
  }) : host = host ?? MationTransformHost.none;

  ///
  /// [controllers] is [Iterable]<[MationTransformHost]>
  /// [setupsLength] is planes count (length of iterable [controllers])
  ///
  /// [animationsBuilderChunks] is iterable int of the length of [MationTransformHost.controllers]
  /// [animationsBuilderList] is a list of [Mations.builder]s that come form [MationTransformHost].
  /// a [MationTransformHost]'s builder comes from [Mations.builder],
  /// and [MationTransformHost.controllers] is [Iterable]<[Mation]>.
  /// in conclusion,
  /// the first depth of [animationsBuilderList] is [setupsLength],
  /// the second depth of [animationsBuilderList] depend on the amount of [MationTransformHost.controllers].
  ///
  /// in this case,
  /// [controllers] lead to 4 * (1 + n) [AnimationBuilder], because a [MationTransformHost] trigger 4 [AnimationBuilder]
  ///
  @override
  Iterable<MationTransformHost> get controllers => [host, ...super.controllers];

  @override
  AnimationsBuilder get builder {
    final hostSetupCount = host.controllers.length;
    final hostBuilder = host.builder;

    return (animations, child) => hostBuilder(
          animations.take(hostSetupCount),
          stack(skip: 1)(animations.skip(hostSetupCount), child),
        );
  }
}

/// transitioner
///
/// must define the generic type as same as the tween type
class MationTransition<T> extends Mation<T> {
  MationTransition._(
    super.tween, {
    required super.builder,
  });

  MationTransition.translate(super.tween)
      : assert(T == Offset || T == Coordinate),
        super(builder: _FTransitionBuilder.slide);

  MationTransition.scale(
    super.tween, {
    Alignment? alignment,
  })  : assert(T == double),
        super(builder: _FTransitionBuilder.scale(alignment));

  MationTransition.rotate(super.tween)
      : assert(T == double),
        super(builder: _FTransitionBuilder.rotation);

  MationTransition.fade(super.tween)
      : assert(T == double),
        super(builder: _FTransitionBuilder.fade);

  MationTransition.decoration(DecorationTween tween)
      : super(
          MyTween(
            begin: tween.begin as T,
            end: tween.end! as T,
            onLerp: _onDecorationLerp(tween) as OnLerp<T>,
          ),
          builder: _FTransitionBuilder.decoration,
        );

  static OnLerp<Decoration> _onDecorationLerp(DecorationTween tween) =>
      (t) => Decoration.lerp(tween.begin, tween.end, t)!;

  // ...

  @override
  MationTransition<T> map(MationMapper<T> mapper) =>
      super.map(mapper) as MationTransition<T>;

  @override
  MationTransition<T> follow(MyTweenMapper<T> mapper) => MationTransition._(
        mapper(tween),
        builder: _builder,
      );
}

class MationPainter extends Mation<SizeToPath> {
  final bool isComplex;
  final bool willChange;
  final CustomPainter? foregroundPainter;
  final Size size;
  final CanvasListener canvasListener;
  final CanvasSizeToPaint canvasSizeToPaint;

  MationPainter._(
    super.tween, {
    required this.isComplex,
    required this.willChange,
    required this.foregroundPainter,
    required this.size,
    required this.canvasListener,
    required this.canvasSizeToPaint,
  });

  MationPainter.drawPathTweenWithPaint(
    PathTween pathTween, {
    required this.canvasSizeToPaint,
  })  : isComplex = false,
        willChange = true,
        size = Size.zero,
        foregroundPainter = null,
        canvasListener = FCanvasListener.drawPathWithPaint,
        super(pathTween);

  @override
  AnimationBuilder get _builder => (animation, child) => CustomPaint(
        painter: MyPainter.rePaintOf(
          canvasSizeToPaint: canvasSizeToPaint,
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
  MationPainter follow(MyTweenMapper<SizeToPath> mapper) => MationPainter._(
        tween,
        isComplex: isComplex,
        willChange: willChange,
        foregroundPainter: foregroundPainter,
        size: size,
        canvasListener: canvasListener,
        canvasSizeToPaint: canvasSizeToPaint,
      );
}

class MationClipper extends Mation<SizeToPath> {
  final Clip behavior;

  MationClipper._(
    super.tween, {
    required this.behavior,
  });

  MationClipper(
    PathTween pathTween, {
    this.behavior = Clip.antiAlias,
  }) : super(pathTween);

  @override
  AnimationBuilder get _builder => (animation, child) => ClipPath(
        clipper: MyClipper.reClipOf(animation.value),
        clipBehavior: behavior,
        child: child,
      );

  @override
  MationClipper follow(MyTweenMapper<SizeToPath> mapper) => MationClipper._(
        tween,
        behavior: behavior,
      );
}

///
/// list
///

/// animated list data
class AnimatedListModification {
  final AnimatedItemPlan itemPlan;
  final AnimatedListItemIndexCreator index;
  final AnimatedListItemInsertListener insert;
  final AnimatedListItemUpdateListener remove;
  final AnimatedListItemUpdateListener onTap;

  // final AnimatedListItemUpdate onDrag;
  // final AnimatedListItemUpdate onPress;
  // final AnimatedListItemUpdate onPressLong;

  const AnimatedListModification({
    this.itemPlan = FListAnimatedItemBuilder.plan1,
    this.index = FListAnimatedItemListener.index0,
    this.insert = FListAnimatedItemListener.insert0,
    this.remove = FListAnimatedItemListener.remove0,
    this.onTap = FListAnimatedItemListener.onTap0,
  });

  static const instance = AnimatedListModification();
}

class AnimatedListItem {
  final String data;

  const AnimatedListItem({
    required this.data,
  });
}

///
/// typedef
///

typedef AnimationBuilder<T> = Widget Function(
  Animation<T> animation,
  Widget child,
);
typedef AnimationsBuilder<T> = Widget Function(
  Iterable<Animation<T>> animations,
  Widget child,
);

///
/// extension
///

extension _AnimationBuilderListExtension<T> on List<AnimationBuilder<T>> {
  Widget animate(Iterable<Animation<T>> animations, Widget child) =>
      animations.foldWithIndex(
        child,
        (child, animation, index) => this[index](animation, child),
      );
}

extension _AnimationsBuilderListExtension<T> on List<AnimationsBuilder<T>> {
  List<Widget> animate(
    Iterable<Iterable<Animation<T>>> animationsList,
    List<Widget> children,
  ) =>
      animationsList.foldWithIndex(
        [],
        (list, animations, index) => list
          ..add(
            this[index](animations, children[index]),
          ),
      );
}

extension _FOnMatrix4Animate on OnMatrix4Animate {
  static OnMatrix4Animate<Coordinate> scaling({
    OnMatrix4D3ValueAnimate? mapper,
  }) =>
      mapper == null
          ? (Matrix4 matrix4, Coordinate value) => matrix4.scaled(
                value.dx,
                value.dy,
                value.dz,
              )
          : (Matrix4 matrix4, Coordinate value) => matrix4.scaled(
                mapper(Dimension.x, value.dx),
                mapper(Dimension.y, value.dy),
                mapper(Dimension.z, value.dz),
              );

  static OnMatrix4Animate<Coordinate> translating({
    Coordinate translated = Coordinate.zero,
    OnMatrix4D3ValueAnimate? mapper,
  }) =>
      mapper == null
          ? (Matrix4 matrix4, Coordinate value) =>
              Matrix4.identity().translated(translated)
                ..translate(value.dx, value.dy, value.dz)
          : (Matrix4 matrix4, Coordinate value) =>
              Matrix4.identity().translated(translated)
                ..translate(
                  mapper(Dimension.x, value.dx),
                  mapper(Dimension.y, value.dy),
                  mapper(Dimension.z, value.dz),
                );

  static OnMatrix4Animate<Coordinate> rotating({
    Coordinate? rotated,
    OnMatrix4D3ValueAnimate? mapper,
  }) {
    final fixedMatrix4 = rotated == null
        ? () => Matrix4.identity()
        : () => Matrix4.identity().rotated(rotated);

    final fixedX =
        rotated == null ? (double x) => x : (double dx) => rotated.dx + dx;

    final fixedY =
        rotated == null ? (double dy) => dy : (double dy) => rotated.dy + dy;

    final fixedZ =
        rotated == null ? (double dz) => dz : (double dz) => rotated.dz + dz;

    final rotate = mapper == null
        ? (Coordinate value) => fixedMatrix4()
          ..rotateX(fixedX(value.dx))
          ..rotateY(fixedY(value.dy))
          ..rotateZ(fixedZ(value.dz))
        : (Coordinate value) => fixedMatrix4()
          ..rotateX(mapper(Dimension.x, fixedX(value.dx)))
          ..rotateY(mapper(Dimension.y, fixedY(value.dy)))
          ..rotateZ(mapper(Dimension.z, fixedZ(value.dz)));

    return (Matrix4 matrix4, Coordinate value) =>
        matrix4..setRotation(rotate(value).getRotation());
  }
}

extension _FTransitionBuilder on AnimationBuilder {
  static Widget slide(Animation animation, Widget child) => SlideTransition(
        position: animation as Animation<Offset>,
        child: child,
      );

  static AnimationBuilder scale(Alignment? scaleAlignment) =>
      (Animation animation, Widget child) => ScaleTransition(
            scale: animation as Animation<double>,
            alignment: scaleAlignment ?? Alignment.center,
            child: child,
          );

  static Widget rotation(Animation animation, Widget child) =>
      RotationTransition(
        turns: animation as Animation<double>,
        child: child,
      );

  static Widget decoration(Animation animation, Widget child) =>
      DecoratedBoxTransition(
        decoration: animation as Animation<Decoration>,
        child: child,
      );

  static Widget fade(Animation animation, Widget child) => FadeTransition(
        opacity: animation as Animation<double>,
        child: child,
      );

  static AnimationBuilder size(Axis? sizeAxis, double? sizeAxisAlignment) =>
      (Animation animation, Widget child) => SizeTransition(
            sizeFactor: animation as Animation<double>,
            axis: sizeAxis ?? Axis.vertical,
            axisAlignment: sizeAxisAlignment ?? 0.0,
            child: child,
          );

  static Widget align(Animation animation, Widget child) => AlignTransition(
        alignment: animation as Animation<Alignment>,
        child: child,
      );

  static Widget defaultTextStyle(Animation animation, Widget child) =>
      DefaultTextStyleTransition(
        style: animation as Animation<TextStyle>,
        child: child,
      );

  static Widget positioned(Animation animation, Widget child) =>
      PositionedTransition(
        rect: animation as Animation<RelativeRect>,
        child: child,
      );

  static Widget silverFade(Animation animation, Widget child) =>
      SliverFadeTransition(
        opacity: animation as Animation<double>,
        sliver: child,
      );

  static AnimationBuilder relativePositioned(Size relativePositionSize) =>
      (Animation animation, Widget child) => RelativePositionedTransition(
            rect: animation as Animation<Rect>,
            size: relativePositionSize,
            child: child,
          );
}
