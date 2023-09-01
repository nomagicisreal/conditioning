part of res;

/// how much
// @immutable
// class _TransactionInputHowMuch {
//   final int fieldLimit;
//   final int dataLimit;
//   final int typeLimit;
//   final int serviceLimit;
//
//   /// limit = 0; means no limit
//   const _TransactionInputHowMuch({
//     this.fieldLimit = 0,
//     this.dataLimit = 0,
//     this.typeLimit = 1,
//     this.serviceLimit = 1,
//   });
// }

/// when
//
// @immutable
// class _TransactionInputWhen {
//   final DateTime? discardWhen;
//   final Repeat repeat;
//   final MapEntry<DateTime, DateTime>? repeatDuring;
//
//   const _TransactionInputWhen({
//     this.discardWhen,
//     this.repeat = Repeat.once,
//     this.repeatDuring,
//   });
// }

/// where
class QueryWhere<D extends Data> {
  final HubStoreOption storeOption;
  final ResultType expectResult;

  final String? id;
  final bool getAll;
  final FieldsSet? fieldsSet;
  final bool Function(D? data)? validation;

  const QueryWhere._({
    required this.storeOption,
    required this.expectResult,
    this.id,
    this.getAll = false,
    this.fieldsSet,
    this.validation,
  });

  factory QueryWhere({
    required HubStoreOption storeOption,
    required ResultType expectResult,
    required bool Function(D? data) where,
  }) =>
      QueryWhere._(
        storeOption: storeOption,
        expectResult: expectResult,
        validation: where,
      );

  factory QueryWhere.withFieldsSet({
    required HubStoreOption storeOption,
    required ResultType expectResult,
    required FieldsSet fieldsSet,
  }) =>
      QueryWhere._(
        storeOption: storeOption,
        expectResult: expectResult,
        fieldsSet: fieldsSet,
      );

  factory QueryWhere.withId({
    required HubStoreOption storeOption,
    required ResultType expectResult,
    required String id,
  }) =>
      QueryWhere._(
        storeOption: storeOption,
        expectResult: expectResult,
        id: id,
      );

  factory QueryWhere.all({
    required HubStoreOption storeOption,
    required ResultType expectResult,
  }) =>
      QueryWhere._(
        storeOption: storeOption,
        expectResult: expectResult,
        getAll: true,
      );
}

/// who
//
// @immutable
// class _TransactionInputWho {
//   final Object? currentAuth; // TODO
//
//   const _TransactionInputWho({
//     this.currentAuth,
//   });
// }


///
// enum ArgsOrResult {
//   searchingText,
//   fieldName,
//   fieldNameWithValue,
//
//   fields,
//   data,
//   datas,
//
//   dataAndField,
//   dataAndFields,
//   datasAndField,
//   datasAndFields,
//
//   fieldAndText,
//   fieldsAndText,
//   dataAndText,
//   datasAndText,
//
//   dataAndFieldAndText,
//   dataAndFieldsAndText,
//   datasAndFieldAndText,
//   datasAndFieldsAndText,
//
//   iterabledata,
//   mapFieldNameAndIterabledata,
// }
//