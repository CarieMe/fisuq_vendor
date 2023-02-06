import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeColor {
  //darktheme
  static Color get darkBackgroundColor => AppColor.dark2;
  static Color get darkprimary => AppColor.dark2;
  static Color get darkprimaryLight => AppColor.dark3;
  static Color get darkprimaryDark => AppColor.primary;
  static Color get darkHintColor => AppColor.light1;
  static Color get darkIndicatorColor => AppColor.light4;
  static Color get darkSplashColor => Colors.transparent;
  static InteractiveInkFeatureFactory get darkSplashFactory =>
      NoSplash.splashFactory;
  static Color get darkCanvasColor => AppColor.dark2;
  static Color get darkShadowColor => AppColor.dark0;
  static Color get darkHighlightColor => AppColor.dark0;
  static Color get darkFocusColor => AppColor.dark4;
  static Color get darkHoverColor => Colors.transparent;
  static Color get darkDisabledColor => AppColor.light1;
  static Color get darkCardColor => AppColor.dark3;
  static Color get darkFontColor => AppColor.light4;

  //lighttheme
  static Color get lightBackgroundColor => AppColor.light2;
  static Color get lightprimary => AppColor.light0;
  static Color get lightprimaryLight => AppColor.dark3;
  static Color get lightprimaryDark => AppColor.primary;
  static Color get lightHintColor => AppColor.light1;
  static Color get lightIndicatorColor => AppColor.dark3;
  static Color get lightSplashColor => Colors.transparent;
  static InteractiveInkFeatureFactory get lightSplashFactory =>
      NoSplash.splashFactory;
  static Color get lightCanvasColor => AppColor.light0;
  static Color get lightShadowColor => AppColor.light0;
  static Color get lightHighlightColor => AppColor.dark0;
  static Color get lightFocusColor => AppColor.dark4;
  static Color get lightHoverColor => Colors.transparent;
  static Color get lightDisabledColor => AppColor.light1;
  static Color get lightCardColor => AppColor.light0;
  static Color get lightFontColor => AppColor.dark3;
}
