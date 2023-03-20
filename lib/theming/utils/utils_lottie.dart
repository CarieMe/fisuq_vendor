import 'package:vendor/theming/utils/utils_design.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@immutable
class AppLottie {
  const AppLottie._();

  static basic({
    required String lottie,
    required bool repeat,
    double? size,
  }) {
    return Lottie.asset(
      SetPath.setLottiePath(lottie),
      repeat: repeat,
      height: size ?? 24,
      width: size ?? 24,
    );
  }
}
