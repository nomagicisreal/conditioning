import 'package:conditioning/res/api.dart';
import 'package:conditioning/ui/controller/controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

abstract class MainService {
  static Future<Widget> initializeApp() async {
    //...
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: defaultFirebaseAppName,
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return MainController.mainScreen();
  }
}

abstract class HubService {
  static HubAuth get auth => Hub.fireauth;

  static HubStore get localStore => Hub.hive;

  static HubStore get cloudStore => Hub.firestore;
}
