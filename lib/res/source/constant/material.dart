// ignore_for_file: constant_identifier_names, non_constant_identifier_names

part of source;

///
/// this file contains:
/// [kPlaceHolder]
///
/// [VColor], [KColor], [KColorHex], [KColorStyle1]
/// [VThemeData]
///
/// [FCanvasSizeToPaint], [VPaintFill], [VPaintFillBlur], [VPaintStroke], [KMaskFilter]
///
/// [KDivider], [KBorderSide], [KBorder], [KBorderWithRadius],
/// [KSizedBox], [VContainer], [VContainerStyled]
///
/// [_VBoxShadowBlack], [_KBoxShadowNormal], [_KBoxShadowOuter], [_KBoxShadowInner], [_KBoxShadowSolid]
/// [VBoxDecorationBorder], [VBoxDecorationStyled]
/// [KShapeDecoration]
/// [KBoxDecoration], [KBoxDecorationStyled]
/// [KBoxDecorationShadow1], [KBoxDecorationShadow1Border], [KBoxDecorationShadow2]
///
/// [KGridPaper]
/// [KProgressIndicator]
/// [KIcon]
/// [KDrawer]
///
/// [KLaTexString], [KLatexStringEquation], [KLatexStringMatrix1N], [KLatexStringMatrix2N], [FLaTexString]
/// [KTextStyle]
/// [KInputBorder], [KInputDecoration]
/// [KLinearGradiant], [KLinearGradiantStyled]
///
///
///

const Placeholder kPlaceHolder = Placeholder();

///
/// [Color]
///

extension VColor on Color {
  static Color get blackO_50 => Colors.black.withOpacity(0.50);

  static Color get blackO_20 => Colors.black.withOpacity(0.20);

  static Color get random => Color(0xFF000000 + Random().nextInt(0xFFFFFFFF));

  static Color get randomWithAlpha =>
      Color(0xFF000000 + Random().nextInt(0x00FFFFFF));
}

extension KColor on Color {
  static const constant_200 = Color.fromARGB(255, 200, 200, 200);
  static const rice = Color.fromARGB(255, 240, 232, 200);

  static const blackO_06 = Color.fromRGBO(0, 0, 0, 0.6);
}

extension KColorHex on Color {
  static const pureRed = Color(0xFFff0000);
  static const pureRedGreen = Color(0xFFffff00);
  static const pureGreen = Color(0xFF00ff00);
  static const pureGreenBlue = Color(0xFF00ffff);
  static const pureBlue = Color(0xFF0000ff);
  static const pureBlueRed = Color(0xFFff00ff);

  static const Color burgundy = Color(0xff880d1e);
  static const Color orange = Color(0xffefa47f);
  static const Color blue = Color(0xff8d8ce7);
  static const Color lightGrey = Color(0xffa28a8a);
  static const Color white = Color(0xfff5f5f5);
  static const Color grey = Color(0xffaeaeae);
  static const Color grey2 = Color(0xffE8E8E8);
  static const Color indyBlue = Color(0xff414361);
  static const Color spaceCadet = Color(0xff2a2d43);
}

extension KColorStyle1 on Color {
  /// R
  static const redB1 = Color(0xFFffe0e0);
  static const redB2 = Color(0xFFffcdcd);
  static const redB3 = Color(0xFFf09999);
  static const redPrimary = Color(0xFFdd5555);
  static const redD3 = Color(0xFF991515);
  static const redD2 = Color(0xFF771010);
  static const redD1 = Color(0xFF440000);

  /// G
  static const greenB1 = Color(0xFFe0ffe0);
  static const greenB2 = Color(0xFFcdffcd);
  static const greenB3 = Color(0xFF99f099);
  static const greenPrimary = Color(0xFF22dd22);
  static const greenD3 = Color(0xFF2c772c);
  static const greenD2 = Color(0xFF1d661d);
  static const greenD1 = Color(0xFF004400);

  /// B
  static const blueB1 = Color(0xFFe0e0ff);
  static const blueB2 = Color(0xFFcdcdff);
  static const blueB3 = Color(0xFFaeaef0);
  static const bluePrimary = Color(0xFF5656dd);
  static const blueD3 = Color(0xFF2c2caa);
  static const blueD2 = Color(0xFF1d1d99);
  static const blueD1 = Color(0xFF0e0e66);

  /// oranges that G over B oranges
  static const orangeB1 = Color(0xFFffeeaa);
  static const orangeB2 = Color(0xFFffcc99);
  static const orangeB3 = Color(0xFFffaa77);
  static const orangePrimary = Color(0xFFdd6644);
  static const orangeD3 = Color(0xFF885511);
  static const orangeD2 = Color(0xFF663300);
  static const orangeD1 = Color(0xFF551100);

  /// yellows that R over G
  static const yellowB1 = Color(0xFFffffee);
  static const yellowB1_1 = Color(0xFFffeeee);
  static const yellowB2 = Color(0xFFffeeaa);
  static const yellowB3 = Color(0xFFffee11);
  static const yellowPrimary = Color(0xFFddcc88);
  static const yellowD3 = Color(0xFFaa9944);
  static const yellowD2 = Color(0xFF998844);
  static const yellowD1 = Color(0xFF776633);

  /// purples that B over R
  static const purpleB1 = Color(0xFFececff);
  static const purpleB2 = Color(0xFFdcdcff);
  static const purpleB3 = Color(0xFFbcbcff);
  static const purpleB4 = Color(0xFFa1a7ee);
  static const purplePrimary = Color(0xFF8833dd);
  static const purpleD3 = Color(0xFFaa44cc);
  static const purpleD2 = Color(0xFF8822bb);
  static const purpleD1 = Color(0xFF882299);
}

extension KColorStyle1LinearGradiant on LinearGradient {
  static const LinearGradient of1 = LinearGradient(colors: [
    Colors.white,
    KColorStyle1.redPrimary,
    KColorStyle1.orangeB3,
    KColorStyle1.greenD1,
    KColorStyle1.greenD3,
  ]);

  static const LinearGradient of2 = LinearGradient(colors: [
    KColorStyle1.blueD3,
    KColorStyle1.purpleD1,
  ]);
}

///
/// [ThemeData]
///

extension VThemeData on ThemeData {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      );

  static ThemeData get style1 {
    const primaryBrown = Color.fromARGB(255, 189, 166, 158);
    const secondaryBrown = Color.fromARGB(255, 109, 92, 90);

    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryBrown,
      primarySwatch: Colors.brown,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBrown,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryBrown,
        selectedItemColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: secondaryBrown,
        elevation: 10,
      ),
      fontFamily: 'Setofont',
      textTheme: const TextTheme(
          // headlineSmall, Medium, Large, 1-6:
          // bodySmall, Medium, Large, 1-3:
          ),
    );
  }

  static ThemeData get style2 => ThemeData(
        primaryColor: KColorHex.spaceCadet,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: KColorHex.spaceCadet),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.blueGrey),
      );
}

///
/// [Paint]
///

extension FCanvasSizeToPaint on CanvasSizeToPaint {
  static CanvasSizeToPaint of(Paint paint) => (_, __) => paint;
}

extension VPaintFill on Paint {
  static Paint get _fill => Paint()..style = PaintingStyle.fill;

  static Paint get black => _fill..color = Colors.black;

  static Paint get white => _fill..color = Colors.white;

  static Paint get red => _fill..color = Colors.red;

  static Paint get orange => _fill..color = Colors.orange;

  static Paint get yellow => _fill..color = Colors.yellow;

  static Paint get green => _fill..color = Colors.green;

  static Paint get blue => _fill..color = Colors.blue;

  static Paint get blueAccent => _fill..color = Colors.blueAccent;

  static Paint get purple => _fill..color = Colors.purple;
}

extension VPaintFillBlur on Paint {
  static Paint get white_normal_05 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_05;

  static Paint get white_normal_1 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_1;

  static Paint get white_normal_2 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_2;

  static Paint get white_normal_3 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_3;

  static Paint get white_normal_4 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_4;

  static Paint get white_normal_5 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_5;

  static Paint get white_normal_6 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_6;

  static Paint get white_normal_7 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_7;

  static Paint get white_normal_8 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_8;

  static Paint get white_normal_9 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_9;

  static Paint get white_normal_10 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_10;
}

extension VPaintStroke on Paint {
  static Paint get _stroke => Paint()..style = PaintingStyle.stroke;

  /// stroke

  static Paint get _stroke_1 => _stroke..strokeWidth = 1;

  static Paint get _stroke_2 => _stroke..strokeWidth = 2;

  static Paint get _stroke_3 => _stroke..strokeWidth = 3;

  static Paint get _stroke_4 => _stroke..strokeWidth = 4;

  static Paint get _stroke_5 => _stroke..strokeWidth = 5;

  /// cap

  static Paint get _stroke_1_capRound => _stroke_1..strokeCap = StrokeCap.round;

  static Paint get _stroke_1_capSquare =>
      _stroke_1..strokeCap = StrokeCap.square;

  static Paint get _stroke_1_capButt => _stroke_1..strokeCap = StrokeCap.butt;

  static Paint get _stroke_2_capRound => _stroke_2..strokeCap = StrokeCap.round;

  static Paint get _stroke_2_capSquare =>
      _stroke_2..strokeCap = StrokeCap.square;

  static Paint get _stroke_2_capButt => _stroke_2..strokeCap = StrokeCap.butt;

  static Paint get _stroke_3_capRound => _stroke_3..strokeCap = StrokeCap.round;

  static Paint get _stroke_3_capSquare =>
      _stroke_3..strokeCap = StrokeCap.square;

  static Paint get _stroke_3_capButt => _stroke_3..strokeCap = StrokeCap.butt;

  static Paint get _stroke_4_capRound => _stroke_4..strokeCap = StrokeCap.round;

  static Paint get _stroke_4_capSquare =>
      _stroke_4..strokeCap = StrokeCap.square;

  static Paint get _stroke_4_capButt => _stroke_4..strokeCap = StrokeCap.butt;

  static Paint get _stroke_5_capRound => _stroke_5..strokeCap = StrokeCap.round;

  static Paint get _stroke_5_capSquare =>
      _stroke_5..strokeCap = StrokeCap.square;

  static Paint get _stroke_5_capButt => _stroke_5..strokeCap = StrokeCap.butt;

  /// color_strokeWidth_cap

  // 1
  static Paint get black_1_capRound => _stroke_1_capRound..color = Colors.black;

  static Paint get black_1_capSquare =>
      _stroke_1_capSquare..color = Colors.black;

  static Paint get black_1_capButt => _stroke_1_capButt..color = Colors.black;

  static Paint get white_1_capRound => _stroke_1_capRound..color = Colors.white;

  static Paint get white_1_capSquare =>
      _stroke_1_capSquare..color = Colors.white;

  static Paint get white_1_capButt => _stroke_1_capButt..color = Colors.white;

  static Paint get red_1_capRound => _stroke_1_capRound..color = Colors.red;

  static Paint get red_1_capSquare => _stroke_1_capSquare..color = Colors.red;

  static Paint get red_1_capButt => _stroke_1_capButt..color = Colors.red;

  static Paint get orange_1_capRound =>
      _stroke_1_capRound..color = Colors.orange;

  static Paint get orange_1_capSquare =>
      _stroke_1_capSquare..color = Colors.orange;

  static Paint get orange_1_capButt => _stroke_1_capButt..color = Colors.orange;

  static Paint get yellow_1_capRound =>
      _stroke_1_capRound..color = Colors.yellow;

  static Paint get yellow_1_capSquare =>
      _stroke_1_capSquare..color = Colors.yellow;

  static Paint get yellow_1_capButt => _stroke_1_capButt..color = Colors.yellow;

  static Paint get green_1_capRound => _stroke_1_capRound..color = Colors.green;

  static Paint get green_1_capSquare =>
      _stroke_1_capSquare..color = Colors.green;

  static Paint get green_1_capButt => _stroke_1_capButt..color = Colors.green;

  static Paint get blue_1_capRound => _stroke_1_capRound..color = Colors.blue;

  static Paint get blue_1_capSquare => _stroke_1_capSquare..color = Colors.blue;

  static Paint get blue_1_capButt => _stroke_1_capButt..color = Colors.blue;

  static Paint get blueAccent_1_capRound =>
      _stroke_1_capRound..color = Colors.blueAccent;

  static Paint get blueAccent_1_capSquare =>
      _stroke_1_capSquare..color = Colors.blueAccent;

  static Paint get blueAccent_1_capButt =>
      _stroke_1_capButt..color = Colors.blueAccent;

  static Paint get purple_1_capRound =>
      _stroke_1_capRound..color = Colors.purple;

  static Paint get purple_1_capSquare =>
      _stroke_1_capSquare..color = Colors.purple;

  static Paint get purple_1_capButt => _stroke_1_capButt..color = Colors.purple;

  // 2
  static Paint get black_2_capRound => _stroke_2_capRound..color = Colors.black;

  static Paint get black_2_capSquare =>
      _stroke_2_capSquare..color = Colors.black;

  static Paint get black_2_capButt => _stroke_2_capButt..color = Colors.black;

  static Paint get white_2_capRound => _stroke_2_capRound..color = Colors.white;

  static Paint get white_2_capSquare =>
      _stroke_2_capSquare..color = Colors.white;

  static Paint get white_2_capButt => _stroke_2_capButt..color = Colors.white;

  static Paint get red_2_capRound => _stroke_2_capRound..color = Colors.red;

  static Paint get red_2_capSquare => _stroke_2_capSquare..color = Colors.red;

  static Paint get red_2_capButt => _stroke_2_capButt..color = Colors.red;

  static Paint get orange_2_capRound =>
      _stroke_2_capRound..color = Colors.orange;

  static Paint get orange_2_capSquare =>
      _stroke_2_capSquare..color = Colors.orange;

  static Paint get orange_2_capButt => _stroke_2_capButt..color = Colors.orange;

  static Paint get yellow_2_capRound =>
      _stroke_2_capRound..color = Colors.yellow;

  static Paint get yellow_2_capSquare =>
      _stroke_2_capSquare..color = Colors.yellow;

  static Paint get yellow_2_capButt => _stroke_2_capButt..color = Colors.yellow;

  static Paint get green_2_capRound => _stroke_2_capRound..color = Colors.green;

  static Paint get green_2_capSquare =>
      _stroke_2_capSquare..color = Colors.green;

  static Paint get green_2_capButt => _stroke_2_capButt..color = Colors.green;

  static Paint get blue_2_capRound => _stroke_2_capRound..color = Colors.blue;

  static Paint get blue_2_capSquare => _stroke_2_capSquare..color = Colors.blue;

  static Paint get blue_2_capButt => _stroke_2_capButt..color = Colors.blue;

  static Paint get blueAccent_2_capRound =>
      _stroke_2_capRound..color = Colors.blueAccent;

  static Paint get blueAccent_2_capSquare =>
      _stroke_2_capSquare..color = Colors.blueAccent;

  static Paint get blueAccent_2_capButt =>
      _stroke_2_capButt..color = Colors.blueAccent;

  static Paint get purple_2_capRound =>
      _stroke_2_capRound..color = Colors.purple;

  static Paint get purple_2_capSquare =>
      _stroke_2_capSquare..color = Colors.purple;

  static Paint get purple_2_capButt => _stroke_2_capButt..color = Colors.purple;

  // 3
  static Paint get black_3_capRound => _stroke_3_capRound..color = Colors.black;

  static Paint get black_3_capSquare =>
      _stroke_3_capSquare..color = Colors.black;

  static Paint get black_3_capButt => _stroke_3_capButt..color = Colors.black;

  static Paint get white_3_capRound => _stroke_3_capRound..color = Colors.white;

  static Paint get white_3_capSquare =>
      _stroke_3_capSquare..color = Colors.white;

  static Paint get white_3_capButt => _stroke_3_capButt..color = Colors.white;

  static Paint get red_3_capRound => _stroke_3_capRound..color = Colors.red;

  static Paint get red_3_capSquare => _stroke_3_capSquare..color = Colors.red;

  static Paint get red_3_capButt => _stroke_3_capButt..color = Colors.red;

  static Paint get orange_3_capRound =>
      _stroke_3_capRound..color = Colors.orange;

  static Paint get orange_3_capSquare =>
      _stroke_3_capSquare..color = Colors.orange;

  static Paint get orange_3_capButt => _stroke_3_capButt..color = Colors.orange;

  static Paint get yellow_3_capRound =>
      _stroke_3_capRound..color = Colors.yellow;

  static Paint get yellow_3_capSquare =>
      _stroke_3_capSquare..color = Colors.yellow;

  static Paint get yellow_3_capButt => _stroke_3_capButt..color = Colors.yellow;

  static Paint get green_3_capRound => _stroke_3_capRound..color = Colors.green;

  static Paint get green_3_capSquare =>
      _stroke_3_capSquare..color = Colors.green;

  static Paint get green_3_capButt => _stroke_3_capButt..color = Colors.green;

  static Paint get blue_3_capRound => _stroke_3_capRound..color = Colors.blue;

  static Paint get blue_3_capSquare => _stroke_3_capSquare..color = Colors.blue;

  static Paint get blue_3_capButt => _stroke_3_capButt..color = Colors.blue;

  static Paint get blueAccent_3_capRound =>
      _stroke_3_capRound..color = Colors.blueAccent;

  static Paint get blueAccent_3_capSquare =>
      _stroke_3_capSquare..color = Colors.blueAccent;

  static Paint get blueAccent_3_capButt =>
      _stroke_3_capButt..color = Colors.blueAccent;

  static Paint get purple_3_capRound =>
      _stroke_3_capRound..color = Colors.purple;

  static Paint get purple_3_capSquare =>
      _stroke_3_capSquare..color = Colors.purple;

  static Paint get purple_3_capButt => _stroke_3_capButt..color = Colors.purple;

  // 4
  static Paint get black_4_capRound => _stroke_4_capRound..color = Colors.black;

  static Paint get black_4_capSquare =>
      _stroke_4_capSquare..color = Colors.black;

  static Paint get black_4_capButt => _stroke_4_capButt..color = Colors.black;

  static Paint get white_4_capRound => _stroke_4_capRound..color = Colors.white;

  static Paint get white_4_capSquare =>
      _stroke_4_capSquare..color = Colors.white;

  static Paint get white_4_capButt => _stroke_4_capButt..color = Colors.white;

  static Paint get red_4_capRound => _stroke_4_capRound..color = Colors.red;

  static Paint get red_4_capSquare => _stroke_4_capSquare..color = Colors.red;

  static Paint get red_4_capButt => _stroke_4_capButt..color = Colors.red;

  static Paint get orange_4_capRound =>
      _stroke_4_capRound..color = Colors.orange;

  static Paint get orange_4_capSquare =>
      _stroke_4_capSquare..color = Colors.orange;

  static Paint get orange_4_capButt => _stroke_4_capButt..color = Colors.orange;

  static Paint get yellow_4_capRound =>
      _stroke_4_capRound..color = Colors.yellow;

  static Paint get yellow_4_capSquare =>
      _stroke_4_capSquare..color = Colors.yellow;

  static Paint get yellow_4_capButt => _stroke_4_capButt..color = Colors.yellow;

  static Paint get green_4_capRound => _stroke_4_capRound..color = Colors.green;

  static Paint get green_4_capSquare =>
      _stroke_4_capSquare..color = Colors.green;

  static Paint get green_4_capButt => _stroke_4_capButt..color = Colors.green;

  static Paint get blue_4_capRound => _stroke_4_capRound..color = Colors.blue;

  static Paint get blue_4_capSquare => _stroke_4_capSquare..color = Colors.blue;

  static Paint get blue_4_capButt => _stroke_4_capButt..color = Colors.blue;

  static Paint get blueAccent_4_capRound =>
      _stroke_4_capRound..color = Colors.blueAccent;

  static Paint get blueAccent_4_capSquare =>
      _stroke_4_capSquare..color = Colors.blueAccent;

  static Paint get blueAccent_4_capButt =>
      _stroke_4_capButt..color = Colors.blueAccent;

  static Paint get purple_4_capRound =>
      _stroke_4_capRound..color = Colors.purple;

  static Paint get purple_4_capSquare =>
      _stroke_4_capSquare..color = Colors.purple;

  static Paint get purple_4_capButt => _stroke_4_capButt..color = Colors.purple;

  // 5
  static Paint get black_5_capRound => _stroke_5_capRound..color = Colors.black;

  static Paint get black_5_capSquare =>
      _stroke_5_capSquare..color = Colors.black;

  static Paint get black_5_capButt => _stroke_5_capButt..color = Colors.black;

  static Paint get white_5_capRound => _stroke_5_capRound..color = Colors.white;

  static Paint get white_5_capSquare =>
      _stroke_5_capSquare..color = Colors.white;

  static Paint get white_5_capButt => _stroke_5_capButt..color = Colors.white;

  static Paint get red_5_capRound => _stroke_5_capRound..color = Colors.red;

  static Paint get red_5_capSquare => _stroke_5_capSquare..color = Colors.red;

  static Paint get red_5_capButt => _stroke_5_capButt..color = Colors.red;

  static Paint get orange_5_capRound =>
      _stroke_5_capRound..color = Colors.orange;

  static Paint get orange_5_capSquare =>
      _stroke_5_capSquare..color = Colors.orange;

  static Paint get orange_5_capButt => _stroke_5_capButt..color = Colors.orange;

  static Paint get yellow_5_capRound =>
      _stroke_5_capRound..color = Colors.yellow;

  static Paint get yellow_5_capSquare =>
      _stroke_5_capSquare..color = Colors.yellow;

  static Paint get yellow_5_capButt => _stroke_5_capButt..color = Colors.yellow;

  static Paint get green_5_capRound => _stroke_5_capRound..color = Colors.green;

  static Paint get green_5_capSquare =>
      _stroke_5_capSquare..color = Colors.green;

  static Paint get green_5_capButt => _stroke_5_capButt..color = Colors.green;

  static Paint get blue_5_capRound => _stroke_5_capRound..color = Colors.blue;

  static Paint get blue_5_capSquare => _stroke_5_capSquare..color = Colors.blue;

  static Paint get blue_5_capButt => _stroke_5_capButt..color = Colors.blue;

  static Paint get blueAccent_5_capRound =>
      _stroke_5_capRound..color = Colors.blueAccent;

  static Paint get blueAccent_5_capSquare =>
      _stroke_5_capSquare..color = Colors.blueAccent;

  static Paint get blueAccent_5_capButt =>
      _stroke_5_capButt..color = Colors.blueAccent;

  static Paint get purple_5_capRound =>
      _stroke_5_capRound..color = Colors.purple;

  static Paint get purple_5_capSquare =>
      _stroke_5_capSquare..color = Colors.purple;

  static Paint get purple_5_capButt => _stroke_5_capButt..color = Colors.purple;

  /// eraser
  static Paint get _eraser => _stroke..color = Colors.transparent;

  static Paint get _eraser_clear => _eraser..blendMode = BlendMode.clear;

  static Paint get eraser_1 => _eraser_clear..strokeWidth = 1;

  static Paint get eraser_2 => _eraser_clear..strokeWidth = 2;

  static Paint get eraser_3 => _eraser_clear..strokeWidth = 3;

  static Paint get eraser_4 => _eraser_clear..strokeWidth = 4;

  static Paint get eraser_5 => _eraser_clear..strokeWidth = 5;
}

extension KMaskFilter on Paint {
  /// normal
  static const MaskFilter normal_05 = MaskFilter.blur(BlurStyle.normal, 0.5);
  static const MaskFilter normal_1 = MaskFilter.blur(BlurStyle.normal, 1);
  static const MaskFilter normal_2 = MaskFilter.blur(BlurStyle.normal, 2);
  static const MaskFilter normal_3 = MaskFilter.blur(BlurStyle.normal, 3);
  static const MaskFilter normal_4 = MaskFilter.blur(BlurStyle.normal, 4);
  static const MaskFilter normal_5 = MaskFilter.blur(BlurStyle.normal, 5);
  static const MaskFilter normal_6 = MaskFilter.blur(BlurStyle.normal, 6);
  static const MaskFilter normal_7 = MaskFilter.blur(BlurStyle.normal, 7);
  static const MaskFilter normal_8 = MaskFilter.blur(BlurStyle.normal, 8);
  static const MaskFilter normal_9 = MaskFilter.blur(BlurStyle.normal, 9);
  static const MaskFilter normal_10 = MaskFilter.blur(BlurStyle.normal, 10);

  /// solid
  static const MaskFilter solid_05 = MaskFilter.blur(BlurStyle.solid, 0.5);
}

///
/// [Divider], [Border]
///

extension KDivider on Divider {
  static const white = Divider(color: Colors.white);
  static const black_3 = Divider(thickness: 3);
}

extension KBorderSide on BorderSide {
  static const black25_02 = BorderSide(color: Colors.black26, width: 0.2);
  static const alignCenter_3 = BorderSide(
    strokeAlign: BorderSide.strokeAlignCenter,
    width: 3,
  );
}

extension KBorder on Border {
  static const none = Border();
  static const circle = CircleBorder();
  static const sideCenter3 = Border.fromBorderSide(KBorderSide.alignCenter_3);
}

extension KBorderWithRadius on Border {
  static const roundRect_8 =
      RoundedRectangleBorder(borderRadius: KBorderRadius.allCircular_8);
  static const roundRect_20 =
      RoundedRectangleBorder(borderRadius: KBorderRadius.allCircular_20);
  static const roundRectVertical_0_8 =
      RoundedRectangleBorder(borderRadius: KBorderRadius.vertical_0_8);
  static const continuousRectVertical_0_56 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_56);
}

///
/// [SizedBox], [Container]
///

extension KSizedBox on SizedBox {
  static const none = SizedBox();
  static const shrink = SizedBox.shrink();
  static const expand = SizedBox.expand();
  static const h16 = SizedBox(height: 16);
  static const h32 = SizedBox(height: 32);
  static const h10 = SizedBox(height: 10);
  static const h20 = SizedBox(height: 20);
  static const h100 = SizedBox(height: 100);
  static const h160 = SizedBox(height: 160);

  static const square16 = SizedBox.square(dimension: 16);
  static const square32 = SizedBox.square(dimension: 32);
  static const square10 = SizedBox.square(dimension: 10);
  static const square20 = SizedBox.square(dimension: 20);
  static const square50 = SizedBox.square(dimension: 50);
  static const square100 = SizedBox.square(dimension: 100);

  static const infinityW_100H = SizedBox(height: 100, width: double.infinity);
  static const infinityW_200H = SizedBox(height: 200, width: double.infinity);
  static const infinityW_300H = SizedBox(height: 300, width: double.infinity);
  static const infinityW_400H = SizedBox(height: 400, width: double.infinity);
  static const infinityW_500H = SizedBox(height: 500, width: double.infinity);
  static const infinityW_128H = SizedBox(height: 128, width: double.infinity);
  static const infinityW_256H = SizedBox(height: 256, width: double.infinity);
  static const infinityW_512H = SizedBox(height: 512, width: double.infinity);

  static const infinityH_16W = SizedBox(height: double.infinity, width: 16);
  static const infinityH_32W = SizedBox(height: double.infinity, width: 32);
  static const infinityH_64W = SizedBox(height: double.infinity, width: 64);
  static const infinityH_128W = SizedBox(height: double.infinity, width: 128);
}

///
/// container
///

extension VContainer on Container {
  static Expanded get expanded => Expanded(child: Container());

  static Container get squareRed_10 =>
      Container(color: Colors.red, width: 10, height: 10);

  static Container get squareYellow_10 =>
      Container(color: Colors.yellow, width: 10, height: 10);

  static Container get squareGreen_10 =>
      Container(color: Colors.green, width: 10, height: 10);

  static Container get squareBlue_10 =>
      Container(color: Colors.blue, width: 10, height: 10);

  static Container get squareRed_50 =>
      Container(color: Colors.red, width: 50, height: 50);

  static Container get squareYellow_50 =>
      Container(color: Colors.yellow, width: 50, height: 50);

  static Container get squareGreen_50 =>
      Container(color: Colors.green, width: 50, height: 50);

  static Container get squareBlue_50 =>
      Container(color: Colors.blue, width: 50, height: 50);

  static Container get squareRed_100 =>
      Container(color: Colors.red, width: 100, height: 100);

  static Container get squareOrange_100 =>
      Container(color: Colors.orange, width: 100, height: 100);

  static Container get squareYellow_100 =>
      Container(color: Colors.yellow, width: 100, height: 100);

  static Container get squareGreen_100 =>
      Container(color: Colors.green, width: 100, height: 100);

  static Container get squareBlue_100 =>
      Container(color: Colors.blue, width: 100, height: 100);

  static Container get squarePurple_100 =>
      Container(color: Colors.purple, width: 100, height: 100);

  static Container get squareBrown_100 =>
      Container(color: Colors.brown, width: 100, height: 100);

  static Container get squareRed_300 =>
      Container(color: Colors.red, width: 300, height: 300);

  static Container get squareYellow_300 =>
      Container(color: Colors.yellow, width: 300, height: 300);

  static Container get squareGreen_300 =>
      Container(color: Colors.green, width: 300, height: 300);

  static Container get squareBlue_300 =>
      Container(color: Colors.blue, width: 300, height: 300);
}

extension VContainerBorder on Container {
  static Container get squareBlue_100 => Container(
        width: 100,
        height: 100,
        decoration: VBoxDecorationBorder.allBlue,
      );
}

extension VContainerStyled on Container {
  static Container get blueStyle1 => Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: KBorderRadius.allCircular_10,
          boxShadow: [_VBoxShadowBlack.o50Style1],
        ),
      );

  static Container get gradiantWhitRed => Container(
        height: 100,
        width: 100,
        decoration: KBoxDecoration.gradientWR,
      );
}

///
/// [BoxShadow]
///

extension _VBoxShadowBlack on BoxShadow {
  static BoxShadow get o50Style1 => BoxShadow(
        color: VColor.blackO_50,
        offset: KOffset.y_3,
        spreadRadius: 5,
        blurRadius: 7,
      );

  static BoxShadow get o20Style1 => BoxShadow(
        color: VColor.blackO_50,
        spreadRadius: 5,
        blurRadius: 7,
        offset: KOffset.y_3,
      );
}

extension _KBoxShadowNormal on BoxShadow {
  static const blackStyle1 =
      BoxShadow(offset: KCoordinate.cube_2, blurRadius: 15, spreadRadius: 25);
  static const blackStyle2 = BoxShadow(
    offset: KOffset.y_5N,
    blurRadius: 60,
    spreadRadius: 40,
  );
  static const blackStyle3 = BoxShadow(
    spreadRadius: 10,
  );
  static const blackStyle4 = BoxShadow(
    offset: KOffset.y_1,
    blurRadius: 10,
    spreadRadius: -25,
  );
  static const blackStyle5 = BoxShadow(
    offset: KOffset.y_6,
    blurRadius: 20,
    spreadRadius: 10,
  );
  static const blackStyle6 = BoxShadow(
    offset: KCoordinate.cube_3,
    blurRadius: 6,
    spreadRadius: 15,
  );
  static const blackStyle7 = BoxShadow(
    offset: KOffset.xy_80_5N,
    blurRadius: 8,
  );
  static const blackStyle8 = BoxShadow(
    offset: KOffset.x_2,
    spreadRadius: 12,
  );
  static const blackStyle9 = BoxShadow(
    offset: KOffset.xy_12N_16N,
    spreadRadius: 3,
  );
  static const blackStyle10 = BoxShadow(
    blurRadius: 16,
    spreadRadius: 3,
  );

  static const greyStyle1 = BoxShadow(
    color: Colors.grey,
    offset: KOffset.y_1,
    blurRadius: 1,
    spreadRadius: 12,
  );
  static const greyStyle2 = BoxShadow(
    color: Colors.grey,
    offset: KOffset.xy_2_6,
    blurRadius: 10,
  );
  static const greyStyle3 = BoxShadow(
    color: Colors.grey,
    offset: KOffset.y_3,
    blurRadius: 5,
    spreadRadius: 10,
  );
  static const greyStyle4 = BoxShadow(
    color: Colors.grey,
    offset: KOffset.xy_4_30,
    blurRadius: 20,
    spreadRadius: 10,
  );
  static const greyStyle5 = BoxShadow(
    color: Colors.grey,
    offset: KOffset.xy_30_15,
    blurRadius: 5,
    spreadRadius: 10,
  );
  static const greyStyle6 = BoxShadow(
    color: Colors.grey,
    offset: KOffset.xy_5_20,
    blurRadius: 5,
    spreadRadius: 8,
  );
  static const greyStyle7 = BoxShadow(
    color: Colors.grey,
    offset: KOffset.x_10,
    blurRadius: 5,
    spreadRadius: 5,
  );
  static const greyStyle8 = BoxShadow(
    color: Colors.grey,
    offset: KOffset.xy_35_8N,
    blurRadius: 1,
    spreadRadius: -10,
  );

  static const brownStyle1 = BoxShadow(
    color: Colors.brown,
    blurRadius: 1,
    spreadRadius: 1,
  );

  static const orangeStyle1 = BoxShadow(
    color: Colors.orange,
    blurRadius: 20,
    spreadRadius: 2,
  );

  static const blueGreyStyle1 = BoxShadow(
    color: Colors.blueGrey,
    blurRadius: 5,
    spreadRadius: 5,
  );

  static const indigoStyle1 = BoxShadow(
    color: Colors.indigo,
    offset: KCoordinateDirection.right,
    blurRadius: 5,
    spreadRadius: 10,
  );

  static const tealStyle1 = BoxShadow(
    color: Colors.teal,
    offset: KCoordinateDirection.left,
    blurRadius: 1,
    spreadRadius: 1,
  );
}

extension _KBoxShadowOuter on BoxShadow {
  static const blackStyle1 = BoxShadow(
    blurStyle: BlurStyle.outer,
    offset: KOffset.xy_2_5,
    blurRadius: 40,
    spreadRadius: 40,
  );

  static const blackStyle2 = BoxShadow(
    blurStyle: BlurStyle.outer,
    blurRadius: 1,
    spreadRadius: 10,
  );
  static const blackStyle3 = BoxShadow(
    blurStyle: BlurStyle.outer,
    blurRadius: 10,
    spreadRadius: 10,
  );

  static const greyStyle1 = BoxShadow(
    blurStyle: BlurStyle.outer,
    color: Colors.grey,
    blurRadius: 5,
    spreadRadius: 10,
  );
  static const greyStyle2 = BoxShadow(
    blurStyle: BlurStyle.outer,
    color: Colors.grey,
    offset: KCoordinateDirection.bottomRight,
    blurRadius: 10,
    spreadRadius: 20,
  );

  static const deepPurpleStyle2 = BoxShadow(
    blurStyle: BlurStyle.outer,
    color: Colors.deepPurple,
    offset: KCoordinateDirection.bottomLeft,
    blurRadius: 1,
    spreadRadius: 1,
  );
}

extension _KBoxShadowInner on BoxShadow {}

extension _KBoxShadowSolid on BoxShadow {}

///
/// [Decoration]
///

extension VBoxDecorationBorder on BoxDecoration {
  static BoxDecoration get allBlack => BoxDecoration(
        border: Border.all(color: Colors.black),
      );

  static BoxDecoration get allBlue => BoxDecoration(
        border: Border.all(color: Colors.blue),
      );

  static BoxDecoration get allOrange => BoxDecoration(
        border: Border.all(color: Colors.blue),
      );
}

extension VBoxDecorationStyled on BoxDecoration {
  static BoxDecoration get style1 => BoxDecoration(
        color: Colors.white,
        borderRadius: KBorderRadius.allCircular_20,
        boxShadow: [_VBoxShadowBlack.o50Style1],
      );

  static BoxDecoration style1Of({
    required BuildContext context,
    required Color color,
  }) =>
      BoxDecoration(
        borderRadius: KBorderRadius.allCircular_10,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [context.theme.primaryColor, color],
        ),
      );
}

extension KShapeDecoration on ShapeDecoration {
  static const stadiumGrey = ShapeDecoration(
    shape: StadiumBorder(),
    color: Colors.grey,
  );
  static const roundRect_8 = ShapeDecoration(
    shape: KBorderWithRadius.roundRect_8,
  );

  static const outlineBlack25_02 = ShapeDecoration(
    shape: KInputBorder.outlineBlack25_02,
  );
}

extension KBoxDecoration on BoxDecoration {
  static const none = BoxDecoration();
  static const blueGrey = BoxDecoration(color: Colors.blueGrey);

  static const circle = BoxDecoration(shape: BoxShape.circle);
  static const circleGreen = BoxDecoration(
    color: Colors.green,
    shape: BoxShape.circle,
  );

  static const gradientWR = BoxDecoration(gradient: KLinearGradiant.whiteToRed);
}

extension KBoxDecorationBorderRadius on BoxDecoration {
  static const circularAll_10 =
      BoxDecoration(borderRadius: KBorderRadius.allCircular_10);
  static const circularAll_20 =
      BoxDecoration(borderRadius: KBorderRadius.allCircular_20);

  static const circularAllWhite_10 = BoxDecoration(
    color: Colors.white,
    borderRadius: KBorderRadius.allCircular_10,
  );

  static const circularAllGrey_10 = BoxDecoration(
    color: Colors.grey,
    borderRadius: KBorderRadius.allCircular_10,
  );
  static const circularAllBlueGrey_20 = BoxDecoration(
    color: Colors.blueGrey,
    borderRadius: KBorderRadius.allCircular_20,
  );
  static const circularAllBlueGrey_30 = BoxDecoration(
    color: Colors.blueGrey,
    borderRadius: KBorderRadius.allCircular_30,
  );
}

extension KBoxDecorationStyled on BoxDecoration {
  static const borderBottom =
      BoxDecoration(border: Border(bottom: BorderSide()));
}

extension KBoxDecorationShadow1 on BoxDecoration {
  static const normalBlack1 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.blackStyle1]);
  static const normalBlack2 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.blackStyle2]);
  static const normalBlack3 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.blackStyle3]);
  static const normalBlack4 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.blackStyle4]);
  static const normalBlack5 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.blackStyle5]);
  static const normalBlack6 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.blackStyle6]);
  static const normalBlack7 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.blackStyle7]);
  static const normalBlack8 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.blackStyle8]);
  static const normalBlack9 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.blackStyle9]);

  static const normalGrey1 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.greyStyle1]);
  static const normalGrey2 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.greyStyle2]);
  static const normalGrey3 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.greyStyle3]);
  static const normalGrey4 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.greyStyle4]);

  static const normalGrey5 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.greyStyle5]);

  static const normalGrey6 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.greyStyle6]);
  static const normalGrey7 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.greyStyle7]);

  static const normalGrey8 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.greyStyle8]);

  static const normalOrange1 =
      BoxDecoration(boxShadow: [_KBoxShadowNormal.orangeStyle1]);

  static const outerBlack1 =
      BoxDecoration(boxShadow: [_KBoxShadowOuter.blackStyle1]);
  static const outerGrey1 = BoxDecoration(
    boxShadow: [_KBoxShadowOuter.greyStyle1],
  );
}

extension KBoxDecorationShadow1Border on BoxDecoration {
  static const style1 = BoxDecoration(
    border: KBorder.none,
    boxShadow: [_KBoxShadowNormal.blackStyle9],
  );
}

extension KBoxDecorationShadow2 on BoxDecoration {
  static const style1 = BoxDecoration(boxShadow: [
    _KBoxShadowNormal.brownStyle1,
    _KBoxShadowOuter.blackStyle2,
  ]);
  static const style2 = BoxDecoration(boxShadow: [
    _KBoxShadowNormal.blueGreyStyle1,
    _KBoxShadowOuter.blackStyle3,
  ]);

  static const style3 = BoxDecoration(boxShadow: [
    _KBoxShadowNormal.indigoStyle1,
    _KBoxShadowOuter.greyStyle2,
  ]);

  static const style4 = BoxDecoration(boxShadow: [
    _KBoxShadowNormal.tealStyle1,
    _KBoxShadowOuter.deepPurpleStyle2,
  ]);
}

///
/// component
///

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

extension KProgressIndicator on ProgressIndicator {
  static const circular = CircularProgressIndicator();
  static const circularBlueGrey = CircularProgressIndicator(
    color: Colors.blueGrey,
  );
  static const linear = LinearProgressIndicator();
  static const refresh = RefreshProgressIndicator();
}

extension KIcon on Icon {
  static const check = Icon(Icons.check);
  static const cross = Icon(Icons.close);

  static const plus = Icon(Icons.add);
  static const minus = Icon(Icons.remove);
  static const multiple = cross;
  static const equal = Icon(CupertinoIcons.equal);

  static const play = Icon(Icons.play_arrow);
  static const pause = Icon(Icons.pause);
  static const stop = Icon(Icons.stop);
  static const edit = Icon(Icons.edit);
  static const delete = Icon(Icons.delete);
  static const cancel_24 = Icon(Icons.cancel, size: 24);
  static const cancelSharp = Icon(Icons.cancel_sharp);
  static const send = Icon(Icons.send);

  static const arrowRight = Icon(Icons.arrow_forward_ios);
  static const arrowLeft = Icon(Icons.arrow_back_ios);
  static const arrowRightward = Icon(Icons.arrow_forward);
  static const arrowLeftward = Icon(Icons.arrow_back);

  static const accountBox = Icon(Icons.account_box);
  static const accountCircle = Icon(Icons.account_circle);
  static const backspace = Icon(Icons.backspace);
  static const email = Icon(Icons.email);
  static const mailOutline = Icon(Icons.mail_outline);
  static const password = Icon(Icons.password);
  static const phone = Icon(Icons.phone);
  static const photo = Icon(Icons.photo);
  static const photo_28 = Icon(Icons.photo, size: 28);
  static const readMore = Icon(Icons.read_more);

  static const accountCircleStyle1 = Icon(
    Icons.account_circle,
    size: 90,
    color: Colors.grey,
  );
  static const accountCircleStyle2 = Icon(
    Icons.account_circle,
    size: 35,
    color: Colors.grey,
  );
}

extension KDrawer on Drawer {
  static const none = Drawer();
}

///
/// text
///

extension KLaTexString on String {
  static const quadraticRoots = r"{-b \pm \sqrt{b^2-4ac} \over 2a}";
  static const sn = r"S_n";
  static const x1_ = r"x_1 + x_2 + ... + x_n";
  static const x1_3 = r"x_1 + x_2 + x_3";
  static const x1_4 = r"x_1 + x_2 + x_3 + x_4";
  static const x1_5 = r"x_1 + x_2 + x_3 + x_4 + x_5";
  static const ax1_ = r"a_1x_1 + a_2x_2 + ... + a_nx_n";
  static const ax1_3 = r"a_1x_1 + a_2x_2 + a_3x_3";
  static const ax1_4 = r"a_1x_1 + a_2x_2 + a_3x_3 + a_4x_4";
  static const ax1_5 = r"a_1x_1 + a_2x_2 + a_3x_3 + a_4x_4 + a_5x_5";
}

extension KLatexStringEquation on String {
  static const quadraticRootsOfX = r"x = " + KLaTexString.quadraticRoots;
  static const yLinearABX = r"y = a + bx";
  static const yLinearMXK = r"y = mx + k";
}

extension KLatexStringMatrix1N on String {
  static const y1_ = r"""\begin{bmatrix}
  y_1\\
  y_2\\
  ...\\
  y_n\\
  \end{bmatrix}""";
}

extension KLatexStringMatrix2N on String {
  static const const1_x1_ = r"""\begin{bmatrix}
  1&x_1\\
  1&x_2\\
  ...&...\\
  1&x_n\\
  \end{bmatrix}""";
}

extension FLaTexString on String {
  static String equationOf(Iterable<String> values) => values.reduce(
        (a, b) => "$a = $b",
      );
}

extension KTextStyle on TextStyle {
  static const k20 = TextStyle(fontSize: 20);
  static const k30 = TextStyle(fontSize: 30);
  static const k40 = TextStyle(fontSize: 40);
  static const k50 = TextStyle(fontSize: 50);
  static const kWhite = TextStyle(color: Colors.white);
  static const kBlack12 = TextStyle(color: Colors.black12);
  static const kBlack26 = TextStyle(color: Colors.black26);
  static const kBlack38 = TextStyle(color: Colors.black38);
  static const kBlack45 = TextStyle(color: Colors.black45);
  static const kBlack54 = TextStyle(color: Colors.black54);
  static const kBlack87 = TextStyle(color: Colors.black87);
  static const roboto = TextStyle(fontFamily: 'Roboto');

  static const white_24 = TextStyle(color: Colors.white, fontSize: 24);
  static const white_28 = TextStyle(color: Colors.white, fontSize: 28);
  static const boldWhite = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const boldBlack = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const boldBlack_30 = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 30,
  );

  static const boldItalicSpaceCadet = TextStyle(
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    color: KColorHex.spaceCadet,
  );

  static const italicGrey_12 = TextStyle(
    fontStyle: FontStyle.italic,
    color: Colors.grey,
    fontSize: 12,
  );
}

extension KInputBorder on InputBorder {
  static const outline = OutlineInputBorder();
  static const outlineBlack25_02 = OutlineInputBorder(
    borderSide: KBorderSide.black25_02,
  );
}

extension KInputDecoration on InputDecoration {
  static const collapsed = InputDecoration.collapsed(hintText: '');

  static const style1 = InputDecoration(
    labelStyle: TextStyle(
      color: Colors.blueGrey,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
      borderRadius: KBorderRadius.allCircular_10,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
      borderRadius: KBorderRadius.allCircular_10,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.5),
      borderRadius: KBorderRadius.allCircular_10,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.5),
      borderRadius: KBorderRadius.allCircular_10,
    ),
  );
}

extension KLinearGradiant on LinearGradient {
  static const whiteToRed = LinearGradient(colors: [Colors.white, Colors.red]);
  static const redToWhite = LinearGradient(colors: [Colors.red, Colors.white]);
}

extension KLinearGradiantStyled on LinearGradient {
  static const style1 = LinearGradient(
    begin: Alignment.center,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(189, 218, 218, 252),
      Color.fromARGB(189, 218, 218, 252),
      Colors.transparent,
    ],
  );
}
