import 'package:fisuq_vendor/Provider/theme.dart';
import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:fisuq_vendor/tools/system_chrome_settings.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:fisuq_vendor/Screen/DeshBord/profileagain.dart';
import 'package:fisuq_vendor/Widget/validation.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Widget/desing.dart';
import '../HomePage/home.dart';
import '../OrderList/OrderList.dart';
import '../ProductList/product_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Widget> pages;
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    pages = [
      const Home(),
      const OrderList(),
      ProductList(
        flag: "",
        fromNavbar: true,
      ),
      // const ProfileAgain(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //SystemChromeSettings.showTopBottom();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: getBottomNav(context),
      body: pages[pageIndex],
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: AppColor.empty,
          elevation: 0,
        ),
      ),
    );
  }

  getBottomNav(BuildContext contextd) {
    final light = MediaQuery.of(context).platformBrightness;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Selector<ThemeNotifier, ThemeMode>(
        selector: (_, themeProvider) => themeProvider.getThemeMode(),
        builder: (context, data, child) {
          return BottomNavigationBar(
            backgroundColor: Theme.of(context).backgroundColor,
            //unselectedItemColor: primary,
            items: <BottomNavigationBarItem>[
              tabItem(
                context: context,
                label: 'Home',
                icon: 'home',
                activeDark: 'dark_active_home',
                activeLight: 'light_active_home',
                data: data,
                light: light,
              ),
              tabItem(
                context: context,
                label: 'Orders',
                icon: 'cart',
                activeDark: 'dark_active_cart',
                activeLight: 'light_active_cart',
                data: data,
                light: light,
              ),
              tabItem(
                context: context,
                label: 'PRODUCTS',
                icon: 'brand',
                activeDark: 'dark_active_explorer',
                activeLight: 'light_active_explorer',
                data: data,
                light: light,
              ),
              // tabItem(
              //   context: context,
              //   label: 'Profile',
              //   icon: 'profile',
              //   activeDark: 'dark_active_profile',
              //   activeLight: 'light_active_profile',
              //   data: data,
              //   light: light,
              // ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIndex,
            selectedItemColor: AppColor.primary,
            unselectedItemColor:
                Theme.of(context).indicatorColor.withOpacity(.7),
            onTap: (int index) {
              if (mounted) {
                setState(
                  () {
                    pageIndex = index;
                  },
                );
              }
            },
          );
        },
      ),
    );
  }

  BottomNavigationBarItem tabItem({
    required BuildContext context,
    required String label,
    required String icon,
    required String activeDark,
    required String activeLight,
    required ThemeMode data,
    required Brightness light,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        DesignConfiguration.setSvgPath(
          icon,
        ),
        height: 20,
        color: Theme.of(context).indicatorColor.withOpacity(.7),
      ),
      activeIcon: Lottie.asset(
        DesignConfiguration.setLottiePath(
          (data == ThemeMode.system && light == Brightness.dark) ||
                  data == ThemeMode.dark
              ? activeDark
              : activeLight,
        ),
        repeat: false,
        height: 25,
      ),
      label: getTranslated(context, label)!,
    );
  }
}
