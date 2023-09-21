// ignore_for_file: non_constant_identifier_names, constant_identifier_names

part of source;

///
/// this file contains:
/// [KDuration], [KDurationFR]
///
/// [VCurve], [KInterval], [KCurveFR], [KCurveFRConstantInterval]
///
/// [FBetweenDouble], [FBetweenOffset], [FBetweenCoordinate], [FBetweenCoordinateRadian]
/// [FAni], [FAnimationStatusListener], [FOnAnimatingProcessor]
/// [KAniInitForward], [KAniInitRepeat], [KAniInitRepeatReverse]...
///
/// [VTimer], [FTimer], [FTimerProcessor]
///
/// [FDateTime],
///
///

extension KDuration on Duration {
  static const milli5 = Duration(milliseconds: 5);
  static const milli10 = Duration(milliseconds: 10);
  static const milli20 = Duration(milliseconds: 20);
  static const milli30 = Duration(milliseconds: 30);
  static const milli40 = Duration(milliseconds: 40);
  static const milli50 = Duration(milliseconds: 50);
  static const milli60 = Duration(milliseconds: 60);
  static const milli70 = Duration(milliseconds: 70);
  static const milli80 = Duration(milliseconds: 80);
  static const milli90 = Duration(milliseconds: 90);
  static const milli100 = Duration(milliseconds: 100);
  static const milli110 = Duration(milliseconds: 110);
  static const milli120 = Duration(milliseconds: 120);
  static const milli130 = Duration(milliseconds: 130);
  static const milli140 = Duration(milliseconds: 140);
  static const milli150 = Duration(milliseconds: 150);
  static const milli160 = Duration(milliseconds: 160);
  static const milli170 = Duration(milliseconds: 170);
  static const milli180 = Duration(milliseconds: 180);
  static const milli190 = Duration(milliseconds: 190);
  static const milli200 = Duration(milliseconds: 200);
  static const milli210 = Duration(milliseconds: 210);
  static const milli220 = Duration(milliseconds: 220);
  static const milli230 = Duration(milliseconds: 230);
  static const milli240 = Duration(milliseconds: 240);
  static const milli250 = Duration(milliseconds: 250);
  static const milli260 = Duration(milliseconds: 260);
  static const milli270 = Duration(milliseconds: 270);
  static const milli280 = Duration(milliseconds: 280);
  static const milli290 = Duration(milliseconds: 290);
  static const milli295 = Duration(milliseconds: 295);
  static const milli300 = Duration(milliseconds: 300);
  static const milli306 = Duration(milliseconds: 306);
  static const milli307 = Duration(milliseconds: 307);
  static const milli308 = Duration(milliseconds: 308);
  static const milli310 = Duration(milliseconds: 310);
  static const milli320 = Duration(milliseconds: 320);
  static const milli330 = Duration(milliseconds: 330);
  static const milli335 = Duration(milliseconds: 335);
  static const milli340 = Duration(milliseconds: 340);
  static const milli350 = Duration(milliseconds: 350);
  static const milli360 = Duration(milliseconds: 360);
  static const milli370 = Duration(milliseconds: 370);
  static const milli380 = Duration(milliseconds: 380);
  static const milli390 = Duration(milliseconds: 390);
  static const milli400 = Duration(milliseconds: 400);
  static const milli410 = Duration(milliseconds: 410);
  static const milli420 = Duration(milliseconds: 420);
  static const milli430 = Duration(milliseconds: 430);
  static const milli440 = Duration(milliseconds: 440);
  static const milli450 = Duration(milliseconds: 450);
  static const milli460 = Duration(milliseconds: 460);
  static const milli466 = Duration(milliseconds: 466);
  static const milli467 = Duration(milliseconds: 467);
  static const milli468 = Duration(milliseconds: 468);
  static const milli470 = Duration(milliseconds: 470);
  static const milli480 = Duration(milliseconds: 480);
  static const milli490 = Duration(milliseconds: 490);
  static const milli500 = Duration(milliseconds: 500);
  static const milli600 = Duration(milliseconds: 600);
  static const milli700 = Duration(milliseconds: 700);
  static const milli800 = Duration(milliseconds: 800);
  static const milli810 = Duration(milliseconds: 810);
  static const milli820 = Duration(milliseconds: 820);
  static const milli830 = Duration(milliseconds: 830);
  static const milli840 = Duration(milliseconds: 840);
  static const milli850 = Duration(milliseconds: 850);
  static const milli860 = Duration(milliseconds: 860);
  static const milli870 = Duration(milliseconds: 870);
  static const milli880 = Duration(milliseconds: 880);
  static const milli890 = Duration(milliseconds: 890);
  static const milli900 = Duration(milliseconds: 900);
  static const milli910 = Duration(milliseconds: 910);
  static const milli920 = Duration(milliseconds: 920);
  static const milli930 = Duration(milliseconds: 930);
  static const milli940 = Duration(milliseconds: 940);
  static const milli950 = Duration(milliseconds: 950);
  static const milli960 = Duration(milliseconds: 960);
  static const milli970 = Duration(milliseconds: 970);
  static const milli980 = Duration(milliseconds: 980);
  static const milli990 = Duration(milliseconds: 990);
  static const second1 = Duration(seconds: 1);
  static const milli1100 = Duration(milliseconds: 1100);
  static const milli1200 = Duration(milliseconds: 1200);
  static const milli1300 = Duration(milliseconds: 1300);
  static const milli1400 = Duration(milliseconds: 1400);
  static const milli1500 = Duration(milliseconds: 1500);
  static const milli1600 = Duration(milliseconds: 1600);
  static const milli1700 = Duration(milliseconds: 1700);
  static const milli1800 = Duration(milliseconds: 1800);
  static const milli1900 = Duration(milliseconds: 1900);
  static const milli1933 = Duration(milliseconds: 1933);
  static const milli1934 = Duration(milliseconds: 1934);
  static const milli1936 = Duration(milliseconds: 1936);
  static const milli1940 = Duration(milliseconds: 1940);
  static const milli1950 = Duration(milliseconds: 1950);
  static const second2 = Duration(seconds: 2);
  static const milli2100 = Duration(milliseconds: 2100);
  static const milli2200 = Duration(milliseconds: 2200);
  static const milli2300 = Duration(milliseconds: 2300);
  static const milli2400 = Duration(milliseconds: 2400);
  static const milli2500 = Duration(milliseconds: 2500);
  static const milli2600 = Duration(milliseconds: 2600);
  static const milli2700 = Duration(milliseconds: 2700);
  static const milli2800 = Duration(milliseconds: 2800);
  static const milli2900 = Duration(milliseconds: 2900);
  static const second3 = Duration(seconds: 3);
  static const milli3800 = Duration(milliseconds: 3800);
  static const milli3822 = Duration(milliseconds: 3822);
  static const milli3833 = Duration(milliseconds: 3833);
  static const milli3866 = Duration(milliseconds: 3866);
  static const second4 = Duration(seconds: 4);
  static const second5 = Duration(seconds: 5);
  static const second6 = Duration(seconds: 6);
  static const second7 = Duration(seconds: 7);
  static const second8 = Duration(seconds: 8);
  static const second9 = Duration(seconds: 9);
  static const second10 = Duration(seconds: 10);
  static const second14 = Duration(seconds: 14);
  static const second15 = Duration(seconds: 15);
  static const second20 = Duration(seconds: 20);
  static const second30 = Duration(seconds: 30);
  static const second40 = Duration(seconds: 40);
  static const second50 = Duration(seconds: 40);
  static const min1 = Duration(minutes: 1);
}

extension KDurationFR on DurationFR {
  static const milli100 = DurationFR.constant(KDuration.milli100);
  static const milli200 = DurationFR.constant(KDuration.milli200);
  static const milli300 = DurationFR.constant(KDuration.milli300);
  static const milli400 = DurationFR.constant(KDuration.milli400);
  static const milli500 = DurationFR.constant(KDuration.milli500);
  static const milli600 = DurationFR.constant(KDuration.milli600);
  static const milli700 = DurationFR.constant(KDuration.milli700);
  static const milli800 = DurationFR.constant(KDuration.milli800);
  static const milli900 = DurationFR.constant(KDuration.milli900);
  static const second1 = DurationFR.constant(KDuration.second1);
  static const second2 = DurationFR.constant(KDuration.second2);
  static const second3 = DurationFR.constant(KDuration.second3);
  static const second4 = DurationFR.constant(KDuration.second4);
  static const second5 = DurationFR.constant(KDuration.second5);
  static const second6 = DurationFR.constant(KDuration.second6);
  static const second7 = DurationFR.constant(KDuration.second7);
  static const second8 = DurationFR.constant(KDuration.second8);
  static const second9 = DurationFR.constant(KDuration.second9);
  static const second10 = DurationFR.constant(KDuration.second10);
  static const second20 = DurationFR.constant(KDuration.second20);
  static const second30 = DurationFR.constant(KDuration.second30);
  static const second40 = DurationFR.constant(KDuration.second40);
  static const second50 = DurationFR.constant(KDuration.second50);
  static const min1 = DurationFR.constant(KDuration.min1);

  static const second1_second2 =
      DurationFR(KDuration.second1, KDuration.second2);
}

///
///
///
/// curve
///
///
///

extension VCurve on Curve {
  static Curve get sin_3_04 => MyCurve(
        FMapperDouble.sinFromFactor(3, 0.4),
      );
}

extension KInterval on Interval {
  static const easeInOut_00_04 = Interval(0, 0.4, curve: Curves.easeInOut);
  static const easeInOut_00_05 = Interval(0, 0.5, curve: Curves.easeInOut);
  static const easeOut_00_06 = Interval(0, 0.6, curve: Curves.easeOut);
  static const easeInOut_02_08 = Interval(0.2, 0.8, curve: Curves.easeInOut);
  static const easeInOut_04_10 = Interval(0.4, 1, curve: Curves.easeInOut);
  static const fastOutSlowIn_00_05 =
      Interval(0, 0.5, curve: Curves.fastOutSlowIn);
}

extension KCurveFR on CurveFR {
  static const linear = CurveFR.constant(Curves.linear);
  static const fastOutSlowIn = CurveFR.constant(Curves.fastOutSlowIn);
  static const ease = CurveFR.constant(Curves.ease);
  static const easeInOut = CurveFR.constant(Curves.easeInOut);
  static const easeInSine = CurveFR.constant(Curves.easeInSine);
  static const easeInQuad = CurveFR.constant(Curves.easeInQuad);
  static const easeInQuart = CurveFR.constant(Curves.easeInQuart);
  static const fastOutSlowIn_easeOutQuad =
      CurveFR(Curves.fastOutSlowIn, Curves.easeOutQuad);
}

extension KCurveFRConstantInterval on Interval {
  static const easeInOut_00_04 = CurveFR.constant(KInterval.easeInOut_00_04);
}

///
///
/// between
///
///

extension FBetweenDouble on Between<double> {
  static Between<double> get zero => Between.constant(0);

  static Between<double> get k1 => Between.constant(1);

  static Between<double> toZeroFrom(double v) => Between(begin: v, end: 0);

  static Between<double> fromZeroTo(double v) => Between(begin: 0, end: v);

  static Between<double> toOneFrom(double v) => Between(begin: v, end: 1);

  static Between<double> fromOneTo(double v) => Between(begin: 1, end: v);

  static Between<double> to01From(double v) => Between(begin: v, end: 0.1);

  static Between<double> from01To(double v) => Between(begin: 0.1, end: v);
}

extension FBetweenOffset on Between<Offset> {
  static Between<Offset> get zero => Between.constant(Offset.zero);

  static Between<Offset> toZeroFrom(Offset from) =>
      Between(begin: from, end: Offset.zero);

  static Between<Offset> fromZeroTo(Offset to) =>
      Between(begin: Offset.zero, end: to);
}

extension FBetweenCoordinate on Between<Coordinate> {
  static Between<Coordinate> get zero => Between.constant(Coordinate.zero);

  static Between<Coordinate> toZeroFrom(Coordinate from) =>
      Between<Coordinate>(begin: from, end: Coordinate.zero);

  static Between<Coordinate> fromZeroTo(Coordinate to) =>
      Between<Coordinate>(begin: Coordinate.zero, end: to);

  static Between<Coordinate> beginOrEndZero(
    Coordinate another, {
    required bool isEndZero,
  }) =>
      Between<Coordinate>(
        begin: isEndZero ? another : Coordinate.zero,
        end: isEndZero ? Coordinate.zero : another,
      );
}

extension FBetweenCoordinateRadian on Between<Coordinate> {
  static Between<Coordinate> get x_0_360 =>
      Between(begin: Coordinate.zero, end: KRadianCoordinate.angleX_360);

  static Between<Coordinate> get y_0_360 =>
      Between(begin: Coordinate.zero, end: KRadianCoordinate.angleY_360);

  static Between<Coordinate> get z_0_360 =>
      Between(begin: Coordinate.zero, end: KRadianCoordinate.angleZ_360);

  static Between<Coordinate> get x_0_180 =>
      Between(begin: Coordinate.zero, end: KRadianCoordinate.angleX_180);

  static Between<Coordinate> get y_0_180 =>
      Between(begin: Coordinate.zero, end: KRadianCoordinate.angleY_180);

  static Between<Coordinate> get z_0_180 =>
      Between(begin: Coordinate.zero, end: KRadianCoordinate.angleZ_180);

  static Between<Coordinate> get x_0_90 =>
      Between(begin: Coordinate.zero, end: KRadianCoordinate.angleX_90);

  static Between<Coordinate> get y_0_90 =>
      Between(begin: Coordinate.zero, end: KRadianCoordinate.angleY_90);

  static Between<Coordinate> get z_0_90 =>
      Between(begin: Coordinate.zero, end: KRadianCoordinate.angleZ_90);

  static Between<Coordinate> toAngleX360From(Coordinate from) =>
      Between<Coordinate>(begin: from, end: KRadianCoordinate.angleX_360);

  static Between<Coordinate> toAngleY360From(Coordinate from) =>
      Between<Coordinate>(begin: from, end: KRadianCoordinate.angleY_360);

  static Between<Coordinate> toAngleZ360From(Coordinate from) =>
      Between<Coordinate>(begin: from, end: KRadianCoordinate.angleZ_360);

  static Between<Coordinate> toAngleX180From(Coordinate from) =>
      Between<Coordinate>(begin: from, end: KRadianCoordinate.angleX_180);

  static Between<Coordinate> toAngleY180From(Coordinate from) =>
      Between<Coordinate>(begin: from, end: KRadianCoordinate.angleY_180);

  static Between<Coordinate> toAngleZ180From(Coordinate from) =>
      Between<Coordinate>(begin: from, end: KRadianCoordinate.angleZ_180);

  static Between<Coordinate> toAngleX90From(Coordinate from) =>
      Between<Coordinate>(begin: from, end: KRadianCoordinate.angleX_90);

  static Between<Coordinate> toAngleY90From(Coordinate from) =>
      Between<Coordinate>(begin: from, end: KRadianCoordinate.angleY_90);

  static Between<Coordinate> toAngleZ90From(Coordinate from) =>
      Between<Coordinate>(begin: from, end: KRadianCoordinate.angleZ_90);
}

///
/// ani functions
///
/// [FAni.initialize] ... ([AnimationControllerInitializer])
/// [FAni.processNothing] ... ([Processor]<[AnimationController]>)
/// [FAni.decideNothing] ... ([Decider]<[AnimationController]>)
///
extension FAni on Ani {
  static const initialize = _initialize;
  static const initializeForward = _initializeForward;
  static const initializeForwardReset = _initializeForwardReset;
  static const initializeRepeat = _initializeRepeat;
  static const initializeRepeatReverse = _initializeRepeatReverse;

  static AnimationController _initialize(
    TickerProvider tickerProvider,
    Duration forward,
    Duration reverse,
  ) =>
      AnimationController(
        vsync: tickerProvider,
        duration: forward,
        reverseDuration: reverse,
      );

  static AnimationController _initializeForward(
    TickerProvider tickerProvider,
    Duration forward,
    Duration reverse,
  ) =>
      _initialize(tickerProvider, forward, reverse)..forward();

  static AnimationController _initializeForwardReset(
    TickerProvider tickerProvider,
    Duration forward,
    Duration reverse,
  ) =>
      _initialize(tickerProvider, forward, reverse)..forwardReset();

  static AnimationController _initializeRepeat(
    TickerProvider tickerProvider,
    Duration forward,
    Duration reverse,
  ) =>
      _initialize(tickerProvider, forward, reverse)..repeat();

  static AnimationController _initializeRepeatReverse(
    TickerProvider tickerProvider,
    Duration forward,
    Duration reverse,
  ) =>
      _initialize(tickerProvider, forward, reverse)..repeat(reverse: true);

  ///
  /// listener
  ///

  static const processNothing = _processNothing;
  static const processForward = _processForward;
  static const processForwardOrReverse = _processForwardOrReverse;
  static const processForwardReset = _processForwardReset;
  static const processReverse = _processReverse;
  static const processRepeat = _processRepeat;
  static const processRepeatReverse = _processRepeatReverse;
  static const processResetForward = _processResetForward;

  static void _processNothing(AnimationController c) {}

  static void _processForward(AnimationController c) => c.forward();

  static void _processForwardReset(AnimationController c) => c.forwardReset();

  static void _processForwardOrReverse(AnimationController controller) =>
      controller.status == AnimationStatus.dismissed
          ? controller.forward()
          : controller.reverse();

  static void _processReverse(AnimationController c) => c.reverse();

  static void _processRepeat(AnimationController c) => c.repeat();

  static void _processRepeatReverse(AnimationController c) =>
      c.repeat(reverse: true);

  static void _processResetForward(AnimationController c) => c.resetForward();

  ///
  /// decider
  ///

  static const decideNothing = _decideNothing;
  static const decideForward = _decideForward;
  static const decideReverse = _decideReverse;
  static const decideForwardReset = _decideForwardReset;
  static const decideRepeat = _decideRepeat;
  static const decideResetForward = _decideResetForward;
  static const decideForwardOrReverse = _decideForwardOrReverse;
  static const decideForwardOrRepeat = _decideForwardOrRepeat;

  static Processor<AnimationController> _decideNothing(bool toggle) =>
      _processNothing;

  static Processor<AnimationController> _decideForward(bool toggle) =>
      toggle ? _processForward : _processNothing;

  static Processor<AnimationController> _decideReverse(bool toggle) =>
      toggle ? _processReverse : _processNothing;

  static Processor<AnimationController> _decideForwardReset(bool toggle) =>
      toggle ? _processForwardReset : _processNothing;

  static Processor<AnimationController> _decideRepeat(bool toggle) =>
      toggle ? _processRepeat : _processNothing;

  static Processor<AnimationController> _decideResetForward(bool toggle) =>
      toggle ? _processResetForward : _processNothing;

  static Processor<AnimationController> _decideForwardOrReverse(
    bool? forward,
  ) =>
      switch (forward) {
        null => _processNothing,
        true => _processForward,
        false => _processReverse,
      };

  static Processor<AnimationController> _decideForwardOrRepeat(
    bool? forward,
  ) =>
      switch (forward) {
        null => _processNothing,
        true => _processForward,
        false => _processRepeat,
      };
}

extension FAnimationStatusListener on AnimationStatusListener {
  static const AnimationStatusListener listenNothing = _listenNothing;

  static void _listenNothing(AnimationStatus status) {}

  static AnimationStatusListener forwardListen(VoidCallback listener) =>
      (status) => status == AnimationStatus.forward ? listener() : null;

  static AnimationStatusListener reverseListen(VoidCallback listener) =>
      (status) => status == AnimationStatus.reverse ? listener() : null;

  static AnimationStatusListener completedListen(VoidCallback listener) =>
      (status) => status == AnimationStatus.completed ? listener() : null;

  static AnimationStatusListener dismissedListen(VoidCallback listener) =>
      (status) => status == AnimationStatus.dismissed ? listener() : null;
}

extension FOnAnimatingProcessor on AnimatingProcessor {
  static const AnimatingProcessor back = _back;
  static const AnimatingProcessor nothing = _nothing;

  static void _nothing(AnimationController controller, bool isForward) {}

  static void _back(AnimationController controller, bool isForward) => isForward
      ? controller.reverse(from: controller.value)
      : controller.forward(from: controller.value);
}

///
///
///
/// ani constants
///
/// [KAniInitForward]
/// [KAniInitRepeat]
/// [KAniInitRepeatReverse]
/// [KAniInitForwardAndUpdateForwardOrReverse]
/// [KAniInitForwardAndUpdateReverse]
///
/// [KAniUpdateForwardOrReverse]
///
///

extension KAniInitForward on Ani {
  static const second1 = Ani.initForward();
  static const second2 = Ani.initForward(duration: KDurationFR.second2);
  static const second3 = Ani.initForward(duration: KDurationFR.second3);
  static const second4 = Ani.initForward(duration: KDurationFR.second4);
  static const second5 = Ani.initForward(duration: KDurationFR.second5);
  static const second6 = Ani.initForward(duration: KDurationFR.second6);
  static const second7 = Ani.initForward(duration: KDurationFR.second7);
  static const second8 = Ani.initForward(duration: KDurationFR.second8);
  static const second9 = Ani.initForward(duration: KDurationFR.second9);
  static const second10 = Ani.initForward(duration: KDurationFR.second10);
  static const second20 = Ani.initForward(duration: KDurationFR.second20);
  static const second50 = Ani.initForward(duration: KDurationFR.second50);
}

extension KAniInitRepeat on Ani {
  static const second1 = Ani.initRepeat();
  static const second2 = Ani.initRepeat(duration: KDurationFR.second2);
  static const second3 = Ani.initRepeat(duration: KDurationFR.second3);
}

extension KAniInitRepeatReverse on Ani {
  static const second1 = Ani.initRepeat(reverseEnable: true);
}

// init forward and update Forward Or Reverse
extension KAniInitForwardAndUpdateForwardOrReverse on Ani {
  static const second1 = Ani.initForwardAndUpdateForwardOrReverse();
  static const second2 =
      Ani.initForwardAndUpdateForwardOrReverse(duration: KDurationFR.second2);
  static const second3 =
      Ani.initForwardAndUpdateForwardOrReverse(duration: KDurationFR.second3);
  static const second5 =
      Ani.initForwardAndUpdateForwardOrReverse(duration: KDurationFR.second5);
  static const second10 =
      Ani.initForwardAndUpdateForwardOrReverse(duration: KDurationFR.second10);
  static const second30 =
      Ani.initForwardAndUpdateForwardOrReverse(duration: KDurationFR.second30);
  static const min1 =
      Ani.initForwardAndUpdateForwardOrReverse(duration: KDurationFR.min1);

  static const second1_onAnimatingBack =
      Ani.initForwardAndUpdateForwardOrReverse(
    onAnimating: FOnAnimatingProcessor.back,
  );
  static const second2_onAnimatingBack =
      Ani.initForwardAndUpdateForwardOrReverse(
    duration: KDurationFR.second2,
    onAnimating: FOnAnimatingProcessor.back,
  );
  static const second3_onAnimatingBack =
      Ani.initForwardAndUpdateForwardOrReverse(
    duration: KDurationFR.second3,
    onAnimating: FOnAnimatingProcessor.back,
  );
  static const second5_onAnimatingBack =
      Ani.initForwardAndUpdateForwardOrReverse(
    duration: KDurationFR.second5,
    onAnimating: FOnAnimatingProcessor.back,
  );
  static const second10_onAnimatingBack =
      Ani.initForwardAndUpdateForwardOrReverse(
    duration: KDurationFR.second10,
    onAnimating: FOnAnimatingProcessor.back,
  );
  static const second30_onAnimatingBack =
      Ani.initForwardAndUpdateForwardOrReverse(
    duration: KDurationFR.second30,
    onAnimating: FOnAnimatingProcessor.back,
  );
  static const min1_onAnimatingBack = Ani.initForwardAndUpdateForwardOrReverse(
    duration: KDurationFR.min1,
    onAnimating: FOnAnimatingProcessor.back,
  );
}

extension KAniInitForwardAndUpdateReverse on Ani {
  static const second1 = Ani.initForwardAndUpdateReverse();
}

extension KAniUpdateForwardOrReverse on Ani {
  static const milli100 =
      Ani.updateForwardOrReverse(duration: KDurationFR.milli100);
  static const milli200 =
      Ani.updateForwardOrReverse(duration: KDurationFR.milli200);
  static const milli300 =
      Ani.updateForwardOrReverse(duration: KDurationFR.milli300);
  static const milli500 =
      Ani.updateForwardOrReverse(duration: KDurationFR.milli500);
  static const second1 = Ani.updateForwardOrReverse();
  static const second1_onAnimatingBack = Ani.updateForwardOrReverse(
    onAnimating: FOnAnimatingProcessor.back,
  );
}

///
///
///
/// timer
///
///
///

extension VTimer on Timer {
  static Timer none = Timer(Duration.zero, kVoidCallback);
}

extension FTimer on Timer {
  static Timer _nest(
    Duration duration,
    VoidCallback listener,
    Iterable<(Duration, VoidCallback)> sequence,
  ) =>
      Timer(duration, () {
        sequence.hasElement ? nest(sequence) : null;
        listener();
      });

  static Timer nest(Iterable<(Duration, VoidCallback)> sequence) {
    final first = sequence.first;
    return _nest(first.$1, first.$2, sequence.skip(1));
  }
}

extension FTimerProcessor on Processor<Timer> {
  static const Processor<Timer> logTick = _logTick;

  static void _logTick(Timer timer) => timer.tick.log();

  static Processor<Timer> periodicProcessUntil(int n, VoidCallback listener) {
    int count = 0;
    return (timer) {
      listener();
      if (++count == n) {
        timer.cancel();
      }
    };
  }

  static Processor<Timer> periodicProcessAfter(int n, VoidCallback listener) {
    int count = 0;
    return (timer) => count < n ? count++ : listener();
  }

  static Processor<Timer> periodicProcessPeriod(
    int period,
    VoidCallback listener,
  ) {
    int count = 0;
    void listenIf(bool value) => value ? listener() : null;
    bool shouldListen() => count % period == 0;

    return (timer) {
      listenIf(shouldListen());
      count++;
    };
  }
}

///
///
/// datetime
///
///

extension FDateTime on DateTime {
  static bool isSameDay(DateTime? a, DateTime? b) => a == null || b == null
      ? false
      : a.year == b.year && a.month == b.month && a.day == b.day;
}
