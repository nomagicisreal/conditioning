part of source;

///
///
/// this file contains:
///
/// enums:
/// [Operator]
/// [Dimension]
/// [Direction2D], [Direction2DVector], [Direction3D]
///
/// class:
/// [RegularPolygon], [RRegularPolygon], [RRegularPolygonCubicStyleOnEdge]
/// [Vector]
/// [_CoordinateBase], [Coordinate]
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

  /// operation
  String operationOf(String a, String b) => "$a $latex $b";

  String operationOfDouble(double a, double b, {int fix = 0}) =>
      "${a.toStringAsFixed(fix)} "
      "$latex "
      "${b.toStringAsFixed(fix)}";

  /// operation column form
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

  /// icon
  Icon get icon => Icon(_iconData);

  IconData get _iconData => switch (this) {
        Operator.plus => Icons.add,
        Operator.minus => Icons.remove,
        Operator.multiply => CupertinoIcons.multiply,
        Operator.divide => CupertinoIcons.divide,
        Operator.modulus => CupertinoIcons.percent,
      };

  /// operate
  double operateDouble(double a, double b) => switch (this) {
        Operator.plus => a + b,
        Operator.minus => a - b,
        Operator.multiply => a * b,
        Operator.divide => a / b,
        Operator.modulus => a % b,
      };

  Duration operateDuration(Duration a, Duration b) => switch (this) {
        Operator.plus => a + b,
        Operator.minus => a - b,
        _ => throw UnimplementedError(),
      };

  Duration operateDurationMilli(Duration d, int value) => Duration(
        milliseconds: switch (this) {
          Operator.plus => d.inMilliseconds + value,
          Operator.minus => d.inMilliseconds - value,
          Operator.multiply => (d.inMilliseconds * value).toInt(),
          Operator.divide => d.inMilliseconds ~/ value,
          Operator.modulus => d.inMilliseconds % value,
        },
      );

  Color operateColorWithValue(Color color, int value) => switch (this) {
        Operator.plus => color.plusARGB(0, value, value, value),
        Operator.minus => color.minusARGB(0, value, value, value),
        Operator.multiply => color.multiplyARGB(1, value, value, value),
        Operator.divide => color.divideARGB(1, value, value, value),
        Operator.modulus => throw UnimplementedError(),
      };
}

enum Dimension { x, y, z }

enum Direction2D { left, top, right, bottom }

enum Direction2DVector {
  left,
  leftTwiceForLeft,
  leftTwiceForMiddle,
  leftTwiceForRight,
  top,
  right,
  rightTwiceForRight,
  rightTwiceForMeddle,
  rightTwiceForLeft,
  bottom,
  leftUp,
  leftDown,
  rightUp,
  rightDown;

  MyTween<Coordinate> tweenOf(
    bool isNavIn,
    CurveFR curve,
  ) =>
      switch (isNavIn) {
        true => MyTween(
            begin: switch (this) {
              Direction2DVector.left => KCoordinateDirection.left,
              Direction2DVector.leftTwiceForLeft => throw UnimplementedError(),
              Direction2DVector.leftTwiceForMiddle =>
                throw UnimplementedError(),
              Direction2DVector.leftTwiceForRight =>
                KCoordinateDirection.left * 2,
              Direction2DVector.top => KCoordinateDirection.top,
              Direction2DVector.right => KCoordinateDirection.right,
              Direction2DVector.rightTwiceForRight =>
                throw UnimplementedError(),
              Direction2DVector.rightTwiceForMeddle =>
                throw UnimplementedError(),
              Direction2DVector.rightTwiceForLeft =>
                KCoordinateDirection.right * 2,
              Direction2DVector.bottom => KCoordinateDirection.bottom,
              Direction2DVector.leftUp => KCoordinateDirection.topLeft,
              Direction2DVector.leftDown => KCoordinateDirection.backLeft,
              Direction2DVector.rightUp => KCoordinateDirection.topRight,
              Direction2DVector.rightDown => KCoordinateDirection.backRight,
            },
            end: Coordinate.zero,
            curve: curve,
          ),
        false => MyTween(
            begin: switch (this) {
              Direction2DVector.left => Coordinate.zero,
              Direction2DVector.leftTwiceForLeft => Coordinate.zero,
              Direction2DVector.leftTwiceForMiddle => KCoordinateDirection.left,
              Direction2DVector.leftTwiceForRight => throw UnimplementedError(),
              Direction2DVector.top => Coordinate.zero,
              Direction2DVector.right => Coordinate.zero,
              Direction2DVector.rightTwiceForRight => Coordinate.zero,
              Direction2DVector.rightTwiceForMeddle =>
                KCoordinateDirection.right,
              Direction2DVector.rightTwiceForLeft => throw UnimplementedError(),
              Direction2DVector.bottom => Coordinate.zero,
              Direction2DVector.leftUp => Coordinate.zero,
              Direction2DVector.leftDown => Coordinate.zero,
              Direction2DVector.rightUp => Coordinate.zero,
              Direction2DVector.rightDown => Coordinate.zero,
            },
            end: switch (this) {
              Direction2DVector.left => KCoordinateDirection.right,
              Direction2DVector.leftTwiceForLeft =>
                KCoordinateDirection.right * 2,
              Direction2DVector.leftTwiceForMiddle =>
                KCoordinateDirection.right,
              Direction2DVector.leftTwiceForRight => throw UnimplementedError(),
              Direction2DVector.top => KCoordinateDirection.bottom,
              Direction2DVector.right => KCoordinateDirection.left,
              Direction2DVector.rightTwiceForRight =>
                KCoordinateDirection.left * 2,
              Direction2DVector.rightTwiceForMeddle =>
                KCoordinateDirection.left,
              Direction2DVector.rightTwiceForLeft => throw UnimplementedError(),
              Direction2DVector.bottom => KCoordinateDirection.top,
              Direction2DVector.leftUp => KCoordinateDirection.backRight,
              Direction2DVector.leftDown => KCoordinateDirection.topRight,
              Direction2DVector.rightUp => KCoordinateDirection.backLeft,
              Direction2DVector.rightDown => KCoordinateDirection.topLeft,
            },
            curve: curve,
          ),
      };
}

enum Direction3D {
  front,
  back,
  left,
  top,
  right,
  bottom;

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
  static List<Direction3D> parseRotation(Coordinate radian) {
    // ?
    final r = FRadianCoordinate.restrictInAngle180Of(radian);

    final rX = r.dx;
    final rY = r.dy;
    final rZ = r.dz;

    return <Direction3D>[
      FRadian.checkIfWithinAngle90_90N(rY) &&
              FRadian.checkIfWithinAngle90_90N(rX)
          ? Direction3D.front
          : Direction3D.back,
      FRadian.checkIfWithinAngle0_180N(rY) &&
              FRadian.checkIfWithinAngle90_90N(rZ)
          ? Direction3D.left
          : Direction3D.right,
      FRadian.checkIfWithinAngle0_180(rX) &&
              FRadian.checkIfWithinAngle90_90N(rZ)
          ? Direction3D.top
          : Direction3D.bottom,
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
            Direction3D.front => Transform(
                transform: instance(),
                alignment: Alignment.center,
                child: child,
              ),
            Direction3D.back => Transform(
                transform: instance()..translate(Vector3(0, 0, -zDeep)),
                alignment: Alignment.center,
                child: child,
              ),
            Direction3D.left => Transform(
                alignment: Alignment.centerLeft,
                transform: instance()..rotateY(pi / 2),
                child: child,
              ),
            Direction3D.right => Transform(
                alignment: Alignment.centerRight,
                transform: instance()..rotateY(-pi / 2),
                child: child,
              ),
            Direction3D.top => Transform(
                alignment: Alignment.topCenter,
                transform: instance()..rotateX(-pi / 2),
                child: child,
              ),
            Direction3D.bottom => Transform(
                alignment: Alignment.bottomCenter,
                transform: instance()..rotateX(pi / 2),
                child: child,
              ),
          }
        : throw UnimplementedError();
  }
}

///
/// [cubicPointsMap] represents [corners]' cubic points, see [FSizeToPath.polygonCubicCorner] for implementation
///

abstract class RegularPolygon {
  /// static functions

  static double radianCornerOf(int n) => (n - 2) * KRadian.angle_180 / n;

  static double lengthSideOf(int n, num radiusCircumscribedCircle) => sqrt(
        radiusCircumscribedCircle.square * 2 * (1 - cos(KRadian.angle_360 / n)),
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
        4 => radiusCircumscribedCircle * sqrt1_2,
        6 => radiusCircumscribedCircle * sqrt(3) / 2,
        _ => radiusCircumscribedCircle *
            sin(FRadian.radianOf(FRadian.angleOf(radianCorner) / 2)),
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

abstract class RRegularPolygon extends RegularPolygon {
  static List<Radius> circularRadiusListOf(int n, double radius) =>
      List.generate(n, (index) => Radius.circular(radius));

  /// properties

  final List<Radius> radiusList;
  CubicPointsMapper cubicPointsMapper;

  Map<Offset, List<Offset>> get _cubicPointsForEachCorners;

  Iterable<List<Offset>> get cubicPoints =>
      cubicPointsMapper(_cubicPointsForEachCorners).values;

  RRegularPolygon(
    super.n, {
    required this.radiusList,
    required this.cubicPointsMapper,
    required super.radiusCircumscribedCircle,
  });
}

class RRegularPolygonCubicStyleOnEdge extends RRegularPolygon {
  double cornerRadius;
  double timesForEdge;

  double get timesForEdgeUnit => cornerRadius * tan(KRadian.angle_180 / n);

  RRegularPolygonCubicStyleOnEdge(
    super.n, {
    this.cornerRadius = 0,
    this.timesForEdge = 0,
    super.cubicPointsMapper = KCubicPointsMapper.add1_remove1,
    required super.radiusCircumscribedCircle,
  }) : super(
          radiusList: RRegularPolygon.circularRadiusListOf(n, cornerRadius),
        );

  ///
  /// each [cubicPoints.values] means [cornerPrevious, controlPointA, controlPointB, cornerNext],
  /// see [FSizeToPath.polygonCubicCorner] for implementation
  ///
  @override
  Map<Offset, List<Offset>> get _cubicPointsForEachCorners => corners
      .asMap()
      .map((index, current) => MapEntry(
            current,
            [
              OffsetExtension.vectorUnitOf(
                current,
                index == 0 ? corners.last : corners[index - 1],
                timesForEdgeUnit,
              ),
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
        //     v
        stepCornerRadiusPolygon,
        //     v
        stepCornerRadiusInscribedCircle,
        //     v
        stepCornerRadiusFragmentFitCorner(),
        //     v
        stepCornerRadiusArcCrossCenter(),
        //     v
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
      (lengthSide - inset) / tan(radianCornerCenterSide);

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
        _ =>
          ((radiusCircumscribedCircle - inset) * cos(radianCornerCenterSide)) /
              (1 - cos(radianCornerCenterSide)),
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

  // bool get is2D => direction.hasNoXY;

  Coordinate get toCoordinate => Coordinate.fromDirection(
        direction: direction,
        distance: distance,
      );

  Vector rotated(Coordinate d) => Vector(direction + d, distance);

  @override
  String toString() => "Vector($direction, $distance)";
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
  double get distance => sqrt(distanceSquared);

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

  static const Coordinate zero = Coordinate.cube(0);

  ///
  ///
  /// The description below, follows two rule:
  /// 1. positive radian means counterclockwise.
  /// 2. radian of "x axis" starts from [Direction3D.back]. radian of y axis, z axis start from [Direction3D.right].
  ///
  /// For example,
  /// [Offset.fromDirection] axis is [Direction3D.front] -> [Direction3D.back], so the radian "from 0 to 2π" going through
  /// [Direction3D.right], [Direction3D.bottom], [Direction3D.left], [Direction3D.top], [Direction3D.right] in sequence.
  ///
  /// [Matrix4.rotationX] axis is [Direction3D.left] -> [Direction3D.right]
  /// [Matrix4.rotationY] axis is [Direction3D.top] -> [Direction3D.bottom]
  /// [Matrix4.rotationZ] axis is [Direction3D.front] -> [Direction3D.back]
  ///
  /// by contrast, [Coordinate.fromDirection] is calculated in the definition:
  /// x axis is [Direction3D.left] -> [Direction3D.right]
  /// y axis is [Direction3D.back] -> [Direction3D.front]
  /// z axis is [Direction3D.bottom] -> [Direction3D.top]
  /// so there is a method helps [Coordinate] translate into the rotation of [Matrix4]
  ///
  ///
  factory Coordinate.fromDirection({
    required Coordinate direction,
    required double distance,
    Coordinate scale = KCoordinate.cube_1,
  }) {
    final dx = direction.dx;
    final dy = direction.dy;
    final dz = direction.dz;
    final point = Coordinate(
      distance * (cos(dz) * cos(dy)),
      distance * (-sin(dz) * -cos(dx)),
      distance * (sin(dx) * sin(dy)),
    );

    return scale == KCoordinate.cube_1
        ? point
        : Coordinate(
            point.dx * scale.dx,
            point.dy * scale.dy,
            point.dz * scale.dz,
          );
  }

  static Coordinate max(Coordinate a, Coordinate b) => a > b ? a : b;

  static Coordinate maxDistance(Coordinate a, Coordinate b) =>
      a.distance > b.distance ? a : b;

  Coordinate abs() => Coordinate(dx.abs(), dy.abs(), dz.abs());
}
