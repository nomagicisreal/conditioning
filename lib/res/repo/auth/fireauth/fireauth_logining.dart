part of res;

///
/// [_FireauthConstants]
/// [_FireauthUserCredentialFromFac]
/// [_FireauthUserCredentialFromFap]
///
/// [_FireauthEmailActionCodeSetting]
/// [_FireauthUserChangesUtil]
///
///

/// provider id, sign in method id
extension _FireauthConstants on String {
  static final Map<String, AuthProvider> _mapSignInMethodAndProvider = {
    fireauth.AppleAuthProvider.APPLE_SIGN_IN_METHOD: AuthProvider.apple,
    fireauth.FacebookAuthProvider.FACEBOOK_SIGN_IN_METHOD: AuthProvider.facebook,
    fireauth.GithubAuthProvider.GITHUB_SIGN_IN_METHOD: AuthProvider.github,
    fireauth.GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD: AuthProvider.google,
    fireauth.MicrosoftAuthProvider.MICROSOFT_SIGN_IN_METHOD: AuthProvider.microsoft,
    fireauth.TwitterAuthProvider.TWITTER_SIGN_IN_METHOD: AuthProvider.twitter,
    fireauth.YahooAuthProvider.YAHOO_SIGN_IN_METHOD: AuthProvider.yahoo,

    //
    fireauth.EmailAuthProvider.EMAIL_PASSWORD_SIGN_IN_METHOD: AuthProvider.email,
    fireauth.EmailAuthProvider.EMAIL_LINK_SIGN_IN_METHOD: AuthProvider.email,
    fireauth.PhoneAuthProvider.PHONE_SIGN_IN_METHOD: AuthProvider.phone,
  };

  static final Map<String, AuthProvider> _mapProviderIdAndProvider = {
    fireauth.AppleAuthProvider.PROVIDER_ID: AuthProvider.apple,
    fireauth.FacebookAuthProvider.PROVIDER_ID: AuthProvider.facebook,
    fireauth.GithubAuthProvider.PROVIDER_ID: AuthProvider.github,
    fireauth.GoogleAuthProvider.PROVIDER_ID: AuthProvider.google,
    fireauth.MicrosoftAuthProvider.PROVIDER_ID: AuthProvider.microsoft,
    fireauth.TwitterAuthProvider.PROVIDER_ID: AuthProvider.twitter,
    fireauth.YahooAuthProvider.PROVIDER_ID: AuthProvider.yahoo,

    //
    fireauth.EmailAuthProvider.PROVIDER_ID: AuthProvider.email,
    fireauth.PhoneAuthProvider.PROVIDER_ID: AuthProvider.phone,
  };

  AuthProvider get _parseAuthProviderId =>
      _mapProviderIdAndProvider[this] ?? (throw ParseStringError(this));

  AuthProvider get _parseSignInMethod =>
      _mapSignInMethodAndProvider[this] ?? (throw ParseStringError(this));
}

/// fuc from fac
extension _FireauthUserCredentialFromFac on fireauth.AuthCredential {
  Future<fireauth.UserCredential> _toUserCredential({
    required AuthProvider authProvider,
    required AuthLoginCategory category,
    required EmailVerification? emailVerification,
    required String? formattedPhoneNumber,
    required PhoneVerification? phoneVerification,
  }) async {
    final i = fireauth.FirebaseAuth.instance;

    switch (authProvider) {

    /// email
      case AuthProvider.email:
        late final fireauth.UserCredential fuc;

        switch (category) {
          case AuthLoginCategory.login:
            fuc = await i.signInWithCredential(this);
            break;
          case AuthLoginCategory.reAuth:
            fuc = await i.currentUser!.reauthenticateWithCredential(this);
            break;
          case AuthLoginCategory.linkIn:
            fuc = await i.currentUser!.linkWithCredential(this);
            break;
        }

        // ensure email verified
        if (!fuc.user!.emailVerified) {
          // TODO:
          // await AuthService.fireauth.sendEmailVerification();
          await emailVerification!(
            fireauth.FirebaseAuth.instance.userChanges()._toEmailVerifiedChanges,
          );
        }
        return fuc;

    /// phone
      case AuthProvider.phone:

      // verify on web with custom reCAPTCHA verifier
        if (kIsWeb) {
          late final fireauth.ConfirmationResult result;

          // TODO: implement reCAPTCHA widget, see https://www.google.com/recaptcha/about/
          const fireauth.RecaptchaVerifier? recaptchaVerifier = null;

          switch (category) {
            case AuthLoginCategory.login:
            case AuthLoginCategory.reAuth:
              result = await i.signInWithPhoneNumber(
                formattedPhoneNumber!,
                recaptchaVerifier,
              );
              break;
            case AuthLoginCategory.linkIn:
              result = await i.currentUser!.linkWithPhoneNumber(
                formattedPhoneNumber!,
                recaptchaVerifier,
              );
              break;
          }

          return result.confirm(await phoneVerification!());

          // verify natively
        } else {
          switch (category) {
            case AuthLoginCategory.login:
              return i.signInWithCredential(this);

            case AuthLoginCategory.reAuth:
              return i.currentUser!.reauthenticateWithCredential(this);

            case AuthLoginCategory.linkIn:
              return i.currentUser!.linkWithCredential(this);
          }
        }

    /// other authProviders
      default:
        switch (category) {
          case AuthLoginCategory.login:
            return i.signInWithCredential(this);

          case AuthLoginCategory.reAuth:
            return i.currentUser!.reauthenticateWithCredential(this);

          case AuthLoginCategory.linkIn:
            return i.currentUser!.linkWithCredential(this);
        }
    }
  }
}

/// fuc from fap
extension _FireauthUserCredentialFromFap on fireauth.OAuthProvider {
  Future<fireauth.UserCredential> _toUserCredential({
    required AuthLoginCategory category,
    required AuthLoginMethod loginMethod,
    required List<String>? scopes,
    required Map<dynamic, dynamic>? parameters,
  }) async {
    final i = fireauth.FirebaseAuth.instance;

    // TODO: understand scopes, parameters
    if (kIsWeb && loginMethod != AuthLoginMethod.credential) {
      setScopes(scopes ?? []);
      setCustomParameters(parameters ?? {});

      log('\n'
          '${scopes.toString()}\n'
          '${parameters.toString()}');
    }

    switch (category) {
      case AuthLoginCategory.login:
        switch (loginMethod) {
          case AuthLoginMethod.anonymously:
          case AuthLoginMethod.credential:
            throw ImpossibleError();

          case AuthLoginMethod.provider:
            return i.signInWithProvider(this);

          case AuthLoginMethod.providerPopup:
            return i.signInWithPopup(this);

          case AuthLoginMethod.providerRedirect:
            return i
                .signInWithRedirect(this)
                .then((_) => i.getRedirectResult());
        }
      case AuthLoginCategory.reAuth:
        switch (loginMethod) {
          case AuthLoginMethod.anonymously:
          case AuthLoginMethod.credential:
            throw ImpossibleError();

          case AuthLoginMethod.provider:
            return i.currentUser!.reauthenticateWithProvider(this);

          case AuthLoginMethod.providerPopup:
            return i.currentUser!.reauthenticateWithPopup(this);

          case AuthLoginMethod.providerRedirect:
            return i.currentUser!
                .reauthenticateWithRedirect(this)
                .then((_) => i.getRedirectResult());
        }
      case AuthLoginCategory.linkIn:
        switch (loginMethod) {
          case AuthLoginMethod.anonymously:
          case AuthLoginMethod.credential:
            throw ImpossibleError();

          case AuthLoginMethod.provider:
            return i.currentUser!.linkWithProvider(this);

          case AuthLoginMethod.providerPopup:
            return i.currentUser!.linkWithPopup(this);

          case AuthLoginMethod.providerRedirect:
            return i.currentUser!
                .linkWithRedirect(this)
                .then((_) => i.getRedirectResult());
        }
    }
  }
}

extension _FireauthEmailActionCodeSetting on fireauth.ActionCodeSettings {
  /// custom email tempt, see https://support.google.com/firebase/answer/7000714
  /// passing state in email actions, see https://firebase.google.com/docs/auth/flutter/passing-state-in-email-actions
  static fireauth.ActionCodeSettings getDefault(String email) {


    // fire.FirebaseAuth.instance.setLanguageCode('zh'); // use locale
    //
    // TODO: know what is a correct continue uri
    // return fire.ActionCodeSettings(
    //   handleCodeInApp: true,
    //   url: 'http://tempt-fa247.web.app/verify?email=$email',
    //   androidPackageName: androidPackageName,
    //   androidInstallApp: true,
    //   androidMinimumVersion: '12',
    //   iOSBundleId: iOSBundleId,
    // );

    throw UnimplementedError();
  }
}

extension _FireauthUserChangesUtil on Stream<fireauth.User?> {
  Stream<bool> get _toEmailVerifiedChanges =>
      map((user) => user?.emailVerified ?? false)
          .whereDiff
          .takeWhile((beenVerified) => beenVerified);
}