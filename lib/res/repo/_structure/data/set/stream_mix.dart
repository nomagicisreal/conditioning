part of structure;

extension MixStreams<D extends Data> on Iterable<Stream<D?>> {
  Stream<Iterable<D?>> mix({
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

          bool eventIsValid(D? event) => (event as Data<D>).match(mixMatch!);

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
      onPause: subscriptions._pauseAll,
      onResume: subscriptions._resumeAll,
      onCancel: subscriptions._cancelAll,
    );
    return controller.stream;
  }
}

extension StreamSubscriptionsUtil on Iterable<StreamSubscription> {
  void _pauseAll() => fold<void>(null, (_, stream) => stream.pause());

  void _resumeAll() => fold<void>(null, (_, stream) => stream.resume());

  void _cancelAll() => fold<void>(null, (_, stream) => stream.cancel());
}
