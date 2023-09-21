part of app;

///
/// this file contains:
///
/// [_Serialize]
///
/// [_toEnumName], [_fromEnumName], [_keep]
/// [_JStringFromJson]
/// [_JStringFromIterable]
/// [_JStringFromEntry]
/// [_JStringFromMap]
/// [_JStringTo]
///
/// [_ConvertModelHuman], [_ConvertModelScript], [_ConvertModelEvent]
/// [_ConvertMetaModelContact]
/// [_ConvertEntryString], [_ConvertEntryH], [_ConvertEntryHH]
/// [_ConvertMapPerspectives]
/// [_ConvertMapHrH], [_ConvertMapHrN], [_ConvertMapHrE], [_ConvertMapRE], [_ConvertMapRN]
///
/// [TypeExtension]
/// [ParseEnumString]
///
/// [JsonToData], [JsonsToData]; [JsonFromData], [JsonsFromData]
///
///
/// they help [Data], [Entity], [Model] to json, from json
///
///
///

extension TypeExtension on Type {
  String get toStringUnderScore => toString().fromCamelToUnderscore;

  static bool isData(String element) => Data.typeList.contains(element);
  static bool isModel(String element) => Model.typeList.contains(element);
  static bool isEntity(String element) => Entity.typeList.contains(element);


  Translator<Json, T> jsonParserOf<T>() {
    // TODO
    return switch (this) {
      Music => throw UnimplementedError(),
      _ => throw UnimplementedError(),
    };
  }

  Translator<T, Json> jsonConstructorOf<T>() {
    // TODO
    return switch (this) {
      Music => throw UnimplementedError(),
      _ => throw UnimplementedError(),
    };
  }
}


// class _Serialize extends JsonSerializable {
//   const _Serialize()
//       : super(
//     explicitToJson: true,
//     converters: const <JsonConverter<dynamic, dynamic>>[
//       // _ConvertModelHuman(),
//       // _ConvertModelScript(),
//       // _ConvertModelEvent(),
//       // _ConvertMetaModelContact(),
//       // // _ConvertTopic(),
//       //
//       // _ConvertMapHrH(),
//       // _ConvertMapHrN(),
//       // _ConvertMapHrE(),
//       // _ConvertMapRN(),
//       // _ConvertMapRE(),
//       //
//       // _ConvertEntryString(),
//       // _ConvertEntryH(),
//       // _ConvertEntryHH(),
//     ],
//   );
// }


//
// /// from
// extension _JStringFromJson on Json {
//   String get toJString => jsonEncode(this);
// }
//
// extension _JStringFromIterable on Iterable<String> {
//   String get _fromIterableJStringToJString => fold(
//       StringBuffer(),
//           (buffer, s) => buffer
//         ..write('${s.length} ')
//         ..write(s)).toString();
// }
//
// extension _JStringFromEntry on MapEntry<dynamic, dynamic> {
//   String _toJStringFromEntry<K, V>({
//     required String Function(K key) keyMap,
//     required String Function(V value) valueMap,
//   }) => [keyMap(key), valueMap(value)]._fromIterableJStringToJString;
// }
//
// extension _JStringFromMap on Map<dynamic, dynamic> {
//   String _toJStringFromMap<K, V>({
//     required String Function(K key) keyMap,
//     required String Function(V value) valueMap,
//   }) =>
//       keys.fold(StringBuffer(), (buffer, key) {
//         final value = valueMap(this[key] as V);
//         return buffer
//           ..write('${keyMap(key)} ')
//           ..write('${value.length} ')
//           ..write(value);
//       }).toString();
// }
//
// /// to
// extension _JStringTo on String {
//   Json get _fromJStringToJson => jsonDecode(this) as Json;
//
//   MapEntry<ModelType, Json> get _parseTypedJString {
//     late final ModelType modelType;
//     final json = replaceFirstMapped(RegExp(r'[\w]+ '), (match) {
//       modelType = match.group0.toEnum<ModelType>();
//       return '';
//     })._fromJStringToJson;
//     return MapEntry(modelType, json);
//   }
//
//   Iterable<String> get _fromJStringToIterableJString {
//     final list = <String>[];
//     String s = this;
//     while (s.isNotEmpty) {
//       final entry = s.splitByFirstSpace;
//       final length = int.parse(entry.key);
//       final remain = entry.value;
//       list.add(remain.substring(0, length));
//       s = remain.substring(length);
//     }
//     return list;
//   }
//
//   MapEntry<K, V> _fromJStringToEntry<K, V>({
//     required K Function(String key) keyMap,
//     required V Function(String value) valueMap,
//   }) {
//     final keyAndValue = _fromJStringToIterableJString;
//     return MapEntry(keyMap(keyAndValue.first), valueMap(keyAndValue.last));
//   }
//
//   Map<K, V> _fromJStringToMap<K, V>({
//     required K Function(String key) keyMap,
//     required V Function(String value) valueMap,
//   }) {
//     final result = <String, String>{};
//     String s = this;
//     while (s.isNotEmpty) {
//       final e1 = s.splitByFirstSpace;
//       final e2 = e1.value.splitByFirstSpace;
//       final key = e1.key;
//       final valueLength = int.parse(e2.key);
//       final remain = e2.value;
//
//       result.putIfAbsent(key, () => remain.substring(0, valueLength));
//       s = remain.substring(valueLength);
//     }
//     return result.map((key, value) => MapEntry(keyMap(key), valueMap(key)));
//   }
// }


///
/// convert model
///
//
// class _ConvertModelHuman extends JsonConverter<Human, String> {
//   const _ConvertModelHuman();
//
//   @override
//   String toJson(Human model) => model.toJson.toJString;
//
//   @override
//   Human fromJson(String typedJsonString) {
//     final entry = typedJsonString._parseTypedJString;
//     final json = entry.value;
//     switch (entry.key) {
//       case ModelType.person:
//         return json.toModel<Person>();
//       case ModelType.people:
//         return json.toModel<People>();
//       case ModelType.org:
//         return json.toModel<Org>();
//       default:
//         throw UnimplementedError();
//     }
//   }
// }
//
// class _ConvertModelScript extends JsonConverter<Script, String> {
//   const _ConvertModelScript();
//
//   @override
//   String toJson(Script model) => model.toJson.toJString;
//
//   @override
//   Script fromJson(String typedJsonString) {
//     final entry = typedJsonString._parseTypedJString;
//     final json = entry.value;
//     switch (entry.key) {
//       case ModelType.scriptAbility:
//         return json.toModel<ScriptFeeling>();
//       case ModelType.scriptConscious:
//         return json.toModel<ScriptAbility>();
//       case ModelType.scriptFeeling:
//         return json.toModel<ScriptFeeling>();
//       default:
//         throw UnimplementedError();
//     }
//   }
// }
//
// class _ConvertModelEvent extends JsonConverter<Event, String> {
//   const _ConvertModelEvent();
//
//   @override
//   String toJson(Event model) => model.toJson.toJString;
//
//   @override
//   Event fromJson(String typedJsonString) {
//     final entry = typedJsonString._parseTypedJString;
//     final json = entry.value;
//     switch (entry.key) {
//       case ModelType.eventAbility:
//         return json.toModel<EventAbility>();
//       case ModelType.eventConscious:
//         return json.toModel<EventConscious>();
//       case ModelType.eventFeeling:
//         return json.toModel<EventFeeling>();
//       default:
//         throw UnimplementedError();
//     }
//   }
// }
//
// class _ConvertMetaModelContact extends JsonConverter<Contact, String> {
//   const _ConvertMetaModelContact();
//
//   @override
//   String toJson(Contact object) => [
//         object.mainContact._toJStringFromEntry<ContactType, String>(
//           keyMap: _toEnumName,
//           valueMap: _keep,
//         ),
//         object.otherContact._toJStringFromMap<ContactType, String>(
//           keyMap: _toEnumName,
//           valueMap: _keep,
//         )
//       ]._fromIterableJStringToJString;
//
//   @override
//   Contact fromJson(String jString) {
//     final mainAndOthers = jString._fromJStringToIterableJString;
//     return Contact(
//       mainContact: mainAndOthers.first._fromJStringToEntry<ContactType, String>(
//         keyMap: _fromEnumName,
//         valueMap: _keep,
//       ),
//       otherContact: mainAndOthers.last._fromJStringToMap<ContactType, String>(
//         keyMap: _fromEnumName,
//         valueMap: _keep,
//       ),
//     );
//   }
// }
//
// ///
// /// convert entry
// ///
//
// class _ConvertEntryString
//     extends JsonConverter<MapEntry<String, String>, String> {
//   const _ConvertEntryString();
//
//   @override
//   String toJson(MapEntry<String, String> object) => object._toJStringFromEntry(
//         keyMap: _keep,
//         valueMap: _keep,
//       );
//
//   @override
//   MapEntry<String, String> fromJson(String json) => json._fromJStringToEntry(
//         keyMap: _keep,
//         valueMap: _keep,
//       );
// }
//
// class _ConvertEntryH extends JsonConverter<MapEntry<Human, String>, String> {
//   const _ConvertEntryH();
//
//   @override
//   String toJson(MapEntry<Human, String> object) =>
//       object._toJStringFromEntry<Human, String>(
//         keyMap: (key) => (const _ConvertModelHuman()).toJson(key),
//         valueMap: _keep,
//       );
//
//   @override
//   MapEntry<Human, String> fromJson(String json) => json._fromJStringToEntry(
//         keyMap: (key) => (const _ConvertModelHuman()).fromJson(key),
//         valueMap: _keep,
//       );
// }
//
// class _ConvertEntryHH extends JsonConverter<MapEntry<Human, Human>, String> {
//   const _ConvertEntryHH();
//
//   @override
//   String toJson(MapEntry<Human, Human> object) =>
//       object._toJStringFromEntry<Human, Human>(
//         keyMap: (key) => (const _ConvertModelHuman()).toJson(key),
//         valueMap: (value) => (const _ConvertModelHuman()).toJson(value),
//       );
//
//   @override
//   MapEntry<Human, Human> fromJson(String json) =>
//       json._fromJStringToEntry<Human, Human>(
//         keyMap: (key) => (const _ConvertModelHuman()).fromJson(key),
//         valueMap: (value) => (const _ConvertModelHuman()).fromJson(value),
//       );
// }
//
// ///
// /// convert map
// ///
//
// class _ConvertMapPerspectives extends JsonConverter<Perspectives, String> {
//   const _ConvertMapPerspectives();
//
//   @override
//   String toJson(Perspectives ps) => ps._toJStringFromMap<String, Script>(
//         keyMap: _keep,
//         valueMap: (const _ConvertModelScript()).toJson,
//       );
//
//   @override
//   Perspectives fromJson(String json) => json._fromJStringToMap<String, Script>(
//         keyMap: _keep,
//         valueMap: (const _ConvertModelScript()).fromJson,
//       );
// }
//
// /// HrH, HrN, HrE
// class _ConvertMapHrH extends JsonConverter<HumanRelatedHuman, String> {
//   const _ConvertMapHrH();
//
//   @override
//   String toJson(HumanRelatedHuman hrh) =>
//       hrh._toJStringFromMap<HumanKind, Perspectives>(
//         keyMap: _toEnumName,
//         valueMap: (const _ConvertMapPerspectives()).toJson,
//       );
//
//   @override
//   HumanRelatedHuman fromJson(String json) =>
//       json._fromJStringToMap<HumanKind, Perspectives>(
//         keyMap: _fromEnumName,
//         valueMap: (const _ConvertMapPerspectives()).fromJson,
//       );
// }
//
// class _ConvertMapHrN extends JsonConverter<HumanRelatedNote, String> {
//   const _ConvertMapHrN();
//
//   @override
//   String toJson(HumanRelatedNote hrn) =>
//       hrn._toJStringFromMap<ScriptKind, Map<String, Perspectives>>(
//         keyMap: _toEnumName,
//         valueMap: (value) => value._toJStringFromMap<String, Perspectives>(
//           keyMap: _keep,
//           valueMap: (const _ConvertMapPerspectives()).toJson,
//         ),
//       );
//
//   @override
//   HumanRelatedNote fromJson(String json) =>
//       json._fromJStringToMap<ScriptKind, Map<String, Perspectives>>(
//         keyMap: _fromEnumName,
//         valueMap: (value) => value._fromJStringToMap<String, Perspectives>(
//           keyMap: (ownerId) => ownerId,
//           valueMap: (const _ConvertMapPerspectives()).fromJson,
//         ),
//       );
// }
//
// class _ConvertMapHrE extends JsonConverter<HumanRelatedEvent, String> {
//   const _ConvertMapHrE();
//
//   @override
//   String toJson(HumanRelatedEvent hre) =>
//       hre._toJStringFromMap<EventKind, Map<String, Perspectives>>(
//         keyMap: _toEnumName,
//         valueMap: (value) => value._toJStringFromMap<String, Perspectives>(
//           keyMap: _keep,
//           valueMap: (const _ConvertMapPerspectives()).toJson,
//         ),
//       );
//
//   @override
//   HumanRelatedEvent fromJson(String json) =>
//       json._fromJStringToMap<EventKind, Map<String, Perspectives>>(
//         keyMap: _fromEnumName,
//         valueMap: (value) => value._fromJStringToMap<String, Perspectives>(
//           keyMap: (ownerId) => ownerId,
//           valueMap: (const _ConvertMapPerspectives()).fromJson,
//         ),
//       );
// }
//
// /// rn, re
// class _ConvertMapRN extends JsonConverter<RelatedNote, String> {
//   const _ConvertMapRN();
//
//   @override
//   String toJson(RelatedNote object) =>
//       object._toJStringFromMap<ScriptKind, Set<String>>(
//         keyMap: _toEnumName,
//         valueMap: (value) => value._fromIterableJStringToJString,
//       );
//
//   @override
//   RelatedNote fromJson(String json) =>
//       json._fromJStringToMap<ScriptKind, Set<String>>(
//         keyMap: _fromEnumName,
//         valueMap: (value) => value._fromJStringToIterableJString.toSet(),
//       );
// }
//
// class _ConvertMapRE extends JsonConverter<RelatedEvent, String> {
//   const _ConvertMapRE();
//
//   @override
//   String toJson(RelatedEvent object) =>
//       object._toJStringFromMap<EventKind, Set<String>>(
//         keyMap: _toEnumName,
//         valueMap: (value) => value._fromIterableJStringToJString,
//       );
//
//   @override
//   RelatedEvent fromJson(String json) =>
//       json._fromJStringToMap<EventKind, Set<String>>(
//         keyMap: _fromEnumName,
//         valueMap: (value) => value._fromJStringToIterableJString.toSet(),
//       );
// }


///
///
///
///
///
///
///
/// json
///
///
///
///
///
///
///

extension JsonToData on Json {
  D toModel<D extends Data>() => [this]._toModels<D>().first;

// D toData<D extends Data>() => [this]._toData<D>().first;
}

extension JsonsToData on Iterable<Json> {
  Iterable<D> _toModels<D extends Data>() {

    throw UnimplementedError();
    // switch (m) {
    //   /// human
    //   case ModelType.person:
    //     return map((data) => _$PersonFromJson(data) as D);
    //   case ModelType.people:
    //     return map((data) => _$PeopleFromJson(data) as D);
    //   case ModelType.org:
    //     return map((data) => _$OrgFromJson(data) as D);
    //
    //   /// script
    //   case ModelType.scriptAbility:
    //     return map((data) => _$ScriptAbilityFromJson(data) as D);
    //   case ModelType.scriptConscious:
    //     return map((data) => _$ScriptConsciousFromJson(data) as D);
    //   case ModelType.scriptFeeling:
    //     return map((data) => _$ScriptFeelingFromJson(data) as D);
    //
    //   /// event
    //   case ModelType.eventAbility:
    //     return map((data) => _$EventAbilityFromJson(data) as D);
    //   case ModelType.eventConscious:
    //     return map((data) => _$EventConsciousFromJson(data) as D);
    //   case ModelType.eventFeeling:
    //     return map((data) => _$EventFeelingFromJson(data) as D);
    // }
  }

// Iterable<D> _toData<D extends Data>() {
//   if (D.isModel) {
//     return _toModels<D>();
//   } else {
//     final d = D.toData;
//     switch (d) {
//       case DataType.music:
//         throw UnimplementedError();
//     }
//   }
// }
}

extension JsonFromData<D extends Data> on D {
  Json get toJson => [this].toJsons.first;
}

extension JsonsFromData<D extends Data> on Iterable<D> {
  Iterable<Json> get toJsons {
    throw UnimplementedError();
    // switch (m) {
    //   /// human
    //   case ModelType.person:
    //     return map((data) => _$PersonToJson(data as Person));
    //   case ModelType.people:
    //     return map((data) => _$PeopleToJson(data as People));
    //   case ModelType.org:
    //     return map((data) => _$OrgToJson(data as Org));
    //
    //   /// script
    //   case ModelType.scriptAbility:
    //     return map((data) => _$ScriptAbilityToJson(data as ScriptAbility));
    //   case ModelType.scriptConscious:
    //     return map((data) => _$ScriptConsciousToJson(data as ScriptConscious));
    //   case ModelType.scriptFeeling:
    //     return map((data) => _$ScriptFeelingToJson(data as ScriptFeeling));
    //
    //   /// event
    //   case ModelType.eventAbility:
    //     return map((data) => _$EventAbilityToJson(data as EventAbility));
    //   case ModelType.eventConscious:
    //     return map((data) => _$EventConsciousToJson(data as EventConscious));
    //   case ModelType.eventFeeling:
    //     return map((data) => _$EventFeelingToJson(data as EventFeeling));
    // }
  }
}
