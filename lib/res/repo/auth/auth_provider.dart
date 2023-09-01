part of res;

///
///
/// [AuthProvider]
/// [AuthProviderData]
///
/// [_IdpApple]
/// [_IdpFacebook]
/// [_IdpGithub]
/// [_IdpGoogle]
/// [_IdpMicrosoft]
/// [_IdpTwitter]
/// [_IdpYahoo]
///
///

/// TODO: enable all kinds of identity provider
/// credential
/// [apple] - ok with [SignInWithApple], but the implementation is much more complex than others.
/// [facebook] - ok with [FacebookAuth], but in my iphone 12, there are some development target conflicts. i tried to handle but failed, so i wouldn't implement for a while
/// [github] - !!! [Github] is an extremely huge package that i should be familiar github flow at first: 1. understand more github work flow, 2. visualize some github tool or kit, design them as element of ui, 3. integrate element in documention.
/// [google] - ok with [GoogleSignIn]
/// [microsoft]
/// [twitter]
/// [yahoo]
/// [otherProvider] - generate, provide, get customToken
///
/// provider
/// [apple] - ok
/// [facebook] - ? i don't know what actually is 'Lost connection to device', but fine. i don't wanna implement at all !!
/// [github] - ok
/// [google] - ok
/// [microsoft]
/// [twitter]
/// [yahoo]
/// [otherProvider]
///
/// web provider popup:
/// [apple] Error: [firebase_auth/operation-not-allowed] The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
/// [facebook] (Sorry, something went wrong.)
/// [github] - ok
/// [google] - ok
/// [microsoft] Error: [firebase_auth/operation-not-allowed] The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
/// [twitter] Error: [firebase_auth/invalid-credential] The supplied auth credential is malformed or has expired.
/// [yahoo] (Looks like something went wrong.)
/// [otherProvider]
///
/// web provider redirect.
/// [apple] - generate Service ID to enable domain
/// [facebook] (無法載入網址)
/// [github] - ok
/// [google] - ok
/// [microsoft] (no login ui occur)
/// [twitter] (no login ui occur)
/// [yahoo] (Looks like something went wrong.)
/// [otherProvider]
///

enum AuthProvider {
  email,
  phone,

  //
  apple,
  facebook,
  github,
  google,
  microsoft,
  twitter,
  yahoo,
  otherProvider,
}

class AuthProviderData {
  final AuthProvider provider;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final String? uid;

  const AuthProviderData._({
    required this.provider,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.uid,
  });

  factory AuthProviderData.fromFireauth(fireauth.UserInfo info) =>
      AuthProviderData._(
        provider: info.providerId._parseAuthProviderId,
        displayName: info.displayName,
        email: info.email,
        phoneNumber: info.phoneNumber,
        photoUrl: info.photoURL,
        uid: info.uid,
      );

  @override
  String toString() => 'AuthProviderData('
      'provider: $provider, '
      'displayName: $displayName, '
      'email: $email, '
      'phoneNumber: $phoneNumber, '
      'photoUrl: $photoUrl, '
      'uid: $uid)';
}

///
/// identity providers
///

// to implement more, see https://pub.dev/packages/sign_in_with_apple
class _IdpApple {
  const _IdpApple._();

  factory _IdpApple() => const _IdpApple._();

  Future<AuthorizationCredentialAppleID> get _credential =>
      SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.fullName,
        AppleIDAuthorizationScopes.email,
      ]);

  Future<C> getCredential<C>(
      C Function(String accessToken) credentialGetter,
      ) async {

    final credential = (await _credential);


    /// see https://developer.apple.com/documentation/sign_in_with_apple/sign_in_with_apple_rest_api/verifying_a_user#:~:text=with%20Apple.-,Verify%20the%20identity%20token,-Start%20by%20securely
    /// verify the identityToken
    final token = credential.identityToken;

    log(credential.toString());

    if (token == null) {
      throw LoginIdpNotSignedException();
    } else {
      return credentialGetter(token);
    }
  }
}

class _IdpFacebook {
  const _IdpFacebook._();

  factory _IdpFacebook() => const _IdpFacebook._();

  // Future<LoginResult> get _account => FacebookAuth.i.login();

  Future<C> getCredential<C>(
      C Function(String accessToken) credentialGetter,
      ) async {
    // final accessToken = (await _account).accessToken;
    // if (accessToken == null) {
    throw LoginIdpNotSignedException();
    // } else {

    // return credentialGetter(accessToken.token);
    // }
  }
}

class _IdpGithub {
  const _IdpGithub._();

  factory _IdpGithub() => const _IdpGithub._();

  Future<C> getCredential<C>(
      C Function(String accessToken) credentialGetter,
      ) async {

    // final github = GitHub(auth: Authentication.withToken('token'));
    throw UnimplementedError();
  }
}

class _IdpGoogle {
  const _IdpGoogle._();

  factory _IdpGoogle() => const _IdpGoogle._();

  Future<GoogleSignInAccount?> get _account {
    if (Platform.isIOS) {
      return GoogleSignIn(
        clientId: DefaultFirebaseOptions.currentPlatform.iosClientId,
      ).signIn();
    } else {
      return GoogleSignIn().signIn();
    }
  }

  Future<GoogleSignInAccount?> get _googlePlayAccount => GoogleSignIn(
    signInOption: SignInOption.games,
  ).signIn();

  Future<C> getCredential<C>(
      C Function({String? accessToken, String? idToken}) credentialGetter, {
        bool signInGooglePlay = false,
      }) async {
    final user = await (signInGooglePlay ? _googlePlayAccount : _account);
    if (user == null) {
      throw LoginIdpNotSignedException();
    } else {
      final auth = await user.authentication;
      return credentialGetter(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
    }
  }
}

class _IdpMicrosoft {
  const _IdpMicrosoft._();

  factory _IdpMicrosoft() => const _IdpMicrosoft._();

  // Future<LoginResult> get _account => throw UnimplementedError();

  Future<C> getCredential<C>(
      C Function(String accessToken) credentialGetter,
      ) async {
    // final accessToken = (await _account).accessToken;
    // if (accessToken == null) {
    throw LoginIdpNotSignedException();
    // } else {
    //   return credentialGetter(accessToken.token);
    // }
  }
}

class _IdpTwitter {
  const _IdpTwitter._();

  factory _IdpTwitter() => const _IdpTwitter._();

  // Future<LoginResult> get _account => throw UnimplementedError();

  Future<C> getCredential<C>(
      C Function({
      required String accessToken,
      required String secret,
      })
      credentialGetter,
      ) async {
    throw UnimplementedError();
  }
}

class _IdpYahoo {
  const _IdpYahoo._();

  factory _IdpYahoo() => const _IdpYahoo._();

  // Future<LoginResult> get _account => throw UnimplementedError();

  Future<C> getCredential<C>(
      C Function(String accessToken) credentialGetter,
      ) async {
    throw UnimplementedError();
  }
}