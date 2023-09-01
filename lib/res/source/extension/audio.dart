part of source;

///
/// this file contains:
///
/// [Beats]
///

class Beats {
  final Duration duration;

  const Beats(this.duration);

  static TimerListener _checkIfLimited(TimerListener listener, int? maxTick) =>
      maxTick == null
          ? listener
          : (t) => t.tick > maxTick ? t.cancel() : listener(t);

  static TimerListener _checkIfSequenced({
    required Iterable<int>? sequences,
    required int intervalCount,
    required VoidCallback listener,
  }) =>
      sequences == null
          ? (_) => listener()
          : (timer) {
        for (var s in sequences) {
          // the last sequence of 8 beats, 16 beats, 32 beats should be set to 0
          if (timer.tick % intervalCount == s) {
            listener();
          }
        }
      };

  ///
  /// duration -> listener -> duration -> listener ...
  ///

  Timer timerOf({
    int interval = 8,
    Iterable<int>? sequences,
    int cycle = 1,
    int? maxTick,
    required VoidCallback listener,
  }) =>
      Timer.periodic(
        Operator.divide.operateDurationMilli(duration, interval),
        _checkIfLimited(
          _checkIfSequenced(
            sequences: sequences,
            intervalCount: interval * cycle,
            listener: listener,
          ),
          maxTick,
        ),
      );
}