// ignore_for_file: constant_identifier_names

part of source;

///
/// this file contains:
/// [KStringAssetImage]
/// [KStringAssetFontFamily]
///
/// [KIconCupertinoIcons]
/// [VGoogleFontsMono]
/// [VLaTexFontStyle]
/// [KTableCalendarStyle]
///
///

extension KStringAssetImage on String {
  static const String wallpaper = "lib/wallpaper.jpg";
  static const String logo_discord = "assets/logo/Discord.png";
  static const String logo_instagram = "assets/logo/Instagram.png";
  static const String logo_line = "assets/logo/LINE.png";
  static const String logo_notion = "assets/logo/Notion.png";
  static const String logo_timetree = "assets/logo/Timetree.png";
  static const String logo_youtube = "assets/logo/Youtube.png";
  static const String logo_pokemon = "assets/logo/Pokemon.png";
  static const String logo_maumiwar = "assets/logo/Maumiwar.png";
  static const String talunity_qr = "assets/talunity_qr.png";
  static const String talunity_recruitmentForm = "assets/talunity_recruitmentForm.png";
}

extension KStringAssetFontFamily on String {
  static const String easyWrite = 'EasyWrite';
  static const String notoSerifCJKtc = 'NotoSerifCJKtc';
  static const String setofont = 'Setofont';
  static const String yozai = 'Yozai';
}

extension KStringAssetMusic on String {
  static const String thatsTheWayLoveGoes =
      "music/JanetJackson_ThatsTheWayLoveGoes.wav";
  static const String river = "music/River.wav";
}

extension KIconCupertinoIcons on Icon {
  static const plus = Icon(CupertinoIcons.plus);
  static const equal = Icon(CupertinoIcons.equal);
  static const question = Icon(CupertinoIcons.question);
}

//
// extension VGoogleFontsMono on GoogleFonts {
//   static TextStyle azeret_18 = GoogleFonts.azeretMono(fontSize: 18);
//   static TextStyle b612_18 = GoogleFonts.b612Mono(fontSize: 18);
//   static TextStyle chivo_18 = GoogleFonts.chivoMono(fontSize: 18);
//   static TextStyle cutive_18 = GoogleFonts.cutiveMono(fontSize: 18);
//   static TextStyle dm_18 = GoogleFonts.dmMono(fontSize: 18);
//   static TextStyle fira_18 = GoogleFonts.firaMono(fontSize: 18);
//   static TextStyle fragment_18 = GoogleFonts.fragmentMono(fontSize: 18);
//   static TextStyle ibmPlex_18 = GoogleFonts.ibmPlexMono(fontSize: 18);
//   static TextStyle jetBrains_18 = GoogleFonts.jetBrainsMono(fontSize: 18);
//   static TextStyle majorDisplay_18 = GoogleFonts.majorMonoDisplay(fontSize: 18);
//   static TextStyle martian_18 = GoogleFonts.martianMono(fontSize: 18);
//   static TextStyle monofett_18 = GoogleFonts.monofett(fontSize: 18);
//   static TextStyle monoton_18 = GoogleFonts.monoton(fontSize: 18);
//   static TextStyle notoSans_18 = GoogleFonts.notoSansMono(fontSize: 18);
//   static TextStyle nova_18 = GoogleFonts.novaMono(fontSize: 18);
//   static TextStyle overpass_18 = GoogleFonts.overpassMono(fontSize: 18);
//   static TextStyle oxygen_18 = GoogleFonts.oxygenMono(fontSize: 18);
//   static TextStyle pt_18 = GoogleFonts.ptMono(fontSize: 18);
//   static TextStyle redHat_18 = GoogleFonts.redHatMono(fontSize: 18);
//   static TextStyle robotoMono_18 = GoogleFonts.robotoMono(fontSize: 18);
//   static TextStyle rubikOne_18 = GoogleFonts.rubikMonoOne(fontSize: 18);
//   static TextStyle shareTech_18 = GoogleFonts.shareTechMono(fontSize: 18);
//   static TextStyle space_18 = GoogleFonts.spaceMono(fontSize: 18);
//   static TextStyle splineSans_18 = GoogleFonts.splineSansMono(fontSize: 18);
//   static TextStyle syne_18 = GoogleFonts.syneMono(fontSize: 18);
//   static TextStyle ubuntu_18 = GoogleFonts.ubuntuMono(fontSize: 18);
//   static TextStyle xanh_18 = GoogleFonts.xanhMono(fontSize: 18);
// }
//
// extension VLaTexFontStyle on TeXViewFontStyle {
//   static TeXViewFontStyle size_10 = TeXViewFontStyle(
//     fontSize: 10,
//   );
//   static TeXViewFontStyle size_12 = TeXViewFontStyle(fontSize: 12);
//   static TeXViewFontStyle size_14 = TeXViewFontStyle(fontSize: 14);
//   static TeXViewFontStyle size_16 = TeXViewFontStyle(fontSize: 16);
//   static TeXViewFontStyle size_18 = TeXViewFontStyle(fontSize: 18);
//   static TeXViewFontStyle size_20 = TeXViewFontStyle(fontSize: 20);
//   static TeXViewFontStyle size_30 = TeXViewFontStyle(fontSize: 30);
// }

// extension KTableCalendarStyle on TableCalendar {
//   static const CalendarStyle none = CalendarStyle();
// }
//
// extension KTableCalendarDaysOfWeekStyle on DaysOfWeekStyle {
//   static const DaysOfWeekStyle weekDayBlack_weekendBlack45 = DaysOfWeekStyle(
//     weekdayStyle: KTextStyle.black,
//     weekendStyle: KTextStyle.black45,
//   );
// }

