part of source;

///
/// this file contains:
///
/// [Beats]
/// [BeatsOfInstrument]
///

class Beats {
  final Duration section;

  const Beats(this.section);

  static Processor<Timer> _limitedListener({
    required Processor<Timer> listener,
    required int maxTick,
    required VoidCallback onCancel,
  }) {
    final Processor<Timer> canceler = onCancel == kVoidCallback
        ? (timer) => timer.cancel()
        : (timer) {
            onCancel();
            timer.cancel();
          };
    return (timer) => timer.tick > maxTick ? canceler(timer) : listener(timer);
  }

  static Processor<Timer> _checkIfListenOnSequences({
    required Iterable<int> sequences,
    required int totalInterval,
    required Processor<Timer> listener,
  }) =>
      sequences.length == totalInterval
          ? listener
          : (timer) {
              try {
                // this indicate that the last sequences of beats should be 0
                if (sequences.contains(timer.tick % totalInterval)) {
                  listener(timer);
                }
              } finally {}
            };

  ///
  /// duration -> listener -> duration -> listener ...
  ///

  Timer timerOf({
    Processor<Timer> listener = FTimerProcessor.logTick,
    VoidCallback onCancel = kVoidCallback,
    required BeatsStyle style,
  }) =>
      Timer.periodic(
        section ~/ style.interval,
        _limitedListener(
          listener: _checkIfListenOnSequences(
            sequences: style.sequences,
            totalInterval: style.totalInterval,
            listener: listener,
          ),
          maxTick: style.maxTick,
          onCancel: onCancel,
        ),
      );
}

class BeatsStyle {
  final int interval;
  final int cycle;
  final int maxTick;
  final Iterable<int> sequences;

  int get totalInterval => interval * cycle;

  const BeatsStyle({
    this.cycle = 1,
    required this.interval,
    required this.maxTick,
    required this.sequences,
  });

  const BeatsStyle.of8({
    this.cycle = 1,
    this.sequences = sequence1To8,
    required this.maxTick,
  }) : interval = 8;

  const BeatsStyle.of16({
    this.cycle = 1,
    this.sequences = sequence1To16,
    required this.maxTick,
  }) : interval = 16;

  static const List<int> sequence1 = [1];
  static const List<int> sequence1To8 = [1, 2, 3, 4, 5, 6, 7, 8];
  static const List<int> sequence1To16 = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16
  ];
}

class BeatsOfInstrument extends Beats {
  final int interval;
  final Iterable<int> sequences;

  const BeatsOfInstrument(
    super.section, {
    required this.interval,
    required this.sequences,
  });

  Timer timerBy({
    int cycle = 1,
    VoidCallback onCancel = kVoidCallback,
    required Processor<Timer> listener,
    required int maxTick,
  }) =>
      timerOf(
        listener: listener,
        style: BeatsStyle(
          interval: interval,
          cycle: cycle,
          maxTick: maxTick,
          sequences: sequences,
        ),
        onCancel: onCancel,
      );
}
