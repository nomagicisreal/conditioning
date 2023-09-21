import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:conditioning/res/source/source.dart';
import 'package:conditioning/res/usecase/usecase.dart';

///
/// this file contains:
///
///
/// results:
/// [TalunityLogo]
/// [TalunityLogoWithRecruitmentQRCode]
/// [TalunityRecruitment2023AutumnSemesterBeginPosterBackground], ...
/// [TalunityRecruitment2023AutumnSemesterBeginFilm], ...
///
/// ps. the results may be a little different because dependencies are updating
///
///
///
/// general constants:
/// [_KPromotionSize]
/// [_KPromotionColor]
/// [_KPromotionFlower]
///
///
///
///
///

class TalunityLogo extends StatelessWidget {
  const TalunityLogo({
    super.key,
    this.hasBackgroundColor = true,
  });

  final bool hasBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: hasBackgroundColor ? _KPromotionColor.layoutEndRed : null,
      child: Transform.rotate(
        angle: KRadian.angle_30,
        child: FClipPath.decoratedPolygon(
          decoration,
          polygon,
        ),
      ),
    );
  }

  static final double polygonCornerRadius = DoubleExtension.infinity2_31;
  static RRegularPolygon polygon = RRegularPolygonCubicOnEdge(
    6,
    radiusCircumscribedCircle: 70,
    cornerRadius: polygonCornerRadius,
    cubicPointsMapper: KMapperCubicPointsPermutation.p1230,
  );

  static const BoxDecoration decoration = BoxDecoration(
    gradient: LinearGradient(colors: [
      Colors.white,
      _KPromotionColor.logoBlue,
      _KPromotionColor.logoBlue,
      _KPromotionColor.logoGreen,
      _KPromotionColor.logoYellow,
      _KPromotionColor.logoYellow,
      Colors.white,
    ]),
  );
}

class TalunityLogoWithRecruitmentQRCode extends StatelessWidget {
  const TalunityLogoWithRecruitmentQRCode(this.dateTime, {super.key});

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: switch (dateTime.year) {
        2023 => switch (dateTime.month) {
            9 => CenterSizedBox.fromSize(
                size: KSize16Ratio9.w800_w450,
                child: Stack(
                  children: [
                    const SizedBox.expand(
                      child: ColoredBox(color: _KPromotionColor.layoutEndRed),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        KSizedBox.w140,
                        SizedBox(
                          width: 300,
                          child: Transform.rotate(
                            angle: KRadian.angle_30,
                            child: FClipPath.decoratedPolygon(
                              TalunityLogo.decoration,
                              TalunityLogo.polygon,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox.fromSize(
                              size: KSize.square_130,
                              child: ImageExtension.assetsInDimension(
                                KStringAssetImage.talunity_qr,
                                10,
                              ),
                            ),
                            SizedBox.fromSize(
                              size: KSize.square_100,
                              child: ImageExtension.assetsInDimension(
                                KStringAssetImage.talunity_recruitmentForm,
                                10,
                              ),
                            ),
                          ],
                        ),
                        KSizedBox.w140,
                      ],
                    ),
                  ],
                ),
              ),
            _ => throw UnimplementedError(),
          },
        _ => throw UnimplementedError(),
      },
    );
  }
}

///
///
///
///
/// [TalunityRecruitment2023AutumnSemesterBeginPosterBackground]
///
///
/// [_PromotionPosterFlower]
/// [_KPromotionPosterText]
/// [_PromotionPosterMessage]
/// [_PromotionPosterVibe]
///
///
///

class TalunityRecruitment2023AutumnSemesterBeginPosterBackground
    extends StatelessWidget {
  const TalunityRecruitment2023AutumnSemesterBeginPosterBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: KStringAssetFontFamily.yozai),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints.tight(_KPromotionSize.poster),
            color: _KPromotionColor.layoutStartBlue,
            child: const Stack(
              children: [
                _PromotionPosterFlower(),
                _PromotionPosterMessage(),
                _PromotionPosterVibe(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PromotionPosterFlower extends StatelessWidget {
  const _PromotionPosterFlower({
    super.key,
    this.shakerCount = 24,
  });

  final int shakerCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        shakerCount,
        (index) => Positioned.fromRect(
          rect: rectList[index],
          child: Opacity(
            opacity: 0.4,
            child: FClipPath.decoratedPolygon(
              _KPromotionFlower.decorationShaker,
              _KPromotionFlower.polygonShaker,
            ),
          ),
        ),
      ),
    );
  }

  List<Rect> get rectList => List.generate(
        shakerCount,
        (index) => Rect.fromLTWH(
          (index % 6) * 78 - 25,
          index * 12 -
              60 +
              (index > 11 ? _KPromotionSize.poster.height - 245 : 0),
          100,
          100,
        ),
      );
}

class _KPromotionPosterText {
  const _KPromotionPosterText._();

  static final ShapeDecoration decoration = ShapeDecoration(
    shape: KOutlinedBorderRounded.allCircular_20,
    gradient: LinearGradient(
      colors: [
        _KPromotionColor.layoutEndRed,
        _KPromotionColor.layoutEndRed.minusARGB(0, 30, 50, 70),
      ],
    ),
  );
}

class _PromotionPosterMessage extends StatelessWidget {
  const _PromotionPosterMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: _KPromotionSize.poster.height * 5 / 7,
        width: _KPromotionSize.poster.width * 5 / 6,
        decoration: _KPromotionPosterText.decoration,
        padding: KEdgeInsets.symH_32,
        child: SizedBox.expand(
          child: Transform(
            transform: Matrix4.identity()
              ..scale(0.6)
              ..translate(-35.0, -50.0),
            alignment: Alignment.topLeft,
            child: const SizedBox(
              height: 300,
              width: double.infinity,
              child: TalunityLogo(hasBackgroundColor: false),
            ),
          ),
        ),
      ),
    );
  }
}

class _PromotionPosterVibe extends StatelessWidget {
  const _PromotionPosterVibe({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [vibeOf(0), vibeOf(1)]);
  }

  Widget vibeOf(int index) => Positioned.fromRect(
        rect: _KPromotionFlower.rectListVibePoster[index],
        child: _KPromotionFlower.polygonsVibe[index],
      );
}

///
///
///
///
///
/// [TalunityRecruitment2023AutumnSemesterBeginFilm]
///
/// [_KPromotionFilmAudio]
/// [_PromotionFilmAudio]
/// [_PromotionFilmProcess]
/// [_KPromotionFilmCaption]
/// [_PromotionFilmMessageDelegate]
/// [_PromotionFilmMessageHolder]
/// [_PromotionFilmMessage]
/// [_PromotionFilmText]
/// [_PromotionFilmAssetEquationListsHolder]
/// [_PromotionFilmAssetEquationList]
/// [_PromotionFilmAssetEquation]
/// [_PromotionFilmVibesHolder]
/// [_PromotionFilmVibe]
/// [_PromotionFilmShakersHolder]
/// [_PromotionFilmShaker]
/// [_PromotionFilmLogo]
///
///
///
/// see [_PromotionFilmProcessState.isDev] for switch between dev mode and product mode
///
///

class TalunityRecruitment2023AutumnSemesterBeginFilm extends StatefulWidget {
  const TalunityRecruitment2023AutumnSemesterBeginFilm({super.key});

  @override
  State<TalunityRecruitment2023AutumnSemesterBeginFilm> createState() =>
      _TalunityRecruitment2023AutumnSemesterBeginFilmState();
}

class _TalunityRecruitment2023AutumnSemesterBeginFilmState
    extends State<TalunityRecruitment2023AutumnSemesterBeginFilm> {
  bool isPlay = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: KStringAssetFontFamily.yozai),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: Stack(
        children: [
          _PromotionFilmAudio(isPlay, _KPromotionFilmAudio.assetString),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => isPlay = !isPlay),
                    child: isPlay ? KIconMaterial.stop : KIconMaterial.play,
                  ),
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints.loose(_KPromotionSize.film),
                child: MyAnimation(
                  ani: Ani(
                    duration: KDurationFR.second50,
                    updateProcess: FAni.decideForward(isPlay),
                  ),
                  mation: Mation(
                    Between(
                      begin: _KPromotionColor.layoutStartBlue,
                      end: _KPromotionColor.layoutEndRed,
                    ),
                    builder: (animation, child) => Material(
                      color: animation.value,
                      child: child,
                    ),
                  ),
                  child: _PromotionFilmProcess(isPlay),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KPromotionFilmAudio {
  const _KPromotionFilmAudio._();

  static const String assetString = KStringAssetMusic.river;

  static const Duration section = KDuration.milli3833;
  static final Duration sectionQuarter = section ~/ 4;

  static BeatsOfInstrument beatsDrumBigOf(bool isDev) => BeatsOfInstrument(
        isDev ? KDuration.milli200 : section,
        interval: 8,
        sequences: [1, 4, 5],
      );

  static BeatsOfInstrument beatsVocalLikeARiverOf(bool isDev) =>
      BeatsOfInstrument(
        isDev ? KDuration.milli200 : section,
        interval: 16,
        sequences: [5, 7],
      );

  static BeatsOfInstrument beatsCrashOf(bool isDev) => BeatsOfInstrument(
        isDev ? KDuration.milli200 : section,
        interval: 8,
        sequences: [3, 7],
      );

  static const int intervalOfBreakIn8 = 4;
  static const int intervalOfRefrainIn8 = 64;
  static const int intervalOfBreakIn16 = intervalOfBreakIn8 * 2;
}

class _PromotionFilmAudio extends StatefulWidget {
  const _PromotionFilmAudio(this.isPlay, this.assetString);

  final bool isPlay;
  final String assetString;

  @override
  State<_PromotionFilmAudio> createState() => _PromotionFilmAudioState();
}

class _PromotionFilmAudioState extends State<_PromotionFilmAudio> {
  late final AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setSource(AssetSource(widget.assetString));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _PromotionFilmAudio oldWidget) {
    if (oldWidget.isPlay != widget.isPlay) {
      widget.isPlay ? player.resume() : player.stop();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => KSizedBox.none;
}

class _PromotionFilmProcess extends StatefulWidget {
  const _PromotionFilmProcess(this.isPlay, {super.key});

  final bool isPlay;

  @override
  State<_PromotionFilmProcess> createState() => _PromotionFilmProcessState();
}

class _PromotionFilmProcessState extends State<_PromotionFilmProcess> {
  late Timer _vocalLikeARiver = VTimer.none;
  late Timer _drumBig = VTimer.none;
  late Timer _crash = VTimer.none;
  final bool isDev = false;

  @override
  void didUpdateWidget(covariant _PromotionFilmProcess oldWidget) {
    if (widget.isPlay) {
      final durationList = isDev
          ? [
              KDuration.milli100,
              KDuration.second1,
              KDuration.second2,
              KDuration.second2,
              KDuration.second2,
              KDuration.second1,
              KDuration.second1,
            ]
          : [
              KDuration.milli820,
              // begin
              _KPromotionFilmAudio.section * 4,
              // like a river
              _KPromotionFilmAudio.section ~/ 2 + KDuration.milli100,
              // refrain 1-1 ~ 1-3
              _KPromotionFilmAudio.section * 3,
              // refrain 1-4
              _KPromotionFilmAudio.section,
              // refrain 2-1 ~ 2-2
              _KPromotionFilmAudio.section * 2,
              // refrain 2-3 ~ 2-4
              _KPromotionFilmAudio.section * 2 - KDuration.milli200,
            ];

      FTimer.nest([
        (durationList[0], _progressingText),
        (
          durationList[1],
          () => _vocalLikeARiver =
                  _KPromotionFilmAudio.beatsVocalLikeARiverOf(isDev).timerBy(
                listener: (_) => _progressVibing(),
                maxTick: _KPromotionFilmAudio.intervalOfBreakIn16,
              ),
        ),
        (
          durationList[2],
          () {
            _drumBig = _KPromotionFilmAudio.beatsDrumBigOf(isDev).timerBy(
              listener: (_) => _progressingText(),
              maxTick: 1,
            );
            _crash = _KPromotionFilmAudio.beatsCrashOf(isDev).timerBy(
              listener: (_) => _shaking(),
              maxTick: _KPromotionFilmAudio.intervalOfRefrainIn8 ~/ 2,
            );
          }
        ),
        (durationList[3], _progressingText),
        (
          durationList[4],
          () {
            _crash = _KPromotionFilmAudio.beatsCrashOf(isDev).timerBy(
              listener: FTimerProcessor.periodicProcessAfter(1, _shaking),
              maxTick: _KPromotionFilmAudio.intervalOfRefrainIn8 ~/ 2 -
                  _KPromotionFilmAudio.intervalOfRefrainIn8 ~/ 16,
            );

            _drumBig = _KPromotionFilmAudio.beatsDrumBigOf(isDev).timerBy(
              listener: (_) => _progressingEquation(),
              maxTick: 12,
            );
          },
        ),
        (
          durationList[5],
          () {
            _progressingText();
            _progressingEquation();
          },
        ),
        (durationList[6], _ending),
      ]);
    } else {
      progressText = 0;
      for (var t in [_crash, _drumBig, _vocalLikeARiver]) {
        t.cancel();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  int progressText = 0;
  int progressVibe = -1;
  int progressEquation = 0;
  bool shakingTrigger = false;

  void _progressingText() => setState(() {
        progressText += 1;
        shakingTrigger = false;
      });

  void _progressingEquation() => setState(() => progressEquation++);

  void _progressVibing() => setState(() => progressVibe++);

  void _ending() => setState(() {
        progressText = 100;
        progressVibe = -1;
      });

  void _shaking() => setState(() => shakingTrigger = true);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        KSizedBox.expand,
        _PromotionFilmShakersHolder(shakingTrigger, progressText),
        _PromotionFilmMessageHolder(progressText, progressEquation),
        _PromotionFilmAssetEquationListsHolder(progressEquation),
        _PromotionFilmVibesHolder(progressVibe),
        _PromotionFilmLogo(progressText),
      ],
    );
  }
}

///
///
/// message,
/// [_KPromotionFilmCaption]
/// [_PromotionFilmMessageDelegate]
/// [_PromotionFilmMessageHolder]
/// [_PromotionFilmMessage]
/// [_PromotionFilmText]
///
///

class _KPromotionFilmCaption {
  const _KPromotionFilmCaption._();

  static const chapter1 = """
自從「黑客松」概念廣為人知以來，
數發部 2022 開始舉辦「點子松」。

同樣為了宣揚「共創、共榮」的理念，
於是「英才社群」也在 2023 暑假誕生了！

「英才社群」希望以經營社群的方式，
定期舉辦有趣的「飛舞」活動！
用「社群」這種更親切的模式，
提供一個大家能安心想像未來的場域！
  """;

  static const chapter2 = """
英才社群的第一次「飛舞」目前預計會辦在 2024 年１月，該次的飛舞主題（or 活動主題）是 "App"，目前正在招募首波「精靈（飛舞籌備人員）」！

希望該次「飛舞」能圍繞 App 這樣的主題，建立共創、共榮的討論環境、遊戲場景，能開放所有人參加！！
  """;

  static const chapter3 = """
精靈的報名身份不限！
只要對未來 App 的發展很有想法，
或者懂得批判現有 App 的優劣差異，
都歡迎報名喔！
  """;

  static const chapter4 = """
「精靈」團隊火熱招募中！

期初報名表單截至 09/22 日落！
期初完成報名才能 100% 通過「精靈面談」！

如果錯過期初報名，
在學期之間的報名，
就必須準備「精靈面試」。
屆時為了提高「破風（籌備飛舞的過程）」品質，
如果面試未被錄取，
還請見諒！
  """;
}

class _PromotionFilmMessageDelegate {
  final int index;

  const _PromotionFilmMessageDelegate(this.index);

  Color get _colorPage => switch (index) {
        1 => _KPromotionColor.layoutStartBlue,
        2 => _KPromotionColor.layoutEndRed.minusARGB(0, 70, 70, 50),
        3 => _KPromotionColor.layoutEndRed.minusARGB(0, 20, 20, 20),
        4 => _KPromotionColor.layoutEndRed,
        _ => throw UnimplementedError(),
      };

  Decoration get decorationPage => ShapeDecoration(
        shape: KOutlinedBorderRounded.allCircular_20,
        gradient: LinearGradient(
          colors: [_colorPage, _colorPage.minusARGB(0, 0, 0, 30)],
        ),
      );

  EdgeInsetsGeometry get paddingPage => switch (index) {
        1 => KEdgeInsets.symH_16,
        _ => KEdgeInsets.symH_32,
      };

  Duration get durationContainer => switch (index) {
        1 => KDuration.second1,
        2 => KDuration.second2,
        3 || 4 => KDuration.milli800,
        _ => throw UnimplementedError(),
      };

  DurationFR get durationPageFadeInFadeOut =>
      DurationFR(durationPageFadeIn, durationPageFadeOut);

  Duration get durationPageFadeIn => switch (index) {
        4 => KDuration.milli800,
        _ => KDuration.second1,
      };

  Duration get durationPageFadeOut => switch (index) {
        4 => _PromotionFilmLogo.forward,
        _ => durationPageFadeIn,
      };

  Duration get durationTextSpeed => switch (index) {
        1 => KDuration.milli120,
        2 => KDuration.milli80,
        3 => KDuration.milli60,
        4 => KDuration.milli50,
        _ => throw UnimplementedError(),
      };

  String get text => switch (index) {
        1 => _KPromotionFilmCaption.chapter1,
        2 => _KPromotionFilmCaption.chapter2,
        3 => _KPromotionFilmCaption.chapter3,
        4 => _KPromotionFilmCaption.chapter4,
        _ => throw UnimplementedError(),
      };

  Curve get textCurve => switch (index) {
        1 => Curves.easeInOut,
        2 => Curves.linear,
        3 => Curves.bounceOut,
        _ => Curves.linear,
      };

  TextStyle textStyleOf(BuildContext context) => switch (index) {
        1 => context.textTheme.titleMedium!.copyWith(color: Colors.white),
        2 => context.textTheme.titleMedium!.copyWith(color: Colors.black),
        3 => context.textTheme.titleMedium!.copyWith(color: Colors.black87),
        4 => context.textTheme.titleSmall!
            .copyWith(color: Colors.black.withOpacity(0.8)),
        _ => throw UnimplementedError(),
      };
}

class _PromotionFilmMessageHolder extends StatelessWidget {
  const _PromotionFilmMessageHolder(
    this.progress,
    this.progressEquation, {
    super.key,
  });

  final int progress;
  final int progressEquation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        4,
        (index) => _PromotionFilmMessage(
          messages[index],
          progress,
          index == 1 ? progressEquation : 0, // delegate 3
        ),
      ),
    );
  }

  static const List<_PromotionFilmMessageDelegate> messages = [
    _PromotionFilmMessageDelegate(4),
    _PromotionFilmMessageDelegate(3),
    _PromotionFilmMessageDelegate(2),
    _PromotionFilmMessageDelegate(1),
  ];
}

class _PromotionFilmMessage extends StatelessWidget {
  const _PromotionFilmMessage(
    this.delegate,
    this.progress,
    this.progressEquation, {
    super.key,
  });

  final _PromotionFilmMessageDelegate delegate;
  final int progress;
  final int progressEquation;

  @override
  Widget build(BuildContext context) {
    return transitionOf(childOf(context));
  }

  Widget transitionOf(Widget child) => MyAnimation(
        ani: AniProgressTernary(
          delegate: delegate.index,
          duration: delegate.durationPageFadeInFadeOut,
          comparison: FTernaryPredicatorComparison.intEqualOrSmallerOrBigger,
        )..current = progress,
        mation: MationTransitionDouble.fadeIn(),
        child: MyAnimation(
          ani: AniProgressBool(
            delegate: delegate.index,
            duration: DurationFR.constant(delegate.durationPageFadeIn),
            comparison: FPredicatorComparison.intEqual,
          )..current = progress - 1,
          mation: MationTransform(
            translateBetween: FBetweenCoordinate.fromZeroTo(
              KCoordinateDirection.front * 300,
            ),
            rotateBetween: FBetweenCoordinate.fromZeroTo(
              KRadianCoordinate.angleX_90 + KRadianCoordinate.angleZ_270,
            ),
            rotateAlignment: Alignment.center,
          ),
          child: child,
        ),
      );

  Widget childOf(BuildContext context) => Center(
        child: AnimatedContainer(
          duration: delegate.durationContainer,
          height: _KPromotionSize.film.height * 3 / 5,
          width: _KPromotionSize.film.width * 4 / 5,
          decoration: delegate.decorationPage,
          padding: delegate.paddingPage,
          child: delegate.index.isSmallerOrEqualTo(progress)
              ? switch (delegate.index) {
                  3 => MyAnimation(
                      ani: AniProgressBool(
                        delegate: 1,
                        comparison: FPredicatorComparison.intEqual,
                      )..current = progressEquation,
                      mation: Mations<dynamic, Mation>([
                        MationTransitionAlign(
                          begin: Alignment.center,
                          end: Alignment.topCenter,
                        ),
                        MationTransitionOffset.fromZeroTo(
                          KOffsetDirection.bottom * 0.08,
                        ),
                      ]),
                      child: _textOf(context),
                    ),
                  _ => Center(child: _textOf(context)),
                }
              : KSizedBox.none,
        ),
      );

  Widget _textOf(BuildContext context) => _PromotionFilmText(
        text: delegate.text,
        textStyle: delegate.textStyleOf(context),
        speed: delegate.durationTextSpeed,
        curve: delegate.textCurve,
      );
}

class _PromotionFilmText extends StatelessWidget {
  const _PromotionFilmText({
    super.key,
    required this.text,
    required this.textStyle,
    required this.speed,
    required this.curve,
  });

  final String text;
  final TextStyle textStyle;
  final Duration speed;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: textStyle,
      child: AnimatedTextKit(
        totalRepeatCount: 1,
        animatedTexts: [
          TypewriterAnimatedText(
            text,
            speed: speed,
            curve: curve,
          )
        ],
      ),
    );
  }
}

///
///
/// equation
/// [_PromotionFilmAssetEquationListsHolder]
/// [_PromotionFilmAssetEquationList]
/// [_PromotionFilmAssetEquation]
///

class _PromotionFilmAssetEquationListsHolder extends StatelessWidget {
  const _PromotionFilmAssetEquationListsHolder(
    this.progressText, {
    super.key,
    this.logoDimension = 50,
    this.logoEquationDistance = 30,
    this.translation = 2,
    Size? size,
  }) : _size = size;
  final int progressText;

  final double logoDimension;
  final double logoEquationDistance;
  final double translation;
  final Size? _size;

  Size get size =>
      _size ?? Size(300, logoDimension * 4 + logoEquationDistance * 4);

  List<_PromotionFilmAssetEquation> get assetEquations => [
        _PromotionFilmAssetEquation(
          assetA: KStringAssetImage.logo_instagram,
          assetB: KStringAssetImage.logo_line,
          dimension: logoDimension,
        ),
        _PromotionFilmAssetEquation(
          assetA: KStringAssetImage.logo_discord,
          assetB: KStringAssetImage.logo_timetree,
          dimension: logoDimension,
        ),
        _PromotionFilmAssetEquation(
          assetA: KStringAssetImage.logo_youtube,
          assetB: KStringAssetImage.logo_notion,
          dimension: logoDimension,
        ),
        _PromotionFilmAssetEquation(
          assetA: KStringAssetImage.logo_pokemon,
          assetB: KStringAssetImage.logo_maumiwar,
          dimension: logoDimension,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [equationOf(4), equationOf(3), equationOf(2), equationOf(1)],
    );
  }

  Widget equationOf(int delegate) => _PromotionFilmAssetEquationList(
        delegate,
        rect: RectExtension.fromLTSize(70, 300, size),
        builder: transitionOf(delegate),
        children: (i) => SizedBox(
          height: logoDimension + logoEquationDistance,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              i + 1 == delegate
                  ? assetEquations[i]
                  : SizedBox(height: logoDimension),
              i < 3 ? SizedBox(height: logoEquationDistance) : KSizedBox.none,
            ],
          ),
        ),
      );

  TransitionBuilder transitionOf(int delegate) => (context, child) =>
      MyAnimationSin.flicker(
        amplitudeOpacity: 0.0,
        times: 2,
        duration: _KPromotionFilmAudio.sectionQuarter.toFR,
        updateListener: FAni.decideForwardReset(progressText == 5),
        child: MyAnimation(
          ani: AniProgressTernary(
            delegate: delegate,
            hear: FAni.decideForwardOrReverse,
            comparison: FTernaryPredicatorComparison.intEqualOrSmallerOrBigger,
          )..current = switch (progressText) {
              0 => 0,
              6 => delegate + 1,
              _ => progressText == delegate ? progressText : 0,
            },
          mation: MationTransitionDouble.fadeIn(),
          child: ClipPath(
            clipper: FMyClipper.rectFromZeroTo(size.toOffset),
            child: MyAnimation(
              ani: AniProgressBool(
                delegate: delegate,
                duration:
                    DurationFR.constant(_KPromotionFilmAudio.sectionQuarter),
                hear: FAni.decideForward,
                comparison: FPredicatorComparison.intEqual,
              )..current = progressText,
              mation: MationTransitionOffset.toZeroFrom(
                KOffsetDirection.right * translation,
              ),
              child: SizedBox(
                height: size.height,
                width: translation,
                child: child,
              ),
            ),
          ),
        ),
      );
}

class _PromotionFilmAssetEquationList extends StatelessWidget {
  const _PromotionFilmAssetEquationList(
    this.delegate, {
    super.key,
    required this.rect,
    required this.builder,
    required this.children,
  });

  final int delegate;
  final Rect rect;
  final TransitionBuilder builder;
  final Generator<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: rect,
      child: builder(
        context,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            delegate,
            (index) => children(index),
          ),
        ),
      ),
    );
  }
}

class _PromotionFilmAssetEquation extends StatelessWidget {
  const _PromotionFilmAssetEquation({
    super.key,
    required this.assetA,
    required this.assetB,
    required this.dimension,
  });

  final String assetA;
  final String assetB;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageExtension.assetsInDimension(assetA, dimension),
        KSizedBox.w30,
        KIconCupertinoIcons.plus,
        KSizedBox.w30,
        ImageExtension.assetsInDimension(assetB, dimension),
        KSizedBox.w30,
        KIconCupertinoIcons.equal,
        KSizedBox.w10,
        KIconCupertinoIcons.question,
      ],
    );
  }
}

///
///
/// vibe
/// [_PromotionFilmVibesHolder]
/// [_PromotionFilmVibe]
///
///

class _PromotionFilmVibesHolder extends StatelessWidget {
  const _PromotionFilmVibesHolder(this.progress, {super.key});

  final int progress;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [vibeOf(1), vibeOf(0)]);
  }

  Widget vibeOf(int index) => _PromotionFilmVibe(
        index,
        progress,
        rectList: _KPromotionFlower.rectListVibeFilm,
        children: _KPromotionFlower.polygonsVibe,
      );
}

class _PromotionFilmVibe extends StatelessWidget {
  const _PromotionFilmVibe(
    this.delegate,
    this.progress, {
    super.key,
    required this.rectList,
    required this.children,
  });

  final int delegate;
  final int progress;
  final List<Rect> rectList;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: rectList[delegate],
      child: MyAnimation(
        ani: AniProgressBool(
          delegate: delegate,
          hear: FAni.decideForward,
          comparison: FPredicatorComparison.intEqual,
        )..current = progress,
        mation: MationTransitionOffset.toZeroFrom(
          switch (delegate) {
            0 => KOffsetDirection.left * 2 + KOffsetDirection.top * 0.5,
            1 => KOffsetDirection.right * 1.5 + KOffsetDirection.bottom * 1,
            _ => throw UnimplementedError(),
          },
        ),
        child: MyAnimation(
          ani: AniProgressBool(
            delegate: delegate,
            duration: const DurationFR.constant(_KPromotionFilmAudio.section),
            hear: FAni.decideForwardReset,
            comparison: FPredicatorComparison.intEqual,
          )..current = progress == -1 ? -1 : delegate,
          mation: MationTransitionDouble.rotateBeginOrEndZero(
            1,
            isEndZero: delegate == 1,
            alignment: Alignment.topLeft,
            curve: KCurveFR.linear,
          ),
          child: children[delegate],
        ),
      ),
    );
  }
}

///
///
/// shaker
/// [_PromotionFilmShakersHolder]
/// [_PromotionFilmShaker]
///
///
///

class _PromotionFilmShakersHolder extends StatelessWidget {
  const _PromotionFilmShakersHolder(
    this.trigger,
    this.progress, {
    super.key,
    this.shakerCount = 24,
  });

  final bool trigger;
  final int progress;
  final int shakerCount;

  @override
  Widget build(BuildContext context) {
    return MyAnimation(
      ani: AniProgressBool(
        delegate: 1,
        hear: FAni.decideForwardReset,
        comparison: FPredicatorComparison.intSmaller,
      )..current = trigger || progress == 100 ? 0 : progress,
      mation: MationTransitionDouble.rotateFromZeroTo(KRadian.angle_360),
      child: Stack(
        children: List.generate(
          shakerCount,
          (index) => _PromotionFilmShaker(
            trigger,
            progress,
            rectList[index],
          ),
        ),
      ),
    );
  }

  List<Rect> get rectList => List.generate(
        shakerCount,
        (index) => Rect.fromLTWH(
          (index % 6) * 78 - 25,
          index * 12 -
              60 +
              (index > 11 ? _KPromotionSize.film.height - 260 : 0),
          100,
          100,
        ),
      );
}

class _PromotionFilmShaker extends StatelessWidget {
  const _PromotionFilmShaker(
    this.trigger,
    this.progress,
    this.rect, {
    super.key,
  });

  final bool trigger;
  final int progress;
  final Rect rect;

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: rect,
      child: Opacity(
        opacity: 0.3,
        child: MyAnimationSin.shaker(
          updateListener: FAni.decideForwardReset(trigger),
          amplitudeRadian: KRadian.angle_1 * 9,
          times: 6,
          duration: KDuration.milli360.toFR,
          child: FClipPath.decoratedPolygon(
            _KPromotionFlower.decorationShaker,
            _KPromotionFlower.polygonShaker,
          ),
        ),
      ),
    );
  }
}

class _PromotionFilmLogo extends StatelessWidget {
  static const Duration forward = KDuration.milli900;
  static const DurationFR duration = KDurationFR.milli900;

  _PromotionFilmLogo(
    this.progress, {
    super.key,
    double? polygonCornerRadiusBegin,
  }) : polygonCornerRadiusBegin =
            polygonCornerRadiusBegin ?? DoubleExtension.infinity3_2;

  final int progress;
  final double polygonCornerRadiusBegin;

  @override
  Widget build(BuildContext context) {
    final ani = AniProgressBool(
      delegate: 100,
      duration: duration,
      comparison: FPredicatorComparison.intEqual,
    )..current = progress;
    return MyAnimation(
      ani: ani,
      mation: MationTransitionDouble.fadeIn(),
      child: Container(
        color: _KPromotionColor.layoutEndRed,
        child: Transform.rotate(
          angle: KRadian.angle_30,
          child: MyAnimation(
            ani: ani,
            mation: MationClipper(
              BetweenRRegularPolygon(
                cornerRadius: Between(
                  begin: polygonCornerRadiusBegin,
                  end: TalunityLogo.polygonCornerRadius,
                  curve: KCurveFR.ease,
                ),
                polygon: TalunityLogo.polygon,
              ),
            ),
            child: OverflowBox(
              maxHeight: 1000,
              maxWidth: 600,
              child: Container(
                decoration: TalunityLogo.decoration,
                child: KSizedBox.expand,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
/// constants
///

extension _KPromotionSize on Size {
  static final poster = KSizePaperCM.a1 * 7;
  static const film = KSize9Ratio16.w450_h800;
}

extension _KPromotionColor on Color {
  static const Color layoutStartBlue = Color(0xFF111155);
  static const Color layoutEndRed = Color(0xFFffdddd);
  static const Color logoYellow = Color(0xffccbb22);
  static const Color logoGreen = Color(0xFF88aa88);
  static const Color logoBlue = Color(0xFF6666cc);
}

extension _KPromotionFlower on RRegularPolygon {
  static final RRegularPolygon polygonShaker = RRegularPolygonCubicOnEdge(
    9,
    radiusCircumscribedCircle: 40,
    cornerRadius: double.infinity.filterInfinity(2.1),
    cubicPointsMapper: KMapperCubicPointsPermutation.p1230,
  );

  static final List<Widget> polygonsVibe = [
    FCustomPaint.polygonCanvasSizeToPaint(
      RRegularPolygonCubicOnEdge(
        5,
        radiusCircumscribedCircle: 30,
        cornerRadius: 60,
      ),
      polygonVibePaint,
    ),
    FCustomPaint.polygonCanvasSizeToPaint(
      RRegularPolygonCubicOnEdge(
        7,
        radiusCircumscribedCircle: 20,
        cornerRadius: 60,
      ),
      polygonVibePaint,
    ),
  ];

  static const Decoration decorationShaker = BoxDecoration(
    gradient: RadialGradient(colors: [Color(0xFFcc8866), Color(0xff8866cc)]),
  );

  static const List<Rect> rectListVibeFilm = [
    Rect.fromLTWH(50, 160, 40, 40),
    Rect.fromLTWH(390, 610, 40, 40),
  ];

  static const List<Rect> rectListVibePoster = [
    Rect.fromLTWH(50, 510, 40, 40),
    Rect.fromLTWH(380, 520, 40, 40),
  ];

  static Paint polygonVibePaint(Canvas canvas, Size size) => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..color = Colors.white70;
}
