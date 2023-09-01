library data;

import 'dart:convert';

import 'package:conditioning/res/api.dart';
import 'package:conditioning/res/repo/_structure/structure.dart';
import 'package:conditioning/res/source/source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_converter.dart';
part 'data_transfer.dart';
// part 'data_transfer.g.dart';
// part 'data_transfer.freezed.dart';
part 'phone/phone.dart';
part 'music/music.dart';

///
/// 1. I want to annotate [unfreezed] on every data class, but suppose there is only a ".freezed" file.
/// 2. I want to make sure converters visible within, only within all the data class.
/// which makes me decide to collect all the file and subdir of 'model' and 'entity' inside this library.
///

part '../model/model.dart';
part '../model/model_meta.dart';
// part '../model/model_set.dart';
// part '../model/human/human.dart';
// part '../model/script/script.dart';
// part '../model/event/event.dart';
part '../entity/entity.dart';

abstract class Data<D> {
  const Data();

  ///
  /// [id] ensure every data in the app has only one
  /// [storeId] enable every data can be stored in any store service
  ///
  String get id;
}

enum DataType {
  music;
}


