import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendor/provider/setting_provider.dart';
import 'package:vendor/screen/authentication/login.dart';
import 'package:vendor/screen/dashboard/dashboard.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/main/scale_route.dart';
import 'package:vendor/widget/parameter_string.dart';
import 'package:vendor/widget/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: DesignConfiguration.back(),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).backgroundColor.withOpacity(0.9),
            child: Center(
              child: SvgPicture.asset(
                DesignConfiguration.setSvgPath('logo3'),
                height: 120,
                width: 220,
              ),
            ),
          ),
          Image.asset(
            DesignConfiguration.setPngPath('doodle'),
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    bool isFirstTime = await getPrefrenceBool(isLogin);
    if (isFirstTime) {
      Navigator.pushReplacement(
        context,
        ScaleRoute(
          page: Dashboard(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        ScaleRoute(
          page: Login(),
        ),
      );
    }
  }
}
