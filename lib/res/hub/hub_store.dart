part of res;

///
/// [HubStoreOption]
///
/// [HubStore]
/// [HubStoreFirestore]
/// [HubStoreHive]
///
///

enum HubStoreOption {
  firestore,
  hive,
}

typedef HubStoreId = Map<HubStoreOption, String>;

/// general store methods
abstract class HubStore extends Hub<HubStoreOption> {
  const HubStore();

  Future<void> insert<D extends Data>(D data);

  /// TODO: check if id exist before call
  Future<void> update<D extends Data>(D data);
  Future<void> delete<D extends Data>(D data);
  
  
  Future<Result<D>> get<D extends Data>({required QueryWhere<D> where});
  Stream<Result<D>> watch<D extends Data>({required QueryWhere<D> where});
}

/// specific store methods, properties
mixin HubStoreFirestore on HubStore {
  @override
  HubStoreOption get hubOption => HubStoreOption.firestore;
}

mixin HubStoreHive on HubStore {
  @override
  HubStoreOption get hubOption => HubStoreOption.hive;
}