part of source;

///
/// this file contains:
/// [KLaTexString], [KLatexStringEquation], [KLatexStringMatrix1N], [KLatexStringMatrix2N], [FLaTexString]
///
/// [FPredicatorComparison], [FTernaryPredicatorComparison]
///
/// [KMapperNone], [FMapperDouble],
/// [KMapperCubicPointsPermutation],
/// [FOffsetListWithSize]
///
/// [FTranslatorConstant]
/// [KOffsetFromSize]
///
/// [FStream]
///
///

extension KLaTexString on String {
  static const quadraticRoots = r"{-b \pm \sqrt{b^2-4ac} \over 2a}";
  static const sn = r"S_n";
  static const x1_ = r"x_1 + x_2 + ... + x_n";
  static const x1_3 = r"x_1 + x_2 + x_3";
  static const x1_4 = r"x_1 + x_2 + x_3 + x_4";
  static const x1_5 = r"x_1 + x_2 + x_3 + x_4 + x_5";
  static const ax1_ = r"a_1x_1 + a_2x_2 + ... + a_nx_n";
  static const ax1_3 = r"a_1x_1 + a_2x_2 + a_3x_3";
  static const ax1_4 = r"a_1x_1 + a_2x_2 + a_3x_3 + a_4x_4";
  static const ax1_5 = r"a_1x_1 + a_2x_2 + a_3x_3 + a_4x_4 + a_5x_5";
}

extension KLatexStringEquation on String {
  static const quadraticRootsOfX = r"x = " + KLaTexString.quadraticRoots;
  static const yLinearABX = r"y = a + bx";
  static const yLinearMXK = r"y = mx + k";
}

extension KLatexStringMatrix1N on String {
  static const y1_ = r"""\begin{bmatrix}
  y_1\\
  y_2\\
  ...\\
  y_n\\
  \end{bmatrix}""";
}

extension KLatexStringMatrix2N on String {
  static const const1_x1_ = r"""\begin{bmatrix}
  1&x_1\\
  1&x_2\\
  ...&...\\
  1&x_n\\
  \end{bmatrix}""";
}

extension FLaTexString on String {
  static String equationOf(Iterable<String> values) => values.reduce(
        (a, b) => "$a = $b",
      );
}

extension FPredicator on Predicator {
  static Predicator<DateTime> isSameDayWith(DateTime? day) =>
      (currentDay) => FDateTime.isSameDay(currentDay, day);
}

extension FPredicatorComparison on PredicatorComparison {
  static bool alwaysTrue<T>(T a, T? b) => true;

  static bool alwaysFalse<T>(T a, T? b) => false;

  static bool equal(bool a, bool? b) => a == b;

  static bool unequal(bool a, bool? b) => a != b;

  static bool intEqual(int a, int? b) => a == b;

  static bool intBigger(int a, int? b) => b != null && a > b;

  static bool intSmaller(int a, int? b) => b != null && a < b;
}

extension FTernaryPredicatorComparison on TernaryPredicatorComparison {
  static bool? alwaysTrue<T>(T a, T? b) => true;

  static bool? alwaysFalse<T>(T a, T? b) => false;

  static bool? alwaysNull<T>(T a, T? b) => null;

  static bool? intEqualOrSmallerOrBigger(int a, int? b) => b == null
      ? null
      : switch (a - b) {
          0 => true,
          < 0 => false,
          _ => null,
        };
}

///
///
/// mapper
///
///

extension KMapperNone on Mapper<double> {
  static const Mapper<double> ofDouble = _double;
  static const Mapper<Offset> ofOffset = _offset;
  static const Mapper<Coordinate> ofCoordinate = _coordinate;
  static const Mapper<Size> ofSize = _size;

  static double _double(double t) => t;

  static Offset _offset(Offset t) => t;

  static Coordinate _coordinate(Coordinate t) => t;

  static Size _size(Size size) => size;
}

extension KMapper on Mapper<Curve> {
  static const Mapper<Curve> curveFlipped = _flipped;

  static Curve _flipped(Curve curve) => curve.flipped;
}

extension FMapperDouble on Mapper<double> {
  static Mapper<double> operate(Operator operator, double value) =>
      operator.doubleMapperWith(value);

  static Mapper<double> sinFromFactor(double timeFactor, double factor) =>
      (value) => math.sin(timeFactor * value) * factor;

  // return "times of period" of (0 ~ 1 ~ 0 ~ -1 ~ 0)
  static Mapper<double> sinFromPeriod(double times) {
    final tween = Tween(
      begin: 0.0,
      end: switch (times) {
        double.infinity || double.negativeInfinity => throw UnimplementedError(
            'instead of times infinity, pls use [Ani] to repeat animation',
          ),
        _ => KRadian.angle_360 * times,
      },
    );
    return (value) => math.sin(tween.transform(value));
  }
}

extension KMapperCubicPointsPermutation on Mapper<Map<Offset, List<Offset>>> {
  static const Mapper<Map<Offset, List<Offset>>> p0231 = _0231;
  static const Mapper<Map<Offset, List<Offset>>> p1230 = _1230;

  static Map<Offset, List<Offset>> _0231(Map<Offset, List<Offset>> points) =>
      points.map(
        (points, cubicPoints) => MapEntry(
          points,
          KOffsetPermutation4.p0231(cubicPoints),
        ),
      );

  static Map<Offset, List<Offset>> _1230(Map<Offset, List<Offset>> points) =>
      points.map(
        (points, cubicPoints) => MapEntry(
          points,
          KOffsetPermutation4.p1230(cubicPoints),
        ),
      );

  static Mapper<Map<Offset, List<Offset>>> of(Mapper<List<Offset>> mapper) =>
      (points) => points
          .map((points, cubicPoints) => MapEntry(points, mapper(cubicPoints)));
}

extension FOffsetListWithSize on MapperWith<List<Offset>, Size> {
  static List<Offset> transformPointsToSizeCenter(
    List<Offset> points,
    Size size,
  ) =>
      points.adjustCenterOf(size);
}

///
///
/// translator
///
///

extension FTranslatorConstant on Translator {
  static Translator<Size, Offset> ofSizeToOffset(Offset value) => (_) => value;

  static Translator<Size, Path> ofSizeToPath(Path value) => (_) => value;
}

extension KOffsetFromSize on Translator<Size, Offset> {
  static const Translator<Size, Offset> topLeft = _topLeft;
  static const Translator<Size, Offset> topCenter = _topCenter;
  static const Translator<Size, Offset> topRight = _topRight;
  static const Translator<Size, Offset> centerLeft = _centerLeft;
  static const Translator<Size, Offset> center = _center;
  static const Translator<Size, Offset> centerRight = _centerRight;
  static const Translator<Size, Offset> bottomLeft = _bottomLeft;
  static const Translator<Size, Offset> bottomCenter = _bottomCenter;
  static const Translator<Size, Offset> bottomRight = _bottomRight;

  static Offset _topLeft(Size size) => size.topLeft(Offset.zero);

  static Offset _topCenter(Size size) => size.topCenter(Offset.zero);

  static Offset _topRight(Size size) => size.topRight(Offset.zero);

  static Offset _centerLeft(Size size) => size.centerLeft(Offset.zero);

  static Offset _center(Size size) => size.center(Offset.zero);

  static Offset _centerRight(Size size) => size.centerRight(Offset.zero);

  static Offset _bottomLeft(Size size) => size.bottomLeft(Offset.zero);

  static Offset _bottomCenter(Size size) => size.bottomCenter(Offset.zero);

  static Offset _bottomRight(Size size) => size.bottomRight(Offset.zero);
}

///
///
/// stream
///
///
///

extension FStream on Stream {
  static Stream<int> intOf({
    int start = 1,
    int end = 10,
    Duration interval = KDuration.second1,
    bool startWithoutDelay = true,
  }) async* {
    final yieldFun = startWithoutDelay
        ? (int value) async => await Future.delayed(interval).then((_) => value)
        : (int value) async => value == start
            ? value
            : await Future.delayed(interval).then((_) => value);

    if (end >= start) {
      for (var value = start; value <= end; value++) {
        yield await yieldFun(value);
      }
    } else {
      for (var value = start; value >= end; value--) {
        yield await yieldFun(value);
      }
    }
  }

  static Stream<double> doubleOf(
    int elementCount, {
    Duration interval = KDuration.second1,
  }) async* {
    for (int i = 0; i < elementCount; i++) {
      yield i.toDouble();
      await Future.delayed(interval);
    }
  }

  static Stream<FollowerBuilder> followerOf(
    int elementCount, {
    Duration interval = KDuration.second2,
    Offset begin = Offset.zero,
    Offset distance = KCoordinate.cube_10,
  }) async* {
    Offset offset = begin;
    for (int i = 0; i < elementCount; i++, offset += distance) {
      yield (link) => Follower(
            link: link,
            leaderOffset: offset,
            anchorOnLeader: Alignment.center,
            child: FSizedBox.square300Of(KColoredBox.green),
          );
      await Future.delayed(interval);
    }
  }
}
