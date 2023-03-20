import 'package:vendor/theming/base/app_color.dart';
import 'package:vendor/theming/utils/utils_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@immutable
class AppIcons {
  const AppIcons._();
  static const String svgIcon = '';

  static white({
    required String icon,
    double? size,
  }) {
    return SvgPicture.asset(
      SetPath.setSvgPath(icon),
      color: AppColors.light0,
      height: size ?? 24,
      width: size ?? 24,
    );
  }

  static colored({
    required String icon,
    double? size,
    required Color color,
  }) {
    return SvgPicture.asset(
      SetPath.setSvgPath(icon),
      color: color,
      height: size ?? 24,
      width: size ?? 24,
    );
  }

  static basic({
    required String icon,
    double? size,
  }) {
    return SvgPicture.asset(
      SetPath.setSvgPath(icon),
      color: AppColors.primary,
      height: size ?? 24,
      width: size ?? 24,
    );
  }

  static material({
    required IconData icon,
    double? size,
  }) {
    return Icon(
      icon,
      size: size ?? 20,
    );
  }
}
