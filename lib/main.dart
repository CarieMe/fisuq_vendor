import 'dart:io';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fisuq_vendor/Provider/theme.dart';
import 'package:fisuq_vendor/theming/theme.dart';
import 'package:fisuq_vendor/tools/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:fisuq_vendor/Provider/faqProvider.dart';
import 'package:fisuq_vendor/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helper/Constant.dart';
import 'Helper/PushNotificationService.dart';
import 'Localization/Demo_Localization.dart';
import 'Localization/Language_Constant.dart';
import 'Provider/ProductListProvider.dart';
import 'Provider/ProfileProvider.dart';
import 'Provider/addProductProvider.dart';
import 'Provider/attributeSetProvider.dart';
import 'Provider/categoryProvider.dart';
import 'Provider/countryProvider.dart';
import 'Provider/editProductProvider.dart';
import 'Provider/home_provider.dart';
import 'Provider/loginProvider.dart';
import 'Provider/mediaProvider.dart';
import 'Provider/orderListProvider.dart';
import 'Provider/privacyProvider.dart';
import 'Provider/reviewListProvider.dart';
import 'Provider/salesReportProvider.dart';
import 'Provider/searchProvider.dart';
import 'Provider/settingProvider.dart';
import 'Provider/stockmanagementProvider.dart';
import 'Provider/taxProvider.dart';
import 'Provider/walletProvider.dart';
import 'Provider/zipcodeProvider.dart';
import 'Screen/SplashScreen/splash_screen.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  if (Firebase.apps.isNotEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (BuildContext context) {
        String? theme = prefs.getString(appTheme);
        if (theme == dark) {
          isDarkTheme = 'true';
        } else if (theme == light) {
          isDarkTheme = 'false';
        }
        if (theme == null || theme == '' || theme == systemDefault) {
          prefs.setString(appTheme, systemDefault);
          var brightness = SchedulerBinding.instance.window.platformBrightness;
          isDarkTheme = (brightness == Brightness.dark).toString();
          return ThemeNotifier(ThemeMode.system);
        }
        return ThemeNotifier(theme == light ? ThemeMode.light : ThemeMode.dark);
      },
      child: FisuqVendor(sharedPreferences: prefs),
    ),
  );
}

class FisuqVendor extends StatefulWidget {
  late SharedPreferences? sharedPreferences;
  FisuqVendor({
    super.key,
    this.sharedPreferences,
  });
  static void setLocale(BuildContext context, Locale newLocale) {
    _FisuqVendorState state =
        context.findAncestorStateOfType<_FisuqVendorState>()!;
    state.setLocale(newLocale);
  }

  @override
  State<FisuqVendor> createState() => _FisuqVendorState();
}

class _FisuqVendorState extends State<FisuqVendor> {
  Locale? _locale;

  setLocale(Locale locale) {
    if (mounted) {
      setState(
        () {
          _locale = locale;
        },
      );
    }
  }

  @override
  void didChangeDependencies() {
    getLocale().then(
      (locale) {
        if (mounted) {
          setState(
            () {
              _locale = locale;
            },
          );
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider()),
        ChangeNotifierProvider<AddProductProvider>(
            create: (context) => AddProductProvider()),
        ChangeNotifierProvider<CountryProvider>(
            create: (context) => CountryProvider()),
        ChangeNotifierProvider<TaxProvider>(create: (context) => TaxProvider()),
        ChangeNotifierProvider<SettingProvider>(
            create: (context) => SettingProvider()),
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<ZipcodeProvider>(
            create: (context) => ZipcodeProvider()),
        ChangeNotifierProvider<CategoryProvider>(
            create: (context) => CategoryProvider()),
        ChangeNotifierProvider<AttributeProvider>(
            create: (context) => AttributeProvider()),
        ChangeNotifierProvider<MediaProvider>(
            create: (context) => MediaProvider()),
        ChangeNotifierProvider<SystemProvider>(
            create: (context) => SystemProvider()),
        ChangeNotifierProvider<ProductListProvider>(
            create: (context) => ProductListProvider()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (context) => ProfileProvider()),
        ChangeNotifierProvider<ReviewListProvider>(
            create: (context) => ReviewListProvider()),
        ChangeNotifierProvider<SalesReportProvider>(
            create: (context) => SalesReportProvider()),
        ChangeNotifierProvider<SearchProvider>(
            create: (context) => SearchProvider()),
        ChangeNotifierProvider<OrderListProvider>(
            create: (context) => OrderListProvider()),
        ChangeNotifierProvider<FaQProvider>(create: (context) => FaQProvider()),
        ChangeNotifierProvider<EditProductProvider>(
            create: (context) => EditProductProvider()),
        ChangeNotifierProvider<WalletTransactionProvider>(
            create: (context) => WalletTransactionProvider()),
        ChangeNotifierProvider<StockProviderProvider>(
            create: (context) => StockProviderProvider()),
      ],
      child: MaterialApp(
        title: title,
        locale: _locale,
        localizationsDelegates: const [
          CountryLocalizations.delegate,
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'DZ'),
          Locale('hi', 'IN'),
          Locale('zh', 'CN'),
          Locale('ru', 'RU'),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: themeNotifier.getThemeMode() == ThemeMode.dark
            ? darkTheme
            : lightTheme,
        darkTheme: darkTheme,
        themeMode: themeNotifier.getThemeMode(),
      ),
    );
  }
}
