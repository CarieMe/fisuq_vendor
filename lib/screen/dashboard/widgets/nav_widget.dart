import 'package:flutter/material.dart';
import 'package:vendor/helper/theming.dart';

class NavWidget {
  static BottomNavigationBarItem tabItem({
    required BuildContext context,
    required String label,
    required String icon,
    required String activeDark,
    required String activeLight,
    required ThemeMode data,
    required Brightness light,
  }) {
    return BottomNavigationBarItem(
      icon: AppIcons.colored(
        icon: icon,
        size: 20,
        color: Theme.of(context).disabledColor,
      ),
      activeIcon: AppLottie.basic(
        lottie: (data == ThemeMode.system && light == Brightness.dark) ||
                data == ThemeMode.dark
            ? activeDark
            : activeLight,
        repeat: false,
        size: 25,
      ),
      label: label,
    );
  }
}
