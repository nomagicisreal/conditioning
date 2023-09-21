import 'dart:ui' show PlatformDispatcher;
import 'package:flutter/material.dart' show Size, runApp;
import 'main_service.dart';

late final PlatformDispatcher platformDispatcher;
late final Iterable<Size> windowSizes;

void main() async {
  platformDispatcher = PlatformDispatcher.instance;
  windowSizes = platformDispatcher.views.map((e) => e.physicalSize);

  runApp(await MainService.initializeApp());
}


/// terminal commands:
///
/// ---clean and get
/// flutter clean && flutter pub get
///
/// ---podfile update
/// flutter clean && flutter pub get && cd ios && pod install && cd ..
///
/// ---generate files and delete conflicting file:
/// flutter pub run build_runner build --delete-conflicting-outputs
/// dart run build_runner build --delete-conflicting-outputs
///
///
/// ---firebase domain setting:
/// flutterfire configure -a com.nomisal.conditioning -i com.nomisal.conditioning -m com.nomisal.conditioning
///
///
///