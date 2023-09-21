library source;

import 'dart:async';
import 'dart:math' as math hide log;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conditioning/res/usecase/usecase.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' show Vector3;

// import 'package:flutter_gen/gen_l10n/app_localizations.dart' show AppLocalizations;

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter_tex/flutter_tex.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:table_calendar/table_calendar.dart';


part 'algorithm/collection.dart';
part 'algorithm/search.dart';
part 'algorithm/sort.dart';
part 'constant/time.dart';
part 'constant/primary.dart';
part 'constant/dependency.dart';
part 'constant/function.dart';
part 'constant/geometry.dart';
part 'constant/material.dart';
part 'constant/typedef.dart';
part 'extension/_e.dart';
part 'extension/animation.dart';
part 'extension/audio.dart';
part 'extension/dependency.dart';
part 'extension/math.dart';
part 'extension/helper.dart';
part 'extension/material.dart';
part 'extension/preference.dart';


const String kApplicationAndroidPackageName = 'com.example.tempt';
const String kApplicationIOSBundleId = kApplicationAndroidPackageName;


const VoidCallback kVoidCallback = _voidCallback;
const WidgetBuilder kWidgetBuilder = _widgetBuilder;
const Processor<Mations<dynamic, Mation>> kMationsProcessor = _mationsProcessor;
const Widget kBackButton = BackButtonIcon();

void _voidCallback() {}
Widget _widgetBuilder(BuildContext context) => KSizedBox.none;
void _mationsProcessor(Mations<dynamic, Mation> mations) => mations;


