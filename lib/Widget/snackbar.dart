import 'package:fisuq_vendor/Widget/validation.dart';
import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:fisuq_vendor/theming/helper/const_corners.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';

setSnackbar(String msg, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: TextCenter(msg),
      backgroundColor: AppColor.primary,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.down,
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).focusColor,
          width: 1,
        ),
        borderRadius: Corners.cornerMd,
      ),
      elevation: 5,
    ),
  );
}

class Snack {
  static message(String msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextCenter(getTranslated(context, msg)!),
        backgroundColor: AppColor.primary,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.down,
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).focusColor,
            width: 1,
          ),
          borderRadius: Corners.cornerMd,
        ),
        elevation: 5,
      ),
    );
  }
}
