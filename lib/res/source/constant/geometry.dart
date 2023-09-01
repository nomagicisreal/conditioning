// ignore_for_file: constant_identifier_names, non_constant_identifier_names

part of source;

///
/// this file contains:
/// [KRadian], [FRadian]
/// [KRadius]
/// [KSize], [FSizeToDouble]
/// [KEdgeInsets]
/// [KBorderRadius]
/// [KAlignment]
///
/// [KOffset]
/// [KCoordinate]
/// [KCoordinateDirection]
/// [KCoordinateRadian]
/// [KVector]
///
/// [FRRegularPolygon]
///
///
///

const kCenterFlutterLogo = Center(child: FlutterLogo(size: 20));

extension KRadian on double {
  static const angle_450 = pi * 5 / 2;
  static const angle_420 = pi * 7 / 3;
  static const angle_390 = pi * 13 / 6;
  static const angle_360 = pi * 2;
  static const angle_315 = pi * 7 / 4;
  static const angle_270 = pi * 3 / 2;
  static const angle_240 = pi * 4 / 3;
  static const angle_225 = pi * 5 / 4;
  static const angle_180 = pi;
  static const angle_135 = pi * 3 / 4;
  static const angle_120 = pi * 2 / 3;
  static const angle_90 = pi / 2;
  static const angle_85 = pi * 17 / 36;
  static const angle_80 = pi * 4 / 9;
  static const angle_75 = pi * 5 / 12;
  static const angle_70 = pi * 7 / 18;
  static const angle_60 = pi / 3;
  static const angle_50 = pi * 5 / 18;
  static const angle_45 = pi / 4;
  static const angle_40 = pi * 2 / 9;
  static const angle_30 = pi / 6;
  static const angle_20 = pi / 9;
  static const angle_15 = pi / 12;
  static const angle_10 = pi / 18;
  static const angle_5 = pi / 36;
  static const angle_1 = pi / 180;
  static const angle_01 = angle_1 / 10;
  static const angle_001 = angle_1 / 100;
}

extension FRadian on double {
  static double angleOf(double radian) => radian / KRadian.angle_1;

  static double radianOf(double angle) => angle * KRadian.angle_1;

  static double complementaryOf(double radian) {
    assert(radian >= 0 && radian <= KRadian.angle_90);
    return radianOf(90 - angleOf(radian));
  }

  static double supplementaryOf(double radian) {
    assert(radian >= 0 && radian <= KRadian.angle_180);
    return radianOf(180 - angleOf(radian));
  }

  ///
  /// if [operator] == [Operator.plus] or [Operator.minus] or [Operator.modulus]
  /// [angle] must be the value of angle, not the value of radian
  ///
  static double operateWithAngle(
    double radian,
    Operator operator,
    double angle,
  ) =>
      switch (operator) {
        Operator.plus => radianOf(angleOf(radian) + angle),
        Operator.minus => radianOf(angleOf(radian) - angle),
        Operator.modulus => radianOf(angleOf(radian) % angle),
        _ => throw UnimplementedError(),
      };

  static double operateAllWithAngle(
    double radian,
    Map<Operator, double> angleOperations,
  ) =>
      radianOf(
        angleOperations.fold(
          angleOf(radian),
          (current, operation) => switch (operation.key) {
            Operator.plus => current + operation.value,
            Operator.minus => current - operation.value,
            Operator.multiply => current * operation.value,
            Operator.divide => current / operation.value,
            Operator.modulus => current % operation.value,
          },
        ),
      );

  static double restrictWithinAngle180_180N(double radian) {
    final r = radian % 360;
    return r >= KRadian.angle_180 ? r - KRadian.angle_360 : r;
  }

  static bool checkIfWithinAngle90_90N(double radian) =>
      radian.abs() < KRadian.angle_90;

  static bool checkIfWithinAngle0_180(double radian) =>
      radian > 0 && radian < KRadian.angle_180;

  static bool checkIfWithinAngle0_180N(double radian) =>
      radian < 0 && radian > -KRadian.angle_180;
}

extension FRadianCoordinate on Coordinate {
  static Coordinate complementaryOf(Coordinate radian) => Coordinate(
        FRadian.complementaryOf(radian.dx),
        FRadian.complementaryOf(radian.dy),
        FRadian.complementaryOf(radian.dz),
      );

  static Coordinate supplementaryOf(Coordinate radian) => Coordinate(
        FRadian.supplementaryOf(radian.dx),
        FRadian.supplementaryOf(radian.dy),
        FRadian.supplementaryOf(radian.dz),
      );

  static Coordinate restrictInAngle180Of(Coordinate radian) => Coordinate(
        FRadian.restrictWithinAngle180_180N(radian.dx),
        FRadian.restrictWithinAngle180_180N(radian.dy),
        FRadian.restrictWithinAngle180_180N(radian.dz),
      );
}

extension KRadius on Radius {
  static const circular1 = Radius.circular(1);
  static const circular2 = Radius.circular(2);
  static const circular3 = Radius.circular(3);
  static const circular4 = Radius.circular(4);
  static const circular5 = Radius.circular(5);
  static const circular6 = Radius.circular(6);
  static const circular7 = Radius.circular(7);
  static const circular8 = Radius.circular(8);
  static const circular9 = Radius.circular(9);
  static const circular10 = Radius.circular(10);
  static const circular11 = Radius.circular(11);
  static const circular12 = Radius.circular(12);
  static const circular13 = Radius.circular(13);
  static const circular14 = Radius.circular(14);
  static const circular15 = Radius.circular(15);
  static const circular16 = Radius.circular(16);
  static const circular17 = Radius.circular(17);
  static const circular18 = Radius.circular(18);
  static const circular19 = Radius.circular(19);
  static const circular20 = Radius.circular(20);
  static const circular21 = Radius.circular(21);
  static const circular22 = Radius.circular(22);
  static const circular23 = Radius.circular(23);
  static const circular24 = Radius.circular(24);
  static const circular25 = Radius.circular(25);
  static const circular26 = Radius.circular(26);
  static const circular27 = Radius.circular(27);
  static const circular28 = Radius.circular(28);
  static const circular29 = Radius.circular(29);
  static const circular30 = Radius.circular(30);
  static const circular31 = Radius.circular(31);
  static const circular32 = Radius.circular(32);
  static const circular33 = Radius.circular(33);
  static const circular34 = Radius.circular(34);
  static const circular35 = Radius.circular(35);
  static const circular36 = Radius.circular(36);
  static const circular37 = Radius.circular(37);
  static const circular38 = Radius.circular(38);
  static const circular39 = Radius.circular(39);
  static const circular40 = Radius.circular(40);
  static const circular41 = Radius.circular(41);
  static const circular42 = Radius.circular(42);
  static const circular43 = Radius.circular(43);
  static const circular44 = Radius.circular(44);
  static const circular45 = Radius.circular(45);
  static const circular46 = Radius.circular(46);
  static const circular47 = Radius.circular(47);
  static const circular48 = Radius.circular(48);
  static const circular49 = Radius.circular(49);
  static const circular50 = Radius.circular(50);
  static const circular51 = Radius.circular(51);
  static const circular52 = Radius.circular(52);
  static const circular53 = Radius.circular(53);
  static const circular54 = Radius.circular(54);
  static const circular55 = Radius.circular(55);
  static const circular56 = Radius.circular(56);
  static const circular57 = Radius.circular(57);
  static const circular58 = Radius.circular(58);
  static const circular59 = Radius.circular(59);
  static const circular60 = Radius.circular(60);
  static const circular61 = Radius.circular(61);
  static const circular62 = Radius.circular(62);
  static const circular63 = Radius.circular(63);
  static const circular64 = Radius.circular(64);
}

extension KSize on Size {
  static const square_10 = Size.square(10);
  static const square_50 = Size.square(50);
  static const square_100 = Size.square(100);
  static const square_200 = Size.square(200);
  static const square_300 = Size.square(300);
}

extension FSizeToDouble on Size {
  static const widthHalf = _widthHalf;
  static const widthQuarter = _widthQuarter;
  static const heightHalf = _heightHalf;
  static const heightQuarter = _heightQuarter;

  static double _widthHalf(Size size) => size.width / 2;

  static double _widthQuarter(Size size) => size.width / 4;

  static double _heightHalf(Size size) => size.height / 2;

  static double _heightQuarter(Size size) => size.height / 4;
}

extension FSizeToOffset on Size {
  static const xy_wh = _xy_wh;
  static const xy_whHalf = _xy_whHalf;
  static const xy_whQuarter = _xy_whQuarter;

  static Offset _xy_wh(Size size) => size.toOffset;

  static Offset _xy_whHalf(Size s) => Offset(s.width / 2, s.height / 2);

  static Offset _xy_whQuarter(Size s) => Offset(s.width / 4, s.height / 4);
}

extension KEdgeInsets on EdgeInsets {
  static const onlyLeft_4 = EdgeInsets.only(left: 4);
  static const onlyLeft_8 = EdgeInsets.only(left: 8);
  static const onlyLeft_10 = EdgeInsets.only(left: 10);
  static const onlyLeft_24 = EdgeInsets.only(left: 24);
  static const onlyLeftTop_10 = EdgeInsets.only(left: 10, top: 10);
  static const onlyLeftTop_100 = EdgeInsets.only(left: 100, top: 100);
  static const onlyTop_4 = EdgeInsets.only(top: 4);
  static const onlyTop_8 = EdgeInsets.only(top: 8);
  static const onlyTop_12 = EdgeInsets.only(top: 12);
  static const onlyTop_16 = EdgeInsets.only(top: 16);
  static const onlyTop_32 = EdgeInsets.only(top: 32);
  static const onlyBottom_8 = EdgeInsets.only(bottom: 8);
  static const onlyBottom_16 = EdgeInsets.only(bottom: 16);
  static const onlyBottom_32 = EdgeInsets.only(bottom: 32);
  static const onlyBottom_64 = EdgeInsets.only(bottom: 64);
  static const onlyRight_4 = EdgeInsets.only(right: 4);
  static const onlyRight_8 = EdgeInsets.only(right: 8);
  static const onlyRight_10 = EdgeInsets.only(right: 10);
  static const onlyRightTop_10 = EdgeInsets.only(right: 10, top: 10);

  static const symH_8 = EdgeInsets.symmetric(horizontal: 8);
  static const symH_10 = EdgeInsets.symmetric(horizontal: 10);
  static const symH_12 = EdgeInsets.symmetric(horizontal: 12);
  static const symH_20 = EdgeInsets.symmetric(horizontal: 20);
  static const symH_32 = EdgeInsets.symmetric(horizontal: 32);
  static const symH_64 = EdgeInsets.symmetric(horizontal: 64);
  static const symV_4 = EdgeInsets.symmetric(vertical: 4);
  static const symV_16 = EdgeInsets.symmetric(vertical: 16);
  static const symV_32 = EdgeInsets.symmetric(vertical: 32);
  static const symV_64 = EdgeInsets.symmetric(vertical: 64);
  static const symHV_64_32 = EdgeInsets.symmetric(horizontal: 64, vertical: 32);

  static const all_2 = EdgeInsets.all(2);
  static const all_4 = EdgeInsets.all(4);
  static const all_8 = EdgeInsets.all(8);
  static const all_10 = EdgeInsets.all(10);
  static const all_12 = EdgeInsets.all(12);
  static const all_16 = EdgeInsets.all(16);
  static const all_20 = EdgeInsets.all(20);
  static const all_32 = EdgeInsets.all(32);
  static const all_36 = EdgeInsets.all(36);
  static const all_100 = EdgeInsets.all(100);
  static const all_500 = EdgeInsets.all(500);

  static const ltrb_8_0_8_20 = EdgeInsets.fromLTRB(8, 0, 8, 20);
  static const ltrb_16_20_16_16 = EdgeInsets.fromLTRB(64, 20, 64, 8);
  static const ltrb_32_20_32_8 = EdgeInsets.fromLTRB(32, 20, 32, 8);
  static const ltrb_64_20_64_8 = EdgeInsets.fromLTRB(64, 20, 64, 8);
  static const ltrb_50_6_0_8 = EdgeInsets.fromLTRB(50, 6, 0, 8);
}

extension KBorderRadius on BorderRadius {
  static const allCircular_5 = BorderRadius.all(KRadius.circular5);
  static const allCircular_6 = BorderRadius.all(KRadius.circular6);
  static const allCircular_7 = BorderRadius.all(KRadius.circular7);
  static const allCircular_8 = BorderRadius.all(KRadius.circular8);
  static const allCircular_9 = BorderRadius.all(KRadius.circular9);
  static const allCircular_10 = BorderRadius.all(KRadius.circular10);
  static const allCircular_11 = BorderRadius.all(KRadius.circular11);
  static const allCircular_12 = BorderRadius.all(KRadius.circular12);
  static const allCircular_13 = BorderRadius.all(KRadius.circular13);
  static const allCircular_14 = BorderRadius.all(KRadius.circular14);
  static const allCircular_15 = BorderRadius.all(KRadius.circular15);
  static const allCircular_16 = BorderRadius.all(KRadius.circular16);
  static const allCircular_20 = BorderRadius.all(KRadius.circular20);
  static const allCircular_30 = BorderRadius.all(KRadius.circular30);

  static const vertical_0_8 = BorderRadius.vertical(bottom: KRadius.circular8);
  static const vertical_0_16 =
      BorderRadius.vertical(bottom: KRadius.circular16);
  static const vertical_0_32 =
      BorderRadius.vertical(bottom: KRadius.circular32);
  static const vertical_0_56 =
      BorderRadius.vertical(bottom: KRadius.circular56);
  static const vertical_0_64 =
      BorderRadius.vertical(bottom: KRadius.circular64);
}

extension KAlignment on Alignment {
  static const topLeftPairBottomRight =
      MapEntry(Alignment.topLeft, Alignment.bottomRight);

  static const bottomRightPairTopLeft =
      MapEntry(Alignment.bottomRight, Alignment.topLeft);
}

///
/// offset, coordinate
///

extension KOffset on Offset {
  // square
  static const square_1 = Offset(1, 1);
  static const square_10 = Offset(10, 10);
  static const square_20 = Offset(20, 20);
  static const square_30 = Offset(30, 30);
  static const square_40 = Offset(40, 40);
  static const square_50 = Offset(50, 50);
  static const square_60 = Offset(60, 60);
  static const square_70 = Offset(70, 70);
  static const square_80 = Offset(80, 80);
  static const square_90 = Offset(90, 90);
  static const square_100 = Offset(100, 100);
  static const square_100N = Offset(-100, -100);

  // y == 0
  static const x_1 = Offset(1, 0);
  static const x_2 = Offset(2, 0);
  static const x_3 = Offset(3, 0);
  static const x_4 = Offset(4, 0);
  static const x_5 = Offset(5, 0);
  static const x_6 = Offset(6, 0);
  static const x_7 = Offset(7, 0);
  static const x_8 = Offset(8, 0);
  static const x_9 = Offset(9, 0);
  static const x_05 = Offset(0.5, 0);
  static const x_10 = Offset(10, 0);
  static const x_20 = Offset(20, 0);
  static const x_30 = Offset(30, 0);
  static const x_40 = Offset(40, 0);
  static const x_50 = Offset(50, 0);
  static const x_60 = Offset(60, 0);
  static const x_70 = Offset(70, 0);
  static const x_80 = Offset(80, 0);
  static const x_90 = Offset(90, 0);
  static const x_100 = Offset(100, 0);
  static const x_10N = Offset(-10, 0);
  static const x_20N = Offset(-20, 0);
  static const x_30N = Offset(-30, 0);
  static const x_40N = Offset(-40, 0);
  static const x_50N = Offset(-50, 0);
  static const x_60N = Offset(-60, 0);
  static const x_70N = Offset(-70, 0);
  static const x_80N = Offset(-80, 0);
  static const x_90N = Offset(-90, 0);
  static const x_100N = Offset(-100, 0);

  // x == 0
  static const y_05 = Offset(0, 0.5);
  static const y_1 = Offset(0, 1);
  static const y_2 = Offset(0, 2);
  static const y_3 = Offset(0, 3);
  static const y_4 = Offset(0, 4);
  static const y_5 = Offset(0, 5);
  static const y_6 = Offset(0, 6);
  static const y_7 = Offset(0, 7);
  static const y_8 = Offset(0, 8);
  static const y_9 = Offset(0, 9);
  static const y_10 = Offset(0, 10);
  static const y_20 = Offset(0, 20);
  static const y_30 = Offset(0, 30);
  static const y_40 = Offset(0, 40);
  static const y_50 = Offset(0, 50);
  static const y_60 = Offset(0, 60);
  static const y_70 = Offset(0, 70);
  static const y_80 = Offset(0, 80);
  static const y_90 = Offset(0, 90);
  static const y_100 = Offset(0, 100);
  static const y_200 = Offset(0, 200);
  static const y_300 = Offset(0, 300);
  static const y_400 = Offset(0, 400);
  static const y_5N = Offset(0, -5);
  static const y_10N = Offset(0, -10);
  static const y_20N = Offset(0, -20);
  static const y_30N = Offset(0, -30);
  static const y_40N = Offset(0, -40);
  static const y_50N = Offset(0, -50);
  static const y_60N = Offset(0, -60);
  static const y_70N = Offset(0, -70);
  static const y_80N = Offset(0, -80);
  static const y_90N = Offset(0, -90);
  static const y_100N = Offset(0, -100);

  // x == 10
  static const xy_10_20 = Offset(10, 20);
  static const xy_10_30 = Offset(10, 30);
  static const xy_10_40 = Offset(10, 40);
  static const xy_10_50 = Offset(10, 50);
  static const xy_10_60 = Offset(10, 60);
  static const xy_10_70 = Offset(10, 70);
  static const xy_10_80 = Offset(10, 80);
  static const xy_10_90 = Offset(10, 90);
  static const xy_10_10N = Offset(10, -10);
  static const xy_10_20N = Offset(10, -20);
  static const xy_10_30N = Offset(10, -30);
  static const xy_10_40N = Offset(10, -40);
  static const xy_10_50N = Offset(10, -50);
  static const xy_10_60N = Offset(10, -60);
  static const xy_10_70N = Offset(10, -70);
  static const xy_10_80N = Offset(10, -80);
  static const xy_10_90N = Offset(10, -90);

  // x == 20
  static const xy_20_10 = Offset(20, 10);
  static const xy_20_30 = Offset(20, 30);
  static const xy_20_40 = Offset(20, 40);
  static const xy_20_50 = Offset(20, 50);
  static const xy_20_60 = Offset(20, 60);
  static const xy_20_70 = Offset(20, 70);
  static const xy_20_80 = Offset(20, 80);
  static const xy_20_90 = Offset(20, 90);
  static const xy_20_10N = Offset(20, -10);
  static const xy_20_20N = Offset(20, -20);
  static const xy_20_30N = Offset(20, -30);
  static const xy_20_40N = Offset(20, -40);
  static const xy_20_50N = Offset(20, -50);
  static const xy_20_60N = Offset(20, -60);
  static const xy_20_70N = Offset(20, -70);
  static const xy_20_80N = Offset(20, -80);
  static const xy_20_90N = Offset(20, -90);

  // x == 30
  static const xy_30_15 = Offset(30, 15);
  static const xy_30_10 = Offset(30, 10);
  static const xy_30_20 = Offset(30, 20);
  static const xy_30_40 = Offset(30, 40);
  static const xy_30_50 = Offset(30, 50);
  static const xy_30_60 = Offset(30, 60);
  static const xy_30_70 = Offset(30, 70);
  static const xy_30_80 = Offset(30, 80);
  static const xy_30_90 = Offset(30, 90);
  static const xy_30_10N = Offset(30, -10);
  static const xy_30_20N = Offset(30, -20);
  static const xy_30_30N = Offset(30, -30);
  static const xy_30_40N = Offset(30, -40);
  static const xy_30_50N = Offset(30, -50);
  static const xy_30_60N = Offset(30, -60);
  static const xy_30_70N = Offset(30, -70);
  static const xy_30_80N = Offset(30, -80);
  static const xy_30_90N = Offset(30, -90);

  // x == 40
  static const xy_40_10 = Offset(40, 10);
  static const xy_40_20 = Offset(40, 20);
  static const xy_40_30 = Offset(40, 30);
  static const xy_40_50 = Offset(40, 50);
  static const xy_40_60 = Offset(40, 60);
  static const xy_40_70 = Offset(40, 70);
  static const xy_40_80 = Offset(40, 80);
  static const xy_40_90 = Offset(40, 90);
  static const xy_40_10N = Offset(40, -10);
  static const xy_40_20N = Offset(40, -20);
  static const xy_40_30N = Offset(40, -30);
  static const xy_40_40N = Offset(40, -40);
  static const xy_40_50N = Offset(40, -50);
  static const xy_40_60N = Offset(40, -60);
  static const xy_40_70N = Offset(40, -70);
  static const xy_40_80N = Offset(40, -80);
  static const xy_40_90N = Offset(40, -90);

  // x == 50
  static const xy_50_10 = Offset(50, 10);
  static const xy_50_20 = Offset(50, 20);
  static const xy_50_30 = Offset(50, 30);
  static const xy_50_40 = Offset(50, 40);
  static const xy_50_60 = Offset(50, 60);
  static const xy_50_70 = Offset(50, 70);
  static const xy_50_80 = Offset(50, 80);
  static const xy_50_90 = Offset(50, 90);
  static const xy_50_10N = Offset(50, -10);
  static const xy_50_20N = Offset(50, -20);
  static const xy_50_30N = Offset(50, -30);
  static const xy_50_40N = Offset(50, -40);
  static const xy_50_50N = Offset(50, -50);
  static const xy_50_60N = Offset(50, -60);
  static const xy_50_70N = Offset(50, -70);
  static const xy_50_80N = Offset(50, -80);
  static const xy_50_90N = Offset(50, -90);

  // x == 60
  static const xy_60_10 = Offset(60, 10);
  static const xy_60_20 = Offset(60, 20);
  static const xy_60_30 = Offset(60, 30);
  static const xy_60_40 = Offset(60, 40);
  static const xy_60_50 = Offset(60, 50);
  static const xy_60_70 = Offset(60, 70);
  static const xy_60_80 = Offset(60, 80);
  static const xy_60_90 = Offset(60, 90);
  static const xy_60_10N = Offset(60, -10);
  static const xy_60_20N = Offset(60, -20);
  static const xy_60_30N = Offset(60, -30);
  static const xy_60_40N = Offset(60, -40);
  static const xy_60_50N = Offset(60, -50);
  static const xy_60_60N = Offset(60, -60);
  static const xy_60_70N = Offset(60, -70);
  static const xy_60_80N = Offset(60, -80);
  static const xy_60_90N = Offset(60, -90);

  // x == 70
  static const xy_70_10 = Offset(70, 10);
  static const xy_70_20 = Offset(70, 20);
  static const xy_70_30 = Offset(70, 30);
  static const xy_70_40 = Offset(70, 40);
  static const xy_70_50 = Offset(70, 50);
  static const xy_70_60 = Offset(70, 60);
  static const xy_70_80 = Offset(70, 80);
  static const xy_70_90 = Offset(70, 90);
  static const xy_70_10N = Offset(70, -10);
  static const xy_70_20N = Offset(70, -20);
  static const xy_70_30N = Offset(70, -30);
  static const xy_70_40N = Offset(70, -40);
  static const xy_70_50N = Offset(70, -50);
  static const xy_70_60N = Offset(70, -60);
  static const xy_70_70N = Offset(70, -70);
  static const xy_70_80N = Offset(70, -80);
  static const xy_70_90N = Offset(70, -90);

  // x == 80
  static const xy_80_5N = Offset(80, -5);
  static const xy_80_10 = Offset(80, 10);
  static const xy_80_20 = Offset(80, 20);
  static const xy_80_30 = Offset(80, 30);
  static const xy_80_40 = Offset(80, 40);
  static const xy_80_50 = Offset(80, 50);
  static const xy_80_60 = Offset(80, 60);
  static const xy_80_70 = Offset(80, 70);
  static const xy_80_90 = Offset(80, 90);
  static const xy_80_10N = Offset(80, -10);
  static const xy_80_20N = Offset(80, -20);
  static const xy_80_30N = Offset(80, -30);
  static const xy_80_40N = Offset(80, -40);
  static const xy_80_50N = Offset(80, -50);
  static const xy_80_60N = Offset(80, -60);
  static const xy_80_70N = Offset(80, -70);
  static const xy_80_80N = Offset(80, -80);
  static const xy_80_90N = Offset(80, -90);

  // x == 90
  static const xy_90_10 = Offset(90, 10);
  static const xy_90_20 = Offset(90, 20);
  static const xy_90_30 = Offset(90, 30);
  static const xy_90_40 = Offset(90, 40);
  static const xy_90_50 = Offset(90, 50);
  static const xy_90_60 = Offset(90, 60);
  static const xy_90_70 = Offset(90, 70);
  static const xy_90_80 = Offset(90, 80);
  static const xy_90_10N = Offset(90, -10);
  static const xy_90_20N = Offset(90, -20);
  static const xy_90_30N = Offset(90, -30);
  static const xy_90_40N = Offset(90, -40);
  static const xy_90_50N = Offset(90, -50);
  static const xy_90_60N = Offset(90, -60);
  static const xy_90_70N = Offset(90, -70);
  static const xy_90_80N = Offset(90, -80);
  static const xy_90_90N = Offset(90, -90);

  // x == 100
  static const xy_100_10 = Offset(100, 10);
  static const xy_100_20 = Offset(100, 20);
  static const xy_100_30 = Offset(100, 30);
  static const xy_100_40 = Offset(100, 40);
  static const xy_100_50 = Offset(100, 50);
  static const xy_100_60 = Offset(100, 60);
  static const xy_100_70 = Offset(100, 70);
  static const xy_100_80 = Offset(100, 80);
  static const xy_100_90 = Offset(100, 90);
  static const xy_100_10N = Offset(100, -10);
  static const xy_100_20N = Offset(100, -20);
  static const xy_100_30N = Offset(100, -30);
  static const xy_100_40N = Offset(100, -40);
  static const xy_100_50N = Offset(100, -50);
  static const xy_100_60N = Offset(100, -60);
  static const xy_100_70N = Offset(100, -70);
  static const xy_100_80N = Offset(100, -80);
  static const xy_100_90N = Offset(100, -90);

  static const xy_12N_16N = Offset(-12, -16);
  static const xy_2_5 = Offset(2, 5);
  static const xy_2_6 = Offset(2, 6);
  static const xy_4_30 = Offset(4, 30);
  static const xy_5_20 = Offset(5, 20);
  static const xy_35_8N = Offset(35, -8);
}

extension KCoordinate on Coordinate {
  static const cube_1 = Coordinate.cube(1);
  static const cube_2 = Coordinate.cube(2);
  static const cube_3 = Coordinate.cube(3);
  static const cube_4 = Coordinate.cube(4);
  static const cube_5 = Coordinate.cube(5);
  static const cube_6 = Coordinate.cube(6);
  static const cube_7 = Coordinate.cube(7);
  static const cube_8 = Coordinate.cube(8);
  static const cube_9 = Coordinate.cube(9);
  static const cube_10 = Coordinate.cube(10);
  static const cube_20 = Coordinate.cube(20);
  static const cube_30 = Coordinate.cube(30);
  static const cube_40 = Coordinate.cube(40);
  static const cube_50 = Coordinate.cube(50);
  static const cube_60 = Coordinate.cube(60);
  static const cube_70 = Coordinate.cube(70);
  static const cube_80 = Coordinate.cube(80);
  static const cube_90 = Coordinate.cube(90);
  static const cube_100 = Coordinate.cube(100);
  static const cube_101 = Coordinate.cube(101);
  static const cube_150 = Coordinate.cube(150);
  static const cube_300 = Coordinate.cube(300);
  static const cube_200 = Coordinate.cube(200);
  static const cube_500 = Coordinate.cube(500);

  static const xyz_150x_100yz = Coordinate(150, 100, 100);
  static const xyz_150y_100xz = Coordinate(100, 150, 100);
  static const xyz_150z_100xy = Coordinate(100, 100, 150);
  static const xyz_150yz_100x = Coordinate(100, 150, 150);
  static const xyz_150xz_100y = Coordinate(150, 100, 150);
  static const xyz_150xy_100z = Coordinate(150, 150, 100);
  static const xyz_200x_100yz = Coordinate(200, 100, 100);
  static const xyz_200y_100xz = Coordinate(100, 200, 100);
  static const xyz_200z_100xy = Coordinate(100, 100, 200);
  static const xyz_200yz_100x = Coordinate(100, 200, 200);
  static const xyz_200xz_100y = Coordinate(200, 100, 200);
  static const xyz_200xy_200z = Coordinate(200, 200, 100);
  static const xyz_200_150_100 = Coordinate(200, 150, 100);
  static const xyz_200_150_150 = Coordinate(200, 150, 150);
  static const xyz_200_100_150 = Coordinate(200, 100, 150);
  static const xyz_100_200_150 = Coordinate(100, 200, 150);
  static const xyz_150_200_100 = Coordinate(150, 200, 100);
  static const xyz_150_200_150 = Coordinate(150, 200, 150);
  static const xyz_150_100_200 = Coordinate(150, 100, 200);
  static const xyz_150_150_200 = Coordinate(150, 150, 200);
  static const xyz_100_150_200 = Coordinate(100, 150, 200);
  static const xyz_150_200_200 = Coordinate(150, 200, 200);
  static const xyz_200_150_200 = Coordinate(200, 150, 200);
  static const xyz_200_200_150 = Coordinate(200, 200, 150);
}

extension KCoordinateDirection on Coordinate {
  static const top = Coordinate.ofXY(0, -1);
  static const left = Coordinate.ofXY(-1, 0);
  static const bottom = Coordinate.ofXY(0, 1);
  static const right = Coordinate.ofXY(1, 0);
  static const topLeft = Coordinate.ofXY(-1, -1);
  static const topRight = Coordinate.ofXY(1, -1);
  static const bottomLeft = Coordinate.ofXY(-1, 1);
  static const bottomRight = Coordinate.ofXY(1, 1);

  static const front = Coordinate.ofZ(1);
  static const frontTop = Coordinate(0, -1, 1);
  static const frontLeft = Coordinate(-1, 0, 1);
  static const frontBottom = Coordinate(0, 1, 1);
  static const frontRight = Coordinate(1, 0, 1);
  static const frontTopLeft = Coordinate(-1, -1, 1);
  static const frontTopRight = Coordinate(1, -1, 1);
  static const frontBottomLeft = Coordinate(-1, 1, 1);
  static const frontBottomRight = Coordinate(1, 1, 1);

  static const back = Coordinate.ofZ(-1);
  static const backTop = Coordinate(0, -1, -1);
  static const backLeft = Coordinate(-1, 0, -1);
  static const backBottom = Coordinate(0, 1, -1);
  static const backRight = Coordinate(1, 0, -1);
  static const backTopLeft = Coordinate(-1, -1, -1);
  static const backTopRight = Coordinate(1, -1, -1);
  static const backBottomLeft = Coordinate(-1, 1, -1);
  static const backBottomRight = Coordinate(1, 1, -1);
}

extension KCoordinateRadian on Coordinate {
  /// x, y, z, xyz, xy of [KRadian] from first const to last const

  static const angleX_450 = Coordinate.ofX(KRadian.angle_450);
  static const angleY_450 = Coordinate.ofY(KRadian.angle_450);
  static const angleZ_450 = Coordinate.ofZ(KRadian.angle_450);
  static const angleXYZ_450 = Coordinate.cube(KRadian.angle_450);
  static const angleXY_450 =
      Coordinate.ofXY(KRadian.angle_450, KRadian.angle_450);
  static const angleX_420 = Coordinate.ofX(KRadian.angle_420);
  static const angleY_420 = Coordinate.ofY(KRadian.angle_420);
  static const angleZ_420 = Coordinate.ofZ(KRadian.angle_420);
  static const angleXYZ_420 = Coordinate.cube(KRadian.angle_420);
  static const angleXY_420 =
      Coordinate.ofXY(KRadian.angle_420, KRadian.angle_420);
  static const angleX_390 = Coordinate.ofX(KRadian.angle_390);
  static const angleY_390 = Coordinate.ofY(KRadian.angle_390);
  static const angleZ_390 = Coordinate.ofZ(KRadian.angle_390);
  static const angleXYZ_390 = Coordinate.cube(KRadian.angle_390);
  static const angleXY_390 =
      Coordinate.ofXY(KRadian.angle_390, KRadian.angle_390);
  static const angleX_360 = Coordinate.ofX(KRadian.angle_360);
  static const angleY_360 = Coordinate.ofY(KRadian.angle_360);
  static const angleZ_360 = Coordinate.ofZ(KRadian.angle_360);
  static const angleXYZ_360 = Coordinate.cube(KRadian.angle_360);
  static const angleXY_360 =
      Coordinate.ofXY(KRadian.angle_360, KRadian.angle_360);
  static const angleX_315 = Coordinate.ofX(KRadian.angle_315);
  static const angleY_315 = Coordinate.ofY(KRadian.angle_315);
  static const angleZ_315 = Coordinate.ofZ(KRadian.angle_315);
  static const angleXYZ_315 = Coordinate.cube(KRadian.angle_315);
  static const angleXY_315 =
      Coordinate.ofXY(KRadian.angle_315, KRadian.angle_315);
  static const angleX_270 = Coordinate.ofX(KRadian.angle_270);
  static const angleY_270 = Coordinate.ofY(KRadian.angle_270);
  static const angleZ_270 = Coordinate.ofZ(KRadian.angle_270);
  static const angleXYZ_270 = Coordinate.cube(KRadian.angle_270);
  static const angleXY_270 =
      Coordinate.ofXY(KRadian.angle_270, KRadian.angle_270);
  static const angleX_240 = Coordinate.ofX(KRadian.angle_240);
  static const angleY_240 = Coordinate.ofY(KRadian.angle_240);
  static const angleZ_240 = Coordinate.ofZ(KRadian.angle_240);
  static const angleXYZ_240 = Coordinate.cube(KRadian.angle_240);
  static const angleXY_240 =
      Coordinate.ofXY(KRadian.angle_240, KRadian.angle_240);
  static const angleX_225 = Coordinate.ofX(KRadian.angle_225);
  static const angleY_225 = Coordinate.ofY(KRadian.angle_225);
  static const angleZ_225 = Coordinate.ofZ(KRadian.angle_225);
  static const angleXYZ_225 = Coordinate.cube(KRadian.angle_225);
  static const angleXY_225 =
      Coordinate.ofXY(KRadian.angle_225, KRadian.angle_225);
  static const angleX_180 = Coordinate.ofX(KRadian.angle_180);
  static const angleY_180 = Coordinate.ofY(KRadian.angle_180);
  static const angleZ_180 = Coordinate.ofZ(KRadian.angle_180);
  static const angleXYZ_180 = Coordinate.cube(KRadian.angle_180);
  static const angleXY_180 =
      Coordinate.ofXY(KRadian.angle_180, KRadian.angle_180);
  static const angleX_135 = Coordinate.ofX(KRadian.angle_135);
  static const angleY_135 = Coordinate.ofY(KRadian.angle_135);
  static const angleZ_135 = Coordinate.ofZ(KRadian.angle_135);
  static const angleXYZ_135 = Coordinate.cube(KRadian.angle_135);
  static const angleXY_135 =
      Coordinate.ofXY(KRadian.angle_135, KRadian.angle_135);
  static const angleX_120 = Coordinate.ofX(KRadian.angle_120);
  static const angleY_120 = Coordinate.ofY(KRadian.angle_120);
  static const angleZ_120 = Coordinate.ofZ(KRadian.angle_120);
  static const angleXYZ_120 = Coordinate.cube(KRadian.angle_120);
  static const angleXY_120 =
      Coordinate.ofXY(KRadian.angle_120, KRadian.angle_120);
  static const angleX_90 = Coordinate.ofX(KRadian.angle_90);
  static const angleY_90 = Coordinate.ofY(KRadian.angle_90);
  static const angleZ_90 = Coordinate.ofZ(KRadian.angle_90);
  static const angleXYZ_90 = Coordinate.cube(KRadian.angle_90);
  static const angleXY_90 = Coordinate.ofXY(KRadian.angle_90, KRadian.angle_90);
  static const angleX_85 = Coordinate.ofX(KRadian.angle_85);
  static const angleY_85 = Coordinate.ofY(KRadian.angle_85);
  static const angleZ_85 = Coordinate.ofZ(KRadian.angle_85);
  static const angleXYZ_85 = Coordinate.cube(KRadian.angle_85);
  static const angleXY_85 = Coordinate.ofXY(KRadian.angle_85, KRadian.angle_85);
  static const angleX_80 = Coordinate.ofX(KRadian.angle_80);
  static const angleY_80 = Coordinate.ofY(KRadian.angle_80);
  static const angleZ_80 = Coordinate.ofZ(KRadian.angle_80);
  static const angleXYZ_80 = Coordinate.cube(KRadian.angle_80);
  static const angleXY_80 = Coordinate.ofXY(KRadian.angle_80, KRadian.angle_80);
  static const angleX_75 = Coordinate.ofX(KRadian.angle_75);
  static const angleY_75 = Coordinate.ofY(KRadian.angle_75);
  static const angleZ_75 = Coordinate.ofZ(KRadian.angle_75);
  static const angleXYZ_75 = Coordinate.cube(KRadian.angle_75);
  static const angleXY_75 = Coordinate.ofXY(KRadian.angle_75, KRadian.angle_75);
  static const angleX_70 = Coordinate.ofX(KRadian.angle_70);
  static const angleY_70 = Coordinate.ofY(KRadian.angle_70);
  static const angleZ_70 = Coordinate.ofZ(KRadian.angle_70);
  static const angleXYZ_70 = Coordinate.cube(KRadian.angle_70);
  static const angleXY_70 = Coordinate.ofXY(KRadian.angle_70, KRadian.angle_70);
  static const angleX_60 = Coordinate.ofX(KRadian.angle_60);
  static const angleY_60 = Coordinate.ofY(KRadian.angle_60);
  static const angleZ_60 = Coordinate.ofZ(KRadian.angle_60);
  static const angleXYZ_60 = Coordinate.cube(KRadian.angle_60);
  static const angleXY_60 = Coordinate.ofXY(KRadian.angle_60, KRadian.angle_60);
  static const angleX_50 = Coordinate.ofX(KRadian.angle_50);
  static const angleY_50 = Coordinate.ofY(KRadian.angle_50);
  static const angleZ_50 = Coordinate.ofZ(KRadian.angle_50);
  static const angleXYZ_50 = Coordinate.cube(KRadian.angle_50);
  static const angleXY_50 = Coordinate.ofXY(KRadian.angle_50, KRadian.angle_50);
  static const angleX_45 = Coordinate.ofX(KRadian.angle_45);
  static const angleY_45 = Coordinate.ofY(KRadian.angle_45);
  static const angleZ_45 = Coordinate.ofZ(KRadian.angle_45);
  static const angleXYZ_45 = Coordinate.cube(KRadian.angle_45);
  static const angleXY_45 = Coordinate.ofXY(KRadian.angle_45, KRadian.angle_45);
  static const angleX_40 = Coordinate.ofX(KRadian.angle_40);
  static const angleY_40 = Coordinate.ofY(KRadian.angle_40);
  static const angleZ_40 = Coordinate.ofZ(KRadian.angle_40);
  static const angleXYZ_40 = Coordinate.cube(KRadian.angle_40);
  static const angleXY_40 = Coordinate.ofXY(KRadian.angle_40, KRadian.angle_40);
  static const angleX_30 = Coordinate.ofX(KRadian.angle_30);
  static const angleY_30 = Coordinate.ofY(KRadian.angle_30);
  static const angleZ_30 = Coordinate.ofZ(KRadian.angle_30);
  static const angleXYZ_30 = Coordinate.cube(KRadian.angle_30);
  static const angleXY_30 = Coordinate.ofXY(KRadian.angle_30, KRadian.angle_30);
  static const angleX_20 = Coordinate.ofX(KRadian.angle_20);
  static const angleY_20 = Coordinate.ofY(KRadian.angle_20);
  static const angleZ_20 = Coordinate.ofZ(KRadian.angle_20);
  static const angleXYZ_20 = Coordinate.cube(KRadian.angle_20);
  static const angleXY_20 = Coordinate.ofXY(KRadian.angle_20, KRadian.angle_20);
  static const angleX_15 = Coordinate.ofX(KRadian.angle_15);
  static const angleY_15 = Coordinate.ofY(KRadian.angle_15);
  static const angleZ_15 = Coordinate.ofZ(KRadian.angle_15);
  static const angleXYZ_15 = Coordinate.cube(KRadian.angle_15);
  static const angleXY_15 = Coordinate.ofXY(KRadian.angle_15, KRadian.angle_15);
  static const angleX_10 = Coordinate.ofX(KRadian.angle_10);
  static const angleY_10 = Coordinate.ofY(KRadian.angle_10);
  static const angleZ_10 = Coordinate.ofZ(KRadian.angle_10);
  static const angleXYZ_10 = Coordinate.cube(KRadian.angle_10);
  static const angleXY_10 = Coordinate.ofXY(KRadian.angle_10, KRadian.angle_10);
  static const angleX_5 = Coordinate.ofX(KRadian.angle_5);
  static const angleY_5 = Coordinate.ofY(KRadian.angle_5);
  static const angleZ_5 = Coordinate.ofZ(KRadian.angle_5);
  static const angleXYZ_5 = Coordinate.cube(KRadian.angle_5);
  static const angleXY_5 = Coordinate.ofXY(KRadian.angle_5, KRadian.angle_5);
  static const angleX_1 = Coordinate.ofX(KRadian.angle_1);
  static const angleY_1 = Coordinate.ofY(KRadian.angle_1);
  static const angleZ_1 = Coordinate.ofZ(KRadian.angle_1);
  static const angleXYZ_1 = Coordinate.cube(KRadian.angle_1);
  static const angleXY_1 = Coordinate.ofXY(KRadian.angle_1, KRadian.angle_1);
  static const angleX_01 = Coordinate.ofX(KRadian.angle_01);
  static const angleY_01 = Coordinate.ofY(KRadian.angle_01);
  static const angleZ_01 = Coordinate.ofZ(KRadian.angle_01);
  static const angleXYZ_01 = Coordinate.cube(KRadian.angle_01);
  static const angleXY_01 = Coordinate.ofXY(KRadian.angle_01, KRadian.angle_01);
  static const angleX_001 = Coordinate.ofX(KRadian.angle_001);
  static const angleY_001 = Coordinate.ofY(KRadian.angle_001);
  static const angleZ_001 = Coordinate.ofZ(KRadian.angle_001);
  static const angleXYZ_001 = Coordinate.cube(KRadian.angle_001);
  static const angleXY_001 =
      Coordinate.ofXY(KRadian.angle_001, KRadian.angle_001);
}

extension KVector on Vector {
  static const dir_0xyz_dis_20 = Vector(Coordinate.zero, 20);
  static const dir_101xyz_dis_100 = Vector(KCoordinate.cube_101, 100);
}

extension FRRegularPolygon on RRegularPolygon {
  static RRegularPolygonCubicStyleOnEdge randomOfCubicStyleOnEdge({
    MapEntry<int, int> nBound = const MapEntry(3, 8),
    MapEntry<int, int> rBound = const MapEntry(60, 60),
  }) {
    final r = Random();
    return RRegularPolygonCubicStyleOnEdge(
      nBound.key + r.nextInt(nBound.value),
      radiusCircumscribedCircle: rBound.key + r.nextInt(rBound.value),
    );
  }
}

extension VLogo on CustomPaint {
  static RRegularPolygonCubicStyleOnEdge get style1P3 =>
      RRegularPolygonCubicStyleOnEdge(
        3,
        radiusCircumscribedCircle: 50,
        // cornerRadius: double.infinity.filterInfinity(1.51),
        // cornerRadius: double.infinity.filterInfinity(1.43),
        cornerRadius: 10,
        // cubicPointsMapper: KCubicPointsMapper.add0_remove0,
      );

  static RRegularPolygonCubicStyleOnEdge get style1P6 =>
      RRegularPolygonCubicStyleOnEdge(
        6,
        radiusCircumscribedCircle: 55,
        cornerRadius: double.infinity.filterInfinity(2.2),
        cubicPointsMapper: KCubicPointsMapper.add0_remove0,
      );

  static RRegularPolygonCubicStyleOnEdge get style1P9 =>
      RRegularPolygonCubicStyleOnEdge(
        9,
        radiusCircumscribedCircle: 30,
        cornerRadius: double.infinity.filterInfinity(2.5),
        cubicPointsMapper: KCubicPointsMapper.add0_remove0,
      );

  static CanvasSizeToPaint get style1Paint1 => (_, __) => Paint()
    ..style = PaintingStyle.fill
    ..color = KColorStyle1.purpleD1;
//
// static CanvasSizeToPaint get style1Paint2 => (_, __) => Paint()
//   ..style = PaintingStyle.fill
//   ..color = KColorStyle1.purpleD2;
//
// static CanvasSizeToPaint get style1Paint3 => (_, __) => Paint()
//   ..style = PaintingStyle.fill
//   ..color = KColorStyle1.blueD2;
}

extension FCustomPaint on CustomPaint {
  static CustomPaint fromPolygonAndCanvasSizeToPaint(
    RRegularPolygonCubicStyleOnEdge polygon,
    CanvasSizeToPaint canvasSizeToPaint,
  ) =>
      CustomPaint(
        painter: MyPainter.rePaintNever(
            canvasSizeToPaint: canvasSizeToPaint,
            sizeToPath: FSizeToPath.polygonCubicCorner(polygon.cubicPoints)),
      );
}

extension FCustomClip on CustomPaint {
  static ClipPath fromPolygonLinearGradiant(
    RRegularPolygonCubicStyleOnEdge polygon,
    LinearGradient linearGradient,
  ) =>
      ClipPath(
        clipper: MyClipper.reClipNeverOf(
          FSizeToPath.polygonCubicCorner(
            polygon.cubicPoints,
            transform: FOnOffsetListWithSize.transformPointsToSizeCenter,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: linearGradient,
          ),
          child: KSizedBox.expand,
        ),
      );
}
