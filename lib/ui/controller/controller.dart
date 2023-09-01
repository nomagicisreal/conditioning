library controller;

import 'package:conditioning/res/source/source.dart';
import 'package:conditioning/res/usecase/material.dart';
import 'package:conditioning/ui/widget/widget.dart';
import 'package:flutter/material.dart';


abstract class MainController {
  static Widget mainScreen() => const Preference(
    theme: null,
    appColor: MainColor.blue,
    animations: {},
    child: CustomApp(screen: Screen.schedule),
  );
}