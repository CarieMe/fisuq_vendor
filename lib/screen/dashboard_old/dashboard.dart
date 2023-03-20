import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/screen/dashboard_old/profileagain.dart';
import 'package:vendor/screen/home_page/home.dart';
import 'package:vendor/screen/order_list/order_list.dart';
import 'package:vendor/screen/product_list/product_list.dart';
import 'package:vendor/theming/base/app_color.dart';
import 'package:vendor/tools/allert_service.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/main/dialogs.dart';
import 'package:vendor/widget/validation.dart';

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
    pages = [
      const Home(),
      const OrderList(),
      const ProductList(
        flag: "",
        fromNavbar: true,
      ),
      const ProfileAgain(),
    ];
    getUpdatedOrderList();
    super.initState();
  }

  Timer? timer;
  final AudioPlayer player = AudioPlayer();
  final alarmAudioPath = "audio/allert1.wav";
  bool notificationActive = false;

  getUpdatedOrderList() async {
    final orderListProvider =
        Provider.of<OrderListProvider>(context, listen: false);
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await player.setSource(AssetSource(Allert.success));
    await player.setVolume(1.0);
    print(sp.getInt('orderList'));
    timer = Timer.periodic(
      const Duration(seconds: 10),
      (Timer t) {
        orderListProvider.getOrderCount(context).then(
          (value) {
            if (sp.getBool('updateNewOrderCount') == true) {
              player.play(AssetSource(Allert.allert1));
              if (notificationActive == false) {
                showNewOrder(
                  context,
                  sp,
                  orderListProvider.orderList.length,
                );
                setState(() {
                  notificationActive = true;
                });
              }
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void showNewOrder(
    BuildContext context,
    SharedPreferences sp,
    int orderList,
  ) async {
    await DesignConfiguration.dialogAnimate(
      context,
      StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
        int count = sp.getInt('orderList') ?? 0;
        return Dialogs.getDialog(
          context: context,
          title: 'You have a new order',
          content: 'Theres a new order',
          confirm: () {
            sp.setInt('orderList', count + 1);
            sp.setBool('updateNewOrderCount', false);
            setState(() {
              pageIndex = 1;
              notificationActive = false;
              player.stop();
            });
            Navigator.pop(context);
          },
          confirmLabel: 'Confirm',
          dismiss: () {},
          dismissLabel: 'dimiss',
        );
      }),
      false,
    );
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
          backgroundColor: AppColors.empty,
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
              tabItem(
                context: context,
                label: 'Profile',
                icon: 'profile',
                activeDark: 'dark_active_profile',
                activeLight: 'light_active_profile',
                data: data,
                light: light,
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIndex,
            selectedItemColor: AppColors.primary,
            unselectedItemColor:
                Theme.of(context).indicatorColor.withOpacity(.7),
            onTap: (int index) {
              Allert.tap();
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
