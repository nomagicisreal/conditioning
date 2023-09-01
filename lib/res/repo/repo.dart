part of res;

///
///
/// [_RepositoryAuth]
/// [_RepositoryStore]
///
/// repositories create instance of the 3rd-party implementation for hub to use
///
///

extension _RepositoryAuth on HubAuthOption {
  A getAuth<A extends HubAuth>() {
    switch (this) {
      case HubAuthOption.fireauth:
        return _RepoAuthFireauth() as A;
      case HubAuthOption.simpleauth:
        return _RepoAuthSimpleauth() as A;
    }
  }
}

extension _RepositoryStore on HubStoreOption {
  S getStore<S extends HubStore>() {
    switch (this) {
      case HubStoreOption.firestore:
        return _RepoStoreFirestore() as S;
      case HubStoreOption.hive:
        return _RepoStoreHive() as S;
    }
  }
}