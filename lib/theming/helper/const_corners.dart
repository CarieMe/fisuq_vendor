import 'package:flutter/material.dart';

class Corners {
  // => SMALL
  static const double sm = 3;
  static const Radius smRadius = Radius.circular(sm);
  static const BorderRadius cornerSm = BorderRadius.all(smRadius);
  // => MEDIUM
  static const double med = 8;
  static const Radius mdRadius = Radius.circular(med);
  static const BorderRadius cornerMd = BorderRadius.all(mdRadius);
  // => LARGE
  static const double lg = 15;
  static const Radius lgRadius = Radius.circular(lg);
  static const BorderRadius cornerLg = BorderRadius.all(lgRadius);
  // =- CIRCLE
  static const double fl = 100;
  static const Radius flRadius = Radius.circular(fl);
  static const BorderRadius cornerFl = BorderRadius.all(flRadius);

  static const double set = 10;
  static const Radius sett = Radius.circular(set);
  static const BorderRadius settings = BorderRadius.all(sett);
}
