part of source;

///
/// this file contains:
/// [TweenTargetAbleMixin]
/// [TweenDouble]
///
/// [MyTween]
/// [VectorTween]
/// [PathTween], [PathTraceTween]
/// [RRegularPolygonTween]
///
/// [MyCurve]
/// [MyOverlayEntry]
/// [MyStreamController]
/// [MyPainter]
/// [MyClipper]
///
/// the helpers for my origin widgets:
/// [Leader], [Follower], [FollowerState]
/// [PesItem], [PesState]
///
///

/// TODO: transfer mixin to enable every subclass of [MyTween].
class TweenTargetAbleMixin<T> extends MyTween<T> {
  TweenTargetAbleMixin._({
    required super.begin,
    required super.end,
    required super.onLerp,
  });

  factory TweenTargetAbleMixin.targets({
    required T begin,
    required T end,
    required Iterable<T> intervals,
  }) {
    T current = begin;
    final tweens = intervals.map((target) {
      final previous = current;
      current = target;
      return Tween(begin: previous, end: current);
    }).toList()
      ..add(Tween(begin: current, end: end))
      ..toList(growable: false);

    final piece = 1 / tweens.length;

    int index = 0;

    return TweenTargetAbleMixin._(
      begin: begin,
      end: end,
      onLerp: (t) {
        if (t > (index + 1) * piece) {
          index++;
        }
        return tweens[index].transform(t);
      },
    );
  }
}

class CurveFR {
  final Curve forward;
  final CurveMapper reverseMapper;

  Curve get reverse => reverseMapper(forward);

  const CurveFR(
    this.forward, {
    this.reverseMapper = KCurveMapper.flipped,
  });
}

class MyTween<T> extends Tween<T> {
  final OnLerp<T> onLerp;
  final CurveFR curve;

  static OnLerp<T> _transform<T>(Tween<T> tween) => (t) => tween.transform(t);

  static OnLerp<T> _constantOf<T>(T value) => (_) => value;

  MyTween({
    this.curve = KCurveFRFlipped.fastOutSlowIn,
    OnLerp<T>? onLerp,
    required T begin,
    required T end,
  })  : onLerp = onLerp ?? _transform(Tween(begin: begin, end: end)),
        super(begin: begin, end: end);

  MyTween.constant(
    T value, {
    this.curve = KCurveFRFlipped.fastOutSlowIn,
  })  : onLerp = _constantOf<T>(value),
        super(begin: value, end: value);

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

  MyTween<T> follow(T next) => MyTween<T>(begin: end, end: next, curve: curve);

  MyTween<T> get reverse => MyTween(begin: end, end: begin, curve: curve);
}

class TweenDouble extends MyTween<double> {
  TweenDouble._({
    required super.begin,
    required super.end,
    required super.curve,
  }) : super(onLerp: KDoubleMapper.none);

  factory TweenDouble.constant(
    double value, {
    CurveFR curve = KCurveFRFlipped.fastOutSlowIn,
    double infinityPrecision = 1,
  }) =>
      TweenDouble._(
        curve: curve,
        begin: value.filterInfinity(infinityPrecision),
        end: value.filterInfinity(infinityPrecision),
      );

  factory TweenDouble({
    CurveFR curve = KCurveFRFlipped.fastOutSlowIn,
    double infinityPrecision = 1,
    required double begin,
    required double end,
  }) =>
      TweenDouble._(
        curve: curve,
        begin: begin.filterInfinity(infinityPrecision),
        end: end.filterInfinity(infinityPrecision),
      );
}

class VectorTween extends MyTween<Vector> {
  VectorTween._({
    required super.begin,
    required super.end,
    required super.onLerp,
    required super.curve,
  });

  factory VectorTween.ofDirectionDistance(
    Tween<Coordinate> direction,
    Tween<double> distance, {
    CurveFR curve = KCurveFRFlipped.fastOutSlowIn,
  }) =>
      VectorTween._(
        begin: Vector(direction.begin!, distance.begin!),
        end: Vector(direction.end!, distance.end!),
        onLerp: (t) => Vector(direction.transform(t), distance.transform(t)),
        curve: curve,
      );

  factory VectorTween({
    CurveFR curve = KCurveFRFlipped.fastOutSlowIn,
    required Vector begin,
    required Vector end,
  }) =>
      VectorTween.ofDirectionDistance(
        Tween(begin: begin.direction, end: end.direction),
        Tween(begin: begin.distance, end: end.distance),
        curve: curve,
      );
}

class PathTween<T> extends MyTween<SizeToPath> {
  PathTween.constant(
    SizeToPath builder, {
    CurveFR curve = KCurveFRFlipped.fastOutSlowIn,
  }) : super(
          begin: builder,
          end: builder,
          onLerp: (t) => builder,
          curve: curve,
        );

  PathTween.fromTween(
    MyTween<T> tween, {
    CurveFR curve = KCurveFRFlipped.fastOutSlowIn,
    required PathPlan<T> plan,
  }) : super(
          begin: plan(tween.begin),
          end: plan(tween.end),
          onLerp: (t) => plan(tween.transform(t)),
          curve: curve,
        );

  PathTween.fromTweenList(
    List<MyTween<T>> list, {
    CurveFR curve = KCurveFRFlipped.fastOutSlowIn,
    required PathPlan<List<T>> plan,
  }) : super(
          begin: plan(list.map((e) => e.begin).toList(growable: false)),
          end: plan(list.map((e) => e.end).toList(growable: false)),
          onLerp: (t) => plan(
            list.map((e) => e.transform(t)).toList(growable: false),
          ),
          curve: curve,
        );
}

class PathTraceTween extends MyTween<SizeToPath> {
  PathTraceTween._({
    required super.curve,
    required super.begin,
    required super.end,
    required super.onLerp,
  });

  factory PathTraceTween.fromOffsetRightBefore({
    CurveFR curve = KCurveFRFlipped.fastOutSlowIn,
    Offset start = Offset.zero,
    required Tween<Offset> point,
    required PathPlan<List<Offset>> plan,
  }) {
    Offset current = start;
    return PathTraceTween._(
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

class RRegularPolygonTween extends PathTween<double> {
  RRegularPolygonTween._({
    required List<TweenDouble> tweenList,
    required PathPlan<List<double>> polygonPlan,
  }) : super.fromTweenList(tweenList, plan: polygonPlan);

  ///
  /// to set the proper [edgeVectorTimes], see [RRegularPolygonCubicStyleOnEdge.timesForEdge]
  /// to set the proper [cornerRadius], see [RRegularPolygonCubicStyleOnEdge.cornerRadius]
  ///
  factory RRegularPolygonTween.cubicStyleOnEdge({
    bool invertFromSize = false,
    TweenDouble? edgeVectorTimes,
    TweenDouble? scale,
    required TweenDouble cornerRadius,
    required RRegularPolygonCubicStyleOnEdge polygon,
  }) =>
      RRegularPolygonTween._(
        tweenList: [
          scale ?? VTweenDouble.k1,
          edgeVectorTimes ?? VTweenDouble.zero,
          cornerRadius,
        ],
        polygonPlan: (values) => FSizeToPath.polygonCubicCorner(
          (polygon
                ..timesForEdge = values[1]
                ..cornerRadius = values[2])
              .cubicPoints,
          invertFromSize: invertFromSize,
          scale: values[0],
        ),
      );
}

class MyCurve extends Curve {
  final DoubleMapper mapper;

  const MyCurve(this.mapper);

  @override
  double transformInternal(double t) => mapper(t);
}

///
/// see [CustomOverlayState] for mor implementation
///
class MyOverlayEntry {
  final Key? key;
  final OverlayEntry overlayEntry;
  AnimationController? controller;

  MyOverlayEntry._({
    this.key,
    required this.overlayEntry,
  });

  static MyOverlayEntry _centerSizedOrNot({
    required Key? key,
    required Size? centerSized,
    required WidgetBuilder builder,
  }) =>
      MyOverlayEntry._(
        key: key,
        overlayEntry: OverlayEntry(
          builder: centerSized == null
              ? builder
              : (context) => Center(
                    child: SizedBox(
                      width: centerSized.width,
                      height: centerSized.height,
                      child: builder(context),
                    ),
                  ),
        ),
      );

  factory MyOverlayEntry({
    Key? key,
    Size? centerSized,
    required WidgetBuilder builder,
  }) =>
      _centerSizedOrNot(
        key: key,
        centerSized: centerSized,
        builder: builder,
      );

  factory MyOverlayEntry.ofAni({
    Key? key,
    Size? centerSized,
    required AniBuilder builder,
  }) {
    late final MyOverlayEntry entry;
    late final AnimationController controller;

    entry = _centerSizedOrNot(
      key: key,
      centerSized: centerSized,
      builder: (context) {
        final ani = builder(context);
        controller = MyAnimation.of(context).animationController;
        return ani;
      },
    );

    // TODO: no yet build before entry insert
    entry.controller = controller;

    return entry;
  }
}

class MyStreamController<T> {
  MyStreamController._() : controller = StreamController<T>();

  StreamController<T> controller;

  void add(T element) => controller.add(element);

  void close() => controller.close();

  Stream<T> get stream => controller.stream;
}

class MyPainter extends CustomPainter {
  final CanvasSizeToPaint canvasSizeToPaint;
  final SizeToPath sizeToPath;
  final CanvasListener canvasListener;
  final bool Function(MyPainter oldPainter, MyPainter painter) _shouldRePaint;

  const MyPainter.rePaintOf({
    this.canvasListener = FCanvasListener.drawPathWithPaint,
    required this.sizeToPath,
    required this.canvasSizeToPaint,
  }) : _shouldRePaint = _rePaintWhenDiff;

  const MyPainter.rePaintNever({
    this.canvasListener = FCanvasListener.drawPathWithPaint,
    required this.canvasSizeToPaint,
    required this.sizeToPath,
  }) : _shouldRePaint = _rePaintNever;

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
        canvasSizeToPaint.hashCode,
        sizeToPath.hashCode,
        canvasListener.hashCode,
      );

  /// paint
  @override
  void paint(Canvas canvas, Size size) {
    final paint = canvasSizeToPaint(canvas, size);
    final path = sizeToPath(size);
    canvasListener(canvas, paint, path);
  }
}

class MyClipper extends CustomClipper<Path> {
  final SizeToPath sizeToPath;
  final bool Function(MyClipper oldClipper, MyClipper clipper) shouldReClip;

  const MyClipper.reClipOf(this.sizeToPath) : shouldReClip = _reClipWhenDiff;

  const MyClipper.reClipNeverOf(this.sizeToPath) : shouldReClip = _reClipNever;

  @override
  bool shouldReclip(MyClipper oldClipper) => shouldReClip(oldClipper, this);

  static bool _reClipWhenDiff(MyClipper oldClipper, MyClipper clipper) =>
      oldClipper.sizeToPath != clipper.sizeToPath;

  static bool _reClipNever(MyClipper oldClipper, MyClipper clipper) => false;

  @override
  Path getClip(Size size) => sizeToPath(size);
}

///
/// to see how [Leader], [Follower] work, see [LeaderShip] for implementation
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

  MyOverlayEntry? overlayEntryController;

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

  MyOverlayEntry getOverlayEntryController(BuildContext leaderContext) {
    overlayEntryController = MyOverlayEntry(
      builder: (context) => toCompositedTransformFollower,
      centerSized: leaderContext.renderBox.size,
    );
    return overlayEntryController!;
  }
}

///
/// to see how [PesState] and [PesItem] work, see [PesPen] for implementation
///

enum PesState {
  inPool,
  inPosition,
  expand,
  shrink,
}

class PesItem<A> {
  final Offset itemZeroOffset;
  final Size itemSize;
  final A item;

  const PesItem({
    required this.itemZeroOffset,
    required this.itemSize,
    required this.item,
  });
}
