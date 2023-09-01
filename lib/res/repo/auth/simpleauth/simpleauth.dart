part of res;

///
/// [_RepoAuthSimpleauth]
///
/// [_ImplSimpleauth]
/// [_ImplSimpleauthLogin]
///

class _RepoAuthSimpleauth extends _ImplSimpleauth with _ImplSimpleauthLogin {
  const _RepoAuthSimpleauth._();

  factory _RepoAuthSimpleauth() => _instance;
  static const _RepoAuthSimpleauth _instance = _RepoAuthSimpleauth._();
}

abstract class _ImplSimpleauth extends HubAuth with HubAuthSimpleauth {
  const _ImplSimpleauth();
}

// to implement, see https://pub.dev/packages/simple_auth
mixin _ImplSimpleauthLogin on _ImplSimpleauth {
  @override
  Stream<AuthUserState> get authUserState => throw UnimplementedError();

  @override
  Future<AuthUser> register({required AuthRegisterCredential credential}) {
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> login({required AuthLoginCredential credential}) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateAuthUser(
      {required Future<AuthLoginCredential> Function(AuthLoginCredentialSetup credentialSetup)
          getReAuthCredential,
      required String? email,
      required String? password,
      required String? photoURL,
      required String? displayName,
      required String? phoneNumber,
      required PhoneVerification? phoneVerification}) {
    throw UnimplementedError();
  }
}
