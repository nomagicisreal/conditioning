part of structure;

///
/// this file contains:
/// [DataArgumentSet]
/// [DataExtension]
///
/// [StreamStructureExtension]
///
///
///

class DataArgumentSet<D extends Data> {
  final Json? fields;
  final D? another;

  const DataArgumentSet._({
    this.fields,
    this.another,
  });

  factory DataArgumentSet.forFields(Json fields) => DataArgumentSet._(fields: fields);
  factory DataArgumentSet.forAnother(D another) => DataArgumentSet._(another: another);
}

extension DataExtension<D extends Data> on Data {
  FieldsSet difference(DataArgumentSet<D> argument) {
    final match = <String, EqualOrNot<dynamic>>{};

    ///
    if (argument.fields != null) {
      for (var field in argument.fields!.entries) {
        final name = field.key;
        final value = field.value;
        if (toJson[name] == value) {
          match.putIfAbsent(name, () => EqualOrNot(value, null));
        } else {
          match.putIfAbsent(name, () => EqualOrNot(null, value));
        }
      }

      ///
    } else if (argument.another != null) {
      _forEachPropsWith(
        another: argument.another as D,
        fun: (fieldName, v1, v2) {
          late final EqualOrNot<dynamic> equalOrNot;
          if (v1 == v2) {
            equalOrNot = EqualOrNot(v2, null);
          } else {
            equalOrNot = EqualOrNot(null, v2);
          }
          match.putIfAbsent(fieldName, () => equalOrNot);
        },
      );

      ///
    } else {
      throw UnimplementedError();
    }
    return match;
  }

  bool match<d extends Data>(FieldsSet fieldsMatch) {
    if (D == d) {
      for (var field in fieldsMatch.entries) {
        final value = toJson[field.key];
        final equalOrNot = field.value;

        if (equalOrNot.equalValue != null) {
          if (value != equalOrNot.equalValue) {
            return false;
          }
        } else {
          if (value == equalOrNot.notEqualValue) {
            return false;
          }
        }
      }
      return true;
    } else {
      throw UnimplementedError();
    }
  }

  void _forEachPropsWith({
    /// v1 is value of current-instance,
    /// v2 is value of argument-instance

    required D another,
    required void Function(String fieldName, dynamic v1, dynamic v2) fun,
  }) =>
      another.toJson.forEach((key, value) => fun(key, toJson[key], value));


  // void retain(ArgumentSet<D> argument);
  // void retainWhere(bool Function(ArgumentSet<D> argument) test);
  // M intersection(ArgumentSet<D> query);
  // M union(ArgumentSet<D> query);
}


///
///
/// brain storming
///
///


/// insert
// Future<bool> Function(M existModel)? replaceWhen,

/// get
// @immutable
// class _TransactionArgumentGet {
//   final _TransactionInputHowMuch howMuch;
//   final _TransactionInputWhen when;
//   final _TransactionInputWhere where;
//   final _TransactionInputWho who;
//   const _TransactionArgumentGet({
//     this.howMuch = const _TransactionInputHowMuch(),
//     this.when = const _TransactionInputWhen(),
//     this.where = const _TransactionInputWhere(),
//     this.who = const _TransactionInputWho(),
//   });
// }
//
// typedef EntryEntrySetStringAndBoolAndBool = MapEntry<MapEntry<Set<String>, bool>, bool>;

/// update
// @immutable
// class _TransactionArgumentUpdate {
//   final Object? updateModel;
//   final MapEntry<_TransactionArgumentGet, M Function<M>(M model)>? updateAfterGet;
//
//   const _TransactionArgumentUpdate({
//     this.updateModel,
//     this.updateAfterGet,
//   }) : assert(updateModel == null || updateAfterGet == null);
// }

/// delete
// @immutable
// class _TransactionArgumentDelete {
//   final Object? deleteModel;
//   final MapEntry<_TransactionArgumentGet, M Function<M>(M model)>? deleteAfterGet;
//
//   const _TransactionArgumentDelete({
//     this.deleteModel,
//     this.deleteAfterGet,
//   }) : assert(deleteModel == null || deleteAfterGet == null);
// }
//


extension StreamStructureExtension on Iterable {
  Stream<Iterable<D?>> mix<D extends Data>({
    FieldsSet? mixMatch,
    bool Function(D? model)? mixValid,
    bool mixAll = true,
  }) {
    late final StreamController<Iterable<D?>> controller;
    final subscriptions = <StreamSubscription<D?>>[];

    void mixSubscriptionAndListen() {
      final list = <D?>[];
      int priority = 0;

      for (var stream in this) {
        final subscription = stream.listen(null)..onError((e) => throw e);

        bool streamYetSubscribed = true;
        int streamPriority = -1;

        void subscribe(D? event) {
          streamYetSubscribed = false;
          streamPriority = priority++;
          subscriptions
              .add(subscription); // enable pause, resume, cancel stream
          list.add(event); // enable listening
        }

        void unsubscribe() {}

        /// listen
        if (mixAll) {
          // listen all streams
          subscription.onData((event) {
            if (streamYetSubscribed) {
              subscribe(event);
            } else {
              list.replaceRange(streamPriority, streamPriority + 1, [event]);
            }
            controller.add(list);
          });
        } else {
          // listen valid streams

          bool eventIsValid(D? event) => (event as Data).match(mixMatch!);

          subscription.onData((event) {
            if (eventIsValid(event)) {
              if (streamYetSubscribed) {
                subscribe(event);
              } else {
                list.replaceRange(streamPriority, streamPriority + 1, [event]);
              }
              controller.add(list);
            } else {
              if (!streamYetSubscribed) {
                unsubscribe();
              }
            }
          });
        }
      }
    }

    controller = StreamController(
      onListen: mixSubscriptionAndListen,
      onPause: subscriptions.pauseAll,
      onResume: subscriptions.resumeAll,
      onCancel: subscriptions.cancelAll,
    );
    return controller.stream;
  }
}
