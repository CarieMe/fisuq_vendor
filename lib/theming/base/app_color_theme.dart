import 'package:vendor/theming/base/app_color.dart';
import 'package:flutter/material.dart';

class AppColorTheme {
  //darktheme
  static Color get darkBackgroundColor => AppColors.dark1;
  static Color get darkprimary => AppColors.dark2;
  static Color get darkprimaryLight => AppColors.dark3;
  static Color get darkprimaryDark => AppColors.primary;

  static Color get darkIndicatorColor => AppColors.light4;
  static Color get darkSplashColor => Colors.transparent;
  static InteractiveInkFeatureFactory get darkSplashFactory =>
      NoSplash.splashFactory;
  static Color get darkCanvasColor => AppColors.dark3.withOpacity(0.2);
  static Color get darkShadowColor => AppColors.dark0;
  static Color get darkHighlightColor => AppColors.dark0;
  static Color get darkFocusColor => AppColors.dark4;
  static Color get darkHoverColor => Colors.transparent;
  static Color get darkDisabledColor => AppColors.light1;
  static Color get darkCardColor => AppColors.dark3;

  static Color get darkInverseFontColor => AppColors.light2;
  static Color get darkFontColor => AppColors.dark3;
  static Color get darkDisabledFontColor => AppColors.light4.withOpacity(.7);
  static Color get darkReverseFontColor => AppColors.dark3;

  //reveresed color
  static Color get darkHintColor => AppColors.dark3;

  //lighttheme
  static Color get lightBackgroundColor => AppColors.light0;
  static Color get lightprimary => AppColors.light0;
  static Color get lightprimaryLight => AppColors.dark3;
  static Color get lightprimaryDark => AppColors.primary;

  static Color get lightIndicatorColor => AppColors.dark3;
  static Color get lightSplashColor => Colors.transparent;
  static InteractiveInkFeatureFactory get lightSplashFactory =>
      NoSplash.splashFactory;
  static Color get lightCanvasColor => AppColors.light2.withOpacity(0.7);
  static Color get lightShadowColor => AppColors.light6;
  static Color get lightHighlightColor => AppColors.dark0;
  static Color get lightFocusColor => AppColors.dark4;
  static Color get lightHoverColor => Colors.transparent;
  static Color get lightDisabledColor => AppColors.light1;
  static Color get lightCardColor => AppColors.light3;

  static Color get lightFontColor => AppColors.light4;
  static Color get lightDisabledFontColor => AppColors.dark3.withOpacity(.7);
  static Color get lightkInverseFontColor => AppColors.dark2;
  static Color get lightReverseFontColor => AppColors.light4;

  //reveresed color
  static Color get lightHintColor => AppColors.light4;
}
