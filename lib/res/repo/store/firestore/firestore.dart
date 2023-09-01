part of res;

/// ancestor of all firestore implementation
abstract class _$ImplFirestore extends HubStore with HubStoreFirestore {
  const _$ImplFirestore();

  // TODO: nested collection
  firestore.CollectionReference<D> _collection<D extends Data>() =>
      firestore.FirebaseFirestore.instance
          .collection(D.toStringUnderScore)
          .withConverter<D>(
            fromFirestore: (snapshot, _) => snapshot.data()!.toData as D,
            toFirestore: (value, _) => value.toJson,
          );
}

class _RepoStoreFirestore extends _$ImplFirestore
    with _$ImplFirestoreData, _$ImplFirestoreBase, _$ImplFirestoreStream {
  const _RepoStoreFirestore._();

  factory _RepoStoreFirestore() => _instance;
  static const _RepoStoreFirestore _instance = _RepoStoreFirestore._();
}

mixin _$ImplFirestoreData on _$ImplFirestore {
  // TODO: ensure mutableWay is better than immutableWay
  @override
  Future<void> insert<D extends Data>(D data) async {
    final newDocId = (await _collection<D>().add(data)).id;
    data.storeId.putIfAbsent(HubStoreOption.firestore, () => newDocId);
  }

  @override
  Future<void> update<D extends Data>(D data) =>
      _collection<D>().doc(data.storeId[HubStoreOption.firestore]).set(data);

  @override
  Future<void> delete<D extends Data>(D data) =>
      _collection<D>().doc(data.storeId[HubStoreOption.firestore]).delete();
}

mixin _$ImplFirestoreBase on _$ImplFirestore {
  @override
  Future<Result<D>> get<D extends Data>({required QueryWhere<D> where}) async {
    late final Iterable<D?> result;
    final collection = _collection<D>();

    if (where.id != null) {
      result = [(await collection.doc(where.id).get()).data()];

      //
    } else if (where.getAll) {
      result = (await collection.get()).docs.map((e) => e.data());

      //
    } else if (where.fieldsSet != null) {
      result = (await collection._filter(where.fieldsSet!).get())._toModels;

      //
    } else if (where.validation != null) {
      throw HubStoreNoImplementationError();

      //
    } else {
      throw QueryNoWhereError();
    }

    return Result.from(queryWhere: where, result: result);
  }
}

mixin _$ImplFirestoreStream on _$ImplFirestore {
  @override
  Stream<Result<D>> watch<D extends Data>({required QueryWhere<D> where}) {
    late final Stream<Iterable<D?>> result;
    final collection = _collection<D>();

    if (where.id != null) {
      result = collection.doc(where.id)._dataStream;

      //
    } else if (where.getAll) {
      result = collection._iterabledataStream;

      //
    } else if (where.fieldsSet != null) {
      result = collection._filter(where.fieldsSet!)._iterabledataStream;

      //
    } else if (where.validation != null) {
      throw HubStoreNoImplementationError();

      //
    } else {
      throw QueryNoWhereError();
    }

    return result.map((e) => Result.from(queryWhere: where, result: e));
  }
}
