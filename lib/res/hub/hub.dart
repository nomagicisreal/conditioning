part of res;

///
///
/// With [Hub] and repositories, when widget & app layer execute functions,
/// developer can only know the function itself without what 3rd-party belongs to.
///
///

abstract class Hub<E extends Enum> {
  const Hub();

  E get hubOption;

  static HubAuthFireauth get fireauth => HubAuthOption.fireauth.getAuth();

  static HubAuthSimpleauth get simpleauth => HubAuthOption.simpleauth.getAuth();

  static HubStoreFirestore get firestore => HubStoreOption.firestore.getStore();

  static HubStoreHive get hive => HubStoreOption.hive.getStore();
}
