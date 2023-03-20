import 'package:flutter/services.dart';

class Allert {
  const Allert._();
  static void tap() {
    HapticFeedback.heavyImpact();
    SystemSound.play(SystemSoundType.click);
  }

  static void allert() {
    HapticFeedback.vibrate();
    SystemSound.play(SystemSoundType.alert);
  }

  static String allert1 = 'audio/allert1.wav';
  static String allert2 = 'audio/allert2.wav';
  static String allert3 = 'audio/allert3.wav';
  static String error = 'audio/error.wav';
  static String success = 'audio/success.wav';
  static String press = 'audio/press.wav';
}
