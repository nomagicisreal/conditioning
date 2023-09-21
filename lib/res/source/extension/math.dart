part of source;

///
/// this file contains:
/// [Operator]
/// [Direction]
/// [Direction2DIn4], [Direction2DIn8]
/// [Direction3DIn6], [Direction3DIn14], [Direction3DIn22]
///
/// [RegularPolygon], [RRegularPolygon], [RRegularPolygonCubicOnEdge]
/// [Vector]
/// [Coordinate]
///
/// [AlignmentExtension]
/// [PositionedExtension]
/// [Matrix4Extension]
/// [PathExtension], [PathOperationExtension]
///
///

enum Operator {
  plus,
  minus,
  multiply,
  divide,
  modulus,
  ;

  @override
  String toString() => switch (this) {
        Operator.plus => '+',
        Operator.minus => '-',
        Operator.multiply => '*',
        Operator.divide => '/',
        Operator.modulus => '%',
      };

  String get latex => switch (this) {
        Operator.plus => r'+',
        Operator.minus => r'-',
        Operator.multiply => r'\times',
        Operator.divide => r'\div',
        Operator.modulus => throw UnimplementedError(),
      };

  ///
  /// latex operation
  ///
  String latexOperationOf(String a, String b) => "$a $latex $b";

  String latexOperationOfDouble(double a, double b, {int fix = 0}) =>
      "${a.toStringAsFixed(fix)} "
      "$latex "
      "${b.toStringAsFixed(fix)}";

  ///
  /// widget operation
  ///
  Widget columnFormOfDoubleOperation(
    double a,
    double b, {
    int fixed = 0,
    TextStyle? textStyle,
    Divider divider = KDivider.black_3,
  }) =>
      CustomColumn.operationColumnForm(
        valueA: CustomText.ofDouble(a, fixed: fixed, style: textStyle),
        operator: icon,
        valueB: CustomText.ofDouble(b, fixed: fixed, style: textStyle),
        divider: divider,
        result: CustomText.ofDouble(
          operateDouble(a, b),
          fixed: fixed,
          style: textStyle,
        ),
      );

  Widget columnFormOfDurationOperation(
    Duration a,
    Duration b, {
    TextStyle? textStyle,
    Divider divider = KDivider.black_3,
  }) =>
      CustomColumn.operationColumnForm(
        valueA: CustomText.ofDuration(a, style: textStyle),
        operator: icon,
        valueB: CustomText.ofDuration(b, style: textStyle),
        divider: divider,
        result: CustomText.ofDuration(operateDuration(a, b), style: textStyle),
      );

  ///
  /// icon
  ///
  Icon get icon => Icon(_iconData);

  IconData get _iconData => switch (this) {
        Operator.plus => Icons.add,
        Operator.minus => Icons.remove,
        Operator.multiply => CupertinoIcons.multiply,
        Operator.divide => CupertinoIcons.divide,
        Operator.modulus => CupertinoIcons.percent,
      };

  ///
  /// operate value
  ///
  double operateDouble(double a, double b) => switch (this) {
        Operator.plus => a + b,
        Operator.minus => a - b,
        Operator.multiply => a * b,
        Operator.divide => a / b,
        Operator.modulus => a % b,
      };

  static double operateDoubleAll(
    double value,
    Iterable<(Operator, double)> operations,
  ) =>
      operations.fold(
        value,
        (a, opertion) => switch (opertion.$1) {
          Operator.plus => a + opertion.$2,
          Operator.minus => a - opertion.$2,
          Operator.multiply => a * opertion.$2,
          Operator.divide => a / opertion.$2,
          Operator.modulus => a % opertion.$2,
        },
      );

  Duration operateDuration(Duration a, Duration b) => switch (this) {
        Operator.plus => a + b,
        Operator.minus => a - b,
        _ => throw UnimplementedError(),
      };

  Color operateColorWithValue(Color color, int value) => switch (this) {
        Operator.plus => color.plusARGB(0, value, value, value),
        Operator.minus => color.minusARGB(0, value, value, value),
        Operator.multiply => color.multiplyARGB(1, value, value, value),
        Operator.divide => color.divideARGB(1, value, value, value),
        Operator.modulus => throw UnimplementedError(),
      };

  T operationOf<T>(T a, T b) => switch (T) {
        double => operateDouble(a as double, b as double),
        Duration => operateDuration(a as Duration, b as Duration),
        _ => throw UnimplementedError(),
      } as T;

  ///
  /// mapper
  ///

  Mapper<double> doubleMapperWith(double b) => switch (this) {
        Operator.plus => (a) => a + b,
        Operator.minus => (a) => a - b,
        Operator.multiply => (a) => a * b,
        Operator.divide => (a) => a / b,
        Operator.modulus => (a) => a % b,
      };
}

///
///
/// [Direction]
/// 2D:
///   [Direction2DIn4]
///   [Direction2DIn8]
/// 3D:
///   [Direction3DIn6]
///   [Direction3DIn14]
///   [Direction3DIn22]
///
///

base mixin Direction<D> {
  D get flipped;

  Offset get toOffset;

  Coordinate get toCoordinate;
}

enum Direction2DIn4 with Direction<Direction2DIn4> {
  left,
  right,
  top,
  bottom;

  @override
  Direction2DIn4 get flipped => switch (this) {
        Direction2DIn4.left => Direction2DIn4.right,
        Direction2DIn4.right => Direction2DIn4.left,
        Direction2DIn4.top => Direction2DIn4.top,
        Direction2DIn4.bottom => Direction2DIn4.bottom,
      };

  @override
  Offset get toOffset => switch (this) {
        Direction2DIn4.left => KOffsetDirection.left,
        Direction2DIn4.right => KOffsetDirection.right,
        Direction2DIn4.top => KOffsetDirection.top,
        Direction2DIn4.bottom => KOffsetDirection.bottom,
      };

  @override
  Coordinate get toCoordinate => switch (this) {
        Direction2DIn4.left => KCoordinateDirection.left,
        Direction2DIn4.right => KCoordinateDirection.right,
        Direction2DIn4.top => KCoordinateDirection.top,
        Direction2DIn4.bottom => KCoordinateDirection.bottom,
      };
}

enum Direction2DIn8 with Direction<Direction2DIn8> {
  topLeft,
  top,
  topRight,
  left,
  right,
  bottomLeft,
  bottom,
  bottomRight;

  @override
  Direction2DIn8 get flipped => switch (this) {
        top => Direction2DIn8.bottom,
        left => Direction2DIn8.right,
        right => Direction2DIn8.left,
        bottom => Direction2DIn8.top,
        topLeft => Direction2DIn8.bottomRight,
        topRight => Direction2DIn8.bottomLeft,
        bottomLeft => Direction2DIn8.topRight,
        bottomRight => Direction2DIn8.topLeft,
      };

  @override
  Offset get toOffset => switch (this) {
        top => KOffsetDirection.top,
        left => KOffsetDirection.left,
        right => KOffsetDirection.right,
        bottom => KOffsetDirection.bottom,
        topLeft => KOffsetDirection.topLeft,
        topRight => KOffsetDirection.topRight,
        bottomLeft => KOffsetDirection.bottomLeft,
        bottomRight => KOffsetDirection.bottomRight,
      };

  @override
  Coordinate get toCoordinate => switch (this) {
        top => KCoordinateDirection.top,
        left => KCoordinateDirection.left,
        right => KCoordinateDirection.right,
        bottom => KCoordinateDirection.bottom,
        topLeft => KCoordinateDirection.topLeft,
        topRight => KCoordinateDirection.topRight,
        bottomLeft => KCoordinateDirection.bottomLeft,
        bottomRight => KCoordinateDirection.bottomRight,
      };

  Alignment get toAlignment => switch (this) {
        top => Alignment.topCenter,
        left => Alignment.centerLeft,
        right => Alignment.centerRight,
        bottom => Alignment.bottomCenter,
        topLeft => Alignment.topLeft,
        topRight => Alignment.topRight,
        bottomLeft => Alignment.bottomLeft,
        bottomRight => Alignment.bottomRight,
      };
}

enum Direction3DIn6 with Direction<Direction3DIn6> {
  left,
  top,
  right,
  bottom,
  front,
  back;

  @override
  Direction3DIn6 get flipped => switch (this) {
        Direction3DIn6.left => Direction3DIn6.right,
        Direction3DIn6.top => Direction3DIn6.bottom,
        Direction3DIn6.right => Direction3DIn6.left,
        Direction3DIn6.bottom => Direction3DIn6.top,
        Direction3DIn6.front => Direction3DIn6.back,
        Direction3DIn6.back => Direction3DIn6.front,
      };

  @override
  Offset get toOffset => switch (this) {
        Direction3DIn6.left => KOffsetDirection.left,
        Direction3DIn6.top => KOffsetDirection.top,
        Direction3DIn6.right => KOffsetDirection.right,
        Direction3DIn6.bottom => KOffsetDirection.bottom,
        _ => throw UnimplementedError(),
      };

  @override
  Coordinate get toCoordinate => switch (this) {
        Direction3DIn6.left => KCoordinateDirection.left,
        Direction3DIn6.top => KCoordinateDirection.top,
        Direction3DIn6.right => KCoordinateDirection.right,
        Direction3DIn6.bottom => KCoordinateDirection.bottom,
        Direction3DIn6.front => KCoordinateDirection.front,
        Direction3DIn6.back => KCoordinateDirection.back,
      };

  ///
  /// The angle value belows are "[Matrix4] radian". see [Coordinate.fromDirection] for my "math radian".
  ///
  /// [front] can be seen within {angleY(-90 ~ 90), angleX(-90 ~ 90)}
  /// [left] can be seen within {angleY(0 ~ -180), angleZ(-90 ~ 90)}
  /// [top] can be seen within {angleX(0 ~ 180), angleZ(-90 ~ 90)}
  /// [back] can be seen while [front] not be seen.
  /// [right] can be seen while [left] not be seen.
  /// [bottom] can be seen while [top] not be seen.
  ///
  ///
  static List<Direction3DIn6> parseRotation(Coordinate radian) {
    // ?
    final r = FRadianCoordinate.restrictInAngle180Of(radian);

    final rX = r.dx;
    final rY = r.dy;
    final rZ = r.dz;

    return <Direction3DIn6>[
      FRadian.checkIfWithinAngle90_90N(rY) &&
              FRadian.checkIfWithinAngle90_90N(rX)
          ? Direction3DIn6.front
          : Direction3DIn6.back,
      FRadian.checkIfWithinAngle0_180N(rY) &&
              FRadian.checkIfWithinAngle90_90N(rZ)
          ? Direction3DIn6.left
          : Direction3DIn6.right,
      FRadian.checkIfWithinAngle0_180(rX) &&
              FRadian.checkIfWithinAngle90_90N(rZ)
          ? Direction3DIn6.top
          : Direction3DIn6.bottom,
    ];
  }

  Widget buildTransform({
    Coordinate initialRadian = Coordinate.zero,
    double zDeep = 100,
    required Widget child,
  }) {
    Matrix4 instance() => Matrix4.identity();
    return initialRadian == Coordinate.zero
        ? switch (this) {
            Direction3DIn6.front => Transform(
                transform: instance(),
                alignment: Alignment.center,
                child: child,
              ),
            Direction3DIn6.back => Transform(
                transform: instance()..translate(Vector3(0, 0, -zDeep)),
                alignment: Alignment.center,
                child: child,
              ),
            Direction3DIn6.left => Transform(
                alignment: Alignment.centerLeft,
                transform: instance()..rotateY(KRadian.angle_90),
                child: child,
              ),
            Direction3DIn6.right => Transform(
                alignment: Alignment.centerRight,
                transform: instance()..rotateY(-KRadian.angle_90),
                child: child,
              ),
            Direction3DIn6.top => Transform(
                alignment: Alignment.topCenter,
                transform: instance()..rotateX(-KRadian.angle_90),
                child: child,
              ),
            Direction3DIn6.bottom => Transform(
                alignment: Alignment.bottomCenter,
                transform: instance()..rotateX(KRadian.angle_90),
                child: child,
              ),
          }
        : throw UnimplementedError();
  }
}

enum Direction3DIn14 with Direction<Direction3DIn14> {
  left,
  top,
  right,
  bottom,
  front,
  frontLeft,
  frontTop,
  frontRight,
  frontBottom,
  back,
  backLeft,
  backTop,
  backRight,
  backBottom;

  @override
  Direction3DIn14 get flipped => switch (this) {
        Direction3DIn14.left => Direction3DIn14.right,
        Direction3DIn14.top => Direction3DIn14.bottom,
        Direction3DIn14.right => Direction3DIn14.left,
        Direction3DIn14.bottom => Direction3DIn14.top,
        Direction3DIn14.front => Direction3DIn14.front,
        Direction3DIn14.frontLeft => Direction3DIn14.frontLeft,
        Direction3DIn14.frontTop => Direction3DIn14.frontTop,
        Direction3DIn14.frontRight => Direction3DIn14.frontRight,
        Direction3DIn14.frontBottom => Direction3DIn14.frontBottom,
        Direction3DIn14.back => Direction3DIn14.back,
        Direction3DIn14.backLeft => Direction3DIn14.backLeft,
        Direction3DIn14.backTop => Direction3DIn14.backTop,
        Direction3DIn14.backRight => Direction3DIn14.backRight,
        Direction3DIn14.backBottom => Direction3DIn14.backBottom,
      };

  @override
  Offset get toOffset => switch (this) {
        Direction3DIn14.left => KOffsetDirection.left,
        Direction3DIn14.top => KOffsetDirection.top,
        Direction3DIn14.right => KOffsetDirection.right,
        Direction3DIn14.bottom => KOffsetDirection.bottom,
        _ => throw UnimplementedError(),
      };

  @override
  Coordinate get toCoordinate => switch (this) {
        Direction3DIn14.left => KCoordinateDirection.left,
        Direction3DIn14.top => KCoordinateDirection.top,
        Direction3DIn14.right => KCoordinateDirection.right,
        Direction3DIn14.bottom => KCoordinateDirection.bottom,
        Direction3DIn14.front => KCoordinateDirection.front,
        Direction3DIn14.frontLeft => KCoordinateDirection.frontLeft,
        Direction3DIn14.frontTop => KCoordinateDirection.frontTop,
        Direction3DIn14.frontRight => KCoordinateDirection.frontRight,
        Direction3DIn14.frontBottom => KCoordinateDirection.frontBottom,
        Direction3DIn14.back => KCoordinateDirection.back,
        Direction3DIn14.backLeft => KCoordinateDirection.backLeft,
        Direction3DIn14.backTop => KCoordinateDirection.backTop,
        Direction3DIn14.backRight => KCoordinateDirection.backRight,
        Direction3DIn14.backBottom => KCoordinateDirection.backBottom,
      };
}

enum Direction3DIn22 {
  top;
}


abstract class RegularPolygon {
  static double radianCornerOf(int n) => (n - 2) * KRadian.angle_180 / n;

  static double lengthSideOf(int n, num radiusCircumscribedCircle) => math.sqrt(
        radiusCircumscribedCircle.square *
            2 *
            (1 - math.cos(KRadian.angle_360 / n)),
      );

  static List<Offset> cornersOf(
    int n,
    num radiusCircumscribedCircle, {
    Size? size,
  }) {
    final step = KRadian.angle_360 / n;
    final center = size?.center(Offset.zero) ?? Offset.zero;
    return List.generate(
      n,
      (i) =>
          center +
          Offset.fromDirection(step * i, radiusCircumscribedCircle.toDouble()),
      growable: false,
    );
  }

  static double inscribedCircleRadiusOf(
    int n,
    num radiusCircumscribedCircle,
    double radianCorner,
  ) =>
      switch (n) {
        3 => radiusCircumscribedCircle / 2,
        4 => radiusCircumscribedCircle * DoubleExtension.sqrt1_2,
        6 => radiusCircumscribedCircle * DoubleExtension.sqrt3 / 2,
        _ => radiusCircumscribedCircle *
            math.sin(FRadian.radianOf(FRadian.angleOf(radianCorner) / 2)),
      };

  /// properties

  final int n;
  final num radiusCircumscribedCircle;

  List<Offset> get corners => cornersOf(n, radiusCircumscribedCircle);

  double get lengthSide => lengthSideOf(n, radiusCircumscribedCircle);

  double get radianSideSide => radianCornerOf(n);

  double get radianCornerCenterSide => KRadian.angle_180 / n;

  double get radiusInscribedCircle => inscribedCircleRadiusOf(
        n,
        radiusCircumscribedCircle,
        radianSideSide,
      );

  const RegularPolygon(
    this.n, {
    required this.radiusCircumscribedCircle,
  });
}

sealed class RRegularPolygon extends RegularPolygon {
  final List<Radius> radiusList;
  final Mapper<Map<Offset, List<Offset>>> cubicPointsMapper;

  Map<Offset, List<Offset>> get _cubicPointsForEachCorners;

  Iterable<List<Offset>> get cubicPoints =>
      cubicPointsMapper(_cubicPointsForEachCorners).values;

  const RRegularPolygon(
    super.n, {
    required this.radiusList,
    required this.cubicPointsMapper,
    required super.radiusCircumscribedCircle,
  });
}

class RRegularPolygonCubicOnEdge extends RRegularPolygon {
  double cornerRadius;
  double timesForEdge;

  double get timesForEdgeUnit => cornerRadius * math.tan(KRadian.angle_180 / n);

  RRegularPolygonCubicOnEdge(
    super.n, {
    this.cornerRadius = 0,
    this.timesForEdge = 0,
    super.cubicPointsMapper = KMapperCubicPointsPermutation.p0231,
    required super.radiusCircumscribedCircle,
  }) : super(radiusList: ListRadiusExtension.generateCircular(n, cornerRadius));

  ///
  /// each [cubicPoints.values] means [cornerPrevious, controlPointA, controlPointB, cornerNext],
  /// see [FPathFromSize.polygonCubicCorner] for implementation
  ///
  @override
  Map<Offset, List<Offset>> get _cubicPointsForEachCorners => corners
      .asMap()
      .map((index, current) => MapEntry(
            current,
            [
              // offset from current corner to previous corner
              OffsetExtension.vectorUnitOf(
                current,
                index == 0 ? corners.last : corners[index - 1],
                timesForEdgeUnit,
              ),

              // offset from current corner to next corner
              OffsetExtension.vectorUnitOf(
                current,
                index == n - 1 ? corners.first : corners[index + 1],
                timesForEdgeUnit,
              )
            ],
          ))
      .map(
        (current, list) => MapEntry(
          current,
          list
            ..add(OffsetExtension.vectorOf(
              list[0],
              current,
              timesForEdge,
            ))
            ..add(OffsetExtension.vectorOf(
              current,
              list[1],
              timesForEdge,
            )),
        ),
      );

  ///
  /// steps of corner radius:
  ///
  List<double> get stepsOfCornerRadius => [
        stepCornerRadiusInfiniteBegin,
        stepCornerRadiusPolygon,
        stepCornerRadiusInscribedCircle,
        stepCornerRadiusFragmentFitCorner(),
        stepCornerRadiusArcCrossCenter(),
        stepCornerRadiusInfiniteEnd,
      ];

  double get stepCornerRadiusInfiniteBegin => double.negativeInfinity;

  double get stepCornerRadiusPolygon => 0;

  ///
  /// the 'Pa' in below discussion, treats as every corner in [corners], and also,
  /// a = [radianSideSide],
  /// c = [radianCornerCenterSide],
  /// Rc = [radiusCircumscribedCircle],
  /// Ri = [radiusInscribedCircle]
  ///
  /// Pa----------------Pb----------(La)
  ///  --            -------
  ///    --       --    -    --
  ///      --    -      -      -
  ///        -- -      Pc       - (the circle with radius R (PbPc = PcPd = R))
  ///          ---   --        -
  ///            -Pd         --
  ///              ---------
  ///                --
  ///                  (Lb)
  ///
  ///

  ///
  /// [stepCornerRadiusInscribedCircle] is the step that
  /// 1. PaPc = Rc
  /// 2. R = Ri
  /// 3. cos(c) = Ri / Rc
  ///
  double get stepCornerRadiusInscribedCircle => radiusInscribedCircle;

  ///
  /// when [inset] = 0 in [stepCornerRadiusFragmentFitCorner], it means that each corner's Pb and Pd are overlap on the nearest two [corners],
  /// which implies: [lengthSide] = PaPb = PaPd = |[timesForEdgeUnit] * borderVectorUnit|
  ///
  ///   [lengthSide] = |[timesForEdgeUnit] * borderVectorUnit| = R * tan(c)
  ///   R = [lengthSide] / tan(c)
  ///
  double stepCornerRadiusFragmentFitCorner({double inset = 0}) =>
      (lengthSide - inset) / math.tan(radianCornerCenterSide);

  ///
  /// when [inset] = 0 in [stepCornerRadiusArcCrossCenter], it means that all [corners]' PbPd arc crossing on the polygon center,
  /// which implies: PaPc = Rc + R
  ///
  ///   cos(c) = R / PaPc = R / (Rc + R)
  ///   Rc * cos(c) = R - R * cos(c)
  ///   R = (Rc * cos(c)) / (1 - cos(c))
  ///
  /// also implies the inequality: Rc + R > (P(0.5) - cornerOffset).distance.
  ///                       (see [PathExtension.cubicToPoint] for detail)
  /// it seems that triangle, square are not satisfy the inequality above,
  /// and P(0.5 - cornerOffset) is too complex to compute. there is two approximate value for triangle and square.
  ///
  double stepCornerRadiusArcCrossCenter({double inset = 0}) => switch (n) {
        3 => radiusCircumscribedCircle * 1.2 - inset,
        4 => radiusCircumscribedCircle * 2.6 - inset,
        _ => ((radiusCircumscribedCircle - inset) *
                math.cos(radianCornerCenterSide)) /
            (1 - math.cos(radianCornerCenterSide)),
      };

  double get stepCornerRadiusInfiniteEnd => double.infinity;

  List<double> get stepsOfEdgeTimes =>
      [double.negativeInfinity, 0, 1, double.infinity];
}

///
/// vector
///

class Vector {
  final Coordinate direction;
  final double distance;

  const Vector(this.direction, this.distance);

  Offset get toOffset => Offset.fromDirection(-direction.dy, distance);

  Coordinate get toCoordinate => Coordinate.fromDirection(
        direction: direction,
        distance: distance,
      );

  Vector rotated(Coordinate d) => Vector(direction + d, distance);

  @override
  String toString() => "Vector($direction, $distance)";

  static Vector lerp(Vector begin, Vector end, double t) => Vector(
      Tween(
        begin: begin.direction,
        end: end.direction,
      ).transform(t),
      Tween(
        begin: begin.distance,
        end: end.distance,
      ).transform(t));
}

///
/// coordinate
///

mixin _CoordinateBase on Offset {
  double get dz;

  bool get isNot3D => (dz == 0 || dx == 0 || dy == 0);

  bool get isNegative => (dz < 0 && dx < 0 && dy < 0);

  bool get hasNegative => (dz < 0 || dx < 0 || dy < 0);

  bool get hasNoXY => (dx == 0 && dy == 0);

  Coordinate get modulus360Angle => Coordinate(
        dx % KRadian.angle_360,
        dy % KRadian.angle_360,
        dz % KRadian.angle_360,
      );

  Coordinate get modulus180Angle => Coordinate(
        dx % KRadian.angle_180,
        dy % KRadian.angle_180,
        dz % KRadian.angle_180,
      );

  Coordinate get modulus90Angle => Coordinate(
        dx % KRadian.angle_90,
        dy % KRadian.angle_90,
        dz % KRadian.angle_90,
      );

  Coordinate get retainX => Coordinate(dx, 0, 0);

  Coordinate get retainY => Coordinate(0, dy, 0);

  Coordinate get retainXY => Coordinate(dx, dy, 0);

  Coordinate get retainYZAsYX => Coordinate(dz, dy, 0);

  Coordinate get retainYZAsXY => Coordinate(dy, dz, 0);

  Coordinate get retainXZAsXY => Coordinate(dx, dz, 0);

  Coordinate get retainXZAsYX => Coordinate(dz, dx, 0);

  Coordinate get roundup => Coordinate(
        dx.roundToDouble(),
        dy.roundToDouble(),
        dz.roundToDouble(),
      );

  @override
  double get distanceSquared => super.distanceSquared + dz * dz;

  @override
  double get distance => math.sqrt(distanceSquared);

  double get volume => dx * dy * dz;

  @override
  double get direction => throw UnimplementedError();

  @override
  bool get isFinite => super.isFinite && dz.isFinite;

  @override
  bool get isInfinite => super.isInfinite && dz.isInfinite;

  @override
  Coordinate operator +(covariant Coordinate other) =>
      Coordinate(dx + other.dx, dy + other.dy, dz + other.dz);

  @override
  Coordinate operator -(covariant Coordinate other) =>
      Coordinate(dx - other.dx, dy - other.dy, dz - other.dz);

  @override
  Coordinate operator -() => Coordinate(-dx, -dy, -dz);

  @override
  Coordinate operator *(double operand) => Coordinate(
        dx * operand,
        dy * operand,
        dz * operand,
      );

  @override
  Coordinate operator /(double operand) => Coordinate(
        dx / operand,
        dy / operand,
        dz / operand,
      );

  @override
  Coordinate operator ~/(double operand) => Coordinate(
        (dx ~/ operand).toDouble(),
        (dy ~/ operand).toDouble(),
        (dz ~/ operand).toDouble(),
      );

  @override
  Coordinate operator %(double operand) => Coordinate(
        dx % operand,
        dy % operand,
        dz % operand,
      );

  @override
  bool operator <(covariant Coordinate other) =>
      dz < other.dz && (super < other);

  @override
  bool operator <=(covariant Coordinate other) =>
      dz <= other.dz && (super <= other);

  @override
  bool operator >(covariant Coordinate other) =>
      dz > other.dz && (super > other);

  @override
  bool operator >=(covariant Coordinate other) =>
      dz >= other.dz && (super >= other);

  @override
  bool operator ==(covariant Coordinate other) =>
      dz == other.dz && (super == other);

  @override
  int get hashCode => Object.hash(super.hashCode, dz);

  @override
  Rect operator &(Size other) =>
      isNot3D ? (super & other) : (throw UnimplementedError());

  @override
  Coordinate scale(
    double scaleX,
    double scaleY, {
    double scaleZ = 0,
  }) =>
      Coordinate(dx * scaleX, dy * scaleY, dz * scaleZ);

  @override
  Coordinate translate(
    double translateX,
    double translateY, {
    double translateZ = 0,
  }) =>
      Coordinate(
        dx + translateX,
        dy + translateY,
        dz + translateZ,
      );

  @override
  String toString() => 'Coordinate('
      '${dx.toStringAsFixed(1)}, '
      '${dy.toStringAsFixed(1)}, '
      '${dz.toStringAsFixed(1)})';
}

///
///
/// See Also [_CoordinateBase]
///
///

class Coordinate extends Offset with _CoordinateBase {
  @override
  final double dz;

  const Coordinate(double dx, double dy, this.dz) : super(dx, dy);

  const Coordinate.cube(double dimension)
      : dz = dimension,
        super(dimension, dimension);

  const Coordinate.ofX(double x)
      : dz = 0,
        super(x, 0);

  const Coordinate.ofY(double y)
      : dz = 0,
        super(0, y);

  const Coordinate.ofZ(double z)
      : dz = z,
        super(0, 0);

  const Coordinate.ofXY(double dx, double dy)
      : dz = 0,
        super(dx, dy);

  const Coordinate.ofYZ(double dy, this.dz) : super(0, dy);

  const Coordinate.ofXZ(double dx, this.dz) : super(dx, 0);

  static const Coordinate zero = Coordinate.cube(0);

  static Coordinate maxDistance(Coordinate a, Coordinate b) =>
      a.distance > b.distance ? a : b;

  ///
  ///
  /// [Coordinate.transferToTransformOf] transfer from my coordinate system:
  /// x axis is [Direction3DIn6.left] -> [Direction3DIn6.right], radian start from [Direction3DIn6.back]
  /// y axis is [Direction3DIn6.front] -> [Direction3DIn6.back], radian start from [Direction3DIn6.left]
  /// z axis is [Direction3DIn6.bottom] -> [Direction3DIn6.top], radian start from [Direction3DIn6.right]
  /// (see [Coordinate.fromDirection] for implementation)
  ///
  /// to dart matrix4 coordinate system (see the comment over [_MationTransformBase] for detail):
  /// x axis is [Direction3DIn6.left] -> [Direction3DIn6.right], radian start from [Direction3DIn6.back] ?
  /// y axis is [Direction3DIn6.top] -> [Direction3DIn6.bottom], radian start from [Direction3DIn6.left] ?
  /// z axis is [Direction3DIn6.front] -> [Direction3DIn6.back], radian start from [Direction3DIn6.right]
  ///
  ///
  /// See Also:
  ///   * [Offset.fromDirection], [Coordinate.fromDirection]
  ///   * [KOffsetDirection], [KCoordinateDirection]
  ///   * [_MationTransformBase], [MationTransform]
  ///
  static Coordinate transferToTransformOf(Coordinate radian) => Coordinate(
        radian.dx,
        -radian.dz,
        -radian.dy,
      );

  factory Coordinate.fromDirection({
    required Coordinate direction,
    required double distance,
    Coordinate scale = KCoordinate.cube_1,
  }) {
    final rX = direction.dx;
    final rY = direction.dy;
    final rZ = direction.dz;
    return Coordinate(
      distance * (math.cos(rZ) * math.cos(rY)),
      distance * (math.sin(rZ) * math.cos(rX)),
      distance * (math.sin(rX) * math.sin(rY)),
    );
  }

  Coordinate scaling(Coordinate scale) =>
      super.scale(scale.dx, scale.dy, scaleZ: scale.dz);

  Coordinate abs() => Coordinate(dx.abs(), dy.abs(), dz.abs());
}


///
///
///
/// extensions
///
///
///

extension AlignmentExtension on Alignment {
  (double, double) get radianBoundaryForSide => switch (this) {
    Alignment.center => (0, KRadian.angle_360),
    Alignment.centerLeft => (-KRadian.angle_90, KRadian.angle_90),
    Alignment.centerRight => (KRadian.angle_90, KRadian.angle_270),
    Alignment.topCenter => (0, KRadian.angle_180),
    Alignment.topLeft => (0, KRadian.angle_90),
    Alignment.topRight => (KRadian.angle_90, KRadian.angle_180),
    Alignment.bottomCenter => (KRadian.angle_180, KRadian.angle_360),
    Alignment.bottomLeft => (KRadian.angle_270, KRadian.angle_360),
    Alignment.bottomRight => (KRadian.angle_180, KRadian.angle_270),
    _ => throw UnimplementedError(),
  };

  double get radianRangeForSide {
    final boundary = radianBoundaryForSide;
    return boundary.$2 - boundary.$1;
  }

  double radianRangeForSideStepOf(int count) =>
      radianRangeForSide / (this == Alignment.center ? count : count - 1);

  Generator<double> directionOfSideSpace(bool isClockwise, int count) {
    final boundary = radianBoundaryForSide;
    final origin = isClockwise ? boundary.$1 : boundary.$2;
    final step = radianRangeForSideStepOf(count);

    return isClockwise
        ? (index) => origin + step * index
        : (index) => origin - step * index;
  }

  Mapper<Widget> get deviateBuilder {
    Row rowOf(List<Widget> children) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );

    final rowBuilder = switch (x) {
      0 => (child) => rowOf([child]),
      1 => (child) => rowOf([child, KSizedBox.expand]),
      -1 => (child) => rowOf([KSizedBox.expand, child]),
      _ => throw UnimplementedError(),
    };

    Column columnOf(List<Widget> children) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );

    final columnBuilder = switch (y) {
      0 => (child) => columnOf([child]),
      1 => (child) => columnOf([rowBuilder(child), KSizedBox.expand]),
      -1 => (child) => columnOf([KSizedBox.expand, rowBuilder(child)]),
      _ => throw UnimplementedError(),
    };

    return (child) => columnBuilder(child);
  }
}

extension PositionedExtension on Positioned {
  Rect? get rect =>
      (left == null || top == null || width == null || height == null)
          ? null
          : Rect.fromLTWH(left!, top!, width!, height!);
}

extension Matrix4Extension on Matrix4 {
  Matrix4 scaledCoordinate(Coordinate coordinate) => scaled(
    coordinate.dx,
    coordinate.dy,
    coordinate.dz,
  );

  void rotateCoordinate(Coordinate coordinate) => this
    ..rotateX(coordinate.dx)
    ..rotateY(coordinate.dy)
    ..rotateZ(coordinate.dz);

  void translateCoordinate(Coordinate coordinate) =>
      translate(coordinate.dx, coordinate.dy, coordinate.dz);

  ///
  /// perspective
  ///

  void setPerspective(double perspective) => setEntry(3, 2, perspective);

  void setDistance(double? distance) =>
      setPerspective(distance == null ? 0 : 1 / distance);

  double entryPerspective() => entry(3, 2);

  void copyPerspectiveFrom(Matrix4 matrix4) =>
      setPerspective(matrix4.entryPerspective());

  static Matrix4 identityPerspectiveOf(Matrix4 matrix4) =>
      Matrix4.identity()..copyPerspectiveFrom(matrix4);
}

extension PathExtension on Path {
  /// move, line
  void moveToPoint(Offset point) => moveTo(point.dx, point.dy);

  void lineToPoint(Offset point) => lineTo(point.dx, point.dy);

  void moveOrLineToPoint(bool shouldMove, Offset point) =>
      shouldMove ? moveToPoint(point) : lineToPoint(point);

  void connect(Offset a, Offset b) => this
    ..moveToPoint(a)
    ..lineToPoint(b);

  /// add oval, rect
  void addOvalFromCircle(Offset center, double radius) =>
      addOval(Rect.fromCircle(center: center, radius: radius));

  void addRectFromPoints(Offset a, Offset b) => addRect(Rect.fromPoints(a, b));

  void addRectFromCenter(Offset center, double width, double height) =>
      addRect(Rect.fromCenter(center: center, width: width, height: height));

  void addRectFromLTWH(double left, double top, double width, double height) =>
      addRect(Rect.fromLTWH(left, top, width, height));

  void quadraticBezierToPoint(Offset controlPoint, Offset endPoint) =>
      quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      );

  /// see https://www.youtube.com/watch?v=aVwxzDHniEw for explanation of cubic bezier
  void cubicToPoint(
      Offset controlPoint1,
      Offset controlPoint2,
      Offset endPoint,
      ) =>
      cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint.dx,
        endPoint.dy,
      );

  /// the [points] will be treated as [controlPointA, controlPointB, endPoint]
  void cubicToPointsList(List<Offset> points) =>
      cubicToPoint(points[0], points[1], points[2]);
}

extension PathOperationExtension on PathOperation {
  Translator<Size, Path> operateSizeToPath(
      Translator<Size, Path> spA,
      Translator<Size, Path> spB,
      ) =>
          (size) => Path.combine(this, spA(size), spB(size));

  Translator<Size, Path> operateSizeToPathAll(
      Iterable<Translator<Size, Path>> sps,
      ) =>
      sps.reduce((sp, spNext) => operateSizeToPath(sp, spNext));
}