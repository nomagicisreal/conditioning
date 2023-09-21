// ignore_for_file: non_constant_identifier_names

part of source;

///
/// this file contains:
/// [FFisherSequence]
/// [KOffsetPermutation4]
///
///
///

extension FFisherSequence on List {
  static int of(int n) {
    int a = 0;
    int b = 1;

    for (var i = 2; i <= n; i++) {
      final next = a + b;
      a = b;
      b = next;
    }
    return switch (n) {
      < 0 => throw UnimplementedError(),
      0 => 0,
      _ => b,
    };
  }
}

extension KOffsetPermutation4 on List<Offset> {
  static const Mapper<List<Offset>> p0123 = _0123;
  static const Mapper<List<Offset>> p1230 = _1230;
  static const Mapper<List<Offset>> p2301 = _2301;
  static const Mapper<List<Offset>> p3012 = _3012;
  static const Mapper<List<Offset>> p0231 = _0231;
  static const Mapper<List<Offset>> p2310 = _2310;
  static const Mapper<List<Offset>> p3102 = _3102;
  static const Mapper<List<Offset>> p1023 = _1023;
  static const Mapper<List<Offset>> p0132 = _0132;
  static const Mapper<List<Offset>> p1320 = _1320;
  static const Mapper<List<Offset>> p3201 = _3201;
  static const Mapper<List<Offset>> p2013 = _2013;
  static const Mapper<List<Offset>> p1302 = _1302;
  static const Mapper<List<Offset>> p3021 = _3021;
  static const Mapper<List<Offset>> p0213 = _0213;
  static const Mapper<List<Offset>> p2130 = _2130;
  static const Mapper<List<Offset>> p0312 = _0312;
  static const Mapper<List<Offset>> p3120 = _3120;
  static const Mapper<List<Offset>> p1203 = _1203;
  static const Mapper<List<Offset>> p2031 = _2031;
  static const Mapper<List<Offset>> p0321 = _0321;
  static const Mapper<List<Offset>> p3210 = _3210;
  static const Mapper<List<Offset>> p2103 = _2103;
  static const Mapper<List<Offset>> p1032 = _1032;

  // 0, 1, 2, 3
  // 1, 2, 3, a (add a, remove a)
  // 2, 3, a, b
  // 3, a, 1, c
  static List<Offset> _0123(List<Offset> list) => list;

  static List<Offset> _1230(List<Offset> list) =>
      list..addFirstAndRemoveFirst();

  static List<Offset> _2301(List<Offset> list) =>
      _1230(list)..addFirstAndRemoveFirst();

  static List<Offset> _3012(List<Offset> list) =>
      _2301(list)..addFirstAndRemoveFirst();

  // a, 2, 3, b (add 1, remove b)
  // 2, 3, 1, a
  // 3, 1, a, c
  // 1, a, 2, d
  static List<Offset> _0231(List<Offset> list) => list
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> _2310(List<Offset> list) =>
      _0231(list)..addFirstAndRemoveFirst();

  static List<Offset> _3102(List<Offset> list) =>
      _2310(list)..addFirstAndRemoveFirst();

  static List<Offset> _1023(List<Offset> list) =>
      _3102(list)..addFirstAndRemoveFirst();

  // 0, 1, 3, 2 (add 2, remove 2)
  // 1, 3, 2, 0
  // 3, 2, 0, 1
  // 2, 0, 1, 3
  static List<Offset> _0132(List<Offset> list) => list
    ..add(list[2])
    ..removeAt(2);

  static List<Offset> _1320(List<Offset> list) =>
      _0132(list)..addFirstAndRemoveFirst();

  static List<Offset> _3201(List<Offset> list) =>
      _1320(list)..addFirstAndRemoveFirst();

  static List<Offset> _2013(List<Offset> list) =>
      _3201(list)..addFirstAndRemoveFirst();

  // 1, 3, 0, 2 (add 02, remove 02)
  // 3, 0, 2, 1
  // 0, 2, 1, 3
  // 2, 1, 3, 0
  static List<Offset> _1302(List<Offset> list) => _1230(list)
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> _3021(List<Offset> list) =>
      _1302(list)..addFirstAndRemoveFirst();

  static List<Offset> _0213(List<Offset> list) =>
      _3021(list)..addFirstAndRemoveFirst();

  static List<Offset> _2130(List<Offset> list) =>
      _0213(list)..addFirstAndRemoveFirst();

  // 0, 3, 1, 2 (add 12, remove 12)
  // 3, 1, 2, 0
  // 1, 2, 0, 3
  // 2, 0, 3, 1
  static List<Offset> _0312(List<Offset> list) => _0231(list)
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> _3120(List<Offset> list) =>
      _0312(list)..addFirstAndRemoveFirst();

  static List<Offset> _1203(List<Offset> list) =>
      _3120(list)..addFirstAndRemoveFirst();

  static List<Offset> _2031(List<Offset> list) =>
      _1203(list)..addFirstAndRemoveFirst();

  // 0, 3, 2, 1 (add 21, remove 21)
  // 3, 2, 1, 0
  // 2, 1, 0, 3
  // 1, 0, 3, 2
  static List<Offset> _0321(List<Offset> list) => _0132(list)
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> _3210(List<Offset> list) =>
      _0321(list)..addFirstAndRemoveFirst();

  static List<Offset> _2103(List<Offset> list) =>
      _3210(list)..addFirstAndRemoveFirst();

  static List<Offset> _1032(List<Offset> list) =>
      _2103(list)..addFirstAndRemoveFirst();
}
