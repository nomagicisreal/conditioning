part of res;

///
///
/// typedef:
/// [PhoneVerification]
/// [EmailVerification]
///
/// class, enum:
/// [AuthRegisterCredential]
/// [AuthLoginCredential]
/// [AuthLoginCredentialSetup]
/// [AuthLoginMethod]
/// [AuthLoginCategory]
/// [AuthLoginExceptionHandler]
///
///

class AuthRegisterCredential {
  const AuthRegisterCredential._();
  factory AuthRegisterCredential.create() => throw UnimplementedError();
}

typedef PhoneVerification = Future<String> Function();
typedef EmailVerification = Future<void> Function(Stream<bool> verifiedChanges);

///
/// factories:
/// [AuthLoginCredential.anonymously]
/// [AuthLoginCredential.ofAuthProvider]
/// [AuthLoginCredential.ofEmail]
/// [AuthLoginCredential.ofPhone]
///
class AuthLoginCredential {
  final AuthLoginCredentialSetup setup;
  final AuthProvider? authProvider;
  final AuthLoginMethod loginMethod;
  final String? email;
  final String? emailLink;
  final String? password;
  final EmailVerification? emailVerification;
  final String? phoneNumber;
  final PhoneVerification? phoneVerification;

  /// the fields for web login
  final List<String>? scopes;
  final Map<dynamic, dynamic>? parameters;

  const AuthLoginCredential._({
    required this.setup,
    required this.authProvider,
    required this.loginMethod,
    this.email,
    this.password,
    this.emailLink,
    this.emailVerification,
    this.phoneNumber,
    this.phoneVerification,
    this.scopes,
    this.parameters,
  });

  factory AuthLoginCredential.anonymously({
    AuthLoginCredentialSetup credentialSetup = const AuthLoginCredentialSetup(),
  }) =>
      AuthLoginCredential._(
        setup: credentialSetup,
        authProvider: null,
        loginMethod: AuthLoginMethod.anonymously,
      );

  factory AuthLoginCredential.ofAuthProvider({
    AuthLoginCredentialSetup credentialSetup = const AuthLoginCredentialSetup(),
    required AuthProvider authProvider,
    required AuthLoginMethod logInMethod,
    List<String>? scopes,
    Map<dynamic, dynamic>? parameters,
  }) {
    assert(
      logInMethod != AuthLoginMethod.anonymously,
      "use 'AuthLoginCredential.empty()' method instead",
    );
    assert(
      (authProvider != AuthProvider.email) &&
          (authProvider != AuthProvider.phone),
      "use 'AuthLoginCredential.ofEmail()' or 'ofPhone()' method instead",
    );

    return AuthLoginCredential._(
      setup: credentialSetup,
      authProvider: authProvider,
      loginMethod: logInMethod,
      scopes: scopes,
      parameters: parameters,
    );
  }

  /// [emailVerification] return a future in the circumstance that email have been verified
  factory AuthLoginCredential.ofEmail({
    AuthLoginCredentialSetup credentialSetup = const AuthLoginCredentialSetup(),
    required String email,
    required String passwordOrEmailLink,
    bool isPassword = true,
    required EmailVerification? verification,
  }) =>
      AuthLoginCredential._(
        setup: credentialSetup,
        authProvider: AuthProvider.email,
        loginMethod: AuthLoginMethod.credential,
        email: email,
        password: isPassword ? passwordOrEmailLink : null,
        emailLink: isPassword ? null : passwordOrEmailLink,
        emailVerification: verification,
      );

  /// [phoneVerification] return a future verificationCode, trigger phone-sign-in-flow
  factory AuthLoginCredential.ofPhone({
    AuthLoginCredentialSetup credentialSetup = const AuthLoginCredentialSetup(),
    required String phoneNumber,
    required PhoneVerification verification,
  }) =>
      AuthLoginCredential._(
        setup: credentialSetup,
        authProvider: AuthProvider.phone,
        loginMethod: AuthLoginMethod.credential,
        phoneNumber: phoneNumber,
        phoneVerification: verification,
      );

  String? get formattedPhoneNumber => phoneNumber?.toFormattedPhoneNumber;
}

/// auth setup, see [AuthLoginCredential.setup]
class AuthLoginCredentialSetup {
  final HubAuthOption authOption;
  final AuthLoginCategory loginCategory;
  final AuthLoginExceptionHandler exceptionHandler;
  final bool saveSignedServiceCredential;

  const AuthLoginCredentialSetup({
    this.authOption = HubAuthOption.fireauth,
    this.loginCategory = AuthLoginCategory.login,
    this.exceptionHandler = const AuthLoginExceptionHandler(),
    this.saveSignedServiceCredential = false,
  });
}

/// login methods, see [AuthLoginCredential]
enum AuthLoginMethod {
  anonymously,
  credential,
  provider,

  /// only provide natively
  providerPopup,

  /// only provide for web
  providerRedirect,

  /// only provide for web
}

/// .record at 2022/11/14

/// login category, see [AuthLoginCredentialSetup]
enum AuthLoginCategory {
  login,
  reAuth,
  linkIn,
}

/// login exception handler, see [AuthLoginCredentialSetup]
class AuthLoginExceptionHandler {
  ///
  /// - [fireauth.FirebaseException.code] - 'user-not-found' --- return true makes [fireauth.FirebaseAuth.createUserWithEmailAndPassword]
  final Future<bool> Function(String email)? askToCreateUser;

  /// - [fireauth.FirebaseException.code] - 'email-already-in-use'
  /// - [fireauth.FirebaseException.code] - 'invalid-email'
  /// - [fireauth.FirebaseException.code] - 'user-disabled'
  /// - [fireauth.FirebaseException.code] - 'wrong-password'
  ///
  /// - [fireauth.FirebaseException.code] - 'invalid-continue-uri'
  /// - [fireauth.FirebaseException.code] - 'unauthorized-continue-uri'
  ///
  /// - [fireauth.FirebaseException.code] - 'invalid-phone-number'
  /// - [fireauth.FirebaseException.code] - 'invalid-credential'
  /// - [fireauth.FirebaseException.code] - 'credential-already-in-use'
  /// - [fireauth.FirebaseException.code] - 'provider-already-linked'
  ///
  /// - [fireauth.FirebaseException.code] - 'popup-closed-by-user'
  /// - [fireauth.FirebaseException.code] - 'too-many-requests'
  ///
  /// - [fireauth.FirebaseException.code] - 'missing-android-pkg-name' (email) (An Android package name must be provided if the Android app is required to be installed.)
  /// - [fireauth.FirebaseException.code] - 'missing-ios-bundle-id' (email) (An iOS Bundle ID must be provided if an App Store ID is provided.)
  ///
  /// - [otherService.OtherException.code] - ...
  ///

  const AuthLoginExceptionHandler({
    this.askToCreateUser,
  });
}
