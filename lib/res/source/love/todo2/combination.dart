part of todo2;

// import 'package:conditioning/res/source/source.dart';
// import 'package:conditioning/ui/widget/compose/graph/api.dart';
// import 'ani.dart';
//
// ///
// /// this file contains:
// ///
// /// TODO: use other data language dependency to handle combination problem
// /// class:
// /// [Combination]
// ///
// /// typedef:
// /// [Combiner]
// /// [Combine]
// ///
// ///
// /// TODO: auto generate combinations util
// /// extension:
// /// [PccCombinations]
// ///
// ///
// ///
//
// // combination
// class Combination<T> {
//   final Set<T> source;
//
//   const Combination({required this.source});
//
//   ///
//   /// methods, getters:
//   /// - [combinationCountOf]
//   /// - [permutationCountOf]
//   /// - [step]
//   /// - [stepsOf]
//   /// - [stepsIn1]
//   ///
//
//   ///
//   /// - example1,
//   ///   [source] = {'hello', 'hi', 'apple', 'banana', 'cat'}
//   ///   [chunks] = [1, 2, 2]
//   ///   - [combinationCountOf] ([chunks]) = C5_1 * C4_2 * C2_2 / 2! = 5 * 6 * 1 / 2 = 15 #
//   ///   - [permutationCountOf] ([chunks]) = 15 * 3! = 90 #
//   ///
//   /// - example2,
//   ///   [source] = [1, 2, 3, 4, 5, 6]
//   ///   [chunks] = [2, 2, 2]
//   ///   - [combinationCountOf] ([chunks]) = C6_2 * C4_2 * C2_2 / 3! = 15 * 6 * 1 / 6 = 15 #
//   ///   - [permutationCountOf] ([chunks]) = 15 * 3! = 90 #
//   ///
//   ///
//   int combinationCountOf(Iterable<int> chunks) {
//     assert(
//       chunks.reduce((a, b) => a + b) == source.length,
//       'invalid chunks: $chunks not fit the ${source.length}-length-source',
//     );
//     int amount = 1;
//
//     int base = source.length;
//     for (var chunk in chunks) {
//       final theOther = base - chunk;
//       amount *= base.factorial ~/
//           (chunk.factorial * (theOther == 0 ? 1 : theOther).factorial);
//       base -= chunk;
//     }
//
//     final set = chunks.toSet();
//     return set.length == chunks.length
//         ? amount
//         : amount ~/
//             set
//                 .map((e) => chunks
//                     .fold(0, (value, c) => e == c ? value + 1 : value)
//                     .factorial)
//                 .reduce((value, element) => value * element);
//   }
//
//   int permutationCountOf(Iterable<int> chunks) {
//     int combination = combinationCountOf(chunks);
//     combination *= chunks.length.factorial;
//     return combination;
//   }
//
//   int get length => source.length;
//
//   Map<int, Iterable<T>> get stepsIn1 => {1: source};
//
//   //
//   // Iterable<Map<int, Iterable<T>>> stepsOf(Iterable<int> chunks) {
//   //   final result = <Map<int, Iterable<T>>>[];
//   //   final stepsAmount = chunks.length;
//   //
//   //   final item = <int, Iterable<T>>{};
//   //
//   //   ///
//   //   /// 1. find all combination by filter source until it's empty
//   //   /// 2. find all permutation on each combination
//   //   ///
//   //
//   //   final pAmount = permutationCountOf(chunks);
//   //   final cAmount = pAmount ~/ chunks.length.factorial;
//   //
//   //   final source = this.source;
//   //
//   //   int skip = 0;
//   //
//   //   final combinations = <Iterable<T>>[];
//   //
//   //   ///
//   //   ///
//   //   /// [source] = [1, 2, 3, 4, 5, 6]
//   //   /// [chunks] = [2, 2, 2]
//   //   /// combinations1 = [1, 2], [3, 4], [5, 6]
//   //   /// combinations2 = [1, 3], [2, 4], [5, 6]
//   //   /// combinations3 = [1, 4], [2, 3], [5, 6]
//   //   /// combinations4 = [1, 5], [2, 3], [5, 6]
//   //   /// combinations5 = [1, 6], [2, 3], [4, 5]
//   //   ///
//   //   /// c1 = [1, 2], [3, 4], [5, 6]
//   //   /// c1' = [1, 2], [3, 5], [4, 6]
//   //   /// c1'' = [1, 2], [3, 6], [4, 5]
//   //   ///
//   //   /// 5 * 3 = 10
//   //   ///
//   //   findCombination:
//   //   for (var chunk in chunks) {
//   //     final combination = <T>[];
//   //
//   //     final sourceLength = source.length;
//   //     for (var i = 1; i <= sourceLength; i++) {
//   //       if (combination.length != chunk) {
//   //         combination.add(source.elementAt(i - 1));
//   //       } else {
//   //         combinations.add(combination);
//   //         source.removeAll(combination);
//   //         skip += 1;
//   //         continue findCombination;
//   //       }
//   //     }
//   //   }
//   //
//   //   // item.putIfAbsent(c + 1, () => step);
//   //   result.add(item);
//   //
//   //   assert(result.length == pAmount);
//   //   return result;
//   // }
//
//   Map<int, Iterable<T>> step(Combiner<T> combiner) =>
//       source.fold(<int, Iterable<T>>{}, (steps, data) {
//         final index = combiner(data);
//         assert(
//           index <= source.length && index > 0,
//           'invalid combination index: $index not in range 0...${source.length}',
//         );
//
//         while (steps.length < index) {
//           steps.putIfAbsent(steps.length + 1, () => []);
//         }
//         return steps..update(index, (value) => [...value, data]);
//       });
// }
//
// ///
// /// typedef
// ///
//
// typedef Combiner<T> = int Function(T value);
// typedef Combine<T> = Map<int, Iterable<T>> Function(Combiner<T> combine);
//
// // planes composer command combinations
// extension PccCombinations on Combination<PlanesComposerCommand> {
//   ///
//   /// r: rotate, t: translate
//   ///
//   /// time diversity:
//   /// 1.
//   ///   - rA-rB-tA-tB
//   ///   - 1 #
//   /// 2.
//   ///   - rA-rB-tA, tB (2!)
//   ///   - rA-rB, tA-tB (2!)
//   ///   - (C4_3 + C4_2) * 2! = 10 * 2 = 20 #
//   /// 3.
//   ///   - rArB, tA, tB (3!)
//   ///   - rAtA, rAtB, rBtA, rBtB, tAtB ...
//   ///   - C4_2 * 3! = 6 * 6 = 36 #
//   /// 4.
//   ///   - 4! = 24 #
//   ///
//   static const Combination<PlanesComposerCommand> i = Combination(
//     source: PlanesComposerCommandExtension.valuesSet,
//   );
//
//   /// time diversity 1
//   static const PlanesComposerCombiner in1 = _in1;
//
//   static int _in1(PlanesComposerCommand command) => 1;
//
//   ///
//   /// time diversity 2
//   ///
//   static const PlanesComposerCombiner in2_1RA_2Other = _in2_1RA_2Other;
//   static const PlanesComposerCombiner in2_1RB_2Other = _in2_1RB_2Other;
//   static const PlanesComposerCombiner in2_1TA_2Other = _in2_1TA_2Other;
//   static const PlanesComposerCombiner in2_1TB_2Other = _in2_1TB_2Other;
//   static const PlanesComposerCombiner in2_1Other_2RA = _in2_1Other_2RA;
//   static const PlanesComposerCombiner in2_1Other_2RB = _in2_1Other_2RB;
//   static const PlanesComposerCombiner in2_1Other_2TA = _in2_1Other_2TA;
//   static const PlanesComposerCombiner in2_1Other_2TB = _in2_1Other_2TB;
//   static const PlanesComposerCombiner in2_1A_2B = _in2_1A_2B;
//   static const PlanesComposerCombiner in2_1B_2A = _in2_1B_2A;
//   static const PlanesComposerCombiner in2_1R_2T = _in2_1R_2T;
//   static const PlanesComposerCombiner in2_1T_2R = _in2_1T_2R;
//   static const PlanesComposerCombiner in2_1RaTb_2RbTa = _in2_1RaTb_2RbTa;
//   static const PlanesComposerCombiner in2_1RbTa_2RaTa = _in2_1RbTa_2RaTa;
//
//   static int _in2_1RA_2Other(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1RB_2Other(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1TA_2Other(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1TB_2Other(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1Other_2RA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1Other_2RB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1Other_2TA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1Other_2TB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1A_2B(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1B_2A(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1R_2T(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1T_2R(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1RaTb_2RbTa(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in2_1RbTa_2RaTa(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   ///
//   /// time diversity 3
//   ///
//   static const PlanesComposerCombiner in3_1R_2TA_3TB = _in3_1R_2TA_3TB;
//   static const PlanesComposerCombiner in3_1R_2TB_3TA = _in3_1R_2TB_3TA;
//   static const PlanesComposerCombiner in3_1T_2RA_3RB = _in3_1T_2RA_3RB;
//   static const PlanesComposerCombiner in3_1T_2RB_3RA = _in3_1T_2RB_3RA;
//   static const PlanesComposerCombiner in3_1A_2BR_3BT = _in3_1A_2BR_3BT;
//   static const PlanesComposerCombiner in3_1A_2BT_3BR = _in3_1A_2BT_3BR;
//   static const PlanesComposerCombiner in3_1B_2AT_3AR = _in3_1B_2AT_3AR;
//   static const PlanesComposerCombiner in3_1B_2AR_3AT = _in3_1B_2AR_3AT;
//   static const PlanesComposerCombiner in3_1TB_2R_3TA = _in3_1TB_2R_3TA;
//   static const PlanesComposerCombiner in3_1TA_2R_3TB = _in3_1TA_2R_3TB;
//   static const PlanesComposerCombiner in3_1RA_2T_3RB = _in3_1RA_2T_3RB;
//   static const PlanesComposerCombiner in3_1RB_2T_3RA = _in3_1RB_2T_3RA;
//   static const PlanesComposerCombiner in3_1BR_2A_3BT = _in3_1BR_2A_3BT;
//   static const PlanesComposerCombiner in3_1BT_2A_3BR = _in3_1BT_2A_3BR;
//   static const PlanesComposerCombiner in3_1AT_2B_3AR = _in3_1AT_2B_3AR;
//   static const PlanesComposerCombiner in3_1AR_2B_3AT = _in3_1AR_2B_3AT;
//   static const PlanesComposerCombiner in3_1TA_2TB_3R = _in3_1TA_2TB_3R;
//   static const PlanesComposerCombiner in3_1TB_2TA_3R = _in3_1TB_2TA_3R;
//   static const PlanesComposerCombiner in3_1RA_2RB_3T = _in3_1RA_2RB_3T;
//   static const PlanesComposerCombiner in3_1RB_2RA_3T = _in3_1RB_2RA_3T;
//   static const PlanesComposerCombiner in3_1BR_2BT_3A = _in3_1BR_2BT_3A;
//   static const PlanesComposerCombiner in3_1BT_2BR_3A = _in3_1BT_2BR_3A;
//   static const PlanesComposerCombiner in3_1AT_2AR_3B = _in3_1AT_2AR_3B;
//   static const PlanesComposerCombiner in3_1AR_2AT_3B = _in3_1AR_2AT_3B;
//   static const PlanesComposerCombiner in3_1RaTb_2RB_3TA = _in3_1RaTb_2RB_3TA;
//   static const PlanesComposerCombiner in3_1RaTb_2TA_3RB = _in3_1RaTb_2TA_3RB;
//   static const PlanesComposerCombiner in3_1RbTa_2RA_3TB = _in3_1RbTa_2RA_3TB;
//   static const PlanesComposerCombiner in3_1RbTa_2TB_3RA = _in3_1RbTa_2TB_3RA;
//   static const PlanesComposerCombiner in3_1RA_2RbTa_3TB = _in3_1RA_2RbTa_3TB;
//   static const PlanesComposerCombiner in3_1TB_2RbTa_3RA = _in3_1TB_2RbTa_3RA;
//   static const PlanesComposerCombiner in3_1RB_2RaTb_3TA = _in3_1RB_2RaTb_3TA;
//   static const PlanesComposerCombiner in3_1TA_2RaTb_3RB = _in3_1TA_2RaTb_3RB;
//   static const PlanesComposerCombiner in3_1RA_2TB_3RbTa = _in3_1RA_2TB_3RbTa;
//   static const PlanesComposerCombiner in3_1TB_2RA_3RbTa = _in3_1TB_2RA_3RbTa;
//   static const PlanesComposerCombiner in3_1RB_2TA_3RaTb = _in3_1RB_2TA_3RaTb;
//   static const PlanesComposerCombiner in3_1TA_2RB_3RaTb = _in3_1TA_2RB_3RaTb;
//
//   static int _in3_1R_2TA_3TB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1TA_2R_3TB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1TB_2TA_3R(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1R_2TB_3TA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1TB_2R_3TA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1TA_2TB_3R(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1T_2RA_3RB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RA_2T_3RB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RB_2RA_3T(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1T_2RB_3RA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RB_2T_3RA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RA_2RB_3T(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1A_2BR_3BT(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1BR_2A_3BT(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1BT_2BR_3A(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1A_2BT_3BR(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1BT_2A_3BR(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1BR_2BT_3A(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1B_2AT_3AR(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1AT_2B_3AR(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1AR_2AT_3B(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1B_2AR_3AT(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1AR_2B_3AT(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1AT_2AR_3B(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RaTb_2RB_3TA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RaTb_2TA_3RB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RbTa_2RA_3TB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RbTa_2TB_3RA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RA_2RbTa_3TB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1TB_2RbTa_3RA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RB_2RaTb_3TA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1TA_2RaTb_3RB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RA_2TB_3RbTa(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1TB_2RA_3RbTa(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 1 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 0) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1RB_2TA_3RaTb(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in3_1TA_2RB_3RaTb(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//             command.childIndex == 0 ||
//         command.transformCategory == TransformCategory.translate &&
//             command.childIndex == 1) {
//       return 3;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   ///
//   /// time diversity 4
//   ///
//   static const PlanesComposerCombiner in4_12RAB_34TAB = _in4_12RAB_34TAB;
//   static const PlanesComposerCombiner in4_12RAB_34TBA = _in4_12RAB_34TBA;
//   static const PlanesComposerCombiner in4_12RBA_34TAB = _in4_12RBA_34TAB;
//   static const PlanesComposerCombiner in4_12RBA_34TBA = _in4_12RBA_34TBA;
//   static const PlanesComposerCombiner in4_12TAB_34RAB = _in4_12TAB_34RAB;
//   static const PlanesComposerCombiner in4_12TAB_34RBA = _in4_12TAB_34RBA;
//   static const PlanesComposerCombiner in4_12TBA_34RAB = _in4_12TBA_34RAB;
//   static const PlanesComposerCombiner in4_12TBA_34RBA = _in4_12TBA_34RBA;
//   static const PlanesComposerCombiner in4_12ART_34BRT = _in4_12ART_34BRT;
//   static const PlanesComposerCombiner in4_12ART_34BTR = _in4_12ART_34BTR;
//   static const PlanesComposerCombiner in4_12ATR_34BRT = _in4_12ATR_34BRT;
//   static const PlanesComposerCombiner in4_12ATR_34BTR = _in4_12ATR_34BTR;
//   static const PlanesComposerCombiner in4_12BRT_34ART = _in4_12BRT_34ART;
//   static const PlanesComposerCombiner in4_12BRT_34ATR = _in4_12BRT_34ATR;
//   static const PlanesComposerCombiner in4_12BTR_34ART = _in4_12BTR_34ART;
//   static const PlanesComposerCombiner in4_12BTR_34ATR = _in4_12BTR_34ATR;
//   static const PlanesComposerCombiner in4_1RA_2TB_3RB_4TA =
//       _in4_1RA_2TB_3RB_4TA;
//   static const PlanesComposerCombiner in4_1RA_2TB_3TA_4RB =
//       _in4_1RA_2TB_3TA_4RB;
//   static const PlanesComposerCombiner in4_1TB_2RA_3RB_4TA =
//       _in4_1TB_2RA_3RB_4TA;
//   static const PlanesComposerCombiner in4_1TB_2RA_3TA_4RB =
//       _in4_1TB_2RA_3TA_4RB;
//   static const PlanesComposerCombiner in4_1RB_2TA_3RA_4TB =
//       _in4_1RB_2TA_3RA_4TB;
//   static const PlanesComposerCombiner in4_1RB_2TA_3TB_4RA =
//       _in4_1RB_2TA_3TB_4RA;
//   static const PlanesComposerCombiner in4_1TA_2RB_3RA_4TB =
//       _in4_1TA_2RB_3RA_4TB;
//   static const PlanesComposerCombiner in4_1TA_2RB_3TB_4RA =
//       _in4_1TA_2RB_3TB_4RA;
//
//   static int _in4_12RAB_34TAB(PlanesComposerCommand command) =>
//       command.transformCategory.index + 1;
//
//   static int _in4_12RAB_34TBA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12RBA_34TAB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12RBA_34TBA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12TAB_34RAB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12TAB_34RBA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12TBA_34RAB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12TBA_34RBA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12ART_34BRT(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12ART_34BTR(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12ATR_34BRT(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12ATR_34BTR(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12BRT_34ART(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12BRT_34ATR(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12BTR_34ART(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_12BTR_34ATR(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_1RA_2TB_3RB_4TA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_1RA_2TB_3TA_4RB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_1TB_2RA_3RB_4TA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_1TB_2RA_3TA_4RB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_1RB_2TA_3RA_4TB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_1RB_2TA_3TB_4RA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_1TA_2RB_3RA_4TB(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
//
//   static int _in4_1TA_2RB_3TB_4RA(PlanesComposerCommand command) {
//     if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 0) {
//       return 1;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 1) {
//       return 2;
//     } else if (command.transformCategory == TransformCategory.translate &&
//         command.childIndex == 1) {
//       return 3;
//     } else if (command.transformCategory == TransformCategory.rotate &&
//         command.childIndex == 0) {
//       return 4;
//     } else {
//       throw UnimplementedError();
//     }
//   }
// }
