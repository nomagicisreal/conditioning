part of structure;

//
// /// for iterable [DataModel]
// extension DataSetUtil<M> on Iterable<M> {
//   Iterable<M> filterMatches({
//     required FieldsSet fieldsSet,
//   }) {
//     final matches = <M>[];
//
//     findModel:
//     for (var model in this) {
//       final json = model.json;
//
//       for (var entry in fieldsSet.entries) {
//         if (json[entry.key] != entry.value) {
//           continue findModel;
//         }
//       }
//       matches.add(model);
//     }
//     return matches;
//   }
// }
//
// /// for [Json]
// extension _FieldSetUtil on Json {
//   FieldsSet _toFieldsSet({
//     required Map<String, bool> requiredEquals,
//   }) =>
//       map((key, value) {
//         if (requiredEquals[key]!) {
//           return MapEntry(key, EqualOrNot(value, null));
//         } else {
//           return MapEntry(key, EqualOrNot(null, value));
//         }
//       });
//
//   FieldsSet _filterAndToFieldsSet({
//     required Set<String> selectedNames,
//     bool keepSelected = true,
//     bool selectedShouldEqual = true,
//   }) {
//     final fields = keepSelected
//         ? keys.fold<Map<String, dynamic>>(
//             {},
//             (map, name) => map..putIfAbsent(name, () => this[name]),
//           )
//         : keys.fold<Map<String, dynamic>>(
//             this,
//             (map, name) => map..remove(name),
//           );
//
//     return selectedShouldEqual
//         ? fields.map((name, value) => MapEntry(name, EqualOrNot(value, null)))
//         : fields.map((name, value) => MapEntry(name, EqualOrNot(null, value)));
//   }
// }
