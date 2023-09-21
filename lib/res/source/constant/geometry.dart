// ignore_for_file: constant_identifier_names, non_constant_identifier_names

part of source;

///
/// this file contains:
/// [KSize], [KSizePaperCM], [KSize3Ratio4], [KSize9Ratio16], [KSize16Ratio9]
/// [KOffset], [KOffsetDirection]
/// [KCoordinate], [KCoordinateDirection]
///
/// [KVector]
/// [KRadian], [FRadian], [KRadianCoordinate], [FRadianCoordinate]
///
/// [KRadius], [KBorderRadius]
/// [KEdgeInsets]
/// [KDivider]
/// [KGridPaper]
/// [KSizedBox]
///
///
///

extension KSize on Size {
  static const square_10 = Size.square(10);
  static const square_20 = Size.square(20);
  static const square_30 = Size.square(30);
  static const square_40 = Size.square(40);
  static const square_50 = Size.square(50);
  static const square_56 = Size.square(56);
  static const square_60 = Size.square(60);
  static const square_70 = Size.square(70);
  static const square_80 = Size.square(80);
  static const square_90 = Size.square(90);
  static const square_100 = Size.square(100);
  static const square_110 = Size.square(110);
  static const square_120 = Size.square(120);
  static const square_130 = Size.square(130);
  static const square_140 = Size.square(140);
  static const square_150 = Size.square(150);
  static const square_160 = Size.square(160);
  static const square_170 = Size.square(170);
  static const square_180 = Size.square(180);
  static const square_190 = Size.square(190);
  static const square_200 = Size.square(200);
  static const square_210 = Size.square(210);
  static const square_220 = Size.square(220);
  static const square_230 = Size.square(230);
  static const square_240 = Size.square(240);
  static const square_250 = Size.square(250);
  static const square_260 = Size.square(260);
  static const square_270 = Size.square(270);
  static const square_280 = Size.square(280);
  static const square_290 = Size.square(290);
  static const square_300 = Size.square(300);
}

extension KSizePaperCM on Size {
  static const a4 = Size(21.0, 29.7);
  static const a3 = Size(29.7, 42.0);
  static const a2 = Size(42.0, 59.4);
  static const a1 = Size(59.4, 84.1);
}

extension KSize3Ratio4 on Size {
  static const w360_h480 = Size(360, 480);
  static const w420_h560 = Size(420, 560);
  static const w450_h600 = Size(450, 600);
  static const w480_h640 = Size(480, 640);
}

extension KSize9Ratio16 on Size {
  static const w270_h480 = Size(270, 480);
  static const w450_h800 = Size(450, 800);
}

extension KSize16Ratio9 on Size {
  static const w800_w450 = Size(800, 450);
}

///
///
///
/// offset
///
///
///

extension KOffset on Offset {
  static const square_1 = Offset(1, 1);
  static const square_2 = Offset(2, 2);
  static const square_3 = Offset(3, 3);
  static const square_4 = Offset(4, 4);
  static const square_5 = Offset(5, 5);
  static const square_6 = Offset(6, 6);
  static const square_7 = Offset(7, 7);
  static const square_8 = Offset(8, 8);
  static const square_9 = Offset(9, 9);
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
  static const square_110 = Offset(110, 110);
  static const square_120 = Offset(120, 120);
  static const square_130 = Offset(130, 130);
  static const square_140 = Offset(140, 140);
  static const square_150 = Offset(150, 150);
  static const square_160 = Offset(160, 160);
  static const square_170 = Offset(170, 170);
  static const square_180 = Offset(180, 180);
  static const square_190 = Offset(190, 190);
  static const square_200 = Offset(200, 200);
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
  static const xy_100_100N = Offset(100, -100);

  // x == 200
  static const xy_200_10 = Offset(200, 10);
  static const xy_200_20 = Offset(200, 20);
  static const xy_200_30 = Offset(200, 30);
  static const xy_200_40 = Offset(200, 40);
  static const xy_200_50 = Offset(200, 50);
  static const xy_200_60 = Offset(200, 60);
  static const xy_200_70 = Offset(200, 70);
  static const xy_200_80 = Offset(200, 80);
  static const xy_200_90 = Offset(200, 90);
  static const xy_200_10N = Offset(200, -10);
  static const xy_200_20N = Offset(200, -20);
  static const xy_200_30N = Offset(200, -30);
  static const xy_200_40N = Offset(200, -40);
  static const xy_200_50N = Offset(200, -50);
  static const xy_200_60N = Offset(200, -60);
  static const xy_200_70N = Offset(200, -70);
  static const xy_200_80N = Offset(200, -80);
  static const xy_200_90N = Offset(200, -90);
  static const xy_200_100N = Offset(200, -100);

  // x == -50
  static const xy_50N_10 = Offset(-50, 10);
  static const xy_50N_20 = Offset(-50, 20);
  static const xy_50N_30 = Offset(-50, 30);
  static const xy_50N_40 = Offset(-50, 40);
  static const xy_50N_50 = Offset(-50, 50);
  static const xy_50N_60 = Offset(-50, 60);
  static const xy_50N_70 = Offset(-50, 70);
  static const xy_50N_80 = Offset(-50, 80);
  static const xy_50N_90 = Offset(-50, 90);
  static const xy_50N_10N = Offset(-50, -10);
  static const xy_50N_20N = Offset(-50, -20);
  static const xy_50N_30N = Offset(-50, -30);
  static const xy_50N_40N = Offset(-50, -40);
  static const xy_50N_50N = Offset(-50, -50);
  static const xy_50N_60N = Offset(-50, -60);
  static const xy_50N_70N = Offset(-50, -70);
  static const xy_50N_80N = Offset(-50, -80);
  static const xy_50N_90N = Offset(-50, -90);
  static const xy_50N_100N = Offset(-50, -100);

  static const xy_12N_16N = Offset(-12, -16);
  static const xy_01_05 = Offset(0.1, 0.5);
  static const xy_2_5 = Offset(2, 5);
  static const xy_2_6 = Offset(2, 6);
  static const xy_4_30 = Offset(4, 30);
  static const xy_5_20 = Offset(5, 20);
  static const xy_35_8N = Offset(35, -8);
}

///
/// See Also:
///   * [KCoordinateDirection]
///   * [_MationTransformBase], [MationTransform]
///   * [Coordinate.transferToTransformOf], [Coordinate.fromDirection]
///
extension KOffsetDirection on Offset {
  static const top = Offset(0, -1);
  static const left = Offset(-1, 0);
  static const right = Offset(1, 0);
  static const bottom = Offset(0, 1);
  static const center = Offset.zero;
  static const topLeft =
      Offset(-DoubleExtension.sqrt1_2, -DoubleExtension.sqrt1_2);
  static const topRight =
      Offset(DoubleExtension.sqrt1_2, -DoubleExtension.sqrt1_2);
  static const bottomLeft =
      Offset(-DoubleExtension.sqrt1_2, DoubleExtension.sqrt1_2);
  static const bottomRight =
      Offset(DoubleExtension.sqrt1_2, DoubleExtension.sqrt1_2);
}

///
///
///
/// coordinate
///
///
///

extension KCoordinate on Coordinate {
  static const cube_01 = Coordinate.cube(0.1);
  static const cube_02 = Coordinate.cube(0.2);
  static const cube_03 = Coordinate.cube(0.3);
  static const cube_04 = Coordinate.cube(0.4);
  static const cube_05 = Coordinate.cube(0.5);
  static const cube_06 = Coordinate.cube(0.6);
  static const cube_07 = Coordinate.cube(0.7);
  static const cube_08 = Coordinate.cube(0.8);
  static const cube_09 = Coordinate.cube(0.9);
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

///
/// See Also:
///   * [KOffsetDirection]
///   * [_MationTransformBase], [MationTransform]
///   * [Coordinate.transferToTransformOf], [Coordinate.fromDirection]
///
extension KCoordinateDirection on Coordinate {
  static const center = Coordinate.zero;
  static const left = Coordinate.ofX(-1);
  static const top = Coordinate.ofY(-1);
  static const right = Coordinate.ofX(1);
  static const bottom = Coordinate.ofY(1);
  static const front = Coordinate.ofZ(1);
  static const back = Coordinate.ofZ(-1);

  static const topLeft =
      Coordinate.ofXY(-DoubleExtension.sqrt1_2, -DoubleExtension.sqrt1_2);
  static const topRight =
      Coordinate.ofXY(DoubleExtension.sqrt1_2, -DoubleExtension.sqrt1_2);
  static const bottomLeft =
      Coordinate.ofXY(-DoubleExtension.sqrt1_2, DoubleExtension.sqrt1_2);
  static const bottomRight =
      Coordinate.ofXY(DoubleExtension.sqrt1_2, DoubleExtension.sqrt1_2);
  static const frontLeft =
      Coordinate.ofXZ(-DoubleExtension.sqrt1_2, DoubleExtension.sqrt1_2);
  static const frontTop =
      Coordinate.ofYZ(-DoubleExtension.sqrt1_2, DoubleExtension.sqrt1_2);
  static const frontRight =
      Coordinate.ofXZ(DoubleExtension.sqrt1_2, DoubleExtension.sqrt1_2);
  static const frontBottom =
      Coordinate.ofYZ(DoubleExtension.sqrt1_2, DoubleExtension.sqrt1_2);
  static const backLeft =
      Coordinate.ofXZ(-DoubleExtension.sqrt1_2, -DoubleExtension.sqrt1_2);
  static const backTop =
      Coordinate.ofYZ(-DoubleExtension.sqrt1_2, -DoubleExtension.sqrt1_2);
  static const backRight =
      Coordinate.ofXZ(DoubleExtension.sqrt1_2, -DoubleExtension.sqrt1_2);
  static const backBottom =
      Coordinate.ofYZ(DoubleExtension.sqrt1_2, -DoubleExtension.sqrt1_2);

  static const frontTopLeft = Coordinate(-DoubleExtension.sqrt1_3,
      -DoubleExtension.sqrt1_3, DoubleExtension.sqrt1_3);
  static const frontTopRight = Coordinate(DoubleExtension.sqrt1_3,
      -DoubleExtension.sqrt1_3, DoubleExtension.sqrt1_3);
  static const frontBottomLeft = Coordinate(-DoubleExtension.sqrt1_3,
      DoubleExtension.sqrt1_3, DoubleExtension.sqrt1_3);
  static const frontBottomRight = Coordinate(DoubleExtension.sqrt1_3,
      DoubleExtension.sqrt1_3, DoubleExtension.sqrt1_3);
  static const backTopLeft = Coordinate(-DoubleExtension.sqrt1_3,
      -DoubleExtension.sqrt1_3, -DoubleExtension.sqrt1_3);
  static const backTopRight = Coordinate(DoubleExtension.sqrt1_3,
      -DoubleExtension.sqrt1_3, -DoubleExtension.sqrt1_3);
  static const backBottomLeft = Coordinate(-DoubleExtension.sqrt1_3,
      DoubleExtension.sqrt1_3, -DoubleExtension.sqrt1_3);
  static const backBottomRight = Coordinate(DoubleExtension.sqrt1_3,
      DoubleExtension.sqrt1_3, -DoubleExtension.sqrt1_3);
}

extension KVector on Vector {
  static const dir_0xyz_dis_20 = Vector(Coordinate.zero, 20);
  static const dir_101xyz_dis_100 = Vector(KCoordinate.cube_101, 100);
}

extension KRadian on double {
  static const angle_450 = math.pi * 5 / 2;
  static const angle_420 = math.pi * 7 / 3;
  static const angle_390 = math.pi * 13 / 6;
  static const angle_360 = math.pi * 2;
  static const angle_315 = math.pi * 7 / 4;
  static const angle_270 = math.pi * 3 / 2;
  static const angle_240 = math.pi * 4 / 3;
  static const angle_225 = math.pi * 5 / 4;
  static const angle_180 = math.pi;
  static const angle_135 = math.pi * 3 / 4;
  static const angle_120 = math.pi * 2 / 3;
  static const angle_90 = math.pi / 2;
  static const angle_85 = math.pi * 17 / 36;
  static const angle_80 = math.pi * 4 / 9;
  static const angle_75 = math.pi * 5 / 12;
  static const angle_70 = math.pi * 7 / 18;
  static const angle_60 = math.pi / 3;
  static const angle_50 = math.pi * 5 / 18;
  static const angle_45 = math.pi / 4;
  static const angle_40 = math.pi * 2 / 9;
  static const angle_30 = math.pi / 6;
  static const angle_20 = math.pi / 9;
  static const angle_15 = math.pi / 12;
  static const angle_10 = math.pi / 18;
  static const angle_5 = math.pi / 36;
  static const angle_1 = math.pi / 180;
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

extension KRadianCoordinate on Coordinate {
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
  static const angleYZ_90 = Coordinate.ofYZ(KRadian.angle_90, KRadian.angle_90);
  static const angleXZ_90 = Coordinate.ofXZ(KRadian.angle_90, KRadian.angle_90);
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

///
///
///
///
/// radius
///
///
///
///

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
  static const circular65 = Radius.circular(65);
  static const circular66 = Radius.circular(66);
  static const circular67 = Radius.circular(67);
  static const circular68 = Radius.circular(68);
  static const circular69 = Radius.circular(69);
  static const circular70 = Radius.circular(70);
  static const circular80 = Radius.circular(80);
  static const circular90 = Radius.circular(90);
  static const circular100 = Radius.circular(100);
  static const circular110 = Radius.circular(110);
  static const circular120 = Radius.circular(120);
  static const circular130 = Radius.circular(130);
  static const circular140 = Radius.circular(140);
  static const circular150 = Radius.circular(150);
  static const circular160 = Radius.circular(160);
  static const circular170 = Radius.circular(170);
  static const circular180 = Radius.circular(180);
  static const circular190 = Radius.circular(190);
  static const circular200 = Radius.circular(200);
}

extension KBorderRadius on BorderRadius {
  static const zero = BorderRadius.all(Radius.zero);
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
  static const allCircular_40 = BorderRadius.all(KRadius.circular40);
  static const allCircular_50 = BorderRadius.all(KRadius.circular50);
  static const allCircular_60 = BorderRadius.all(KRadius.circular60);
  static const allCircular_70 = BorderRadius.all(KRadius.circular70);
  static const allCircular_80 = BorderRadius.all(KRadius.circular80);
  static const allCircular_90 = BorderRadius.all(KRadius.circular90);
  static const allCircular_100 = BorderRadius.all(KRadius.circular100);
  static const allCircular_200 = BorderRadius.all(KRadius.circular200);

  static const vertical_0_8 = BorderRadius.vertical(bottom: KRadius.circular8);
  static const vertical_0_9 = BorderRadius.vertical(bottom: KRadius.circular9);
  static const vertical_0_10 =
      BorderRadius.vertical(bottom: KRadius.circular10);
  static const vertical_0_11 =
      BorderRadius.vertical(bottom: KRadius.circular11);
  static const vertical_0_12 =
      BorderRadius.vertical(bottom: KRadius.circular12);
  static const vertical_0_13 =
      BorderRadius.vertical(bottom: KRadius.circular13);
  static const vertical_0_14 =
      BorderRadius.vertical(bottom: KRadius.circular14);
  static const vertical_0_15 =
      BorderRadius.vertical(bottom: KRadius.circular15);
  static const vertical_0_16 =
      BorderRadius.vertical(bottom: KRadius.circular16);
  static const vertical_0_17 =
      BorderRadius.vertical(bottom: KRadius.circular17);
  static const vertical_0_18 =
      BorderRadius.vertical(bottom: KRadius.circular18);
  static const vertical_0_19 =
      BorderRadius.vertical(bottom: KRadius.circular19);
  static const vertical_0_20 =
      BorderRadius.vertical(bottom: KRadius.circular20);
  static const vertical_0_30 =
      BorderRadius.vertical(bottom: KRadius.circular30);
  static const vertical_0_32 =
      BorderRadius.vertical(bottom: KRadius.circular32);
  static const vertical_0_40 =
      BorderRadius.vertical(bottom: KRadius.circular40);
  static const vertical_0_50 =
      BorderRadius.vertical(bottom: KRadius.circular50);
  static const vertical_0_56 =
      BorderRadius.vertical(bottom: KRadius.circular56);
  static const vertical_0_60 =
      BorderRadius.vertical(bottom: KRadius.circular60);
  static const vertical_0_64 =
      BorderRadius.vertical(bottom: KRadius.circular64);
  static const vertical_0_70 =
      BorderRadius.vertical(bottom: KRadius.circular70);
  static const vertical_0_80 =
      BorderRadius.vertical(bottom: KRadius.circular80);
  static const vertical_0_90 =
      BorderRadius.vertical(bottom: KRadius.circular90);
  static const vertical_0_100 =
      BorderRadius.vertical(bottom: KRadius.circular100);
}

///
///
///
///
/// edgeInsets
///
///
///
///

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
  static const onlyTop_10 = EdgeInsets.only(top: 10);
  static const onlyTop_20 = EdgeInsets.only(top: 20);
  static const onlyTop_30 = EdgeInsets.only(top: 30);
  static const onlyTop_40 = EdgeInsets.only(top: 40);
  static const onlyTop_50 = EdgeInsets.only(top: 50);
  static const onlyTop_60 = EdgeInsets.only(top: 60);
  static const onlyTop_70 = EdgeInsets.only(top: 70);
  static const onlyTop_80 = EdgeInsets.only(top: 80);
  static const onlyTop_90 = EdgeInsets.only(top: 90);
  static const onlyTop_100 = EdgeInsets.only(top: 100);
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
  static const symH_16 = EdgeInsets.symmetric(horizontal: 16);
  static const symH_18 = EdgeInsets.symmetric(horizontal: 18);
  static const symH_20 = EdgeInsets.symmetric(horizontal: 20);
  static const symH_32 = EdgeInsets.symmetric(horizontal: 32);
  static const symH_64 = EdgeInsets.symmetric(horizontal: 64);
  static const symV_4 = EdgeInsets.symmetric(vertical: 4);
  static const symV_8 = EdgeInsets.symmetric(vertical: 8);
  static const symV_16 = EdgeInsets.symmetric(vertical: 16);
  static const symV_32 = EdgeInsets.symmetric(vertical: 32);
  static const symV_64 = EdgeInsets.symmetric(vertical: 64);
  static const symV_10 = EdgeInsets.symmetric(vertical: 10);
  static const symV_20 = EdgeInsets.symmetric(vertical: 20);
  static const symV_30 = EdgeInsets.symmetric(vertical: 30);
  static const symV_40 = EdgeInsets.symmetric(vertical: 40);
  static const symV_50 = EdgeInsets.symmetric(vertical: 50);
  static const symV_60 = EdgeInsets.symmetric(vertical: 60);
  static const symV_70 = EdgeInsets.symmetric(vertical: 70);
  static const symV_80 = EdgeInsets.symmetric(vertical: 80);
  static const symV_90 = EdgeInsets.symmetric(vertical: 90);
  static const symV_100 = EdgeInsets.symmetric(vertical: 100);

  static const symHV_64_32 = EdgeInsets.symmetric(horizontal: 64, vertical: 32);
  static const symHV_32_4 = EdgeInsets.symmetric(horizontal: 32, vertical: 4);
  static const symHV_24_8 = EdgeInsets.symmetric(horizontal: 24, vertical: 8);

  static const all_1 = EdgeInsets.all(1);
  static const all_2 = EdgeInsets.all(2);
  static const all_3 = EdgeInsets.all(3);
  static const all_4 = EdgeInsets.all(4);
  static const all_5 = EdgeInsets.all(5);
  static const all_6 = EdgeInsets.all(6);
  static const all_7 = EdgeInsets.all(7);
  static const all_8 = EdgeInsets.all(8);
  static const all_9 = EdgeInsets.all(9);
  static const all_10 = EdgeInsets.all(10);
  static const all_12 = EdgeInsets.all(12);
  static const all_16 = EdgeInsets.all(16);
  static const all_20 = EdgeInsets.all(20);
  static const all_32 = EdgeInsets.all(32);
  static const all_36 = EdgeInsets.all(36);
  static const all_100 = EdgeInsets.all(100);
  static const all_500 = EdgeInsets.all(500);

  static const ltrb_2_16_2_0 = EdgeInsets.fromLTRB(2, 16, 2, 0);
  static const ltrb_2_0_2_8 = EdgeInsets.fromLTRB(2, 0, 2, 8);
  static const ltrb_4_16_4_0 = EdgeInsets.fromLTRB(4, 16, 4, 0);
  static const ltrb_8_0_8_8 = EdgeInsets.fromLTRB(8, 0, 8, 8);
  static const ltrb_8_0_8_20 = EdgeInsets.fromLTRB(8, 0, 8, 20);
  static const ltrb_8_16_8_0 = EdgeInsets.fromLTRB(8, 16, 8, 0);
  static const ltrb_16_20_16_16 = EdgeInsets.fromLTRB(64, 20, 64, 8);
  static const ltrb_32_20_32_8 = EdgeInsets.fromLTRB(32, 20, 32, 8);
  static const ltrb_64_20_64_8 = EdgeInsets.fromLTRB(64, 20, 64, 8);
  static const ltrb_50_6_0_8 = EdgeInsets.fromLTRB(50, 6, 0, 8);
}

extension KDivider on Divider {
  static const white = Divider(color: Colors.white);
  static const black_3 = Divider(thickness: 3);
}

extension KGridPaper on GridPaper {
  static const none = GridPaper();
  static const simple =
      GridPaper(color: Colors.white, interval: 100, subdivisions: 1);

  static const simpleList = <GridPaper>[simple, simple, simple];

  static const simpleListList = <List<GridPaper>>[
    <GridPaper>[simple, simple, simple],
    <GridPaper>[simple, simple, simple]
  ];
}

extension KSizedBox on SizedBox {
  static const none = SizedBox();
  static const shrink = SizedBox.shrink();
  static const expand = SizedBox.expand();
  static const expandW = SizedBox(width: double.infinity);
  static const expandH = SizedBox(height: double.infinity);

  // square
  static const square5 = SizedBox.square(dimension: 5);
  static const square10 = SizedBox.square(dimension: 10);
  static const square50 = SizedBox.square(dimension: 50);
  static const square100 = SizedBox.square(dimension: 100);

  // height
  static const h10 = SizedBox(height: 10);
  static const h16 = SizedBox(height: 16);
  static const h20 = SizedBox(height: 20);
  static const h30 = SizedBox(height: 30);
  static const h32 = SizedBox(height: 32);
  static const h40 = SizedBox(height: 40);
  static const h50 = SizedBox(height: 50);
  static const h60 = SizedBox(height: 60);
  static const h70 = SizedBox(height: 70);
  static const h80 = SizedBox(height: 80);
  static const h90 = SizedBox(height: 90);
  static const h100 = SizedBox(height: 100);
  static const h110 = SizedBox(height: 110);
  static const h120 = SizedBox(height: 120);
  static const h130 = SizedBox(height: 130);
  static const h140 = SizedBox(height: 140);
  static const h150 = SizedBox(height: 150);
  static const h160 = SizedBox(height: 160);
  static const h170 = SizedBox(height: 170);
  static const h180 = SizedBox(height: 180);
  static const h190 = SizedBox(height: 190);
  static const h200 = SizedBox(height: 200);

  // width
  static const w5 = SizedBox(width: 5);
  static const w10 = SizedBox(width: 10);
  static const w16 = SizedBox(width: 16);
  static const w20 = SizedBox(width: 20);
  static const w30 = SizedBox(width: 30);
  static const w32 = SizedBox(width: 32);
  static const w40 = SizedBox(width: 40);
  static const w50 = SizedBox(width: 50);
  static const w60 = SizedBox(width: 60);
  static const w70 = SizedBox(width: 70);
  static const w80 = SizedBox(width: 80);
  static const w90 = SizedBox(width: 90);
  static const w100 = SizedBox(width: 100);
  static const w110 = SizedBox(width: 110);
  static const w120 = SizedBox(width: 120);
  static const w130 = SizedBox(width: 130);
  static const w140 = SizedBox(width: 140);
  static const w150 = SizedBox(width: 150);
  static const w160 = SizedBox(width: 160);
  static const w170 = SizedBox(width: 170);
  static const w180 = SizedBox(width: 180);
  static const w190 = SizedBox(width: 190);
  static const w200 = SizedBox(width: 200);

  // infinite width
  static const infiniteW_100H = SizedBox(height: 100, width: double.infinity);
  static const infiniteW_200H = SizedBox(height: 200, width: double.infinity);
  static const infiniteW_300H = SizedBox(height: 300, width: double.infinity);
  static const infiniteW_400H = SizedBox(height: 400, width: double.infinity);
  static const infiniteW_500H = SizedBox(height: 500, width: double.infinity);
  static const infiniteW_128H = SizedBox(height: 128, width: double.infinity);
  static const infiniteW_256H = SizedBox(height: 256, width: double.infinity);
  static const infiniteW_512H = SizedBox(height: 512, width: double.infinity);

  // infinite height
  static const infiniteH_16W = SizedBox(height: double.infinity, width: 16);
  static const infiniteH_32W = SizedBox(height: double.infinity, width: 32);
  static const infiniteH_64W = SizedBox(height: double.infinity, width: 64);
  static const infiniteH_128W = SizedBox(height: double.infinity, width: 128);
}

extension FSizedBox on SizedBox {
  static SizedBox square10Of(Widget child) => SizedBox.fromSize(size: KSize.square_10, child: child);
  static SizedBox square20Of(Widget child) => SizedBox.fromSize(size: KSize.square_20, child: child);
  static SizedBox square30Of(Widget child) => SizedBox.fromSize(size: KSize.square_30, child: child);
  static SizedBox square40Of(Widget child) => SizedBox.fromSize(size: KSize.square_40, child: child);
  static SizedBox square50Of(Widget child) => SizedBox.fromSize(size: KSize.square_50, child: child);
  static SizedBox square60Of(Widget child) => SizedBox.fromSize(size: KSize.square_60, child: child);
  static SizedBox square70Of(Widget child) => SizedBox.fromSize(size: KSize.square_70, child: child);
  static SizedBox square80Of(Widget child) => SizedBox.fromSize(size: KSize.square_80, child: child);
  static SizedBox square90Of(Widget child) => SizedBox.fromSize(size: KSize.square_90, child: child);

  static SizedBox square100Of(Widget child) =>
      SizedBox.fromSize(size: KSize.square_100, child: child);

  static SizedBox square200Of(Widget child) =>
      SizedBox.fromSize(size: KSize.square_200, child: child);

  static SizedBox square300Of(Widget child) =>
      SizedBox.fromSize(size: KSize.square_300, child: child);
}
