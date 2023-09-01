part of source;

///
/// this file contains:
/// typedef:
/// [PreferColors], [PreferAnimations]
///
/// enum, class:
/// [MainColor], [PreferColor], [PreferColorPlacement]
/// [MainAnimation], [PreferAnimation], [PreferAnimationPlacement]
///
/// [Device], [LayoutDimension], [LayoutDimensionForm1], [LayoutDimensionForm1Variant]
///
///

///
/// see [PlatformDispatcher] to learn more about device, layout related topics
///

late final Device vDevice;

enum Device {
  iPhone14;

  Size get windowSize => switch (this) {
    Device.iPhone14 => const Size(430, 932),
  };

  LayoutDimensionForm1 get layoutDimensionForm1 => switch (this) {
    Device.iPhone14 => const LayoutDimensionForm1(
      height: 560,
      width: 360,
      paddingA: KEdgeInsets.onlyBottom_32,
      paddingB: KEdgeInsets.symH_64,
      paddingC: KEdgeInsets.onlyTop_32,
      sizedBoxA: KSizedBox.h32,
    ),
  };

  LayoutDimensionForm1Variant get layoutDimensionForm1Variant => switch (this) {
    Device.iPhone14 => const LayoutDimensionForm1Variant(
      sizedBoxZ: KSizedBox.h16,
      paddingZ: KEdgeInsets.ltrb_32_20_32_8,
    ),
  };
}

///
/// layout dimension
///

sealed class LayoutDimension {
  const LayoutDimension();

  String get info;
}

class LayoutDimensionForm1 extends LayoutDimension {
  final double height;
  final double width;
  final EdgeInsetsGeometry paddingA;
  final EdgeInsetsGeometry paddingB;
  final EdgeInsetsGeometry paddingC;
  final SizedBox sizedBoxA;
  final SizedBox sizedBoxB;

  const LayoutDimensionForm1({
    required this.height,
    required this.width,
    required this.paddingA,
    required this.paddingB,
    required this.paddingC,
    required this.sizedBoxA,
  }) : sizedBoxB = sizedBoxA;

  @override
  String get info =>
      "center -> sizedBox{height, width} -> form -> column(spaceBetween)["
          "padding{A} row(spaceBetween)[button1, button2]"
          "padding{B} of column[title, sizedBox{A}, textFormField1, sizedBox{B}, textFormField2]"
          "padding{C} column[button1, button2]"
          "]";
}

class LayoutDimensionForm1Variant extends LayoutDimension {
  final SizedBox sizedBoxA;
  final SizedBox sizedBoxB;
  final SizedBox sizedBoxZ;
  final EdgeInsetsGeometry paddingZ;

  const LayoutDimensionForm1Variant({
    required this.sizedBoxZ,
    required this.paddingZ,
  })  : sizedBoxA = sizedBoxZ,
        sizedBoxB = sizedBoxZ;

  @override
  String get info =>
      "center -> sizedBox{height, width} -> form -> column(spaceBetween)["
          "padding{A} row(spaceBetween)[button1, button2]"
          "padding{B} of column[title,"
          " sizedBox{Z}, padding{Z} textFormField3,"
          " sizedBox{A}, textFormField1,"
          " sizedBox{B}, textFormField2"
          " ]"
          "padding{C} column[button1, button2]"
          "]";
}


typedef PreferColors = Map<PreferColorPlacement, PreferColor>;
typedef PreferAnimations = Map<PreferAnimationPlacement, PreferAnimation>;

enum MainColor {
  red,
  orange,
  yellow,
  green,
  blue,
  purple;

  static MainColor get randomMainColor {
    final randomInt = Random().nextInt(6);
    switch (randomInt) {
      case 0:
        return MainColor.red;
      case 1:
        return MainColor.orange;
      case 2:
        return MainColor.yellow;
      case 3:
        return MainColor.green;
      case 4:
        return MainColor.blue;
      case 5:
        return MainColor.purple;
      default:
        throw UnimplementedError();
    }
  }

  bool get isRed => this == MainColor.red;

  bool get isOrange => this == MainColor.orange;

  bool get isYellow => this == MainColor.yellow;

  bool get isGreen => this == MainColor.green;

  bool get isBlue => this == MainColor.blue;

  bool get isPurple => this == MainColor.purple;

  Color get colorB1 {
    switch (this) {
      case MainColor.red:
        return KColorStyle1.redB1;
      case MainColor.orange:
        return KColorStyle1.orangeB1;
      case MainColor.yellow:
        return KColorStyle1.yellowB1;
      case MainColor.green:
        return KColorStyle1.greenB1;
      case MainColor.blue:
        return KColorStyle1.blueB1;
      case MainColor.purple:
        return KColorStyle1.purpleB1;
    }
  }

  Color get colorB2 {
    switch (this) {
      case MainColor.red:
        return KColorStyle1.redB2;
      case MainColor.orange:
        return KColorStyle1.orangeB2;
      case MainColor.yellow:
        return KColorStyle1.yellowB2;
      case MainColor.green:
        return KColorStyle1.greenB2;
      case MainColor.blue:
        return KColorStyle1.blueB2;
      case MainColor.purple:
        return KColorStyle1.purpleB2;
    }
  }

  Color get primaryColor {
    switch (this) {
      case MainColor.red:
        return KColorStyle1.redPrimary;
      case MainColor.orange:
        return KColorStyle1.orangePrimary;
      case MainColor.yellow:
        return KColorStyle1.yellowPrimary;
      case MainColor.green:
        return KColorStyle1.greenPrimary;
      case MainColor.blue:
        return KColorStyle1.bluePrimary;
      case MainColor.purple:
        return KColorStyle1.purplePrimary;
    }
  }

  Color get colorB3 {
    switch (this) {
      case MainColor.red:
        return KColorStyle1.redB3;
      case MainColor.orange:
        return KColorStyle1.orangeB3;
      case MainColor.yellow:
        return KColorStyle1.yellowB3;
      case MainColor.green:
        return KColorStyle1.greenB3;
      case MainColor.blue:
        return KColorStyle1.blueB3;
      case MainColor.purple:
        return KColorStyle1.purpleB3;
    }
  }

  Color get colorD1 {
    switch (this) {
      case MainColor.red:
        return KColorStyle1.redD1;
      case MainColor.orange:
        return KColorStyle1.orangeD1;
      case MainColor.yellow:
        return KColorStyle1.yellowD1;
      case MainColor.green:
        return KColorStyle1.greenD1;
      case MainColor.blue:
        return KColorStyle1.blueD1;
      case MainColor.purple:
        return KColorStyle1.purpleD1;
    }
  }

  Color get colorD2 {
    switch (this) {
      case MainColor.red:
        return KColorStyle1.redD2;
      case MainColor.orange:
        return KColorStyle1.orangeD2;
      case MainColor.yellow:
        return KColorStyle1.yellowD2;
      case MainColor.green:
        return KColorStyle1.greenD2;
      case MainColor.blue:
        return KColorStyle1.blueD2;
      case MainColor.purple:
        return KColorStyle1.purpleD2;
    }
  }

  Color get colorD3 {
    switch (this) {
      case MainColor.red:
        return KColorStyle1.redD3;
      case MainColor.orange:
        return KColorStyle1.orangeD3;
      case MainColor.yellow:
        return KColorStyle1.yellowD3;
      case MainColor.green:
        return KColorStyle1.greenD3;
      case MainColor.blue:
        return KColorStyle1.blueD3;
      case MainColor.purple:
        return KColorStyle1.purpleD3;
    }
  }
}

enum MainAnimation {
  slide,
  scale,
  translate,
  rotate;
}

class PreferColor {
  final PreferColorPlacement placement;
  final Color color;

  const PreferColor({
    required this.placement,
    required this.color,
  });
}

class PreferAnimation {
  final PreferAnimationPlacement placement;
  final Duration duration;
  final Curve curve;
  final Decoration? decoration;
  final Color? color;

  const PreferAnimation.container({
    required this.placement,
    required this.duration,
    required this.curve,
    required this.decoration,
    required this.color,
  });
}

///
/// placement
///

enum PreferColorPlacement {
  navigationGraph;

  PreferColor get defaultColor {
    throw UnimplementedError();
  }
}

enum PreferAnimationPlacement {
  navigationMap,
  navigationMapExpand,
  navigationMapShrink,
  navigationMapItem,
  navigationMapItemSelect;

  PreferAnimation get defaultAnimation {
    throw UnimplementedError();
  }
}
