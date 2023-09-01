part of res;

/// ancestor of all hive implementation
abstract class _$ImplHive extends HubStore with HubStoreHive {
  const _$ImplHive();

  Future<hive.Box<D>> openBox<D extends Data>() =>
      hive.Hive.openBox(D.toStringUnderScore);

  Future<void> closeBox<D>(hive.Box<D> box) => box.close();
}

class _RepoStoreHive extends _$ImplHive
    with _ImplHiveBase, _ImplHiveData, _ImplHiveStream {
  const _RepoStoreHive._();

  factory _RepoStoreHive() => _instance;
  static const _RepoStoreHive _instance = _RepoStoreHive._();
}

mixin _ImplHiveData on _$ImplHive {
  /// hive use the uuid i generate
  @override
  Future<void> insert<D extends Data>(D data) async {
    final uuid = (const Uuid()).v4();
    data.storeId.putIfAbsent(HubStoreOption.hive, () => uuid);
    hive.Hive.box<D>(D.toStringUnderScore).put(uuid, data);
  }

  /// already check id in [HubStoreOption._checkdataHaveId]

  @override
  Future<void> update<D extends Data>(D data) async =>
      hive.Hive.box<D>(D.toStringUnderScore).put(
        data.storeId[HubStoreOption.hive]!,
        data,
      );

  @override
  Future<void> delete<D extends Data>(D data) async =>
      hive.Hive.box<D>(D.toStringUnderScore).delete(
        data.storeId[HubStoreOption.hive]!,
      );
}

mixin _ImplHiveBase on _$ImplHive {
  @override
  Future<Result<D>> get<D extends Data>({required QueryWhere<D> where}) async {
    late final Iterable<D?> result;
    final box = hive.Hive.box<D>(D.toStringUnderScore);

    if (where.id != null) {
      result = [box.get(where.id)];

      //
    } else if (where.getAll) {
      result = box.values;

      //
    } else if (where.fieldsSet != null) {
      result = box.values.where((element) => element.match(where.fieldsSet!));

      //
    } else if (where.validation != null) {
      result = box.values.where(where.validation!);

      //
    } else {
      throw QueryNoWhereError();
    }

    return Result.from(queryWhere: where, result: result);
  }
}

mixin _ImplHiveStream on _$ImplHive {
  @override
  Stream<Result<D>> watch<D extends Data>({required QueryWhere<D> where}) {
    late final Stream<Iterable<D?>> result;
    final box = hive.Hive.box<D>(D.toStringUnderScore);

    if (where.id != null) {
      result = box._watch(where.id!).map((event) => [event]);

      ///
    } else {
      final streams = box.keys.map<Stream<D?>>((key) => box._watch(key));

      result = streams.mix(
        mixMatch: where.fieldsSet,
        mixValid: where.validation,
        mixAll: where.getAll,
      );
    }

    return result.map(
      (event) => Result.from(queryWhere: where, result: event),
    );
  }
}
