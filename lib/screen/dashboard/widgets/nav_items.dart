import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor/generated/locale_keys.g.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/dashboard/widgets/nav_widget.dart';
import 'package:vendor/state/utility/navigation_provider.dart';
import 'package:vendor/state/utility/theme_notifier.dart';

class NavItems extends ConsumerWidget {
  const NavItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = ref.watch(navProvider);
    final light = MediaQuery.of(context).platformBrightness;
    final themeMode = ref.watch(themeProvider);
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const NetworkAvailability(),
          BottomNavigationBar(
            currentIndex: navigation.index,
            backgroundColor: Theme.of(context).colorScheme.background,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.secondary,
            selectedIconTheme: const IconThemeData(color: AppColors.primary),
            unselectedIconTheme:
                IconThemeData(color: Theme.of(context).disabledColor),
            onTap: (index) {
              Allert.tap();
              ref.read(navProvider.notifier).selectPage(index);
            },
            items: [
              NavWidget.tabItem(
                context: context,
                label: LocaleKeys.home.tr(),
                icon: AssetSvg.home,
                activeDark: AssetLottie.darkActiveHome,
                activeLight: AssetLottie.lightActiveHome,
                data: themeMode,
                light: light,
              ),
              NavWidget.tabItem(
                context: context,
                label: LocaleKeys.orders.tr(),
                icon: AssetSvg.cart,
                activeDark: AssetLottie.darkActiveCart,
                activeLight: AssetLottie.lightActiveCart,
                data: themeMode,
                light: light,
              ),
              NavWidget.tabItem(
                context: context,
                label: LocaleKeys.products.tr(),
                icon: AssetSvg.category,
                activeDark: AssetLottie.darkActiveCategory,
                activeLight: AssetLottie.lightActiveCategory,
                data: themeMode,
                light: light,
              ),
              NavWidget.tabItem(
                context: context,
                label: LocaleKeys.active.tr(),
                icon: AssetSvg.brand,
                activeDark: AssetLottie.darkActiveExplorer,
                activeLight: AssetLottie.lightActiveExplorer,
                data: themeMode,
                light: light,
              ),
              NavWidget.tabItem(
                context: context,
                label: LocaleKeys.profile.tr(),
                icon: AssetSvg.profile,
                activeDark: AssetLottie.darkActiveProfile,
                activeLight: AssetLottie.lightActiveProfile,
                data: themeMode,
                light: light,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
