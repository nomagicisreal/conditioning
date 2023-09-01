library structure;

///
/// this library should be treat as a bridge connecting dart with the useful library of data-science language
///
/// this library enhance:
/// 1. (solo) the functionality of a single 'data', 'model', 'entity'
/// 2. (set) the functionality in a type of 'data', 'model', 'entity'
/// 2. (set) the functionality between the type of 'data', 'model', 'entity'.
///

import 'dart:async';
import 'package:conditioning/app/data/data.dart';

import '../../api.dart';

part '_error.dart';
part '_constants.dart';

part 'data/solo.dart';
part 'data/set/set.dart';
part 'data/set/set_crud.dart';
part 'data/set/set_extension.dart';
part 'data/set/stream_mix.dart';
