import 'package:vendor/theming/buttons/button_icon.dart';
import 'package:vendor/theming/utils/utils_allert.dart';
import 'package:vendor/theming/utils/utils_neuro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIconDirection {
  static getLeadingIcon(context) {
    TextDirection textDirection = Directionality.of(context);
    return ButtonIcon(
      onPressed: () {
        Allert.tap();
        Navigator.pop(context);
      },
      data: Icon(
        textDirection == TextDirection.ltr
            ? CupertinoIcons.chevron_left
            : CupertinoIcons.chevron_right,
        size: 24,
      ),
    );
  }

  static chevron(context) {
    TextDirection textDirection = Directionality.of(context);
    return ButtonIcon(
      onPressed: () {
        Allert.tap();
        Navigator.pop(context);
      },
      data: Icon(
        textDirection == TextDirection.ltr
            ? CupertinoIcons.chevron_right
            : CupertinoIcons.chevron_left,
        size: 16,
      ),
    );
  }

  static getFullScreenLeading(context) {
    TextDirection textDirection = Directionality.of(context);
    return NeuContainer.simple(
      context: context,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: ButtonIcon(
          onPressed: () {
            Allert.tap();
            Navigator.pop(context);
          },
          data: Icon(
            textDirection == TextDirection.ltr
                ? CupertinoIcons.chevron_left
                : CupertinoIcons.chevron_right,
            size: 24,
          ),
        ),
      ),
    );
  }

  static chevronInverse(context) {
    TextDirection textDirection = Directionality.of(context);
    return ButtonIcon(
      onPressed: () {
        Allert.tap();
        Navigator.pop(context);
      },
      data: Icon(
        textDirection == TextDirection.ltr
            ? CupertinoIcons.chevron_right
            : CupertinoIcons.chevron_left,
        size: 16,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
