part of source;

///
/// this file contains:
///
/// [ObjectExtension]
/// [NumExtension], [DoubleExtension], [IntExtension]
///
/// [MatchExtension], [StringExtension]
///
/// [IterableExtension], [IterableIterableExtension], [IterableMapEntryExtension]
/// [IterableTimerExtension]
///
/// [StreamExtension], [StreamIterableExtension]
/// [ListExtension], [ListSetExtension]
/// [MapExtension]
///
/// [DurationExtension], [DateTimeExtension]
/// [StateExtension], [AnimationStatusExtension]
///
/// [SizeExtension], [OffsetExtension], [RectExtension], [DirectionExtension]
/// [OffsetListExtension]
///
///
///

extension ObjectExtension on Object {
  void log([String? string]) => developer.log(string ?? toString());
}

extension NumExtension on num {
  num get square => pow(this, 2);
}

extension DoubleExtension on double {
  Radius get toCircularRadius => Radius.circular(this);

  bool get isNearlyInt => (ceil() - this) <= 0.01;

  ///
  /// infinity usages
  ///

  static double proximateInfinityOf(double precision) =>
      1.0 / pow(0.1, precision);

  static double proximateNegativeInfinityOf(double precision) =>
      -1.0 / pow(0.1, precision);

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
}

extension MatchExtension on Match {
  String get group0 => group(0)!;
}

extension StringExtension on String {
  /// camel underscore

  // String get _fromUnderscoreToCamelBody => splitMapJoin(RegExp(r'_[a-z]'),
  //     onMatch: (match) => match.group0[1].toUpperCase());

  String get fromCamelToUnderscore =>
      lowercaseFirstChar.splitMapJoin(RegExp(r'[a-z][A-Z]'), onMatch: (match) {
        final s = match.group0;
        return '${s[0]}_${s[1].toLowerCase()}';
      });

  String get lowercaseFirstChar => replaceFirstMapped(
      RegExp(r'[A-Z]'), (match) => match.group0.toLowerCase());

  /// split

  MapEntry<String, String> get splitByFirstSpace {
    late final String key;
    final value = replaceFirstMapped(RegExp(r'\w '), (match) {
      key = match.group0.trim();
      return '';
    });
    return MapEntry(key, value);
  }
}

extension IterableExtension<I> on Iterable<I> {
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
    T Function(T current, I element, int index) foldIterable,
  ) {
    int index = -1;
    return fold(
      initialValue,
      (previousValue, element) => foldIterable(previousValue, element, ++index),
    );
  }

  Iterable<T> flat<T>({
    bool isNested = false,
  }) =>
      fold<List<T>>(
          [],
          (list, element) => (element is Iterable<T>)
              ? (list..addAll(element))
              : (element is T)
                  ? (list..add(element))
                  : (throw UnimplementedError()));

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

extension IterableIterableExtension<E> on Iterable<Iterable<E>> {
  Iterable<int> get lengths => map((e) => e.length);
}

extension IterableMapEntryExtension<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> get toMap => Map.fromEntries(this);
}

extension IterableTimerExtension on Iterable<Timer> {
  void cancelAll() {
    for (var t in this) {
      t.cancel();
    }
  }
}

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

extension ListExtension<T> on List<T> {
  void addIfNotNull(T? element) => element == null ? null : add(element);

  T getOrDefault(int position, T defaultValue) =>
      position < length ? this[position] : defaultValue;

  void addFirstAndRemoveFirst() => this
    ..add(first)
    ..removeAt(0);

  T addFirstAndRemoveFirstAndGet() => (this
        ..add(first)
        ..removeAt(0))
      .last;
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

extension DurationExtension on Duration {
  String toStringDayMinuteSecond({String splitter = ':'}) {
    final dayMinuteSecond = toString().substring(0, 7);
    return splitter == ":"
        ? dayMinuteSecond
        : dayMinuteSecond.splitMapJoin(RegExp(':'), onMatch: (_) => splitter);
  }
}

extension DateTimeExtension on DateTime {
  String get date => toString().split(' ').first;

  String get time => toString().split(' ').last;

  static String parseTimestampOf(String string) =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(string)).toIso8601String();
}

extension StateExtension on State {
  // ignore: invalid_use_of_protected_member
  VoidCallback setStateOf(VoidCallback callback) => () => setState(callback);
}

extension AnimationStatusExtension on AnimationStatus {
  void listenWhenCompleted(VoidCallback listener) =>
      this == AnimationStatus.completed ? listener() : kVoidCallback;
}

extension SizeExtension on Size {
  double get diagonal => sqrt(width * width + height * height);

  Offset get toOffset => Offset(width, height);

  Radius get toRadiusEllipse => Radius.elliptical(width, height);

  Offset diagonalPosition(Offset zero) =>
      Offset(zero.dx + width, zero.dy + height);
}

/// offset
extension OffsetExtension on Offset {
  /// vector

  static double distanceOf(Offset from, Offset destination) =>
      (destination - from).distance;

  static Offset unitOf(Offset from, Offset destination) =>
      (destination - from) / distanceOf(from, destination);

  static Offset vectorOf(Offset from, Offset destination, double t) =>
      from + (destination - from) * t;

  static Offset vectorUnitOf(Offset from, Offset destination, double t) =>
      from + unitOf(from, destination) * t;

  ///
  /// dynamic methods, getters
  ///

  String toStringAsFixed1() =>
      '(${dx.toStringAsFixed(1)}, ${dy.toStringAsFixed(1)})';

  Size get toSize => Size(dx, dy);

  Coordinate get toCoordinate => Coordinate.ofXY(dx, dy);

  Offset get toReciprocal => Offset(1 / dx, 1 / dy);

  MyTween<Offset> get tweenFromZero => MyTween(begin: Offset.zero, end: this);

  Offset toCenterOffset(Size size) => Offset(
        (dx + (dx + size.width)) / 2,
        (dy + (dy + size.height)) / 2,
      );
}

extension RectExtension on Rect {
  double get diagonal => size.diagonal;
}

extension OffsetListExtension on List<Offset> {
  List<Offset> adjustCenterOf(Size size) {
    final center = size.center(Offset.zero);
    return map((e) => e + center).toList(growable: false);
  }
}
