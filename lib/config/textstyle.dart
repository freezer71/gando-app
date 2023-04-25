// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static String? primaryColorString = "#000000";
  static String? secondaryColorString = "#faf5f7";
  static Color backgroundColor = Color(0xFFEBEBEB);
  static Color light = Color(0xFFFFFFFF);
  static Color buttonColor = Color(0xFF292F36);

  static Color primaryColor = Color(0xff4ecdc4);
  // static Color primaryColor = Color(0xFF40ac9c);
  // static Color redColor = Color(0xFFCC5656);
  static Color redColor = Color(0xFFFF6B6B);
  static Color secondaryColor = Color(0xFF203e5a);
  static Color darkColor = Color(0xff292F36);

  static Brightness brightness =
      SchedulerBinding.instance.window.platformBrightness;

  static bool isLightTheme = false;

  static ThemeData getTheme() {
    final box = GetStorage();
    isLightTheme = box.read('isLightMode') ?? isLightTheme;

    if (isLightTheme) {
      return lightTheme();
    } else {
      return darkTheme();
    }
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline6: GoogleFonts.manrope(
          textStyle: TextStyle(
              color: base.headline6!.color,
              fontSize: 20,
              fontWeight: FontWeight.w500)),
      subtitle1: GoogleFonts.manrope(
          textStyle: TextStyle(color: base.subtitle1!.color, fontSize: 18)),
      subtitle2: GoogleFonts.manrope(
          textStyle: TextStyle(
              color: base.subtitle2!.color,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      bodyText2: GoogleFonts.manrope(
          textStyle: TextStyle(color: base.bodyText2!.color, fontSize: 16)),
      bodyText1: GoogleFonts.manrope(
          textStyle: TextStyle(color: base.bodyText1!.color, fontSize: 14)),
      button: GoogleFonts.manrope(
          textStyle: TextStyle(
              color: base.button!.color,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      caption: GoogleFonts.manrope(
          textStyle: TextStyle(color: base.caption!.color, fontSize: 12)),
      headline4: GoogleFonts.manrope(
          textStyle: TextStyle(color: base.headline4!.color, fontSize: 34)),
      headline3: GoogleFonts.manrope(
          textStyle: TextStyle(color: base.headline3!.color, fontSize: 48)),
      headline2: GoogleFonts.manrope(
          textStyle: TextStyle(color: base.headline2!.color, fontSize: 60)),
      headline1: GoogleFonts.manrope(
          textStyle: TextStyle(color: base.headline1!.color, fontSize: 96)),
      headline5: GoogleFonts.manrope(
          textStyle: TextStyle(color: base.headline5!.color, fontSize: 24)),
      overline: GoogleFonts.manrope(
          textStyle: TextStyle(color: base.overline!.color, fontSize: 10)),
    );
  }

  static ThemeData lightTheme() {
    Color secondaryColor = HexColor(secondaryColorString!);
    Color primaryColor = HexColor(primaryColorString!);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );

    final ThemeData base = ThemeData.light();
    return base.copyWith(
      appBarTheme: AppBarTheme(color: Colors.black),
      popupMenuTheme: PopupMenuThemeData(color: Colors.black),
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      splashColor: Colors.black.withOpacity(0.1),
      hoverColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.transparent,
      accentColor: primaryColor,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      backgroundColor: Colors.white,
      errorColor: Colors.red,
      primaryColorLight: Colors.red,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      indicatorColor: primaryColor,
      disabledColor: HexColor("#D5D7D8"),
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme() {
    Color primaryColor = HexColor(primaryColorString!);
    Color secondaryColor = HexColor(secondaryColorString!);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      popupMenuTheme: PopupMenuThemeData(color: Colors.black),
      appBarTheme: AppBarTheme(color: Colors.black),
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: Colors.grey[850],
      scaffoldBackgroundColor: Colors.grey[850],
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
