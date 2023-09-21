// ignore_for_file: constant_identifier_names, non_constant_identifier_names

part of source;

///
/// this file contains:
/// [VColor], [KColor], [KColorHex], [KColorStyle1]
/// [KColoredBox]
///
/// [VThemeData]
///
/// [KBoxBorder], [KOutlinedBorderRounded], ...
/// [KBorderSideBlack], [FBorderSide]
/// [FBoxShadow], [FBoxShadowGrey], [FBoxShadowBlack]
/// [FDecorationBox], [FDecorationShape], [FDecorationInput] ...
///
/// [KSpacer]
/// [KProgressIndicator]
/// [KDrawer]
/// [KTextStyle]
/// [VListView]
/// [KIconMaterial]
///
///
///

extension VColor on Color {
  static Color get blackO_50 => Colors.black.withOpacity(0.50);

  static Color get blackO_20 => Colors.black.withOpacity(0.20);

  static Color get random =>
      Color(0xFF000000 + math.Random().nextInt(0xFFFFFFFF));

  static Color get randomWithAlpha =>
      Color(0xFF000000 + math.Random().nextInt(0x00FFFFFF));
}

extension KColor on Color {
  static const constant_200 = Color.fromARGB(255, 200, 200, 200);
  static const rice = Color.fromARGB(255, 240, 232, 200);
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
  static const redB1 = Color(0xFFffdddd);
  static const redB2 = Color(0xFFeecccc);
  static const redB3 = Color(0xFFdd9999);
  static const redPrimary = Color(0xFFdd7777);
  static const redD3 = Color(0xFFbb4444);
  static const redD2 = Color(0xFFaa1111);
  static const redD1 = Color(0xFF880000);

  /// G
  static const greenB1 = Color(0xFFddffdd);
  static const greenB2 = Color(0xFFcceecc);
  static const greenB3 = Color(0xFFaaddaa);
  static const greenPrimary = Color(0xFF88aa88);
  static const greenD3 = Color(0xFF559955);
  static const greenD2 = Color(0xFF227722);
  static const greenD1 = Color(0xFF005500);

  /// B
  static const blueB1 = Color(0xFFddddff);
  static const blueB2 = Color(0xFFbbbbee);
  static const blueB3 = Color(0xFF8888dd);
  static const bluePrimary = Color(0xFF6666cc);
  static const blueD3 = Color(0xFF4444bb);
  static const blueD2 = Color(0xFF222288);
  static const blueD1 = Color(0xFF111155);

  /// oranges that G over B oranges
  static const orangeB1 = Color(0xFFffeecc);
  static const orangeB2 = Color(0xFFffccaa);
  static const orangeB3 = Color(0xFFeeaa88);
  static const orangePrimary = Color(0xFFcc8866);
  static const orangeD3 = Color(0xFFaa5533);
  static const orangeD2 = Color(0xFF773322);
  static const orangeD1 = Color(0xFF551100);

  /// yellows that R over G
  static const yellowB1 = Color(0xFFffffbb);
  static const yellowB1_1 = Color(0xFFeeeeaa);
  static const yellowB2 = Color(0xFFeedd99);
  static const yellowB3 = Color(0xFFddcc66);
  static const yellowPrimary = Color(0xffccbb22);
  static const yellowD3 = Color(0xFFccbb33);
  static const yellowD2 = Color(0xFFbbaa22);
  static const yellowD1 = Color(0xFF998811);

  /// purples that B over R
  static const purpleB1 = Color(0xFFeeccff);
  static const purpleB2 = Color(0xFFddbbee);
  static const purpleB3 = Color(0xFFaa88dd);
  static const purpleB4 = Color(0xFF9977cc);
  static const purplePrimary = Color(0xff8866cc);
  static const purpleD3 = Color(0xFF8844bb);
  static const purpleD2 = Color(0xFF6622aa);
  static const purpleD1 = Color(0xFF440099);
}

extension KColoredBox on ColoredBox {
  static const ColoredBox red = ColoredBox(color: Colors.red);
  static const ColoredBox orange = ColoredBox(color: Colors.orange);
  static const ColoredBox yellow = ColoredBox(color: Colors.yellow);
  static const ColoredBox green = ColoredBox(color: Colors.green);
  static const ColoredBox blue = ColoredBox(color: Colors.blue);
  static const ColoredBox blueAccent = ColoredBox(color: Colors.blueAccent);
  static const ColoredBox purple = ColoredBox(color: Colors.purple);
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
///
/// shape border
/// below is the hierarchy condense from https://api.flutter.dev/flutter/painting/ShapeBorder-class.html at 2023/09/16
///
/// [ShapeBorder]
///   * [BoxBorder]
///     * [Border]                          ([KBoxBorder])
///     * [BorderDirectional]
///   * [OutlinedBorder]
///     * [StarBorder]
///     * [LinearBorder]
///     * [StadiumBorder]
///     * [BeveledRectangleBorder]
///     * [RoundedRectangleBorder]          ([KOutlinedBorderRounded])
///     * [ContinuousRectangleBorder]       ([KOutlinedBorderContinuousRadius])
///     * [MaterialStateOutlinedBorder]
///     * [CircleBorder]                    ([KOutlinedBorderCircle])
///       * [OvalBorder]
///   * [InputBorder]
///     * [OutlineInputBorder]              ([KInputBorderOutline])
///     * [UnderlineInputBorder]
///
/// [KBorderSideBlack]
///
///
extension KBoxBorder on BoxBorder {
  static const none = Border();
  static const sideCenter1 = Border.fromBorderSide(KBorderSideBlack.center_1);
  static const sideCenter2 = Border.fromBorderSide(KBorderSideBlack.center_2);
  static const sideCenter3 = Border.fromBorderSide(KBorderSideBlack.center_3);
  static const sideCenter4 = Border.fromBorderSide(KBorderSideBlack.center_4);
  static const sideCenter5 = Border.fromBorderSide(KBorderSideBlack.center_5);
  static const sideCenter6 = Border.fromBorderSide(KBorderSideBlack.center_6);
  static const sideCenter7 = Border.fromBorderSide(KBorderSideBlack.center_7);
  static const sideCenter8 = Border.fromBorderSide(KBorderSideBlack.center_8);
  static const sideCenter9 = Border.fromBorderSide(KBorderSideBlack.center_9);
  static const sideCenter10 = Border.fromBorderSide(KBorderSideBlack.center_10);
}

extension KOutlinedBorderCircle on OutlinedBorder {
  static const none = CircleBorder();
}

extension KOutlinedBorderRounded on OutlinedBorder {
  static const allCircular_8 =
      RoundedRectangleBorder(borderRadius: KBorderRadius.allCircular_8);
  static const allCircular_20 =
      RoundedRectangleBorder(borderRadius: KBorderRadius.allCircular_20);
  static const vertical_0_8 =
      RoundedRectangleBorder(borderRadius: KBorderRadius.vertical_0_8);
}

extension KOutlinedBorderContinuousRadius on OutlinedBorder {
  static const vertical_0_10 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_10);
  static const vertical_0_12 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_12);
  static const vertical_0_14 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_14);
  static const vertical_0_16 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_16);
  static const vertical_0_18 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_18);
  static const vertical_0_20 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_20);
  static const vertical_0_30 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_30);
  static const vertical_0_40 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_40);
  static const vertical_0_50 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_50);
  static const vertical_0_56 =
      ContinuousRectangleBorder(borderRadius: KBorderRadius.vertical_0_56);
}

extension KOutlinedBorderContinuousSideRadius on OutlinedBorder {
  static const insideBlack26_02_vertical_0_10 = ContinuousRectangleBorder(
    side: KBorderSideBlack.inside26_02,
    borderRadius: KBorderRadius.vertical_0_10,
  );
  static const insideBlack26_02_vertical_0_16 = ContinuousRectangleBorder(
    side: KBorderSideBlack.inside26_02,
    borderRadius: KBorderRadius.vertical_0_16,
  );
}

extension KInputBorderOutline on InputBorder {
  static const none = OutlineInputBorder();
}

extension KInputBorderOutlineSolidInside on InputBorder {
  static const black26_02 = OutlineInputBorder(
    borderSide: KBorderSideBlack.inside26_02,
  );

  static const blueGrey_1_allCircular_10 = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
    borderRadius: KBorderRadius.allCircular_10,
  );
}

extension KBorderSideBlack on BorderSide {
  static const inside26_02 = BorderSide(color: Colors.black26, width: 0.2);
  static const center_1 =
      BorderSide(strokeAlign: BorderSide.strokeAlignCenter, width: 1);
  static const center_2 =
      BorderSide(strokeAlign: BorderSide.strokeAlignCenter, width: 2);
  static const center_3 =
      BorderSide(strokeAlign: BorderSide.strokeAlignCenter, width: 3);
  static const center_4 =
      BorderSide(strokeAlign: BorderSide.strokeAlignCenter, width: 4);
  static const center_5 =
      BorderSide(strokeAlign: BorderSide.strokeAlignCenter, width: 5);
  static const center_6 =
      BorderSide(strokeAlign: BorderSide.strokeAlignCenter, width: 6);
  static const center_7 =
      BorderSide(strokeAlign: BorderSide.strokeAlignCenter, width: 7);
  static const center_8 =
      BorderSide(strokeAlign: BorderSide.strokeAlignCenter, width: 8);
  static const center_9 =
      BorderSide(strokeAlign: BorderSide.strokeAlignCenter, width: 9);
  static const center_10 =
      BorderSide(strokeAlign: BorderSide.strokeAlignCenter, width: 10);
}

extension FBorderSide on BorderSide {
  static BorderSide solidInside({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      BorderSide(
        color: color,
        width: width,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignInside,
      );

  static BorderSide solidCenter({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      BorderSide(
        color: color,
        width: width,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignCenter,
      );

  static BorderSide solidOutside({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      BorderSide(
        color: color,
        width: width,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignOutside,
      );
}

///
///
/// [BoxShadow]
///
///
/// [blurNormalOf]
/// [blurSolidOf]
/// [blurOuterOf]
/// [blurInnerOf]
///
///
///
extension FBoxShadow on BoxShadow {
  static BoxShadow blurNormalOf({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.normal,
      );

  static BoxShadow blurSolidOf({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.solid,
      );

  static BoxShadow blurOuterOf({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.outer,
      );

  static BoxShadow blurInnerOf({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.inner,
      );
}

extension FBoxShadowGrey on BoxShadow {
  static BoxShadow blurNormalOf({
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      FBoxShadow.blurNormalOf(
        color: Colors.grey,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
      );

  static BoxShadow blurSolidOf({
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      FBoxShadow.blurSolidOf(
        color: Colors.grey,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
      );

  static BoxShadow blurOuterOf({
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      FBoxShadow.blurOuterOf(
        color: Colors.grey,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
      );

  static BoxShadow blurInnerOf({
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      FBoxShadow.blurInnerOf(
        color: Colors.grey,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
      );
}

extension FBoxShadowBlack on BoxShadow {
  static BoxShadow blurNormalOf({
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      FBoxShadow.blurNormalOf(
        color: Colors.black,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
      );

  static BoxShadow blurSolidOf({
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      FBoxShadow.blurSolidOf(
        color: Colors.black,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
      );

  static BoxShadow blurOuterOf({
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      FBoxShadow.blurOuterOf(
        color: Colors.black,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
      );

  static BoxShadow blurInnerOf({
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      FBoxShadow.blurInnerOf(
        color: Colors.black,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
      );
}

///
///
///
/// decoration
/// [FDecorationBox], [KDecorationBox],
/// [FDecorationShape], [KDecorationShapeInputOutline]
/// [FDecorationInput], [KDecorationInput]
///
///
///
///

extension KDecorationBox on BoxDecoration {
  static const none = BoxDecoration();
  static const circle = BoxDecoration(shape: BoxShape.circle);
}

extension FDecorationBox on BoxDecoration {
  static BoxDecoration of({
    Color? color,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    DecorationImage? image,
  }) =>
      BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
        backgroundBlendMode: backgroundBlendMode,
        image: image,
      );
}

extension FDecorationShape on ShapeDecoration {
  static const stadiumGrey = ShapeDecoration(
    shape: StadiumBorder(),
    color: Colors.grey,
  );
  static const roundRect_8 = ShapeDecoration(
    shape: KOutlinedBorderRounded.allCircular_8,
  );

  static ShapeDecoration of({
    Color? color,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    DecorationImage? image,
    required ShapeBorder shape,
  }) =>
      ShapeDecoration(
        shape: shape,
        color: color,
        gradient: gradient,
        shadows: shadows,
        image: image,
      );
}

extension KDecorationShapeInputOutline on ShapeDecoration {
  static const black26_02 = ShapeDecoration(
    shape: KInputBorderOutlineSolidInside.black26_02,
  );
}

///
/// [of]
/// [rowLabelIconText]
///
extension FDecorationInput on InputDecoration {
  static InputDecoration of({
    bool isCollapsed = false,
    bool enabled = true,
    bool? filled,
    bool? alignLabelWithHint,
    bool? isDense,
    Widget? icon,
    Widget? label,
    Widget? error,
    Widget? prefix,
    Widget? suffix,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Widget? counter,
    String? labelText,
    String? helperText,
    String? hintText,
    String? errorText,
    String? prefixText,
    String? suffixText,
    String? counterText,
    String? semanticCounterText,
    BoxConstraints? constraints,
    BoxConstraints? prefixIconConstraints,
    BoxConstraints? suffixIconConstraints,
    TextStyle? labelStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    TextStyle? hintStyle,
    TextStyle? prefixStyle,
    TextStyle? suffixStyle,
    TextStyle? counterStyle,
    TextStyle? floatingLabelStyle,
    TextDirection? hintTextDirection,
    int? hintMaxLines,
    int? helperMaxLines,
    int? errorMaxLines,
    FloatingLabelBehavior? floatingLabelBehavior,
    FloatingLabelAlignment? floatingLabelAlignment,
    InputBorder? disabledBorder,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? border,
    EdgeInsetsGeometry? contentPadding,
    Color? iconColor,
    Color? prefixIconColor,
    Color? suffixIconColor,
    Color? fillColor,
    Color? focusColor,
    Color? hoverColor,
  }) =>
      InputDecoration(
        icon: icon,
        iconColor: iconColor,
        label: label,
        labelText: labelText,
        labelStyle: labelStyle,
        helperText: helperText,
        helperStyle: helperStyle,
        helperMaxLines: helperMaxLines,
        hintText: hintText,
        hintStyle: hintStyle,
        hintTextDirection: hintTextDirection,
        hintMaxLines: hintMaxLines,
        error: error,
        errorText: errorText,
        errorStyle: errorStyle,
        errorMaxLines: errorMaxLines,
        floatingLabelStyle: floatingLabelStyle,
        floatingLabelBehavior: floatingLabelBehavior,
        floatingLabelAlignment: floatingLabelAlignment,
        isDense: isDense,
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        prefixIconConstraints: prefixIconConstraints,
        prefix: prefix,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
        suffixIconConstraints: suffixIconConstraints,
        suffix: suffix,
        suffixText: suffixText,
        suffixStyle: suffixStyle,
        counter: counter,
        counterText: counterText,
        counterStyle: counterStyle,
        isCollapsed: isCollapsed,
        filled: filled,
        fillColor: fillColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        errorBorder: errorBorder,
        focusedBorder: focusedBorder,
        focusedErrorBorder: focusedErrorBorder,
        disabledBorder: disabledBorder,
        enabledBorder: enabledBorder,
        border: border,
        enabled: enabled,
        semanticCounterText: semanticCounterText,
        alignLabelWithHint: alignLabelWithHint,
        constraints: constraints,
      );

  static InputDecoration rowLabelIconText({
    InputBorder? border,
    required Icon icon,
    required String text,
  }) =>
      InputDecoration(
        alignLabelWithHint: true,
        border: border,
        contentPadding: switch (border) {
          KInputBorderOutline.none => null,
          null => EdgeInsets.zero,
          _ => throw UnimplementedError(),
        },
        label: Row(
          children: [
            icon,
            Text(text, style: KTextStyle.roboto),
          ],
        ),
      );
}

extension KDecorationInput on InputDecoration {
  static const collapsed = InputDecoration.collapsed(hintText: '');

  static const style1 = InputDecoration(
    labelStyle: TextStyle(color: Colors.blueGrey),
    enabledBorder: KInputBorderOutlineSolidInside.blueGrey_1_allCircular_10,
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

///
///
///
/// other
///
///
///

extension KSpacer on Spacer {
  static const Spacer none = Spacer();
}

extension KProgressIndicator on ProgressIndicator {
  static const circular = CircularProgressIndicator();
  static const circularBlueGrey = CircularProgressIndicator(
    color: Colors.blueGrey,
  );
  static const linear = LinearProgressIndicator();
  static const refresh = RefreshProgressIndicator();
}

extension KDrawer on Drawer {
  static const none = Drawer();
}

extension KTextStyle on TextStyle {
  static const size_10 = TextStyle(fontSize: 10);
  static const size_20 = TextStyle(fontSize: 20);
  static const size_30 = TextStyle(fontSize: 30);
  static const size_40 = TextStyle(fontSize: 40);
  static const size_50 = TextStyle(fontSize: 50);
  static const white = TextStyle(color: Colors.white);
  static const black12 = TextStyle(color: Colors.black12);
  static const black26 = TextStyle(color: Colors.black26);
  static const black38 = TextStyle(color: Colors.black38);
  static const black45 = TextStyle(color: Colors.black45);
  static const black54 = TextStyle(color: Colors.black54);
  static const black87 = TextStyle(color: Colors.black87);
  static const black = TextStyle(color: Colors.black);
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

extension VListView on ListView {
  static ListView get bigSmall_25 => ListView.builder(
        padding: KEdgeInsets.symV_8,
        itemCount: 25,
        itemBuilder: (context, index) => Container(
          margin: KEdgeInsets.symHV_24_8,
          height: index.isOdd ? 128 : 36,
          decoration: BoxDecoration(
            borderRadius: KBorderRadius.allCircular_8,
            color: Colors.grey.shade600,
          ),
        ),
      );
}

extension KIconMaterial on Icon {
  static const check = Icon(Icons.check);
  static const close = Icon(Icons.close);

  static const add = Icon(Icons.add);
  static const minus = Icon(Icons.remove);
  static const plus = add;
  static const cross = close;
  static const multiple = cross;
  static const questionMark = Icon(Icons.question_mark);

  static const play = Icon(Icons.play_arrow);
  static const pause = Icon(Icons.pause);
  static const stop = Icon(Icons.stop);
  static const create = Icon(Icons.create);
  static const edit = Icon(Icons.edit);
  static const delete = Icon(Icons.delete);
  static const cancel_24 = Icon(Icons.cancel, size: 24);
  static const cancelSharp = Icon(Icons.cancel_sharp);
  static const send = Icon(Icons.send);

  static const arrowRight = Icon(Icons.arrow_forward_ios);
  static const arrowLeft = Icon(Icons.arrow_back_ios);
  static const arrowRightward = Icon(Icons.arrow_forward);
  static const arrowLeftward = Icon(Icons.arrow_back);
  static const chevronLeft = Icon(Icons.chevron_left);
  static const chevronRight = Icon(Icons.chevron_right);

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
  static const calendarToday = Icon(Icons.calendar_today);

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

extension KIconMaterialWhite on Icon {
  static const add = Icon(Icons.add, color: Colors.white);
}
