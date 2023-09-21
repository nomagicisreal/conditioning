library structure;

///
///
/// this library is built for [Data], [Model], [Entity],
/// in convenience for all the transaction in application, seamless between local storage and cloud storage
///
/// 1. (solo) the functionality of a single 'data', 'model', 'entity'
/// 2. (set) the functionality in a type of 'data', 'model', 'entity'
/// 2. (set) the functionality between the type of 'data', 'model', 'entity'.
///

import 'dart:async';
import 'package:conditioning/app/app.dart';
import 'package:conditioning/res/source/source.dart';


part 'data_solo.dart';
part 'data_set.dart';


typedef Json = Map<String, dynamic>;
typedef FieldsSet = Map<String, EqualOrNot<dynamic>>;
typedef BaseTransaction = Future<void> Function();
