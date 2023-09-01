part of res;

///
/// [HubAuthOption]
///
/// [HubAuth]
/// [HubAuthFireauth]
/// [HubAuthSimpleauth]
///
///

enum HubAuthOption {
  fireauth,
  simpleauth;
}

/// general authentication methods
abstract class HubAuth extends Hub<HubAuthOption> {
  const HubAuth();

  Future<AuthUser> register({required AuthRegisterCredential credential});

  Future<AuthUser> login({required AuthLoginCredential credential});

  Future<void> logout();

  Future<void> sendEmailVerification();

  Future<void> resetPassword(String email);

  Stream<AuthUserState> get authUserState;

  Future<void> updateAuthUser({
    required Future<AuthLoginCredential> Function(AuthLoginCredentialSetup credentialSetup)
        getReAuthCredential,
    required String? email,
    required String? password,
    required String? photoURL,
    required String? displayName,
    required String? phoneNumber,
    required PhoneVerification? phoneVerification,
  });

}

/// specific authentication methods, properties
mixin HubAuthFireauth on HubAuth {
  @override
  HubAuthOption get hubOption => HubAuthOption.fireauth;


  Future<Map<String, AuthProvider>> fetchLoginMethods(String email);

// await i.sendSignInLinkToEmail(email: email!, actionCodeSettings: actionCodeSettings)
}

mixin HubAuthSimpleauth on HubAuth {
  @override
  HubAuthOption get hubOption => HubAuthOption.simpleauth;
}