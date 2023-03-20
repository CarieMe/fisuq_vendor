import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/state/utility/prefs_provider.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(ref);
});

class ThemeState {
  final ThemeMode themeMode;
  ThemeState({required this.themeMode});
}

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final Ref ref;
  ThemeNotifier(this.ref) : super(ThemeMode.system) {
    loadTheme();
  }
  void loadTheme() {
    final savedMode = ref.watch(prefsProvider);
    ThemeMode themeMode = ThemeMode.system;
    int mode = savedMode.getInt(Values.theme) ?? themeMode.index;
    state = ThemeMode.values[mode];
  }

  void setThemeMode(ThemeMode mode) {
    final savedMode = ref.watch(prefsProvider);
    savedMode.setInt(Values.theme, mode.index);
    state = mode;
  }
}
