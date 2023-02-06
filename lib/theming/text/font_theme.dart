import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:fisuq_vendor/theming/text/font_size.dart';
import 'package:fisuq_vendor/tools/constants.dart';
import 'package:flutter/material.dart';

final fontLightTheme = TextTheme(
  /// FONTSIZE 34 BOLD
  headlineLarge: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(34),
    fontWeight: FontWeight.w800,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 34 REGULAR
  headlineMedium: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(34),
    fontWeight: FontWeight.w600,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 34 BOLD
  headlineSmall: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(34),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 28 regular
  labelLarge: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(28),
    fontWeight: FontWeight.w800,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 22 regular
  labelMedium: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(22),
    fontWeight: FontWeight.w800,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 20 regular
  labelSmall: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(20),
    fontWeight: FontWeight.w800,
    fontFamily: urbanist,
  ),

  /// =>17
  bodyLarge: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(17),
    fontWeight: FontWeight.w600,
    fontFamily: urbanist,
  ),
  bodyMedium: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(17),
    fontWeight: FontWeight.w400,
    fontFamily: urbanist,
  ),
  bodySmall: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(17),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),

  /// USE THIS FOR BUTTON COLOR WHITE light and dark
  displayLarge: TextStyle(
    color: AppColor.light2,
    fontSize: FS.c(18),
    fontWeight: FontWeight.w400,
    fontFamily: urbanist,
  ),

  /// USE THIS FOR GESTURE COLOR WITH OPACITY
  displayMedium: TextStyle(
    color: AppColor.light7,
    fontSize: FS.c(18),
    fontWeight: FontWeight.w600,
    fontFamily: urbanist,
  ),

  /// USE THIS FOR GESTURE COLOR NO OPACITY
  displaySmall: TextStyle(
    color: AppColor.light7,
    fontSize: FS.c(18),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 15
  titleLarge: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(15),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 13
  titleMedium: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(13),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 11
  titleSmall: TextStyle(
    color: AppColor.dark3,
    fontSize: FS.c(11),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),
);

final fontDarkTheme = TextTheme(
  /// FONTSIZE 34 BOLD
  headlineLarge: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(34),
    fontWeight: FontWeight.w800,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 34 REGULAR
  headlineMedium: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(34),
    fontWeight: FontWeight.w600,
    fontFamily: urbanist,
    letterSpacing: 1.1,
  ),

  /// FONTSIZE 34 BOLD
  headlineSmall: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(34),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 28 regular
  labelLarge: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(28),
    fontWeight: FontWeight.w800,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 22 regular
  labelMedium: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(22),
    fontWeight: FontWeight.w800,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 20 regular
  labelSmall: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(20),
    fontWeight: FontWeight.w800,
    fontFamily: urbanist,
  ),

  /// =>17
  bodyLarge: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(17),
    fontWeight: FontWeight.w600,
    fontFamily: urbanist,
  ),
  bodyMedium: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(17),
    fontWeight: FontWeight.w400,
    fontFamily: urbanist,
  ),
  bodySmall: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(17),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),

  /// USE THIS FOR BUTTON COLOR WHITE light and dark
  displayLarge: TextStyle(
    color: AppColor.light2,
    fontSize: FS.c(18),
    fontWeight: FontWeight.w400,
    fontFamily: urbanist,
  ),

  /// USE THIS FOR GESTURE COLOR WITH OPACITY
  displayMedium: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(18),
    fontWeight: FontWeight.w600,
    fontFamily: urbanist,
  ),

  /// USE THIS FOR GESTURE COLOR NO OPACITY
  displaySmall: TextStyle(
    color: AppColor.light7,
    fontSize: FS.c(18),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 15
  titleLarge: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(15),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 13
  titleMedium: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(13),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),

  /// FONTSIZE 11
  titleSmall: TextStyle(
    color: AppColor.light4,
    fontSize: FS.c(11),
    fontWeight: FontWeight.w300,
    fontFamily: urbanist,
  ),
);
