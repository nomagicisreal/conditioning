library res;

import 'package:conditioning/app/app.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'dart:async';
import 'dart:developer' show log;
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart' as fireauth;
import 'package:google_sign_in/google_sign_in.dart'
    show GoogleSignInAccount, GoogleSignIn, SignInOption;
import 'package:sign_in_with_apple/sign_in_with_apple.dart'
    show
        SignInWithApple,
        AuthorizationCredentialAppleID,
        AppleIDAuthorizationScopes;
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:hive/hive.dart' as hive;
import 'package:uuid/uuid.dart';

import '../app/data/data.dart';
import 'repo/_structure/structure.dart';
import 'source/source.dart';


part 'hub/hub.dart';
part 'hub/auth/hub_auth.dart';
part 'hub/hub_store.dart';
part 'hub/_constants.dart';
part 'repo/repo.dart';
part 'repo/auth/auth_credential.dart';
part 'repo/auth/auth_provider.dart';
part 'repo/auth/auth_user.dart';
part 'repo/auth/fireauth/fireauth.dart';
part 'repo/auth/fireauth/fireauth_login.dart';
part 'repo/auth/fireauth/fireauth_logining.dart';
part 'repo/auth/simpleauth/simpleauth.dart';
part 'repo/store/store_query.dart';
part 'repo/store/store_result.dart';
part 'repo/store/firestore/firestore.dart';
part 'repo/store/firestore/firestore_extension.dart';
part 'repo/store/hive/hive.dart';
part 'repo/store/hive/hive_extension.dart';
part 'repo/firebase_options.dart';