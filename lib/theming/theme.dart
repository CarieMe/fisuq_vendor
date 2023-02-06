import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:fisuq_vendor/theming/colors/color_theme.dart';
import 'package:fisuq_vendor/theming/text/font_theme.dart';
import 'package:fisuq_vendor/tools/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: ThemeColor.darkprimary,
      ),
      iconTheme: IconThemeData(color: ThemeColor.darkFontColor)),
  canvasColor: ThemeColor.darkCanvasColor,
  cardColor: ThemeColor.darkCardColor,
  dialogBackgroundColor: AppColor.primary,
  primaryColor: AppColor.primary,
  toggleableActiveColor: AppColor.primary,
  fontFamily: urbanist,
  brightness: Brightness.dark,
  hintColor: AppColor.primary,
  iconTheme: const IconThemeData(
    color: AppColor.primary,
  ),
  backgroundColor: ThemeColor.darkBackgroundColor,
  textTheme: fontDarkTheme,
  disabledColor: ThemeColor.darkFontColor,
  shadowColor: ThemeColor.darkShadowColor,
  indicatorColor: ThemeColor.darkIndicatorColor,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: ThemeColor.darkBackgroundColor,
  ),
  splashColor: AppColor.empty,
);

final lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: ThemeColor.lightprimary,
      ),
      iconTheme: IconThemeData(color: ThemeColor.lightFontColor)),
  canvasColor: ThemeColor.lightCanvasColor,
  cardColor: ThemeColor.lightCardColor,
  dialogBackgroundColor: const Color(0xffFFFFFF),
  iconTheme: const IconThemeData(
    color: AppColor.primary,
  ),
  primaryColor: const Color(0xffEEF2F9),
  fontFamily: urbanist,
  brightness: Brightness.light,
  backgroundColor: ThemeColor.lightBackgroundColor,
  textTheme: fontLightTheme,
  disabledColor: ThemeColor.lightFontColor,
  shadowColor: ThemeColor.lightShadowColor,
  indicatorColor: ThemeColor.lightIndicatorColor,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: ThemeColor.lightBackgroundColor,
  ),
  splashColor: AppColor.empty,
);
