import 'dart:math';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:vendor/theming/text/text.dart';

Color generateRandomColor() {
  Random random = Random();
  // Pick a random number in the range [0.0, 1.0)
  double randomDouble = random.nextDouble();

  return Color((randomDouble * 0xFFFFFF).toInt()).withOpacity(1.0);
}

gethomePageTextDesing(
  String numberValue,
  String title,
) {
  return Column(
    children: [
      TextLM(
        numberValue,
      ),
      const SizedBox(height: 10),
      TextC(
        title,
        size: 14,
      )
    ],
  );
}
