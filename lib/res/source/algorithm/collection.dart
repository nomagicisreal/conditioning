part of source;

///
/// this file contains:
///
/// [NumExtension], [DoubleExtension], [IntExtension]
/// [MatchExtension], [StringExtension]
/// [SizeExtension], [OffsetExtension], [RectExtension], [PathOperationExtension]
///
/// [DurationExtension], [DateTimeExtension]
///
/// [IterableExtension]
/// [IterableTimerExtension], [IterableMapEntryExtension]
///
/// [ListExtension], [ListSetExtension], [ListRadiusExtension], [ListOffsetExtension]
///
/// [MapExtension]
///
/// [StreamExtension], [StreamIterableExtension]
///
///
///

extension NumExtension on num {
  num get square => math.pow(this, 2);
}

extension DoubleExtension on double {
  static final double infinity2_31 = DoubleExtension.proximateInfinityOf(2.31);
  static final double infinity3_2 = DoubleExtension.proximateInfinityOf(3.2);
  static const double sqrt2 = math.sqrt2;
  static const double sqrt3 = 1.7320508075688772;
  static const double sqrt5 = 2.23606797749979;
  static const double sqrt6 = 2.44948974278317;
  static const double sqrt7 = 2.6457513110645907;
  static const double sqrt8 = 2.8284271247461903;
  static const double sqrt10 = 3.1622776601683795;
  static const double sqrt1_2 = math.sqrt1_2;
  static const double sqrt1_3 = 0.5773502691896257;
  static const double sqrt1_5 = 0.4472135954999579;
  static const double sqrt1_6 = 0.408248290463863;
  static const double sqrt1_7 = 0.3779644730092272;
  static const double sqrt1_8 = 0.3535533905932738;
  static const double sqrt1_10 = 0.31622776601683794;

  Radius get toCircularRadius => Radius.circular(this);

  bool get isNearlyInt => (ceil() - this) <= 0.01;

  ///
  /// infinity usages
  ///

  static double proximateInfinityOf(double precision) =>
      1.0 / math.pow(0.1, precision);

  static double proximateNegativeInfinityOf(double precision) =>
      -1.0 / math.pow(0.1, precision);

  double filterInfinity(double precision) => switch (this) {
        double.infinity => proximateInfinityOf(precision),
        double.negativeInfinity => proximateNegativeInfinityOf(precision),
        _ => this,
      };
}

extension IntExtension on int {
  int get factorial {
    assert(!isNegative && this != 0, 'invalid factorial integer: $this');
    int accelerator = 1;
    for (var i = 1; i <= this; i++) {
      accelerator *= i;
    }
    return accelerator;
  }

  bool isSmallerOrEqualTo(int value) => this == value || this < value;

  bool isLess1OrEqualTo(int value) => this == value || this + 1 == value;

  bool isHigherOrEqualTo(int value) => this == value || this > value;

  bool isHigher1OrEqualTo(int value) => this == value || this == value + 1;
}

///
///
/// match, string
///
///

extension MatchExtension on Match {
  String get group0 => group(0)!;
}

extension StringExtension on String {
  String get lowercaseFirstChar => replaceFirstMapped(
      RegExp(r'[A-Z]'), (match) => match.group0.toLowerCase());

  MapEntry<String, String> get splitByFirstSpace {
    late final String key;
    final value = replaceFirstMapped(RegExp(r'\w '), (match) {
      key = match.group0.trim();
      return '';
    });
    return MapEntry(key, value);
  }

  ///
  /// camel, underscore usage
  ///

  String get fromUnderscoreToCamelBody => splitMapJoin(RegExp(r'_[a-z]'),
      onMatch: (match) => match.group0[1].toUpperCase());

  String get fromCamelToUnderscore =>
      lowercaseFirstChar.splitMapJoin(RegExp(r'[a-z][A-Z]'), onMatch: (match) {
        final s = match.group0;
        return '${s[0]}_${s[1].toLowerCase()}';
      });
}

///
/// size, offset, rect
///

extension SizeExtension on Size {
  double get diagonal => math.sqrt(width * width + height * height);

  Offset get toOffset => Offset(width, height);

  Radius get toRadiusEllipse => Radius.elliptical(width, height);

  Size keepWidthInRatioOf(double ratio) => Size(width, width * ratio);

  Size keepHeightInRatioOf(double ratio) => Size(height * ratio, height);
}

extension OffsetExtension on Offset {
  static double distanceOf(Offset from, Offset destination) =>
      (destination - from).distance;

  static Offset unitOf(Offset from, Offset destination) =>
      (destination - from) / distanceOf(from, destination);

  static Offset vectorOf(Offset from, Offset destination, double t) =>
      from + (destination - from) * t;

  static Offset vectorUnitOf(Offset from, Offset destination, double t) =>
      from + unitOf(from, destination) * t;

  String toStringAsFixed1() =>
      '(${dx.toStringAsFixed(1)}, ${dy.toStringAsFixed(1)})';

  Size get toSize => Size(dx, dy);

  Coordinate get toCoordinate => Coordinate.ofXY(dx, dy);

  Offset get toReciprocal => Offset(1 / dx, 1 / dy);

  Between<Offset> get tweenFromZero => Between(begin: Offset.zero, end: this);

  Offset toCenterOffset(Size size) => Offset(
        (dx + (dx + size.width)) / 2,
        (dy + (dy + size.height)) / 2,
      );
}

extension RectExtension on Rect {
  static Rect fromLTSize(double left, double top, Size size) =>
      Rect.fromLTWH(left, top, size.width, size.height);

  static Rect fromOffsetSize(Offset zero, Size size) =>
      Rect.fromLTWH(zero.dx, zero.dy, size.width, size.height);

  static Rect fromCenterSize(Offset center, Size size) =>
      Rect.fromCenter(center: center, width: size.width, height: size.height);

  static Rect fromCircle(Offset center, double radius) =>
      Rect.fromCircle(center: center, radius: radius);

  Rect expandToIncludeDirection({
    required Direction2DIn8 direction,
    required double width,
    required double length,
  }) {
    final start = offsetOf(direction);
    return expandToInclude(
      switch (direction) {
        Direction2DIn8.top => Rect.fromPoints(
            start + Offset(width / 2, 0),
            start + Offset(-width / 2, -length),
          ),
        Direction2DIn8.bottom => Rect.fromPoints(
            start + Offset(width / 2, 0),
            start + Offset(-width / 2, length),
          ),
        Direction2DIn8.left => Rect.fromPoints(
            start + Offset(0, width / 2),
            start + Offset(-length, -width / 2),
          ),
        Direction2DIn8.right => Rect.fromPoints(
            start + Offset(0, width / 2),
            start + Offset(length, -width / 2),
          ),
        Direction2DIn8.topLeft => Rect.fromPoints(
            start,
            start + Offset(-length, -length) * DoubleExtension.sqrt1_2,
          ),
        Direction2DIn8.topRight => Rect.fromPoints(
            start,
            start + Offset(length, -length) * DoubleExtension.sqrt1_2,
          ),
        Direction2DIn8.bottomLeft => Rect.fromPoints(
            start,
            start + Offset(-length, length) * DoubleExtension.sqrt1_2,
          ),
        Direction2DIn8.bottomRight => Rect.fromPoints(
            start,
            start + Offset(length, length) * DoubleExtension.sqrt1_2,
          ),
      },
    );
  }

  double get distanceDiagonal => size.diagonal;

  Offset offsetOf<T>(T value) => switch (value) {
        Alignment() => switch (value) {
            Alignment.topLeft => topLeft,
            Alignment.topCenter => topCenter,
            Alignment.topRight => topRight,
            Alignment.centerLeft => centerLeft,
            Alignment.center => center,
            Alignment.centerRight => centerRight,
            Alignment.bottomLeft => bottomLeft,
            Alignment.bottomCenter => bottomCenter,
            Alignment.bottomRight => bottomRight,
            _ => throw UnimplementedError(),
          },
        Direction2DIn8() => switch (value) {
            Direction2DIn8.topLeft => topLeft,
            Direction2DIn8.top => topCenter,
            Direction2DIn8.topRight => topRight,
            Direction2DIn8.left => centerLeft,
            Direction2DIn8.right => centerRight,
            Direction2DIn8.bottomLeft => bottomLeft,
            Direction2DIn8.bottom => bottomCenter,
            Direction2DIn8.bottomRight => bottomRight,
          },
        _ => throw UnimplementedError(),
      };
}

///
/// duration, datetime
///

extension DurationExtension on Duration {
  DurationFR get toFR => DurationFR.constant(this);

  String toStringDayMinuteSecond({String splitter = ':'}) {
    final dayMinuteSecond = toString().substring(0, 7);
    return splitter == ":"
        ? dayMinuteSecond
        : dayMinuteSecond.splitMapJoin(RegExp(':'), onMatch: (_) => splitter);
  }
}

extension DateTimeExtension on DateTime {
  String get date => toString().split(' ').first; // $y-$m-$d

  String get time => toString().split(' ').last; // $h:$min:$sec.$ms$us

  int get monthDays => switch (month) {
        1 => 31,
        2 => year % 4 == 0
            ? year % 100 == 0
                ? year % 400 == 0
                    ? 29
                    : 28
                : 29
            : 28,
        3 => 31,
        4 => 30,
        5 => 31,
        6 => 30,
        7 => 31,
        8 => 31,
        9 => 30,
        10 => 31,
        11 => 30,
        12 => 31,
        _ => throw UnimplementedError(),
      };

  static String parseTimestampOf(String string) =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(string)).toIso8601String();
}

///
///
///
///
/// collection
///
///
///
///

extension IterableExtension<I> on Iterable<I> {
  bool get hasElement => !isEmpty;

  List<T> mapToList<T>(
    T Function(I i) mapper, {
    bool growable = false,
  }) =>
      map(mapper).toList(growable: growable);

  bool notContains(I element) => !contains(element);

  T foldWith<T, O>(
    T initialValue,
    List<O> another,
    T Function(T current, I element, O elementAnother) foldIterable,
  ) {
    assert(length == another.length, 'invalid length');
    return foldWithIndex(
      initialValue,
      (previousValue, element, index) => foldIterable(
        previousValue,
        element,
        another[index],
      ),
    );
  }

  T foldWithIndex<T>(
    T initialValue,
    T Function(T current, I element, int i) foldIterable,
  ) {
    int index = -1;
    return fold(
      initialValue,
      (previousValue, element) => foldIterable(previousValue, element, ++index),
    );
  }

  Iterable<T> flat<T>({bool isNested = false}) => fold<List<T>>(
        [],
        (list, element) => switch (element) {
          T() => list..add(element),
          Iterable<T>() => list..addAll(element),
          _ => throw UnimplementedError(),
        },
      );

  Iterable<Iterable<I>> chunk(Iterable<int> lengthOfEachChunk) {
    assert(lengthOfEachChunk.reduce((a, b) => a + b) == length);
    final list = toList(growable: false);
    final splitList = <List<I>>[];

    int start = 0;
    int end;
    for (var i in lengthOfEachChunk) {
      end = i + start;
      splitList.add(list.getRange(start, end).toList(growable: false));
      start = end;
    }
    return splitList;
  }
}

extension IterableTimerExtension on Iterable<Timer> {
  void cancelAll() {
    for (var t in this) {
      t.cancel();
    }
  }
}

extension IterableMapEntryExtension<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> get toMap => Map.fromEntries(this);
}

extension ListExtension<T> on List<T> {
  void addIfNotNull(T? element) => element == null ? null : add(element);

  T getOrDefault(int position, T defaultValue) =>
      position < length ? this[position] : defaultValue;

  void addFirstAndRemoveFirst() => this
    ..add(first)
    ..removeFirst();

  T addFirstAndRemoveFirstAndGet() => (this
        ..add(first)
        ..removeFirst())
      .last;

  T removeFirst() => removeAt(0);

  /// see also [Set.intersection]
  Map<int, T> intersectionWith(List<T> others) {
    final maxLength = math.min(length, others.length);
    final intersection = <int, T>{};

    for (var index = 0; index < maxLength; index++) {
      final current = this[index];
      if (current == others[index]) {
        intersection.putIfAbsent(index, () => current);
      }
    }

    return intersection;
  }

  /// see also [Set.difference]
  List<int> differenceIndexWith(List<T> others) {
    final difference = <int>[];
    void put(int index) => difference.add(index);

    final differentiationLength = math.min(length, others.length);
    for (var index = 0; index < differentiationLength; index++) {
      final current = this[index];
      if (current != others[index]) put(index);
    }

    if (length > others.length) {
      for (var index = others.length; index < length; index++) {
        put(index);
      }
    }

    return difference;
  }

  Map<int, T> differenceWith(List<T> others) =>
      differenceIndexWith(others).fold(
        <int, T>{},
        (difference, i) => difference..putIfAbsent(i, () => this[i]),
      );
}

extension ListSetExtension<I> on List<Set<I>> {
  void forEachAddAll(List<Set<I>>? another) {
    if (another != null) {
      for (var i = 0; i < length; i++) {
        this[i].addAll(another[i]);
      }
    }
  }
}

extension ListRadiusExtension on List<Radius> {
  static List<Radius> generateCircular(int n, double radius) =>
      List.generate(n, (index) => Radius.circular(radius));
}

extension ListOffsetExtension on List<Offset> {
  List<Offset> adjustCenterOf(Size size) {
    final center = size.center(Offset.zero);
    return map((point) => point + center).toList(growable: false);
  }
}

extension MapExtension<K, V> on Map<K, V> {
  T fold<T>(
    T initialValue,
    T Function(T current, MapEntry<K, V> entry) foldMap,
  ) =>
      entries.fold<T>(
        initialValue,
        (previousValue, element) => foldMap(previousValue, element),
      );

  T foldWithIndex<T>(
    T initialValue,
    T Function(T current, MapEntry<K, V> entry, int entryIndex) foldMap,
  ) {
    int index = -1;
    return entries.fold<T>(
      initialValue,
      (previousValue, element) => foldMap(previousValue, element, ++index),
    );
  }

  void replaceAll(Iterable<K>? keys, V Function(V value) value) {
    if (keys != null) {
      for (var k in keys) {
        update(k, value);
      }
    }
  }

  bool notContainsKey(K key) => !containsKey(key);

  bool containsKeys(Iterable<K> keys) {
    for (var key in keys) {
      if (notContainsKey(key)) {
        return false;
      }
    }
    return true;
  }
}

///
///
///
///
///
/// stream
///
///
///
///
///

extension StreamExtension<M> on Stream<M> {
  Stream<M> get whereDiff {
    M? previousValue;
    return where((event) {
      if (previousValue == event) {
        return false;
      } else {
        previousValue = event;
        return true;
      }
    });
  }
}

extension StreamIterableExtension<T, I extends Iterable<T>> on Stream<I> {
  Stream<int> get mapLength => map((items) => items.length);

  Stream<Iterable<T>> mapWhere(bool Function(T item) checker) =>
      map((Iterable<T> items) => items.where(checker));
}
