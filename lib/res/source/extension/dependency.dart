part of source;

///
/// this file contains:
/// [SampleAnimatedTextKit]
/// [SampleAudioPlayer]
/// [CustomLaTex]
///
///
/// TODO: condense animated text to [MationText]
///

// class SampleAnimatedTextKit extends StatelessWidget {
//   const SampleAnimatedTextKit({
//     super.key,
//     this.fontSize = 32.0,
//   });
//
//   final double fontSize;
//
//   @override
//   Widget build(BuildContext context) {
//     final textStyle = TextStyle(fontSize: fontSize);
//     return DefaultTextStyle(
//       style: textStyle,
//       child: AnimatedTextKit(
//         pause: Duration.zero,
//         isRepeatingAnimation: true,
//         repeatForever: true,
//         animatedTexts: [
//           RotateAnimatedText("Hello"),
//           FadeAnimatedText("Hello"),
//           TyperAnimatedText("Hello"),
//           TypewriterAnimatedText("Hello"),
//           ScaleAnimatedText("Hello"),
//           ColorizeAnimatedText(
//             "Hello",
//             textStyle: textStyle,
//             colors: [Colors.blue, Colors.orange],
//           ),
//           WavyAnimatedText("Hello"),
//           FlickerAnimatedText("Hello"),
//         ],
//       ),
//     );
//   }
// }


// class CustomLaTex extends StatelessWidget {
//   const CustomLaTex(
//     this.string, {
//     super.key,
//     this.engine = const TeXViewRenderingEngine.katex(),
//     this.style,
//   });
//
//   final String string;
//   final TeXViewRenderingEngine? engine;
//   final TeXViewStyle? style;
//
//   factory CustomLaTex.advance(
//     String string, {
//     TeXViewStyle? style,
//   }) =>
//       CustomLaTex(
//         string,
//         engine: const TeXViewRenderingEngine.mathjax(),
//         style: style,
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return TeXView(
//       renderingEngine: engine,
//       style: style,
//       child: TeXViewDocument(
//         r"$$"
//         "$string"
//         r"$$",
//       ),
//     );
//   }
// }

// class SampleAudioPlayer extends StatefulWidget {
//   const SampleAudioPlayer({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<SampleAudioPlayer> createState() => _SampleAudioPlayerState();
// }
//
// class _SampleAudioPlayerState extends State<SampleAudioPlayer> {
//   final player = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//
//   String formatTime(int seconds) {
//     return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     player.onPlayerStateChanged.listen((state) {
//       setState(() {
//         isPlaying = state == PlayerState.playing;
//       });
//     });
//
//     player.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//     });
//
//     player.onPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 25,
//                   child: IconButton(
//                     icon: Icon(
//                       isPlaying ? Icons.pause : Icons.play_arrow,
//                     ),
//                     onPressed: (){
//                       if(isPlaying)
//                       {
//                         player.pause();
//                       }
//                       else{
//                         player.play(AssetSource('theme_01.mp3'));
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 20,),
//                 CircleAvatar(
//                   radius: 25,
//                   child: IconButton(
//                     icon:const Icon(Icons.stop),
//                     onPressed: (){
//                       player.stop();
//                     },
//                   ),
//                 ),
//
//
//               ],
//             ),
//             Slider(
//               min: 0,
//               max: duration.inSeconds.toDouble(),
//               value: position.inSeconds.toDouble(),
//               onChanged: (value) {
//                 final position = Duration(seconds: value.toInt());
//                 player.seek(position);
//                 player.resume();
//               },
//             ),
//             Container(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(formatTime(position.inSeconds)),
//                   Text(formatTime((duration - position).inSeconds)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
