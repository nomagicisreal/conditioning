part of source;

///
/// this file contains:
/// [DurationFR]
/// [CurveFR]
///
/// [Between]
/// [BetweenPath]
/// [BetweenRRegularPolygon]
///
/// [MyCurve]
/// [MyClipper]
/// [MyPainter]
/// [MyOverlay]
///
/// the helpers for building widgets:
/// [FabExpandableSetup]
/// [Leader], [Follower], [FollowerState]
///
/// TODO:
/// [AnimatedListModification], [AnimatedListItem]
///
///

class DurationFR {
  final Duration forward;
  final Duration reverse;

  const DurationFR(this.forward, this.reverse);

  const DurationFR.constant(Duration duration)
      : forward = duration,
        reverse = duration;

  DurationFR operator ~/(int value) => DurationFR(
        forward ~/ value,
        reverse ~/ value,
      );
}

class CurveFR {
  final Curve forward;
  final Curve? _reverse;
  final Mapper<Curve>? _reverseMapper;

  Curve get reverse => _reverse ?? _reverseMapper!(forward);

  const CurveFR(
    this.forward,
    Curve reverse,
  )   : _reverse = reverse,
        _reverseMapper = null;

  const CurveFR.constant(Curve curve)
      : forward = curve,
        _reverse = curve,
        _reverseMapper = null;

  CurveFR.constantInterval(double begin, double end, CurveFR curve)
      : forward = Interval(begin, end, curve: curve.forward),
        _reverse = Interval(begin, end, curve: curve.reverse),
        _reverseMapper = null;

  CurveFR.fromMapper(
    this.forward, {
    Mapper<Curve>? reverseMapper = KMapper.curveFlipped,
  })  : _reverseMapper = reverseMapper,
        _reverse = null;

  CurveFR get flipped => CurveFR.fromMapper(reverse);
}

///
///
/// [Between.constant]
/// [Between.sequence]
///
/// [_onLerp]
/// [_onLerpConstant]
///
/// [reverse]
/// [follow]
///
///

class Between<T> extends Tween<T> {
  final OnLerp<T> onLerp;
  final CurveFR curve;

  @override
  T get begin => super.begin!;

  @override
  T get end => super.end!;

  @override
  T transform(double t) => onLerp(t);

  @override
  Animation<T> animate(Animation<double> parent) =>
      super.animate(CurvedAnimation(
        parent: parent,
        curve: curve.forward,
        reverseCurve: curve.reverse,
      ));

  Between({
    this.curve = KCurveFR.fastOutSlowIn,
    OnLerp<T>? onLerp,
    required T super.begin,
    required T super.end,
  }) : onLerp = onLerp ?? FOnLerp.of(begin, end);

  Between.constant(
    T value, {
    this.curve = KCurveFR.fastOutSlowIn,
  })  : onLerp = FOnLerp.constant(value),
        super(begin: value, end: value);

  factory Between.sequence({
    CurveFR curve = KCurveFR.linear,
    required bool isElementCurveForward,
    required T begin,
    required Iterable<(double, T, CurveFR)> intervals, // weight, value, curve
  }) {
    T current = begin;

    final curveOf = isElementCurveForward
        ? (CurveFR curve) => CurveTween(curve: curve.forward)
        : (CurveFR curve) => CurveTween(curve: curve.reverse);

    final list = intervals.isEmpty
        ? [TweenSequenceItem(tween: Between.constant(begin), weight: 1.0)]
        : intervals.mapToList((interval) {
            final previous = current;
            current = interval.$2;
            return TweenSequenceItem(
              tween: Between(begin: previous, end: current)
                  .chain(curveOf(interval.$3)),
              weight: interval.$1,
            );
          });

    return Between(
      curve: curve,
      begin: begin,
      end: list.last.tween.transform(1.0),
      onLerp: TweenSequence(list).transform,
    );
  }

  Between<T> get reverse => Between(
        begin: end,
        end: begin,
        onLerp: onLerp,
        curve: curve,
      );

  ///
  /// follow
  ///

  Between<T> follow(T next) =>
      Between<T>(begin: end, end: next, onLerp: onLerp, curve: curve);

  Between<T> followPlus(T next) => Between<T>(
        begin: end,
        end: Operator.plus.operationOf(end, next),
        onLerp: onLerp,
        curve: curve,
      );

  Between<T> followMinus(T next) => Between<T>(
        begin: end,
        end: Operator.minus.operationOf(end, next),
        onLerp: onLerp,
        curve: curve,
      );

  Between<T> followMultiply(T next) => Between<T>(
        begin: end,
        end: Operator.multiply.operationOf(end, next),
        onLerp: onLerp,
        curve: curve,
      );

  Between<T> followDivide(T next) => Between<T>(
        begin: end,
        end: Operator.divide.operationOf(end, next),
        onLerp: onLerp,
        curve: curve,
      );
}

class BetweenPath<T> extends Between<Translator<Size, Path>> {
  BetweenPath._({
    required super.begin,
    required super.end,
    required super.onLerp,
    required super.curve,
  });

  BetweenPath.constant(
    Translator<Size, Path> path, {
    CurveFR curve = KCurveFR.fastOutSlowIn,
  }) : super(begin: path, end: path, onLerp: (t) => path, curve: curve);

  BetweenPath.fromTween(
    Between<T> tween, {
    CurveFR curve = KCurveFR.fastOutSlowIn,
    required OnLerpPath<T> lerp,
  }) : super(
          begin: lerp(tween.begin),
          end: lerp(tween.end),
          onLerp: (t) => lerp(tween.transform(t)),
          curve: curve,
        );

  BetweenPath.fromTweenList(
    List<Between<T>> list, {
    CurveFR curve = KCurveFR.fastOutSlowIn,
    required OnLerpPath<List<T>> lerp,
  }) : super(
          begin: lerp(list.map((e) => e.begin).toList(growable: false)),
          end: lerp(list.map((e) => e.end).toList(growable: false)),
          onLerp: (t) => lerp(
            list.map((e) => e.transform(t)).toList(growable: false),
          ),
          curve: curve,
        );

  BetweenPath.fromShapeBorder(
    Between<ShapeBorder> shape, {
    CurveFR curve = KCurveFR.fastOutSlowIn,
    OnLerpPath<ShapeBorder> lerp = FOnLerpPath.shapeOuterLtr,
  }) : super(
          begin: lerp(shape.begin),
          end: lerp(shape.end),
          onLerp: (t) => lerp(shape.onLerp(t)),
          curve: curve,
        );

  factory BetweenPath.dynamicTrace({
    Offset start = Offset.zero,
    CurveFR curve = KCurveFR.fastOutSlowIn,
    required Tween<Offset> point,
    required OnLerpPath<List<Offset>> plan,
  }) {
    Offset current = start;
    return BetweenPath._(
      begin: plan([current, point.begin!].toList(growable: false)),
      end: plan([current, point.end!].toList(growable: false)),
      onLerp: (t) {
        final before = current;
        current = point.transform(t);
        return plan([before, current].toList(growable: false));
      },
      curve: curve,
    );
  }
}

class BetweenRRegularPolygon extends BetweenPath<double> {
  BetweenRRegularPolygon._({
    required List<Between<double>> tweenList,
    required OnLerpPath<List<double>> polygonPlan,
    required CurveFR curve,
  }) : super.fromTweenList(tweenList, lerp: polygonPlan, curve: curve);

  ///
  /// to set the proper [edgeVectorTimes], see [RRegularPolygonCubicOnEdge.timesForEdge]
  /// to set the proper [cornerRadius], see [RRegularPolygonCubicOnEdge.cornerRadius]
  ///
  factory BetweenRRegularPolygon({
    bool invertFromSize = false,
    Between<double>? edgeVectorTimes,
    Between<double>? scale,
    MapperWith<List<Offset>, Size> transform =
        FOffsetListWithSize.transformPointsToSizeCenter,
    CurveFR curve = KCurveFR.fastOutSlowIn,
    required Between<double> cornerRadius,
    required RRegularPolygon polygon,
  }) =>
      BetweenRRegularPolygon._(
        tweenList: [
          scale ?? FBetweenDouble.k1,
          edgeVectorTimes ?? FBetweenDouble.zero,
          cornerRadius,
        ],
        polygonPlan: switch (polygon) {
          RRegularPolygonCubicOnEdge() => (values) =>
              FPathFromSize.polygonCubicCornerFromSize(
                (polygon
                      ..timesForEdge = values[1]
                      ..cornerRadius = values[2])
                    .cubicPoints,
                invertFromSize: invertFromSize,
                scale: values[0],
                transform: transform,
              ),
        },
        curve: curve,
      );
}

///
///
///
/// curve
///
///
///

class MyCurve extends Curve {
  final Mapper<double> mapper;

  const MyCurve(this.mapper);

  MyCurve.sinPeriodOf(int times)
      : mapper = FMapperDouble.sinFromPeriod(times.toDouble());

  @override
  double transformInternal(double t) => mapper(t);
}

class MyClipper extends CustomClipper<Path> {
  final Translator<Size, Path> sizeToPath;
  final bool Function(MyClipper oldClipper, MyClipper clipper) shouldReClip;

  @override
  Path getClip(Size size) => sizeToPath(size);

  @override
  bool shouldReclip(MyClipper oldClipper) => shouldReClip(oldClipper, this);

  static bool _reClipWhenDiff(MyClipper oldClipper, MyClipper clipper) =>
      oldClipper.sizeToPath != clipper.sizeToPath;

  static bool _reClipNever(MyClipper oldClipper, MyClipper clipper) => false;

  const MyClipper.reClipOf(this.sizeToPath) : shouldReClip = _reClipWhenDiff;

  const MyClipper.reClipNeverOf(this.sizeToPath) : shouldReClip = _reClipNever;
}

class MyPainter extends CustomPainter {
  final PaintFromCanvasSize paintFromCanvasSize;
  final Translator<Size, Path> sizeToPath;
  final CanvasProcessor canvasListener;
  final bool Function(MyPainter oldPainter, MyPainter painter) _shouldRePaint;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = paintFromCanvasSize(canvas, size);
    final path = sizeToPath(size);
    canvasListener(canvas, paint, path);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) =>
      _shouldRePaint(oldDelegate, this);

  static bool _rePaintWhenDiff(MyPainter oldPainter, MyPainter painter) =>
      oldPainter != painter;

  static bool _rePaintNever(MyPainter oldPainter, MyPainter painter) => false;

  @override
  bool operator ==(covariant MyPainter other) => identical(this, other);

  @override
  int get hashCode => Object.hash(
        paintFromCanvasSize.hashCode,
        sizeToPath.hashCode,
        canvasListener.hashCode,
      );

  const MyPainter.rePaintOf({
    this.canvasListener = FCanvasProcessor.drawPathWithPaint,
    required this.sizeToPath,
    required this.paintFromCanvasSize,
  }) : _shouldRePaint = _rePaintWhenDiff;

  const MyPainter.rePaintNever({
    this.canvasListener = FCanvasProcessor.drawPathWithPaint,
    required this.paintFromCanvasSize,
    required this.sizeToPath,
  }) : _shouldRePaint = _rePaintNever;
}

class MyOverlay {
  MyOverlay();

  List<OverlayEntry> entries = [];

  ///
  /// it seems that if passing variables to static method, the arguments won't update when [OverlayEntry.markNeedsBuild].
  /// instead of assigning all variables to static arguments in here directly,
  /// it's necessary to have [Caller] as arguments calling variables.
  ///
  /// See Also:
  ///   * [addFadingEntry]
  ///
  static OverlayEntry fadeInDecide<S>({
    bool opaque = false,
    bool maintainState = false,
    CurveFR curve = KCurveFR.linear,
    DurationFR duration = KDurationFR.second1,
    AnimatingProcessor onAnimating = FOnAnimatingProcessor.nothing,
    AnimationStatusListener initialStatusListener =
        FAnimationStatusListener.listenNothing,
    required Decider<AnimationController, S> updateDecide,
    required Caller<S> shouldDecide,
    required WidgetBuilder builder,
  }) =>
      OverlayEntry(
        opaque: opaque,
        maintainState: maintainState,
        builder: (context) => MyAnimation(
          ani: Ani.initForward(
            duration: duration,
            initialStatusListener: initialStatusListener,
            updateProcess: updateDecide(shouldDecide()),
            onAnimating: onAnimating,
          ),
          mation: MationTransitionDouble.fadeIn(curve: curve),
          child: builder(context),
        ),
      );

  void addFadingEntry({
    bool isDecideToFadeOutAndRemoveWhenDismissed = true,
    bool opaque = false,
    bool maintainState = false,
    CurveFR curve = KCurveFR.linear,
    DurationFR duration = KDurationFR.milli300,
    AnimatingProcessor onAnimating = FOnAnimatingProcessor.nothing,
    required BuildContext context,
    required Caller<bool> shouldFadeOut,
    required WidgetBuilder builder,
  }) {
    if (isDecideToFadeOutAndRemoveWhenDismissed) {
      late final OverlayEntry entry;
      void remove() => entry.remove();
      entry = MyOverlay.fadeInDecide<bool>(
        duration: duration,
        initialStatusListener: FAnimationStatusListener.dismissedListen(remove),
        updateDecide: FAni.decideReverse,
        shouldDecide: shouldFadeOut,
        onAnimating: onAnimating,
        builder: builder,
      );
      entries.add(entry..insert(context));
    } else {
      throw UnimplementedError();
    }
  }

  ///
  /// [removeLast] is really "remove" only if the entry is added by [addFadingEntry],
  /// or other entry that will be removed after rebuild
  ///
  void removeLast() {
    try {
      entries.last.markNeedsBuild();
      entries.removeLast();
    } catch (noElement) {
      return;
    }
  }
}

///
///
///
///
///
/// origin classes
///
///
///
///
///
///

///
/// See also:
/// [FabExpandable]
///
class FabExpandableSetup {
  final Rect positioned;
  final Alignment alignment;
  final DurationFR duration;
  final Decider<AnimationController, bool> updateHear;
  final Generator<MationBase> mationsGenerator;
  final List<(Icon, VoidCallback)> icons;

  Ani aniOf(bool isOpen) => Ani.initForward(
        duration: duration,
        updateProcess: updateHear(isOpen),
        onAnimating: FOnAnimatingProcessor.back,
      );

  FabExpandableSetup._({
    required this.positioned,
    required this.alignment,
    required this.duration,
    required this.updateHear,
    required this.mationsGenerator,
    required this.icons,
  });

  factory FabExpandableSetup.orbitOnOpenIcon({
    double distance = 2,
    double maxElementsIconSize = 24,
    DurationFR duration = KDurationFR.milli800,
    CurveFR curve = KCurveFR.fastOutSlowIn_easeOutQuad,
    Decider<AnimationController, bool> updateHear = FAni.decideForwardOrReverse,
    Processor<Mations<dynamic, Mation>> mationsListener = kMationsProcessor,
    required BuildContext context,
    required Rect openIconRect,
    required Generator<double> direction,
    required List<(Icon, VoidCallback)> icons,
  }) {
    final maxElementsIconSize = icons.maxSizeOf(context);
    return FabExpandableSetup._(
      positioned: RectExtension.fromCircle(
        openIconRect.center,
        maxElementsIconSize * (1 + 2 * distance),
      ),
      alignment: Alignment.center,
      duration: duration,
      updateHear: updateHear,
      mationsGenerator: (index) => Mations<dynamic, Mation>([
        MationTransitionDouble.fade(0, 1, curve: curve),
        MationTransitionOffset.ofDirection(
          direction(index),
          (0, distance),
          curve: CurveFR.constantInterval(0.2 * index, 1.0, curve),
        ),
      ])
        ..configure(mationsListener),
      icons: icons,
    );
  }

  factory FabExpandableSetup.line({
    double distance = 1.2,
    DurationFR duration = KDurationFR.milli800,
    CurveFR curve = KCurveFR.ease,
    Decider<AnimationController, bool> updateHear = FAni.decideForwardOrReverse,
    Processor<Mations<dynamic, Mation>> mationsListener = kMationsProcessor,
    required BuildContext context,
    required Rect openIconRect,
    required Direction2DIn8 direction,
    required List<(Icon, VoidCallback)> icons,
  }) {
    final maxElementsIconSize = icons.maxSizeOf(context);
    return FabExpandableSetup._(
      positioned: openIconRect.expandToIncludeDirection(
        direction: direction,
        width: maxElementsIconSize * 2,
        length: maxElementsIconSize * 2 * distance * icons.length,
      ),
      alignment: direction.flipped.toAlignment,
      duration: duration,
      updateHear: updateHear,
      mationsGenerator: (index) => Mations<dynamic, Mation>([
        MationTransitionOffset(
          Offset.zero,
          direction.toOffset * distance * (index + 1).toDouble(),
        ),
        MationTransitionDouble.scale(
          0.0,
          1.0,
          curve: CurveFR.constantInterval(0.2 * index, 1.0, curve),
        ),
      ]),
      icons: icons,
    );
  }
}

///
///
///
///
/// See Also:
/// [LeaderShip]
///
///
class Leader {
  final Key? key;
  final LayerLink link;
  final Widget child;

  const Leader({
    this.key,
    required this.link,
    required this.child,
  });

  CompositedTransformTarget get toCompositedTransformTarget =>
      CompositedTransformTarget(
        key: key,
        link: link,
        child: child,
      );
}

enum FollowerState { join, leave }

class Follower {
  final Key? key;
  final LayerLink link;
  final FollowerState state;
  final bool showDespiteUnlink;
  final Offset leaderOffset;
  final Alignment anchorOnLeader;
  final Alignment anchorOnFollower;
  final Widget child;

  OverlayEntry? overlayEntry;

  Follower({
    this.key,
    required this.link,
    required this.leaderOffset,
    required this.child,
    this.state = FollowerState.join,
    this.anchorOnLeader = Alignment.topLeft,
    this.anchorOnFollower = Alignment.topLeft,
    this.showDespiteUnlink = false,
  });

  CompositedTransformFollower get toCompositedTransformFollower =>
      CompositedTransformFollower(
        key: key,
        link: link,
        showWhenUnlinked: showDespiteUnlink,
        targetAnchor: anchorOnLeader,
        followerAnchor: anchorOnFollower,
        offset: leaderOffset,
        child: child,
      );

  OverlayEntry overlayEntryOf(BuildContext leaderContext) {
    overlayEntry = OverlayEntry(
      builder: (context) =>
          SizedBox.fromSize(size: leaderContext.renderBox.size),
    );
    return overlayEntry!;
  }
}

class AnimatedListModification {
  final AnimatedListItemPlan itemPlan;
  final AnimatedListItemIndexCreator index;
  final AnimatedListItemInsertProcessor insert;
  final AnimatedListItemUpdateProcessor remove;
  final AnimatedListItemUpdateProcessor onTap;

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
