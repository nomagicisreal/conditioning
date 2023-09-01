part of structure;


typedef Json = Map<String, dynamic>;
typedef FieldsSet = Map<String, EqualOrNot<dynamic>>;
/// [FieldsSet] example,
///
/// final p1 = Person(name: 'Abby', phone: '0000');
/// final p2 = Person(name: 'Abby', phone: '999');
/// final p3 = Person(name: 'Abby', phone: '0000');
/// final match1 = service.get(
///   query: QueryWhere( see []
///     fieldsMatch: {
///       'name': MapEntry('Abby', null),
///     }, // equal 'Abby'
///   ),
/// );
/// print(match1); // p1, p2, p3
///
/// final match2 = service.get(
///   query: QueryWhere( see [QueryWhere]
///     fieldsMatch: {
///       'name': MapEntry('Abby', null),
///       'phone': MapEntry(null, '999')
///     }, // equal 'Abby', but not equal '999'
///   ),
/// );
/// print(match2); // p1, p2
class EqualOrNot<A> {
  final A? equalValue;
  final A? notEqualValue;
  const EqualOrNot._(this.equalValue, this.notEqualValue);
  const factory EqualOrNot(A? equalValue, A? notEqualValue) = EqualOrNot<A>._;
}

extension DataStore<D> on Data<D> {
  ///
  /// [storeId] is depend on the service app provide, not the [Data] instance or [Data] type
  ///
  HubStoreId get storeId {
    throw UnimplementedError();
  }
}

// mixin MixData<D> on Data<D>
//     implements
//         MixDataInsert<D>,
//         MixDataGet<D>,
//         MixDataUpdate<D>,
//         MixDataDelete<D> {
//
//   /// queue
//   Future<void> queueTransaction({
//     required List<BaseTransaction> transactions,
//   }) async {
//     for (var t in transactions) {
//       await t();
//     }
//   }
//
//   /// schedule
//   Future<void> scheduleTransaction({
//     required Map<DateTime, BaseTransaction> transactions,
//   }) async {
//     throw UnimplementedError();
//   }
// }
//
// typedef BaseTransaction = Future<void> Function();

/// CRUD

// mixin MixDataInsert<D> on Data<D> implements MixDataGet<D> {
//   // Map<HubStore, String> get _storeId => storeId.map<HubStore, String>((key, value) => )
//   //
//   // Future<void> insert() {
//   //   final list = storeId.entries.map((e) => MapE)
//   //   for (Map<> element in storeId.entries) {
//   //     element.key
//   //   }_storeService.insert(_model);
//   // }
//
//   Future<void> insertBeforeCheck({
//     QueryWhere<D>? queryWhere,
//     required Future<bool> Function(Result<D> queriedModels) askIfInsert,
//   }) async {
//     assert(queryWhere != null);
//     if (await askIfInsert(await get(queryWhere: queryWhere))) {
//       insert();
//     }
//   }
// }
// mixin MixDataGet<D> on Data<D> {
//   Future<Result<D>> get({
//     QueryWhere<D>? queryWhere,
//   }) async {
//     assert(queryWhere != null);
//     return _storeService.get(where: queryWhere!);
//   }
// }
//
// mixin MixDataUpdate<D> on Data<D> implements
//     MixDataGet<D> {
//   Future<void> update() => _storeService.update(_model);
//
//   Future<void> updateBeforeACheck({
//     QueryWhere<D>? queryWhere,
//     required Future<bool> Function(Result<D> queriedModels) askIfUpdate,
//   }) async {
//     assert(queryWhere != null);
//     if (await askIfUpdate(await get(queryWhere: queryWhere))) {
//       update();
//     }
//   }
// }
//
// mixin MixDataDelete<D> on Data<D>
// implements MixDataGet<D> {
//   Future<void> delete() => _storeService.delete(_model);
//
//   Future<void> deleteBeforeCheck({
//     QueryWhere<D>? queryWhere,
//     required Future<bool> Function(Result<D> queriedModels) askIfDelete,
//   }) async {
//     assert(queryWhere != null);
//     if (await askIfDelete(await get(queryWhere: queryWhere))) {
//       delete();
//     }
//   }
// }
