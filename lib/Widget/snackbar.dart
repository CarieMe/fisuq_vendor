import 'package:vendor/Widget/validation.dart';
import 'package:flutter/material.dart';
import 'package:vendor/helper/theming.dart';

setSnackbar(String msg, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: TextCenter(msg),
      backgroundColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.down,
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).focusColor,
          width: 1,
        ),
        borderRadius: Corners.br15,
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
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.down,
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).focusColor,
            width: 1,
          ),
          borderRadius: Corners.br15,
        ),
        elevation: 5,
      ),
    );
  }
}

class Snacks {
  static success(String msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: IntroCenter(
          data: msg,
          size: 17,
        ),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.down,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).focusColor,
            width: 1,
          ),
          borderRadius: Corners.br15,
        ),
        elevation: 5,
      ),
    );
  }

  static error(String msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: IntroCenter(
          data: msg,
          size: 17,
        ),
        backgroundColor: AppColors.red,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.down,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).focusColor,
            width: 1,
          ),
          borderRadius: Corners.br15,
        ),
        elevation: 5,
      ),
    );
  }
}
