import 'package:vendor/theming/base/app_color.dart';
import 'package:vendor/theming/utils/utils_corners.dart';
import 'package:flutter/material.dart';

class NeuContainer {
  static simple({required BuildContext context, required Widget child}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: Corners.br12,
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: child,
    );
  }

  static product({required BuildContext context, required Widget child}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: Corners.br15,
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }

  static outline({required BuildContext context, required Widget child}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: Corners.br6,
        // border: Border.all(
        //   color: Theme.of(context).colorScheme.outlineVariant,
        //   width: 1,
        // ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: child,
    );
  }

  static colorOutline(
      {required BuildContext context,
      required Widget child,
      required Color color}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: Corners.br6,
        border: Border.all(
          color: color,
          width: 1,
        ),
        color: AppColors.empty,
      ),
      child: child,
    );
  }

  static color({required BuildContext context, required Widget child}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: Corners.br6,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
        ),
        color: AppColors.empty,
      ),
      child: child,
    );
  }
}
