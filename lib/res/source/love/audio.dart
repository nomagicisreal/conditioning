import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:conditioning/res/source/source.dart';

///
/// TODO: transfer arbitrary length audio into loopAble music chunk, according to beats duration, interval
///
///

class MusicCounter extends StatefulWidget {
  const MusicCounter({super.key});

  @override
  State<MusicCounter> createState() => _MusicCounterState();
}

class _MusicCounterState extends State<MusicCounter> {
  late final AudioPlayer player;

  Timer _string = VTimer.none;
  Timer _hiHatTick = VTimer.none;
  Timer _punch = VTimer.none;
  Timer _drum = VTimer.none;
  Timer _keyboard = VTimer.none;
  Timer _beep = VTimer.none;
  int _stringValue = 0;
  int _hiHatTickValue = 0;
  int _punchValue = 0;
  int _drumValue = 0;
  int _keyboardValue = 0;
  int _beepValue = 0;

  Iterable<Timer> get _timers => [
        _hiHatTick,
        _punch,
        _drum,
        _string,
        _keyboard,
        _beep,
      ];

  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setPlayerMode(PlayerMode.mediaPlayer);
    player.setSource(AssetSource(KStringAssetMusic.thatsTheWayLoveGoes));
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            await player.resume();

            setState(() {
              _stringValue = 0;
              _keyboardValue = 0;
              _hiHatTickValue = 0;
              _punchValue = 0;
              _drumValue = 0;
              _beepValue = 0;
            });

            final duration =
                KDuration.milli306 * 8; // 2, 448 -> 4, 896 -> 7, 344 -> 9, 792
            ///
            /// (1): 0, 306  --- (1.5): 0, 459
            /// (2): 0, 612  --- (2.5): 0, 765
            /// (3): 0, 918  --- (3.5): 1, 071
            /// (4): 1, 224  --- (4.5): 1, 459
            /// (5): 1, 530  --- (5.5): 1, 683
            /// (6): 1, 836  --- (6.5): 1, 989
            /// (7): 2, 142  --- (7.5): 2, 295
            /// (8): 2, 448
            ///

            final beats = Beats(duration);
            FTimer.nest([
              (
                KDuration.second10 + KDuration.milli150 - duration,
                () {
                  _string = beats.timerOf(
                    listener: (timer) => setState(() => _stringValue++),
                    style: const BeatsStyle.of8(
                      maxTick: 8,
                      sequences: [5, 7],
                    ),
                  );
                  _keyboard = beats.timerOf(
                    listener: (timer) => setState(() => _keyboardValue++),
                    style: const BeatsStyle.of16(
                      maxTick: 16,
                      sequences: [11, 13, 14, 0],
                    ),
                  );
                }
              ),
              (
                duration,
                () {
                  _string = beats.timerOf(
                    listener: (timer) => setState(() => _stringValue++),
                    style: const BeatsStyle.of16(
                      cycle: 4,
                      maxTick: 76,
                      sequences: [2, 4, 6, 8, 9, 10, 11, 12],
                    ),
                  );

                  _keyboard = beats.timerOf(
                    listener: (timer) => setState(() => _keyboardValue++),
                    style: const BeatsStyle.of16(
                      cycle: 2,
                      maxTick: 112,
                      sequences: [2, 4, 5, 27, 29, 30, 0],
                    ),
                  );

                  _hiHatTick = beats.timerOf(
                    listener: (timer) => setState(() => _hiHatTickValue++),
                    style: const BeatsStyle.of8(maxTick: 57),
                  );
                  _punch = beats.timerOf(
                    listener: (timer) => setState(() => _punchValue++),
                    style: const BeatsStyle.of8(maxTick: 56, sequences: [3, 7]),
                  );
                  _drum = beats.timerOf(
                    listener: (timer) => setState(() => _drumValue++),
                    style: const BeatsStyle.of16(
                      maxTick: 112,
                      sequences: [2, 9, 10, 12, 0],
                    ),
                  );

                  _beep = beats.timerOf(
                    listener: (timer) => setState(() => _beepValue++),
                    style: const BeatsStyle.of16(
                      maxTick: 1,
                      cycle: 2,
                      sequences: [2, 5, 18, 22],
                    ),
                  );
                }
              ),
            ]);
          },
          child: KIconMaterial.play,
        ),
        ElevatedButton(
          onPressed: () async {
            await player.stop();
            _timers.cancelAll();
          },
          child: KIconMaterial.stop,
        ),
        Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 32.0,
              color: Colors.white,
            ),
            child: Column(
              children: [
                Text(_stringValue.toString()),
                Text(_keyboardValue.toString()),
                Text(_hiHatTickValue.toString()),
                Text(_punchValue.toString()),
                Text(_drumValue.toString()),
                Text(_beepValue.toString()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
