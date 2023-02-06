import 'dart:io';

import 'package:flutter/foundation.dart';

class FS {
  static double c(double s) {
    double size;
    if (kIsWeb || Platform.isMacOS) {
      size = s - 2;
      return size;
    } else {
      size = s;
      return size;
    }
  }

  const FS._();
}
