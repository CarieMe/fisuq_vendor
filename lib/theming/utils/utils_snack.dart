import 'package:vendor/theming/base/app_color.dart';
import 'package:vendor/theming/text/text_buttons.dart';
import 'package:vendor/theming/utils/utils_corners.dart';
import 'package:flutter/material.dart';

class SnackBars {
  static error({
    required BuildContext context,
    required String msg,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: BNW(data: msg),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.down,
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).focusColor,
            width: 1,
          ),
          borderRadius: Corners.br8,
        ),
        elevation: 5,
      ),
    );
  }
}
