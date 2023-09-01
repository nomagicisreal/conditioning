part of res;

///
/// [_FireauthLogin]
/// [_FireauthLoginCredential]
/// [_FireAuthLoginProvider]
/// [_FireauthLoginExceptionHandler]
/// [_FireauthToAuthUser]
///

/// - try login anonymously
/// - try login with credential by [_FireauthLoginCredential]
/// - try login with provider by [_FireauthLoginProvider]
extension _FireauthLogin on AuthLoginCredential {
  ///
  /// the login flow except from 'login anonymously':
  /// 1. [AuthLoginCredential]
  /// 2. [fireauth.AuthCredential] || [fireauth.OAuthProvider]
  /// 3. [fireauth.UserCredential]
  /// 4. [AuthUser]
  ///
  Future<AuthUser> get _user async {
    late final fireauth.UserCredential fuc;
    fireauth.AuthCredential? fac;
    try {
      switch (loginMethod) {

        /// login anonymously
        case AuthLoginMethod.anonymously:
          fuc = await fireauth.FirebaseAuth.instance.signInAnonymously();
          break;

        /// login with credential
        case AuthLoginMethod.credential:
          fac = await _toFireauthCredential;
          fuc = await fac._toUserCredential(
            authProvider: authProvider!,
            category: setup.loginCategory,
            emailVerification: emailVerification,
            formattedPhoneNumber: formattedPhoneNumber,
            phoneVerification: phoneVerification,
          );
          break;

        /// login with provider
        default:
          fuc = await authProvider!._toOAuthProvider._toUserCredential(
            category: setup.loginCategory,
            loginMethod: loginMethod,
            scopes: scopes,
            parameters: parameters,
          );
          break;
      }
    } on fireauth.FirebaseAuthException catch (exception) {
      fuc = await exception._solveAndGetFuc(
        credential: this,
        handler: setup.exceptionHandler,
      );
    }
    return fuc._toAuthUser(
      signedCredential: this,
      signedServiceCredential: setup.saveSignedServiceCredential ? fac : null,
    );
  }
}

/// parse [AuthLoginCredential], used in [_FireauthLogin._user]
extension _FireauthLoginCredential on AuthLoginCredential {
  Future<fireauth.AuthCredential> get _toFireauthCredential async {
    switch (authProvider!) {

      /// email
      case AuthProvider.email:
        if (email != null) {
          if (password != null) {
            return fireauth.EmailAuthProvider.credential(
              email: email!,
              password: password!,
            );
          } else if (emailLink != null) {
            return fireauth.EmailAuthProvider.credentialWithLink(
              email: email!,
              emailLink: emailLink!,
            );
          }
        }
        throw HubAuthLoginError();

      /// phone
      case AuthProvider.phone:
        late final fireauth.AuthCredential fac;
        late final String smsCode;
        String? verificationId;
        int? token;

        await fireauth.FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: formattedPhoneNumber,
          codeAutoRetrievalTimeout: (id) {},
          verificationCompleted: (credential) => fac = credential,
          verificationFailed: (e) => throw e,
          codeSent: (vId, resentToken) {
            verificationId = vId;
            token = resentToken;
          },
        );
        smsCode = await phoneVerification!();

        if (token != null) {
          fac = fireauth.PhoneAuthProvider.credentialFromToken(
            token!,
            smsCode: smsCode,
          );
        } else if (verificationId != null) {
          fac = fireauth.PhoneAuthProvider.credential(
            verificationId: verificationId!,
            smsCode: smsCode,
          );
        } else {
          throw HubAuthLoginError();
        }

        return fac;

      /// apple
      case AuthProvider.apple:
        return _IdpApple().getCredential(
          fireauth.AppleAuthProvider.credential,
        );

      /// facebook
      case AuthProvider.facebook:
        return _IdpFacebook().getCredential(
          fireauth.FacebookAuthProvider.credential,
        );

      /// github
      case AuthProvider.github:
        return _IdpGithub().getCredential(
          fireauth.GithubAuthProvider.credential,
        );

      /// google
      case AuthProvider.google:
        return _IdpGoogle().getCredential(
          fireauth.GoogleAuthProvider.credential,
          signInGooglePlay: false,
        );

      /// microsoft
      case AuthProvider.microsoft:
        return _IdpMicrosoft().getCredential(
          fireauth.MicrosoftAuthProvider.credential,
        );

      /// twitter
      case AuthProvider.twitter:
        return _IdpTwitter().getCredential(
          fireauth.TwitterAuthProvider.credential,
        );

      /// yahoo
      case AuthProvider.yahoo:
        return _IdpYahoo().getCredential(
          fireauth.YahooAuthProvider.credential,
        );

      /// others
      // TODO: Create Custom Tokens ---see https://firebase.google.com/docs/auth/admin/create-custom-tokens
      case AuthProvider.otherProvider:
        throw UnimplementedError();
    }
  }
}

/// parse [AuthProvider], used in [_FireAuthLogin]
extension _FireAuthLoginProvider on AuthProvider {
  fireauth.OAuthProvider get _toOAuthProvider =>
      fireauth.OAuthProvider(_fireAuthProviderId);

  String get _fireAuthProviderId {
    switch (this) {

      /// apple
      case AuthProvider.apple:
        return fireauth.AppleAuthProvider.PROVIDER_ID;

      /// facebook
      case AuthProvider.facebook:
        return fireauth.FacebookAuthProvider.PROVIDER_ID;

      /// github
      case AuthProvider.github:
        return fireauth.GithubAuthProvider.PROVIDER_ID;

      /// google
      case AuthProvider.google:
        return fireauth.GoogleAuthProvider.PROVIDER_ID;

      /// microsoft
      case AuthProvider.microsoft:
        return fireauth.MicrosoftAuthProvider.PROVIDER_ID;

      /// twitter
      case AuthProvider.twitter:
        return fireauth.TwitterAuthProvider.PROVIDER_ID;

      /// yahoo
      case AuthProvider.yahoo:
        return fireauth.YahooAuthProvider.PROVIDER_ID;

      /// others
      case AuthProvider.otherProvider:
        throw UnimplementedError();

      /// email
      case AuthProvider.email:
        return fireauth.EmailAuthProvider.PROVIDER_ID;

      /// apple
      case AuthProvider.phone:
        return fireauth.PhoneAuthProvider.PROVIDER_ID;
    }
  }
}

extension _FireauthLoginExceptionHandler on fireauth.FirebaseAuthException {
  Future<fireauth.UserCredential> _solveAndGetFuc({
    required AuthLoginCredential credential,
    required AuthLoginExceptionHandler handler,
  }) async {
    final i = fireauth.FirebaseAuth.instance;

    switch (code) {
      case 'user-not-found':
        final needCreate = await handler.askToCreateUser!(credential.email!);
        if (needCreate) {
          return i.createUserWithEmailAndPassword(
            email: credential.email!,
            password: credential.password!,
          );
        }
        throw LoginFailException();

      default:
        throw this;
    }
  }
}

/// parse firebase user credential, used in [_FireauthLogin]
extension _FireauthToAuthUser on fireauth.UserCredential {
  AuthUser _toAuthUser({
    required AuthLoginCredential signedCredential,
    required fireauth.AuthCredential? signedServiceCredential,
  }) => AuthUser._(
    signedCredential: signedCredential,
    signedServiceCredential: signedServiceCredential,
    signInMethod: credential?.signInMethod,
    token: credential?.token,
    accessToken: credential?.accessToken,
    isNewUser: additionalUserInfo?.isNewUser,
    profile: additionalUserInfo?.profile,
    username: additionalUserInfo?.username,
    displayName: user?.displayName,
    email: user?.email,
    emailVerified: user?.emailVerified,
    creationTime: user?.metadata.creationTime,
    latSignInTime: user?.metadata.lastSignInTime,
    phoneNumber: user?.phoneNumber,
    photoURL: user?.photoURL,
    providerData: user?.providerData.map(AuthProviderData.fromFireauth),
    refreshToken: user?.refreshToken,
    tenantId: user?.tenantId,
    uid: user?.uid,
  );
}