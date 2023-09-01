// ignore_for_file: non_constant_identifier_names, constant_identifier_names

part of source;

///
/// this file contains:
/// [kTweenDoubleZero]
///
/// [KDuration], [KCurve], [KInterval]
///
/// [VTweenDouble]
/// [VTweenOffset], [VTweenOffsetConstX], [VTweenOffsetConstY]
/// [VTweenCoordinate], [VTweenCoordinateRadian]
/// [VTweenVector]
/// [VTweenDecoration]
/// [VTweenPathCircle]
///
/// [VMation]
/// [KAniInitForward], [KAniInitFor], [KAniInitRepeatReverse], [KAniInitRepeat]
/// [KAniInitForwardAndUpdateFor]
///
/// [FTransitionBuilder], [VMationTransition]
/// [VMationTransformScale], [VMationTransformTranslate], [VMationTransformRotate]
/// [FAnimationTransformClipper], [FAnimationTransformRowTransformClipper]
/// [FTimer]
///
/// [VMationClipper]
/// [VMationPainter], [FMationPainter]
///
///
///

extension KDuration on Duration {
  static const milli10 = Duration(milliseconds: 10);
  static const milli100 = Duration(milliseconds: 100);
  static const milli150 = Duration(milliseconds: 150);
  static const milli200 = Duration(milliseconds: 200);
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
  static const milli900 = Duration(milliseconds: 900);
  static const second1 = Duration(seconds: 1);
  static const second2 = Duration(seconds: 2);
  static const second3 = Duration(seconds: 3);
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

extension VTimer on Timer {
  static Timer none = Timer(Duration.zero, kVoidCallback);
}

extension FTimer on Timer {
  static Timer periodicN(Duration duration, TimerListener listener, int n) {
    late final Timer timer;

    void cancelTimer() => timer.cancel();

    int count = 0;
    timer = Timer.periodic(duration, (timer) {
      listener(timer);
      if (++count == n) {
        cancelTimer();
      }
    });
    return timer;
  }
}

extension KCurveFRFlipped on Curve {
  static const CurveFR linear = CurveFR(Curves.linear);
  static const CurveFR fastOutSlowIn = CurveFR(Curves.fastOutSlowIn);
}

extension KInterval on Interval {
  static const easeInOut00To04 = Interval(0, 0.4, curve: Curves.easeInOut);
  static const easeOut00To06 = Interval(0, 0.6, curve: Curves.easeOut);
  static const easeInOut02To08 = Interval(0.2, 0.8, curve: Curves.easeInOut);
  static const easeInOut04To10 = Interval(0.4, 1, curve: Curves.easeInOut);
  static const fastOutSlowIn00To05 =
      Interval(0, 0.5, curve: Curves.fastOutSlowIn);
}

///
/// [Tween]
///

extension VTweenDouble on TweenDouble {
  ///
  /// constant
  ///

  static TweenDouble get zero => TweenDouble.constant(0);

  static TweenDouble get k1 => TweenDouble.constant(1);

  static TweenDouble get k2 => TweenDouble.constant(2);

  static TweenDouble get k3 => TweenDouble.constant(3);

  static TweenDouble get k4 => TweenDouble.constant(4);

  static TweenDouble get k5 => TweenDouble.constant(5);

  static TweenDouble get k6 => TweenDouble.constant(6);

  static TweenDouble get k7 => TweenDouble.constant(7);

  static TweenDouble get k8 => TweenDouble.constant(8);

  static TweenDouble get k9 => TweenDouble.constant(9);

  static TweenDouble get k10 => TweenDouble.constant(10);

  static TweenDouble get k20 => TweenDouble.constant(20);

  static TweenDouble get k30 => TweenDouble.constant(30);

  static TweenDouble get k35 => TweenDouble.constant(35);

  static TweenDouble get k40 => TweenDouble.constant(40);

  static TweenDouble get k50 => TweenDouble.constant(50);

  static TweenDouble get k60 => TweenDouble.constant(60);

  static TweenDouble get k70 => TweenDouble.constant(70);

  static TweenDouble get k80 => TweenDouble.constant(80);

  static TweenDouble get k90 => TweenDouble.constant(90);

  static TweenDouble get k100 => TweenDouble.constant(100);

  static TweenDouble get k10N => TweenDouble.constant(-10);

  static TweenDouble get k20N => TweenDouble.constant(-20);

  static TweenDouble get k30N => TweenDouble.constant(-30);

  static TweenDouble get k40N => TweenDouble.constant(-40);

  static TweenDouble get k50N => TweenDouble.constant(-50);

  static TweenDouble get k60N => TweenDouble.constant(-60);

  static TweenDouble get k70N => TweenDouble.constant(-70);

  static TweenDouble get k80N => TweenDouble.constant(-80);

  static TweenDouble get k90N => TweenDouble.constant(-90);

  static TweenDouble get k100N => TweenDouble.constant(-100);

  ///
  /// double -- from negative
  ///

  static TweenDouble get double_500N_500 => TweenDouble(begin: -500, end: 500);

  static TweenDouble get double_100N_100 => TweenDouble(begin: -100, end: 100);

  static TweenDouble get double_80N_200 => TweenDouble(begin: -80, end: 200);

  static TweenDouble get double_50N_150 => TweenDouble(begin: -50, end: 150);

  static TweenDouble get double_50N_50 => TweenDouble(begin: -50, end: 50);

  static TweenDouble get double_40N_120 => TweenDouble(begin: -40, end: 120);

  static TweenDouble get double_20N_120 => TweenDouble(begin: -20, end: 120);

  static TweenDouble get double_5N_1 => TweenDouble(begin: -5, end: 1);

  static TweenDouble get double_5N_5 => TweenDouble(begin: -5, end: 5);

  static TweenDouble get double_1N_1 => TweenDouble(begin: -1, end: 1);

  static TweenDouble get double_1N_2 => TweenDouble(begin: -1, end: 2);

  static TweenDouble get double_1N_3 => TweenDouble(begin: -1, end: 3);

  static TweenDouble get double_1N_4 => TweenDouble(begin: -1, end: 4);

  static TweenDouble get double_1N_5 => TweenDouble(begin: -1, end: 5);

  static TweenDouble get double_1N_6 => TweenDouble(begin: -1, end: 6);

  static TweenDouble get double_1N_7 => TweenDouble(begin: -1, end: 7);

  static TweenDouble get double_1N_8 => TweenDouble(begin: -1, end: 8);

  static TweenDouble get double_1N_9 => TweenDouble(begin: -1, end: 9);

  static TweenDouble get double_1N_10 => TweenDouble(begin: -1, end: 10);

  /// double -- from zero

  static TweenDouble get double_0_1 => TweenDouble(begin: 0, end: 1);

  ///
  /// double -- from positive
  ///

  /// from decimal

  // from decimal to 0.05
  static TweenDouble get double_01_005 => TweenDouble(begin: 0.1, end: 0.05);

  static TweenDouble get double_02_005 => TweenDouble(begin: 0.2, end: 0.05);

  static TweenDouble get double_03_005 => TweenDouble(begin: 0.3, end: 0.05);

  static TweenDouble get double_04_005 => TweenDouble(begin: 0.4, end: 0.05);

  static TweenDouble get double_05_005 => TweenDouble(begin: 0.5, end: 0.05);

  static TweenDouble get double_06_005 => TweenDouble(begin: 0.6, end: 0.05);

  static TweenDouble get double_07_005 => TweenDouble(begin: 0.7, end: 0.05);

  static TweenDouble get double_08_005 => TweenDouble(begin: 0.8, end: 0.05);

  static TweenDouble get double_09_005 => TweenDouble(begin: 0.9, end: 0.05);

  // from decimal to 0.1
  static TweenDouble get double_02_01 => TweenDouble(begin: 0.2, end: 0.1);

  static TweenDouble get double_03_01 => TweenDouble(begin: 0.3, end: 0.1);

  static TweenDouble get double_04_01 => TweenDouble(begin: 0.4, end: 0.1);

  static TweenDouble get double_05_01 => TweenDouble(begin: 0.5, end: 0.1);

  static TweenDouble get double_06_01 => TweenDouble(begin: 0.6, end: 0.1);

  static TweenDouble get double_07_01 => TweenDouble(begin: 0.7, end: 0.1);

  static TweenDouble get double_08_01 => TweenDouble(begin: 0.8, end: 0.1);

  static TweenDouble get double_09_01 => TweenDouble(begin: 0.9, end: 0.1);

  // from decimal to 0.2
  static TweenDouble get double_03_02 => TweenDouble(begin: 0.3, end: 0.2);

  static TweenDouble get double_04_02 => TweenDouble(begin: 0.4, end: 0.2);

  static TweenDouble get double_05_02 => TweenDouble(begin: 0.5, end: 0.2);

  static TweenDouble get double_06_02 => TweenDouble(begin: 0.6, end: 0.2);

  static TweenDouble get double_07_02 => TweenDouble(begin: 0.7, end: 0.2);

  static TweenDouble get double_08_02 => TweenDouble(begin: 0.8, end: 0.2);

  static TweenDouble get double_09_02 => TweenDouble(begin: 0.9, end: 0.2);

  // from decimal to 0.3
  static TweenDouble get double_04_03 => TweenDouble(begin: 0.4, end: 0.3);

  static TweenDouble get double_05_03 => TweenDouble(begin: 0.5, end: 0.3);

  static TweenDouble get double_06_03 => TweenDouble(begin: 0.6, end: 0.3);

  static TweenDouble get double_07_03 => TweenDouble(begin: 0.7, end: 0.3);

  static TweenDouble get double_08_03 => TweenDouble(begin: 0.8, end: 0.3);

  static TweenDouble get double_09_03 => TweenDouble(begin: 0.9, end: 0.3);

  // for decimal to 1
  static TweenDouble get double_01_1 => TweenDouble(begin: 0.1, end: 1);

  static TweenDouble get double_02_1 => TweenDouble(begin: 0.2, end: 1);

  static TweenDouble get double_03_1 => TweenDouble(begin: 0.3, end: 1);

  static TweenDouble get double_04_1 => TweenDouble(begin: 0.4, end: 1);

  static TweenDouble get double_05_1 => TweenDouble(begin: 0.5, end: 1);

  static TweenDouble get double_06_1 => TweenDouble(begin: 0.6, end: 1);

  static TweenDouble get double_07_1 => TweenDouble(begin: 0.7, end: 1);

  static TweenDouble get double_08_1 => TweenDouble(begin: 0.8, end: 1);

  static TweenDouble get double_09_1 => TweenDouble(begin: 0.9, end: 1);

  // from 1 to decimal
  static TweenDouble get double_1_005 => TweenDouble(begin: 1, end: 0.05);

  static TweenDouble get double_1_01 => TweenDouble(begin: 1, end: 0.1);

  static TweenDouble get double_1_02 => TweenDouble(begin: 1, end: 0.2);

  static TweenDouble get double_1_03 => TweenDouble(begin: 1, end: 0.3);

  static TweenDouble get double_1_04 => TweenDouble(begin: 1, end: 0.4);

  static TweenDouble get double_1_05 => TweenDouble(begin: 1, end: 0.5);

  static TweenDouble get double_1_06 => TweenDouble(begin: 1, end: 0.6);

  static TweenDouble get double_1_07 => TweenDouble(begin: 1, end: 0.7);

  static TweenDouble get double_1_08 => TweenDouble(begin: 1, end: 0.8);

  static TweenDouble get double_1_09 => TweenDouble(begin: 1, end: 0.9);

  // from 1 to integer
  static TweenDouble get double_1_2 => TweenDouble(begin: 1, end: 2);

  static TweenDouble get double_1_3 => TweenDouble(begin: 1, end: 3);

  static TweenDouble get double_1_4 => TweenDouble(begin: 1, end: 4);

  static TweenDouble get double_1_5 => TweenDouble(begin: 1, end: 5);

  static TweenDouble get double_1_6 => TweenDouble(begin: 1, end: 6);

  static TweenDouble get double_1_7 => TweenDouble(begin: 1, end: 7);

  static TweenDouble get double_1_8 => TweenDouble(begin: 1, end: 8);

  static TweenDouble get double_1_9 => TweenDouble(begin: 1, end: 9);

  static TweenDouble get double_1_10 => TweenDouble(begin: 1, end: 10);

  // from 10
  static TweenDouble get double_10_20 => TweenDouble(begin: 10, end: 20);

  static TweenDouble get double_10_30 => TweenDouble(begin: 10, end: 30);

  static TweenDouble get double_10_40 => TweenDouble(begin: 10, end: 40);

  static TweenDouble get double_10_50 => TweenDouble(begin: 10, end: 50);

  static TweenDouble get double_10_60 => TweenDouble(begin: 10, end: 60);

  static TweenDouble get double_10_70 => TweenDouble(begin: 10, end: 70);

  static TweenDouble get double_10_80 => TweenDouble(begin: 10, end: 80);

  static TweenDouble get double_10_90 => TweenDouble(begin: 10, end: 90);

  static TweenDouble get double_10_100 => TweenDouble(begin: 10, end: 100);

  static TweenDouble get double_10_200 => TweenDouble(begin: 10, end: 200);

  static TweenDouble get double_10_300 => TweenDouble(begin: 10, end: 300);

  static TweenDouble get double_10_400 => TweenDouble(begin: 10, end: 400);

  // from 20
  static TweenDouble get double_20_10 => TweenDouble(begin: 20, end: 10);

  static TweenDouble get double_20_30 => TweenDouble(begin: 20, end: 30);

  static TweenDouble get double_20_40 => TweenDouble(begin: 20, end: 40);

  static TweenDouble get double_20_50 => TweenDouble(begin: 20, end: 50);

  static TweenDouble get double_20_60 => TweenDouble(begin: 20, end: 60);

  static TweenDouble get double_20_70 => TweenDouble(begin: 20, end: 70);

  static TweenDouble get double_20_80 => TweenDouble(begin: 20, end: 80);

  static TweenDouble get double_20_90 => TweenDouble(begin: 20, end: 90);

  static TweenDouble get double_20_100 => TweenDouble(begin: 20, end: 100);

  static TweenDouble get double_20_200 => TweenDouble(begin: 20, end: 200);

  static TweenDouble get double_20_300 => TweenDouble(begin: 20, end: 300);

  static TweenDouble get double_20_400 => TweenDouble(begin: 20, end: 400);

  // from 30
  static TweenDouble get double_30_10 => TweenDouble(begin: 30, end: 10);

  static TweenDouble get double_30_20 => TweenDouble(begin: 30, end: 20);

  static TweenDouble get double_30_40 => TweenDouble(begin: 30, end: 40);

  static TweenDouble get double_30_50 => TweenDouble(begin: 30, end: 50);

  static TweenDouble get double_30_60 => TweenDouble(begin: 30, end: 60);

  static TweenDouble get double_30_70 => TweenDouble(begin: 30, end: 70);

  static TweenDouble get double_30_80 => TweenDouble(begin: 30, end: 80);

  static TweenDouble get double_30_90 => TweenDouble(begin: 30, end: 90);

  static TweenDouble get double_30_100 => TweenDouble(begin: 30, end: 100);

  // from others
  static TweenDouble get double_70_80 => TweenDouble(begin: 70, end: 80);

  static TweenDouble get double_70_90 => TweenDouble(begin: 70, end: 90);

  static TweenDouble get double_70_100 => TweenDouble(begin: 70, end: 100);

  static TweenDouble get double_80_90 => TweenDouble(begin: 80, end: 90);

  /// radian

  static TweenDouble get angle_0_90 =>
      TweenDouble(begin: 0, end: KRadian.angle_90);

  static TweenDouble get angle_0_180 =>
      TweenDouble(begin: 0, end: KRadian.angle_180);

  static TweenDouble get angle_0_360 =>
      TweenDouble(begin: 0, end: KRadian.angle_360);

  static TweenDouble get angle_0_90N =>
      TweenDouble(begin: 0, end: -KRadian.angle_90);

  static TweenDouble get angle_0_180N =>
      TweenDouble(begin: 0, end: -KRadian.angle_180);

  static TweenDouble get angle_0_360N =>
      TweenDouble(begin: 0, end: -KRadian.angle_360);
}

extension VTweenOffset on MyTween<Offset> {
  static MyTween<Offset> get square_0_100 =>
      MyTween(begin: Offset.zero, end: KOffset.square_100);

  static MyTween<Offset> get square_100_0 =>
      MyTween(begin: KOffset.square_100, end: Offset.zero);

  static MyTween<Offset> get xy_0x100y_100x0y =>
      MyTween(begin: KOffset.y_100, end: KOffset.x_100);

  static MyTween<Offset> get xy_100Nx100y_100x0y =>
      MyTween(begin: KOffset.x_100N + KOffset.y_100, end: KOffset.x_100);
}

extension VTweenOffsetConstX on MyTween<Offset> {
  static MyTween<Offset> get y_0_05 =>
      MyTween(begin: Offset.zero, end: KOffset.y_05);

  static MyTween<Offset> get y_0_1 =>
      MyTween(begin: Offset.zero, end: KOffset.y_1);

  static MyTween<Offset> get y_0_2 =>
      MyTween(begin: Offset.zero, end: KOffset.y_2);

  static MyTween<Offset> get y_0_3 =>
      MyTween(begin: Offset.zero, end: KOffset.y_3);

  static MyTween<Offset> get y_0_4 =>
      MyTween(begin: Offset.zero, end: KOffset.y_4);

  static MyTween<Offset> get y_0_5 =>
      MyTween(begin: Offset.zero, end: KOffset.y_5);

  static MyTween<Offset> get y_0_6 =>
      MyTween(begin: Offset.zero, end: KOffset.y_6);

  static MyTween<Offset> get y_0_7 =>
      MyTween(begin: Offset.zero, end: KOffset.y_7);

  static MyTween<Offset> get y_0_8 =>
      MyTween(begin: Offset.zero, end: KOffset.y_8);

  static MyTween<Offset> get y_0_9 =>
      MyTween(begin: Offset.zero, end: KOffset.y_9);

  static MyTween<Offset> get y_0_10 =>
      MyTween(begin: Offset.zero, end: KOffset.y_10);

  static MyTween<Offset> get y_0_20 =>
      MyTween(begin: Offset.zero, end: KOffset.y_20);

  static MyTween<Offset> get y_0_30 =>
      MyTween(begin: Offset.zero, end: KOffset.y_30);

  static MyTween<Offset> get y_0_40 =>
      MyTween(begin: Offset.zero, end: KOffset.y_40);

  static MyTween<Offset> get y_0_50 =>
      MyTween(begin: Offset.zero, end: KOffset.y_50);

  static MyTween<Offset> get y_0_100 =>
      MyTween(begin: Offset.zero, end: KOffset.y_100);

  static MyTween<Offset> get y_0_100N =>
      MyTween(begin: Offset.zero, end: -KOffset.y_100);

  static MyTween<Offset> get y_10N_10 =>
      MyTween(begin: -KOffset.y_10, end: KOffset.y_10);

  static MyTween<Offset> get y_20N_20 =>
      MyTween(begin: -KOffset.y_20, end: KOffset.y_20);

  static MyTween<Offset> get y_30N_30 =>
      MyTween(begin: -KOffset.y_30, end: KOffset.y_30);

  static MyTween<Offset> get y_40N_40 =>
      MyTween(begin: -KOffset.y_40, end: KOffset.y_40);

  static MyTween<Offset> get y_50N_10 =>
      MyTween(begin: -KOffset.y_50, end: KOffset.y_10);

  static MyTween<Offset> get y_50N_20 =>
      MyTween(begin: -KOffset.y_50, end: KOffset.y_20);

  static MyTween<Offset> get y_50N_30 =>
      MyTween(begin: -KOffset.y_50, end: KOffset.y_30);

  static MyTween<Offset> get y_50N_40 =>
      MyTween(begin: -KOffset.y_50, end: KOffset.y_40);

  static MyTween<Offset> get y_50N_50 =>
      MyTween(begin: -KOffset.y_50, end: KOffset.y_50);

  static MyTween<Offset> get y_50N_100 =>
      MyTween(begin: -KOffset.y_50, end: KOffset.y_100);

  static MyTween<Offset> get y_50N_10N =>
      MyTween(begin: -KOffset.y_50, end: -KOffset.y_10);

  static MyTween<Offset> get y_50N_100N =>
      MyTween(begin: -KOffset.y_50, end: -KOffset.y_100);
}

extension VTweenOffsetConstY on MyTween<Offset> {
  static MyTween<Offset> get x_0_05 =>
      MyTween(begin: Offset.zero, end: KOffset.x_05);

  static MyTween<Offset> get x_0_1 =>
      MyTween(begin: Offset.zero, end: KOffset.x_1);

  static MyTween<Offset> get x_0_2 =>
      MyTween(begin: Offset.zero, end: KOffset.x_2);

  static MyTween<Offset> get x_0_3 =>
      MyTween(begin: Offset.zero, end: KOffset.x_3);

  static MyTween<Offset> get x_0_4 =>
      MyTween(begin: Offset.zero, end: KOffset.x_4);

  static MyTween<Offset> get x_0_5 =>
      MyTween(begin: Offset.zero, end: KOffset.x_5);

  static MyTween<Offset> get x_0_6 =>
      MyTween(begin: Offset.zero, end: KOffset.x_6);

  static MyTween<Offset> get x_0_7 =>
      MyTween(begin: Offset.zero, end: KOffset.x_7);

  static MyTween<Offset> get x_0_8 =>
      MyTween(begin: Offset.zero, end: KOffset.x_8);

  static MyTween<Offset> get x_0_9 =>
      MyTween(begin: Offset.zero, end: KOffset.x_9);

  static MyTween<Offset> get x_0_10 =>
      MyTween(begin: Offset.zero, end: KOffset.x_10);

  static MyTween<Offset> get x_0_20 =>
      MyTween(begin: Offset.zero, end: KOffset.x_20);

  static MyTween<Offset> get x_0_30 =>
      MyTween(begin: Offset.zero, end: KOffset.x_30);

  static MyTween<Offset> get x_0_40 =>
      MyTween(begin: Offset.zero, end: KOffset.x_40);

  static MyTween<Offset> get x_0_50 =>
      MyTween(begin: Offset.zero, end: KOffset.x_50);

  static MyTween<Offset> get x_0_100 =>
      MyTween(begin: Offset.zero, end: KOffset.x_100);

  static MyTween<Offset> get x_0_10N =>
      MyTween(begin: Offset.zero, end: -KOffset.x_10);

  static MyTween<Offset> get x_0_100N =>
      MyTween(begin: Offset.zero, end: KOffset.x_100N);

  static MyTween<Offset> get x_50N_10 =>
      MyTween(begin: KOffset.x_50N, end: KOffset.x_10);

  static MyTween<Offset> get x_50N_20 =>
      MyTween(begin: KOffset.x_50N, end: KOffset.x_20);

  static MyTween<Offset> get x_50N_30 =>
      MyTween(begin: KOffset.x_50N, end: KOffset.x_30);

  static MyTween<Offset> get x_50N_40 =>
      MyTween(begin: KOffset.x_50N, end: KOffset.x_40);

  static MyTween<Offset> get x_50N_50 =>
      MyTween(begin: KOffset.x_50N, end: KOffset.x_50);

  static MyTween<Offset> get x_50N_10N =>
      MyTween(begin: KOffset.x_50N, end: KOffset.x_10);

  static MyTween<Offset> get x_50N_100 =>
      MyTween(begin: KOffset.x_50N, end: KOffset.x_100);

  static MyTween<Offset> get x_50N_100N =>
      MyTween(begin: KOffset.x_50N, end: KOffset.x_100N);

  static MyTween<Offset> get x_10N_10 =>
      MyTween(begin: KOffset.x_10N, end: KOffset.x_10);

  static MyTween<Offset> get x_20N_20 =>
      MyTween(begin: KOffset.x_20N, end: KOffset.x_20);

  static MyTween<Offset> get x_30N_30 =>
      MyTween(begin: KOffset.x_30N, end: KOffset.x_30);

  static MyTween<Offset> get x_40N_40 =>
      MyTween(begin: KOffset.x_40N, end: KOffset.x_40);

  static MyTween<Offset> get x_60N_60 =>
      MyTween(begin: KOffset.x_60N, end: KOffset.x_60);

  static MyTween<Offset> get x_70N_70 =>
      MyTween(begin: KOffset.x_70N, end: KOffset.x_70);

  static MyTween<Offset> get x_80N_80 =>
      MyTween(begin: KOffset.x_80N, end: KOffset.x_80);

  static MyTween<Offset> get x_90N_90 =>
      MyTween(begin: KOffset.x_90N, end: KOffset.x_90);

  static MyTween<Offset> get x_0_10_10y =>
      MyTween(begin: KOffset.y_10, end: KOffset.y_10 + KOffset.x_10);

  static MyTween<Offset> get x_0_20_20y =>
      MyTween(begin: KOffset.y_20, end: KOffset.y_20 + KOffset.x_20);

  static MyTween<Offset> get x_0_30_30y =>
      MyTween(begin: KOffset.y_30, end: KOffset.y_30 + KOffset.x_30);

  static MyTween<Offset> get x_0_40_40y =>
      MyTween(begin: KOffset.y_40, end: KOffset.y_40 + KOffset.x_40);

  static MyTween<Offset> get x_0_50_10Ny =>
      MyTween(begin: KOffset.y_10N, end: KOffset.y_10N + KOffset.x_50);

  static MyTween<Offset> get x_0_50_20Ny =>
      MyTween(begin: KOffset.y_20N, end: KOffset.y_20N + KOffset.x_50);

  static MyTween<Offset> get x_0_50_30Ny =>
      MyTween(begin: KOffset.y_30N, end: KOffset.y_30N + KOffset.x_50);

  static MyTween<Offset> get x_0_50_40Ny =>
      MyTween(begin: KOffset.y_40N, end: KOffset.y_40N + KOffset.x_50);

  static MyTween<Offset> get x_0_50_50Ny =>
      MyTween(begin: KOffset.y_50N, end: KOffset.y_50N + KOffset.x_50);

  static MyTween<Offset> get x_0_50_60Ny =>
      MyTween(begin: KOffset.y_60N, end: KOffset.y_60N + KOffset.x_50);

  static MyTween<Offset> get x_0_50_70Ny =>
      MyTween(begin: KOffset.y_70N, end: KOffset.y_70N + KOffset.x_50);

  static MyTween<Offset> get x_0_50_80Ny =>
      MyTween(begin: KOffset.y_80N, end: KOffset.y_80N + KOffset.x_50);

  static MyTween<Offset> get x_0_50_90Ny =>
      MyTween(begin: KOffset.y_90N, end: KOffset.y_90N + KOffset.x_50);

  static MyTween<Offset> get x_0_50_100Ny =>
      MyTween(begin: KOffset.y_100N, end: KOffset.y_100N + KOffset.x_50);

  static MyTween<Offset> get x_0_50_10y =>
      MyTween(begin: KOffset.y_10, end: KOffset.y_10 + KOffset.x_50);

  static MyTween<Offset> get x_0_50_20y =>
      MyTween(begin: KOffset.y_20, end: KOffset.y_20 + KOffset.x_50);

  static MyTween<Offset> get x_0_50_30y =>
      MyTween(begin: KOffset.y_30, end: KOffset.y_30 + KOffset.x_50);

  static MyTween<Offset> get x_0_50_40y =>
      MyTween(begin: KOffset.y_40, end: KOffset.y_40 + KOffset.x_50);

  static MyTween<Offset> get x_0_50_50y =>
      MyTween(begin: KOffset.y_50, end: KOffset.y_50 + KOffset.x_50);

  static MyTween<Offset> get x_0_50_60y =>
      MyTween(begin: KOffset.y_60, end: KOffset.y_60 + KOffset.x_50);

  static MyTween<Offset> get x_0_50_70y =>
      MyTween(begin: KOffset.y_70, end: KOffset.y_70 + KOffset.x_50);

  static MyTween<Offset> get x_0_50_80y =>
      MyTween(begin: KOffset.y_80, end: KOffset.y_80 + KOffset.x_50);

  static MyTween<Offset> get x_0_50_90y =>
      MyTween(begin: KOffset.y_90, end: KOffset.y_90 + KOffset.x_50);

  static MyTween<Offset> get x_0_50_100y =>
      MyTween(begin: KOffset.y_100, end: KOffset.y_100 + KOffset.x_50);

  static MyTween<Offset> get x_0_100_100y =>
      MyTween(begin: KOffset.y_100, end: KOffset.y_100 + KOffset.x_100);

  static MyTween<Offset> get x_50N_10_10y => MyTween(
      begin: KOffset.x_50N + KOffset.y_10, end: KOffset.x_10 + KOffset.y_10);

  static MyTween<Offset> get x_50N_20_20y => MyTween(
      begin: KOffset.x_50N + KOffset.y_20, end: KOffset.x_20 + KOffset.y_20);

  static MyTween<Offset> get x_50N_30_30y => MyTween(
      begin: KOffset.x_50N + KOffset.y_30, end: KOffset.x_30 + KOffset.y_30);

  static MyTween<Offset> get x_50N_40_40y => MyTween(
      begin: KOffset.x_50N + KOffset.y_40, end: KOffset.x_40 + KOffset.y_40);

  static MyTween<Offset> get x_50N_50_50y => MyTween(
      begin: KOffset.x_50N + KOffset.y_50, end: KOffset.x_50 + KOffset.y_50);

  static MyTween<Offset> get x_50N_50_50Ny => MyTween(
      begin: KOffset.x_50N + KOffset.y_50N, end: KOffset.x_50 + KOffset.y_50N);

  static MyTween<Offset> get x_50N_10N_10Ny => MyTween(
      begin: KOffset.x_50N + KOffset.y_10N, end: KOffset.x_10 + KOffset.y_10N);

  static MyTween<Offset> get x_50N_100_100y => MyTween(
      begin: KOffset.x_50N + KOffset.y_100, end: KOffset.x_100 + KOffset.y_100);

  static MyTween<Offset> get x_100N_100_100y => MyTween(
      begin: KOffset.x_100N + KOffset.y_100,
      end: KOffset.x_100 + KOffset.y_100);

  static MyTween<Offset> get x_100N_100_100Ny => MyTween(
      begin: KOffset.x_100N + KOffset.y_100N,
      end: KOffset.x_100 + KOffset.y_100N);
}

extension VTweenCoordinate on MyTween<Coordinate> {
  static MyTween<Coordinate> get zero => MyTween.constant(Coordinate.zero);

  static MyTween<Coordinate> get k1 => MyTween.constant(KCoordinate.cube_1);

  static MyTween<Coordinate> get cube_1_2 =>
      MyTween(begin: KCoordinate.cube_1, end: KCoordinate.cube_2);

  static MyTween<Coordinate> get cube_1_3 =>
      MyTween(begin: KCoordinate.cube_1, end: KCoordinate.cube_3);

  static MyTween<Coordinate> get cube_1_4 =>
      MyTween(begin: KCoordinate.cube_1, end: KCoordinate.cube_4);

  static MyTween<Coordinate> get cube_1_5 =>
      MyTween(begin: KCoordinate.cube_1, end: KCoordinate.cube_5);

  // 1 ~ 10
  static MyTween<Coordinate> get cube_0_1 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_1);

  static MyTween<Coordinate> get cube_0_2 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_2);

  static MyTween<Coordinate> get cube_0_3 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_3);

  static MyTween<Coordinate> get cube_0_4 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_4);

  static MyTween<Coordinate> get cube_0_5 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_5);

  static MyTween<Coordinate> get cube_0_6 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_6);

  static MyTween<Coordinate> get cube_0_7 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_7);

  static MyTween<Coordinate> get cube_0_8 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_8);

  static MyTween<Coordinate> get cube_0_9 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_9);

  static MyTween<Coordinate> get cube_0_10 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_10);

  // -1 ~ -10
  static MyTween<Coordinate> get cube_0_1N =>
      MyTween(begin: Coordinate.zero, end: -KCoordinate.cube_1);

  static MyTween<Coordinate> get cube_0_2N =>
      MyTween(begin: Coordinate.zero, end: -KCoordinate.cube_2);

  static MyTween<Coordinate> get cube_0_3N =>
      MyTween(begin: Coordinate.zero, end: -KCoordinate.cube_3);

  static MyTween<Coordinate> get cube_0_4N =>
      MyTween(begin: Coordinate.zero, end: -KCoordinate.cube_4);

  static MyTween<Coordinate> get cube_0_5N =>
      MyTween(begin: Coordinate.zero, end: -KCoordinate.cube_5);

  static MyTween<Coordinate> get cube_0_6N =>
      MyTween(begin: Coordinate.zero, end: -KCoordinate.cube_6);

  static MyTween<Coordinate> get cube_0_7N =>
      MyTween(begin: Coordinate.zero, end: -KCoordinate.cube_7);

  static MyTween<Coordinate> get cube_0_8N =>
      MyTween(begin: Coordinate.zero, end: -KCoordinate.cube_8);

  static MyTween<Coordinate> get cube_0_9N =>
      MyTween(begin: Coordinate.zero, end: -KCoordinate.cube_9);

  static MyTween<Coordinate> get cube_0_10N =>
      MyTween(begin: Coordinate.zero, end: -KCoordinate.cube_10);

  // (0 -> 50) ~ (100 -> 50)
  static MyTween<Coordinate> get cube_0_50 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_50);

  static MyTween<Coordinate> get cube_10_50 =>
      MyTween(begin: KCoordinate.cube_10, end: KCoordinate.cube_50);

  static MyTween<Coordinate> get cube_20_50 =>
      MyTween(begin: KCoordinate.cube_20, end: KCoordinate.cube_50);

  static MyTween<Coordinate> get cube_30_50 =>
      MyTween(begin: KCoordinate.cube_30, end: KCoordinate.cube_50);

  static MyTween<Coordinate> get cube_40_50 =>
      MyTween(begin: KCoordinate.cube_40, end: KCoordinate.cube_50);

  static MyTween<Coordinate> get cube_60_50 =>
      MyTween(begin: KCoordinate.cube_60, end: KCoordinate.cube_50);

  static MyTween<Coordinate> get cube_70_50 =>
      MyTween(begin: KCoordinate.cube_70, end: KCoordinate.cube_50);

  static MyTween<Coordinate> get cube_80_50 =>
      MyTween(begin: KCoordinate.cube_80, end: KCoordinate.cube_50);

  static MyTween<Coordinate> get cube_90_50 =>
      MyTween(begin: KCoordinate.cube_90, end: KCoordinate.cube_50);

  static MyTween<Coordinate> get cube_100_50 =>
      MyTween(begin: KCoordinate.cube_100, end: KCoordinate.cube_50);

  // (0 -> 100) ~ (90 -> 100)
  static MyTween<Coordinate> get cube_0_100 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_100);

  static MyTween<Coordinate> get cube_10_100 =>
      MyTween(begin: KCoordinate.cube_10, end: KCoordinate.cube_100);

  static MyTween<Coordinate> get cube_20_100 =>
      MyTween(begin: KCoordinate.cube_20, end: KCoordinate.cube_100);

  static MyTween<Coordinate> get cube_30_100 =>
      MyTween(begin: KCoordinate.cube_30, end: KCoordinate.cube_100);

  static MyTween<Coordinate> get cube_40_100 =>
      MyTween(begin: KCoordinate.cube_40, end: KCoordinate.cube_100);

  static MyTween<Coordinate> get cube_50_100 =>
      MyTween(begin: KCoordinate.cube_50, end: KCoordinate.cube_100);

  static MyTween<Coordinate> get cube_60_100 =>
      MyTween(begin: KCoordinate.cube_60, end: KCoordinate.cube_100);

  static MyTween<Coordinate> get cube_70_100 =>
      MyTween(begin: KCoordinate.cube_70, end: KCoordinate.cube_100);

  static MyTween<Coordinate> get cube_80_100 =>
      MyTween(begin: KCoordinate.cube_80, end: KCoordinate.cube_100);

  static MyTween<Coordinate> get cube_90_100 =>
      MyTween(begin: KCoordinate.cube_90, end: KCoordinate.cube_100);

  static MyTween<Coordinate> get cube_0_101 =>
      MyTween(begin: Coordinate.zero, end: KCoordinate.cube_101);
}

extension VTweenCoordinateRadian on Tween {
  /// x, y, z

  // 360
  static MyTween<Coordinate> get x_0_360 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleX_360);

  static MyTween<Coordinate> get y_0_360 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleY_360);

  static MyTween<Coordinate> get z_0_360 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleZ_360);

  // 270
  static MyTween<Coordinate> get x_0_270 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleX_270);

  static MyTween<Coordinate> get y_0_270 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleY_270);

  static MyTween<Coordinate> get z_0_270 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleZ_270);

  // 180
  static MyTween<Coordinate> get x_0_180 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleX_180);

  static MyTween<Coordinate> get y_0_180 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleY_180);

  static MyTween<Coordinate> get z_0_180 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleZ_180);

  // 90
  static MyTween<Coordinate> get x_0_90 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleX_90);

  static MyTween<Coordinate> get y_0_90 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleY_90);

  static MyTween<Coordinate> get z_0_90 =>
      MyTween(begin: Coordinate.zero, end: KCoordinateRadian.angleZ_90);

  /// xy, yz, xz

  static MyTween<Coordinate> get xy_0_360 => MyTween(
        begin: Coordinate.zero,
        end: KCoordinateRadian.angleX_360 + KCoordinateRadian.angleY_360,
      );

  static MyTween<Coordinate> get yz_0_360 => MyTween(
        begin: Coordinate.zero,
        end: KCoordinateRadian.angleY_360 + KCoordinateRadian.angleZ_360,
      );

  static MyTween<Coordinate> get xz_0_360 => MyTween(
        begin: Coordinate.zero,
        end: KCoordinateRadian.angleX_360 + KCoordinateRadian.angleZ_360,
      );

  static MyTween<Coordinate> get xyz_0_360 => MyTween(
        begin: Coordinate.zero,
        end: KCoordinateRadian.angleX_360 +
            KCoordinateRadian.angleY_360 +
            KCoordinateRadian.angleZ_360,
      );
}

extension VTweenVector on VectorTween {
  static VectorTween get dir_0xyz_101xyz_dis_20_100 => VectorTween(
        begin: KVector.dir_0xyz_dis_20,
        end: KVector.dir_101xyz_dis_100,
      );
}

extension VTweenDecoration on Tween<Decoration> {
  static Tween<Decoration> get style1 => DecorationTween(
        begin: KBoxDecorationShadow1.normalBlack1,
        end: KBoxDecorationShadow1.normalBlack3,
      );

  static Tween<Decoration> get style2 => DecorationTween(
        begin: KBoxDecorationShadow1.normalBlack2,
        end: KBoxDecorationShadow1.normalBlack4,
      );

  static Tween<Decoration> get style3 => DecorationTween(
        begin: KBoxDecorationShadow1.normalBlack3,
        end: KBoxDecorationShadow1.normalOrange1,
      );
}

extension VTweenPathCircle on PathTween {
  ///
  /// c: center point
  /// r: radius
  ///

  static PathTween<Vector> get c_0xy_101xy_r_20_100 => PathTween.fromTween(
        VTweenVector.dir_0xyz_101xyz_dis_20_100,
        plan: (v) =>
            FSizeToPath.circle(center: v.direction, radius: v.distance),
      );

  static PathTween<Vector> get c_0xy_101xy_r_20_100_invert =>
      PathTween.fromTween(
        VTweenVector.dir_0xyz_101xyz_dis_20_100,
        plan: (v) => FSizeToPath.circle(
          center: v.direction,
          radius: v.distance,
          invertFromSize: true,
        ),
      );
}

extension VTweenTarget on TweenTargetAbleMixin<double> {
  static TweenTargetAbleMixin<double> get double_05_1_05 =>
      TweenTargetAbleMixin.targets(
        begin: 0.5,
        end: 0.5,
        intervals: [1.0],
      );
}

extension VCurve on Curve {
  static Curve get sin_3_04 => MyCurve(
        FDoubleMapper.sinFromFactor(timeFactor: 3, factor: 0.4),
      );
}

extension FCurveRadian on Curve {
  static Curve sinPeriodOf(double times) =>
      MyCurve(FDoubleMapper.sinPeriodOf(times));
}

///
/// [Mation], [MationSettingTime], [Ani]
///

extension KAniSetting on Ani {
  /// function constant

  static const initialize = _initialize;
  static const initializeForward = _initializeForward;
  static const listenNothing = _listenNothing;
  static const listenForward = _listenForward;
  static const listenForwardOrReverse = _listenForwardOrReverse;
  static const listenForwardReset = _listenForwardReset;
  static const listenRepeat = _listenRepeat;
  static const listenRepeatReverse = _listenRepeatReverse;
  static const listenRepeatIf = _listenRepeatIf;
  static const listenResetForward = _listenResetForward;

  /// function for backend

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

  static void _listenNothing(AnimationController c) {}

  static void _listenForward(AnimationController c) => c.forward();

  static void _listenForwardReset(AnimationController c) =>
      c.forward().then((_) => c.reset());

  static void _listenResetForward(AnimationController c) => c
    ..reset()
    ..forward();

  static void _listenForwardOrReverse(AnimationController controller) =>
      controller.status == AnimationStatus.dismissed
          ? controller.forward()
          : controller.reverse();

  static void _listenRepeat(AnimationController c) => c.repeat();

  static void _listenRepeatReverse(AnimationController c) =>
      c.repeat(reverse: true);

  static AnimationControllerListener _listenRepeatIf(bool toggle) =>
      toggle ? (controller) => controller.repeat() : _listenNothing;

  /// function for widget

  static AnimationControllerListener listenResetForwardIf(bool toggle) => toggle
      ? (controller) => controller
        ..reset()
        ..forward()
      : _listenNothing;
}

extension KAniInitForward on Ani {
  static const second1 = Ani.initForward();

  static const second2 = Ani.initForward(
    forward: KDuration.second2,
  );

  static const second3 = Ani.initForward(
    forward: KDuration.second3,
  );
}

extension KAniInitRepeat on Ani {
  static const second1 = Ani.initRepeat();
  static const second2 = Ani.initRepeat(
    forward: KDuration.second2,
  );

  static const second3 = Ani.initRepeat(
    forward: KDuration.second3,
  );

  static const sin_3_04_900MILLI = Ani.initRepeat(
    forward: KDuration.milli900,
  );
}

extension KAniInitRepeatReverse on Ani {
  /// fast out slow in

  static const second1 = Ani.initRepeat(reverseEnable: true);
  static const second1_2 = Ani.initRepeat(
    reverseEnable: true,
    reverse: KDuration.second2,
  );

  static const second2_3 = Ani.initRepeat(
    reverseEnable: true,
    forward: KDuration.second2,
    reverse: KDuration.second3,
  );

  static const second3_4 = Ani.initRepeat(
    reverseEnable: true,
    forward: KDuration.second3,
    reverse: KDuration.second4,
  );

  /// ease in out
  static const second3 = Ani.initRepeat(
    reverseEnable: true,
    forward: KDuration.second3,
    reverse: KDuration.second3,
  );
}

// init Forward Or Reverse
extension KAniInitFor on Ani {
  static const second3 = Ani.initForwardOrReverseFR(
    duration: KDuration.second3,
  );
}

// init forward and update Forward Or Reverse
extension KAniInitForwardAndUpdateFor on Ani {
  static const second1 = Ani.initForwardAndUpdateForFR(
    duration: KDuration.second1,
  );

  static const second2 = Ani.initForwardAndUpdateForFR(
    duration: KDuration.second2,
  );

  static const second3 = Ani.initForwardAndUpdateForFR(
    duration: KDuration.second3,
  );

  static const second10 = Ani.initForwardAndUpdateForFR(
    duration: KDuration.second10,
  );

  static const second30 = Ani.initForwardAndUpdateForFR(
    duration: KDuration.second30,
  );

  static const min1 = Ani.initForwardAndUpdateForFR(
    duration: KDuration.min1,
  );
}

///
/// [MationTransition]
///

extension VMationTransition on MationTransition {
  static MationTransition<double> get spin =>
      MationTransition<double>.rotate(VTweenDouble.angle_0_360);

  static MationTransition<double> get fadeIn =>
      MationTransition<double>.fade(VTweenDouble.double_0_1);

  static MationTransition<double> get fadeInAndOut =>
      MationTransition<double>.fade(VTweenDouble.double_0_1);

  static List<Iterable<MationTransition>> style0 = [
    style0Begin,
    //...
  ];

  static List<MationTransition> get style0Begin => [
        MationTransition.translate(
          MyTween(begin: Coordinate.zero, end: KCoordinateDirection.right),
        ),
        MationTransition.decoration(
          DecorationTween(
            begin: KBoxDecorationShadow2.style1,
            end: KBoxDecorationShadow2.style2,
          ),
        ),
      ];
}

///
/// [MationTransform]
///

extension VMationTransformTranslate on MationTransform {
  static MationTransform get none =>
      MationTransform.translate(VTweenCoordinate.cube_0_1);
}

extension VMationTransformScale on MationTransform {
  static MationTransform get scale_1xyz =>
      MationTransform.scale(VTweenCoordinate.zero);
}

extension VMationTransformRotate on MationTransform {
  static MationTransform get none =>
      MationTransform.rotate(VTweenCoordinate.zero);

  static MationTransform get topCenter_3 => MationTransform.rotate(
        alignment: Alignment.topCenter,
        VTweenCoordinateRadian.y_0_360,
      );
}

extension FAnimationTransformClipper on MyAnimation {
  static MyAnimation rotate({
    Clip clipBehavior = Clip.antiAlias,
    required AlignmentGeometry alignment,
    required Ani setting,
    required MyTween<Coordinate> tween,
    required SizeToPath sizeToPath,
    required Widget child,
  }) =>
      MyAnimation(
        mation: MationTransform.rotate(alignment: alignment, tween),
        child: ClipPath(
          clipper: MyClipper.reClipNeverOf(sizeToPath),
          clipBehavior: clipBehavior,
          child: child,
        ),
      );
}

extension FAnimationTransformRowTransformClipper on MyAnimation {
  static MyAnimation rotateHalfCircleFlip({
    MainAxisAlignment halfCircleAlignment = MainAxisAlignment.center,
    Widget? childRight,
    Widget? childLeft,
    required MyTween<Coordinate> tweenRotate,
    required MyTween<Coordinate> tweenFlip,
    required AnimationStatusListener statusListenerRotate,
    required AnimationStatusListener statusListenerFlip,
    required bool isFlipped,
  }) =>
      MyAnimation(
        ani: Ani(
          statusListener: statusListenerRotate,
          initListener: KAniSetting.listenForward,
          updateListener: KAniSetting.listenResetForwardIf(isFlipped),
        ),
        mation: MationTransform.rotate(
          alignment: Alignment.center,
          tweenRotate,
        ),
        child: Row(
          mainAxisAlignment: halfCircleAlignment,
          children: [
            FAnimationTransformClipper.rotate(
              tween: tweenFlip,
              alignment: Alignment.centerRight,
              sizeToPath: FSizeToPathRow.circleLeftRight(isRight: false),
              setting: Ani(
                updateListener: KAniSetting.listenResetForwardIf(!isFlipped),
              ),
              child: childLeft ?? VContainer.squareBlue_100,
            ),
            FAnimationTransformClipper.rotate(
              tween: tweenFlip,
              alignment: Alignment.centerLeft,
              sizeToPath: FSizeToPathRow.circleLeftRight(isRight: true),
              setting: Ani(
                statusListener: statusListenerFlip,
                updateListener: KAniSetting.listenResetForwardIf(!isFlipped),
              ),
              child: childRight ?? VContainer.squareYellow_100,
            ),
          ],
          // children: [VContainerStyled.gradiantWhitRed],
        ),
      );
}

///
/// clipper, painter
///

extension VMationClipper on MationClipper {
  static MationClipper get diagonalCircle_1_2 =>
      MationClipper(VTweenPathCircle.c_0xy_101xy_r_20_100);

  static MationClipper get diagonalCircleInvert_1_2 =>
      MationClipper(VTweenPathCircle.c_0xy_101xy_r_20_100_invert);
}

extension VMationPainter on MationPainter {
  static MationPainter get strokeCircleBlack_1 =>
      MationPainter.drawPathTweenWithPaint(
        VTweenPathCircle.c_0xy_101xy_r_20_100,
        canvasSizeToPaint: (canvas, size) => VPaintStroke.black_3_capRound,
      );

  static MationPainter get fillCircleRed_1 =>
      MationPainter.drawPathTweenWithPaint(
        VTweenPathCircle.c_0xy_101xy_r_20_100,
        canvasSizeToPaint: (canvas, size) => VPaintFill.red,
      );
}

///
/// [progressingCircles]
/// [rRegularPolygon]
///

extension FMationPainter on MationPainter {
  static MationPainter progressingCircles({
    double initialCircleRadius = 5.0,
    double circleRadiusFactor = 0.1,
    required Ani setting,
    required Paint paint,
    required Tween<double> radiusOrbit,
    required int circleCount,
    required VectorToVectorGenerator planetGenerator,
  }) =>
      MationPainter.drawPathTweenWithPaint(
        canvasSizeToPaint: (_, __) => paint,
        PathTween.fromTween(
          VectorTween.ofDirectionDistance(
            VTweenCoordinateRadian.z_0_360,
            radiusOrbit,
          ),
          plan: (vector) => FSizeToPathOperation.operateAll(
            operation: PathOperation.union,
            sps: Iterable.generate(
              circleCount,
                  (i) => FSizeToPath.circle(
                center: planetGenerator(vector, i).toCoordinate,
                radius: initialCircleRadius * (i + 1) * circleRadiusFactor,
              ),
            ),
          ),
        ),
      );
}
