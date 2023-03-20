import 'package:vendor/theming/utils/utils_corners.dart';
import 'package:flutter/material.dart';

class Shapes {
  static ShapeBorder small(context) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).focusColor,
        width: 1,
      ),
      borderRadius: Corners.br4,
    );
  }

  static ShapeBorder medium(context) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).colorScheme.outlineVariant,
        width: 1,
      ),
      borderRadius: Corners.br8,
    );
  }

  static ShapeBorder dialog(context) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).colorScheme.outlineVariant,
        width: 1,
      ),
      borderRadius: Corners.br12,
    );
  }

  static ShapeBorder large(context) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).focusColor,
        width: 1,
      ),
      borderRadius: Corners.br15,
    );
  }

  static ShapeBorder full(context) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).focusColor,
        width: 1,
      ),
      borderRadius: Corners.br100,
    );
  }
}
