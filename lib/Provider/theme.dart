import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/tools/constants.dart';
import 'package:vendor/widget/validation.dart';

class ThemeProvider extends ChangeNotifier {
  int activeThemeIndex = 0;
  bool isDark = false;

  getCurrentTheme(BuildContext context, List<String?> themeList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? get = prefs.getString(appTheme);
    activeThemeIndex = themeList.indexOf(
      get == '' || get == systemDefault
          ? getTranslated(context, 'SYSTEM_DEFAULT')
          : get == light
              ? getTranslated(context, 'LIGHT_THEME')
              : getTranslated(context, 'DARK_THEME'),
    );

    notifyListeners();
  }

  void changeTheme(int index, String value, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: false);
    if (value == getTranslated(context, 'SYSTEM_DEFAULT')) {
      themeNotifier.setThemeMode(ThemeMode.system);
      prefs.setString(appTheme, systemDefault);
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      isDark = brightness == Brightness.dark;
      if (isDark) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    } else if (value == getTranslated(context, 'LIGHT_THEME')) {
      themeNotifier.setThemeMode(ThemeMode.light);
      prefs.setString(systemDefault, light);
      isDark = false;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    } else if (value == getTranslated(context, 'DARK_THEME')) {
      themeNotifier.setThemeMode(ThemeMode.dark);
      prefs.setString(systemDefault, dark);

      isDark = true;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
    isDarkTheme = isDark.toString();
    activeThemeIndex = index;
    notifyListeners();
  }
}

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeNotifier(this._themeMode);

  getThemeMode() => _themeMode;

  setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
  }
}
