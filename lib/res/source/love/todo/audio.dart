//
//
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// ///
// /// TODO: transfer arbitrary length audio into loopAble music chunk, according to beats duration, interval
// ///
// ///
//
// class MusicCounter extends StatefulWidget {
//   const MusicCounter({super.key});
//
//   @override
//   State<MusicCounter> createState() => _MusicCounterState();
// }
//
// class _MusicCounterState extends State<MusicCounter> {
//   late final AudioPlayer player;
//
//   Timer _string = VTimer.none;
//   Timer _hiHatTick = VTimer.none;
//   Timer _punch = VTimer.none;
//   Timer _drum = VTimer.none;
//   Timer _keyboard = VTimer.none;
//   Timer _beep = VTimer.none;
//   int _stringValue = 0;
//   int _hiHatTickValue = 0;
//   int _punchValue = 0;
//   int _drumValue = 0;
//   int _keyboardValue = 0;
//   int _beepValue = 0;
//
//   Iterable<Timer> get _timers => [
//     _hiHatTick,
//     _punch,
//     _drum,
//     _string,
//     _keyboard,
//     _beep,
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     player = AudioPlayer()..setPlayerMode(PlayerMode.mediaPlayer);
//     player.setSource(AssetSource(KStringAssetMusic.thatsTheWayLoveGoes));
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     player.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: () async {
//             await player.resume();
//
//             setState(() {
//               _stringValue = 0;
//               _keyboardValue = 0;
//               _hiHatTickValue = 0;
//               _punchValue = 0;
//               _drumValue = 0;
//               _beepValue = 0;
//             });
//
//             final duration = KDuration.milli306 * 8; // 2, 448 -> 4, 896 -> 7, 344 -> 9, 792
//             ///
//             /// (1): 0, 306  --- (1.5): 0, 459
//             /// (2): 0, 612  --- (2.5): 0, 765
//             /// (3): 0, 918  --- (3.5): 1, 071
//             /// (4): 1, 224  --- (4.5): 1, 459
//             /// (5): 1, 530  --- (5.5): 1, 683
//             /// (6): 1, 836  --- (6.5): 1, 989
//             /// (7): 2, 142  --- (7.5): 2, 295
//             /// (8): 2, 448
//             ///
//
//             final beats = Beats(duration);
//             Timer(
//               KDuration.second10 + KDuration.milli150 - duration,
//                   () {
//                 Timer(duration, () {
//                   _hiHatTick = beats.timerOf(
//                     maxTick: 57,
//                     listener: setStateOf(() => _hiHatTickValue++),
//                   );
//                   _punch = beats.timerOf(
//                     maxTick: 56,
//                     sequences: [3, 7],
//                     listener: setStateOf(() => _punchValue++),
//                   );
//                   _drum = beats.timerOf(
//                     interval: 16,
//                     maxTick: 112,
//                     sequences: [2, 9, 10, 12, 0],
//                     listener: setStateOf(() => _drumValue++),
//                   );
//
//                   _keyboard = beats.timerOf(
//                     interval: 16,
//                     maxTick: 112,
//                     cycle: 2,
//                     sequences: [2, 4, 5, 27, 29, 30, 0],
//                     listener: setStateOf(() => _keyboardValue++),
//                   );
//
//                   _string = beats.timerOf(
//                     interval: 16,
//                     maxTick: 76,
//                     cycle: 4,
//                     sequences: [2, 4, 6, 8, 9, 10, 11, 12],
//                     listener: setStateOf(() => _stringValue++),
//                   );
//
//                   _beep = beats.timerOf(
//                     interval: 16,
//                     maxTick: 0,
//                     cycle: 2,
//                     sequences: [2, 5, 18, 22],
//                     listener: setStateOf(() => _beepValue++),
//                   );
//                 });
//
//                 _string = beats.timerOf(
//                   maxTick: 8,
//                   sequences: [5, 7],
//                   listener: setStateOf(() => _stringValue++),
//                 );
//                 _keyboard = beats.timerOf(
//                   interval: 16,
//                   maxTick: 16,
//                   sequences: [11, 13, 14, 0],
//                   listener: setStateOf(() => _keyboardValue++),
//                 );
//               },
//             );
//           },
//           child: KIcon.play,
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             await player.stop();
//             _timers.cancelAll();
//           },
//           child: KIcon.stop,
//         ),
//         Center(
//           child: DefaultTextStyle(
//             style: const TextStyle(
//               fontSize: 32.0,
//               color: Colors.white,
//             ),
//             child: Column(
//               children: [
//                 Text(_stringValue.toString()),
//                 Text(_keyboardValue.toString()),
//                 Text(_hiHatTickValue.toString()),
//                 Text(_punchValue.toString()),
//                 Text(_drumValue.toString()),
//                 Text(_beepValue.toString()),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }