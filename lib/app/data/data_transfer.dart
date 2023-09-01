part of data;

///
///
/// [ParseType]
/// [ParseEnumString]
///
/// [JsonToData]
/// [JsonsToData]
/// [JsonFromData]
/// [JsonsFromData]
///
///

/// parse type
extension ParseType on Type {
  String get toStringUnderScore => toString().fromCamelToUnderscore;

  DataType get toData => toString().lowercaseFirstChar.toEnum<DataType>();
  EntityType get toEntity => toString().lowercaseFirstChar.toEnum<EntityType>();
  ModelType get toModel => toString().lowercaseFirstChar.toEnum<ModelType>();

  bool get isDataType => toString().lowercaseFirstChar.isModelType;
  bool get isModel => toString().lowercaseFirstChar.isModelType;
  bool get isEntity => toString().lowercaseFirstChar.isEntityType;
}

extension ParseEnumString on String {
  bool get isDataType => (DataType.values.map((e) => e.name).contains(this));
  bool get isModelType => (ModelType.values.map((e) => e.name).contains(this));
  bool get isEntityType => (EntityType.values.map((e) => e.name).contains(this));

  E toEnum<E extends Enum>() {
    late final Iterable values;

    throw UnimplementedError();
    // if (E == ModelType) {
    //   values = ModelType.values;
    // } else if (E == DataType) {
    //   values = DataType.values;
    // } else if (E == HumanKind) {
    //   values = HumanKind.values;
    // } else if (E == ScriptKind) {
    //   values = ScriptKind.values;
    // } else if (E == ContactType) {
    //   values = ContactType.values;
    // } else {
    //   throw ParseEnumError(E);
    // }
    //
    // E? e;
    // for (var value in values as Iterable<E>) {
    //   if (this == value.name) {
    //     e = value;
    //     break;
    //   }
    // }
    // return e ?? (throw ParseStringError(this));
  }
}

/// json
extension JsonToData on Json {
  D toModel<D extends Data>() => [this]._toModels<D>().first;

  D toData<D extends Data>() => [this]._toData<D>().first;
}

extension JsonsToData on Iterable<Json> {
  Iterable<D> _toModels<D extends Data>() {
    final m = D.toModel;

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

  Iterable<D> _toData<D extends Data>() {
    if (D.isModel) {
      return _toModels<D>();
    } else {
      final d = D.toData;
      switch (d) {
        case DataType.music:
          throw UnimplementedError();
      }
    }
  }
}

extension JsonFromData<D extends Data> on D {
  Json get toJson => [this].toJsons.first;
}

extension JsonsFromData<D extends Data> on Iterable<D> {
  Iterable<Json> get toJsons {
    final m = D.toModel;

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
