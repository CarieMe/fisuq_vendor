import 'package:vendor/theming/base/app_color.dart';
import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  //base colors
  background: AppColors.light0,
  primary: AppColors.primary,
  secondary: AppColors.secondary,
  tertiary: AppColors.tertiary,
  //on top of base colors
  onBackground: AppColors.dark3,
  onPrimary: AppColors.light4,
  onSecondary: AppColors.light4,
  onTertiary: AppColors.light4,
  // errors
  error: AppColors.error,
  errorContainer: AppColors.error,
  onError: AppColors.light0,
  onErrorContainer: AppColors.light0,

  //widget background color
  surface: AppColors.light01,
  onSurface: Color(0xFF2C1700),
  surfaceVariant: Color(0xFFF4DDDC),
  surfaceTint: Color(0xFFBA172C),
  onSurfaceVariant: Color(0xFF524342),

  // use for containers
  primaryContainer: Color(0xFFFFDAD8),
  onPrimaryContainer: Color(0xFF410007),
  secondaryContainer: Color(0xFFFFDAD8),
  onSecondaryContainer: Color(0xFF410006),
  tertiaryContainer: Color(0xFFFFDDB7),
  onTertiaryContainer: Color(0xFF2A1700),

  //outline colors
  outline: AppColors.primary,
  outlineVariant: AppColors.light02,

  //invesersed objects like white container on black backgound
  onInverseSurface: Color(0xFFFFEEE0),
  inverseSurface: AppColors.dark3.withOpacity(.8),
  inversePrimary: AppColors.light2,
  //shadow colors
  shadow: AppColors.light5,
);

final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  //base colors
  background: AppColors.dark0,
  primary: AppColors.primary,
  secondary: AppColors.secondary,
  tertiary: AppColors.tertiary,
  //on top of base colors
  onBackground: AppColors.light4,
  onPrimary: AppColors.light4,
  onSecondary: AppColors.light4,
  onTertiary: AppColors.light4,
  // errors
  error: AppColors.error,
  errorContainer: AppColors.error,
  onError: AppColors.light0,
  onErrorContainer: AppColors.light0,

  //widget background color
  surface: AppColors.dark01,
  onSurface: Color(0xFF2C1700),
  surfaceVariant: Color(0xFFF4DDDC),
  surfaceTint: Color(0xFFBA172C),
  onSurfaceVariant: Color(0xFF524342),

  // use for containers
  primaryContainer: Color(0xFFFFDAD8),
  onPrimaryContainer: Color(0xFF410007),
  secondaryContainer: Color(0xFFFFDAD8),
  onSecondaryContainer: Color(0xFF410006),
  tertiaryContainer: Color(0xFFFFDDB7),
  onTertiaryContainer: Color(0xFF2A1700),

  //outline colors
  outline: AppColors.primary,
  outlineVariant: AppColors.dark02,

  //invesersed objects like white container on black backgound
  onInverseSurface: Color(0xFFFFEEE0),
  inverseSurface: AppColors.light4.withOpacity(.8),
  inversePrimary: AppColors.dark3,
  //shadow colors
  shadow: AppColors.dark0,
  scrim: const Color(0xFF000000),
);
