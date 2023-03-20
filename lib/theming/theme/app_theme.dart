import 'package:vendor/theming/base/app_color.dart';
import 'package:vendor/theming/base/app_color_theme.dart';
import 'package:vendor/theming/base/app_strings.dart';
import 'package:vendor/theming/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: AppColors.empty,
      //systemNavigationBarColor: AppColorTheme.darkprimary,
    ),
    iconTheme: IconThemeData(
      color: AppColors.light4,
      size: 24,
    ),
    scrolledUnderElevation: 0.0,
  ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  canvasColor: AppColorTheme.darkCanvasColor,
  cardColor: AppColorTheme.darkCardColor,
  dialogBackgroundColor: AppColors.dark2,
  colorScheme: darkColorScheme,
  primaryColor: AppColors.primary,
  // textSelectionTheme: TextSelectionThemeData(
  //   cursorColor: AppColors.darkIcon,
  //   selectionColor: AppColors.darkIcon,
  //   selectionHandleColor: AppColors.darkIcon,
  // ),
  toggleableActiveColor: AppColors.primary,
  fontFamily: AppStrings.urbanist,
  brightness: Brightness.dark,
  iconTheme: IconThemeData(
    color: AppColors.primary,
  ),
  backgroundColor: AppColorTheme.darkBackgroundColor,
  disabledColor: AppColorTheme.darkDisabledFontColor,
  shadowColor: AppColorTheme.darkShadowColor,
  indicatorColor: AppColorTheme.darkIndicatorColor,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColorTheme.darkBackgroundColor,
  ),

  errorColor: AppColors.error,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: AppColors.light4,
    ),
    displayMedium: TextStyle(
      color: AppColors.light4,
    ),
    displaySmall: TextStyle(
      color: AppColors.light4,
    ),
    headlineLarge: TextStyle(
      color: AppColors.light4,
    ),
    headlineMedium: TextStyle(
      color: AppColors.light4,
    ),
    headlineSmall: TextStyle(
      color: AppColors.light4,
    ),
    labelLarge: TextStyle(
      color: AppColors.light4,
    ),
    labelMedium: TextStyle(
      color: AppColors.light4,
    ),
    labelSmall: TextStyle(
      color: AppColors.light4,
    ),
    bodyLarge: TextStyle(
      color: AppColors.light4,
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      color: AppColors.light4,
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      color: AppColors.light4,
      fontSize: 14,
    ),
    titleLarge: TextStyle(
      color: AppColors.light4,
    ),
    titleMedium: TextStyle(
      color: AppColors.light4,
    ),
    titleSmall: TextStyle(
      color: AppColors.light4,
    ),
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: AppColors.empty,
      systemNavigationBarColor: AppColorTheme.lightprimary,
    ),
    iconTheme: IconThemeData(
      color: AppColors.dark3,
      size: 24,
    ),
    scrolledUnderElevation: 0.0,
  ),
  splashFactory: NoSplash.splashFactory,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  // colorScheme: AppColorscheme.fromSwatch(
  //   primarySwatch: AppColors.primary_app,
  // ).copyWith(
  //   secondary: AppColors.darkIcon,
  //   brightness: Brightness.light,
  // ),
  colorScheme: lightColorScheme,
  canvasColor: AppColorTheme.lightCanvasColor,
  cardColor: AppColorTheme.lightCardColor,
  dialogBackgroundColor: const Color(0xffFFFFFF),
  iconTheme: IconThemeData(
    color: AppColors.primary,
  ),
  //primarySwatch: AppColors(color: ).primary,
  primaryColor: AppColors.primary,
  fontFamily: AppStrings.urbanist,
  brightness: Brightness.light,
  backgroundColor: AppColorTheme.lightBackgroundColor,
  disabledColor: AppColorTheme.lightDisabledFontColor,
  shadowColor: AppColorTheme.lightShadowColor,
  indicatorColor: AppColorTheme.lightIndicatorColor,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColorTheme.lightBackgroundColor,
  ),
  errorColor: AppColors.error,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: AppColors.dark3,
    ),
    displayMedium: TextStyle(
      color: AppColors.dark3,
    ),
    displaySmall: TextStyle(
      color: AppColors.dark3,
    ),
    headlineLarge: TextStyle(
      color: AppColors.dark3,
    ),
    headlineMedium: TextStyle(
      color: AppColors.dark3,
    ),
    headlineSmall: TextStyle(
      color: AppColors.dark3,
    ),
    labelLarge: TextStyle(
      color: AppColors.dark3,
    ),
    labelMedium: TextStyle(
      color: AppColors.dark3,
    ),
    labelSmall: TextStyle(
      color: AppColors.dark3,
    ),
    bodyLarge: TextStyle(
      color: AppColors.dark3,
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      color: AppColors.dark3,
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      color: AppColors.dark3,
      fontSize: 14,
    ),
    titleLarge: TextStyle(
      color: AppColors.dark3,
    ),
    titleMedium: TextStyle(
      color: AppColors.dark3,
    ),
    titleSmall: TextStyle(
      color: AppColors.dark3,
    ),
  ),
);
