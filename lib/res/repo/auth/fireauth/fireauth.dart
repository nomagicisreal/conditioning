part of res;

///
/// [_RepoAuthFireauth]
///
/// [_ImplFireauth]
/// [_ImplFireauthRegister]
/// [_ImplFireauthLogin]
/// [_ImplFireauthLoginUser]
/// [_ImplFireauthStream]
///
///

/// singleton firebase auth
class _RepoAuthFireauth extends _ImplFireauth
    with
        _ImplFireauthRegister,
        _ImplFireauthLogin,
        _ImplFireauthLoginUser,
        _ImplFireauthStream {
  const _RepoAuthFireauth._();

  factory _RepoAuthFireauth() => _instance;
  static const _RepoAuthFireauth _instance = _RepoAuthFireauth._();
}

/// below classes separate the implementation of [fireauth.FirebaseAuth], preventing class being too large.
abstract class _ImplFireauth extends HubAuth with HubAuthFireauth {
  const _ImplFireauth();
}

mixin _ImplFireauthRegister on _ImplFireauth {
  @override
  Future<AuthUser> register({required AuthRegisterCredential credential}) {
    throw UnimplementedError();
  }
}

mixin _ImplFireauthLogin on _ImplFireauth {
  @override
  Future<AuthUser> login({required AuthLoginCredential credential}) =>
      credential._user;

  @override
  Future<void> logout() => fireauth.FirebaseAuth.instance.signOut();

  // TODO: email action
  @override
  Future<void> sendEmailVerification() {
    final user = fireauth.FirebaseAuth.instance.currentUser!;
    return user.email == null
        ? (throw LoginUserNotFoundException())
        : user.sendEmailVerification(
            _FireauthEmailActionCodeSetting.getDefault(user.email!),
          );
  }

  @override
  Future<Map<String, AuthProvider>> fetchLoginMethods(String email) async =>
      (await fireauth.FirebaseAuth.instance.fetchSignInMethodsForEmail(email))
          .map((method) => MapEntry(method, method._parseSignInMethod)).toMap;

  // TODO: email action
  @override
  Future<void> resetPassword(String email) =>
      fireauth.FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: _FireauthEmailActionCodeSetting.getDefault(email),
      );
}

mixin _ImplFireauthLoginUser on _ImplFireauth {
  @override
  Future<void> updateAuthUser({
    required Future<AuthLoginCredential> Function(
      AuthLoginCredentialSetup credentialSetup,
    ) getReAuthCredential,
    required String? email,
    required String? password,
    required String? photoURL,
    required String? displayName,
    required String? phoneNumber,
    required PhoneVerification? phoneVerification,
  }) async {
    final currentUser = fireauth.FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw LoginUserNotFoundException();
    } else {
      try {
        Future<void> update({
          required fireauth.User user,
          required String? email,
          required String? password,
          required String? photoURL,
          required String? displayName,
          required String? phoneNumber,
          required PhoneVerification? phoneVerification,
        }) async {
          email == null ? null : await user.verifyBeforeUpdateEmail(email);
          photoURL == null ? null : await user.updatePhotoURL(photoURL);
          password == null ? null : await user.updatePassword(password);
          displayName == null
              ? null
              : await user.updateDisplayName(displayName);

          if (phoneNumber != null && phoneVerification != null) {
            await user.updatePhoneNumber(
              await AuthLoginCredential.ofPhone(
                phoneNumber: phoneNumber,
                verification: phoneVerification,
              )._toFireauthCredential as fireauth.PhoneAuthCredential,
            );
          }
        }

        await update(
          user: currentUser,
          email: email,
          password: password,
          photoURL: photoURL,
          displayName: displayName,
          phoneNumber: phoneNumber,
          phoneVerification: phoneVerification,
        );
      } on fireauth.FirebaseAuthException catch (e) {
        if (e.message == 'requires-recent-login') {
          await (await getReAuthCredential(const AuthLoginCredentialSetup(
            loginCategory: AuthLoginCategory.reAuth,
          )))
              ._user;
          await updateAuthUser(
            getReAuthCredential: getReAuthCredential,
            email: email,
            password: password,
            photoURL: photoURL,
            displayName: displayName,
            phoneNumber: phoneNumber,
            phoneVerification: phoneVerification,
          );
        } else {
          rethrow;
        }
      }
    }
  }
}

mixin _ImplFireauthStream on _ImplFireauth {
  @override
  Stream<AuthUserState> get authUserState {
    late final StreamController<AuthUserState> controller;
    late final StreamSubscription<fireauth.User?> subscription;

    void listen() {
      subscription = fireauth.FirebaseAuth.instance.userChanges().listen(null)
        ..onData((user) {
          if (user == null) {
            controller.add(AuthUserState.none);
          } else {
            controller.add(AuthUserState.login);
            // controller.add(AuthUserState.profileUpdate);
            // controller.add(AuthUserState.authStateChanged);
            throw UnimplementedError();
          }
        })
        ..onError((error) => throw error);
    }

    controller = StreamController(
      onListen: listen,
      onPause: () => subscription.pause(),
      onResume: () => subscription.resume(),
      onCancel: () => subscription.cancel(),
    );
    return controller.stream;
  }
}
