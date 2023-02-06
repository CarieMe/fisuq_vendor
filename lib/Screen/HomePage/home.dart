import 'dart:async';
import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fisuq_vendor/Helper/ApiBaseHelper.dart';
import 'package:fisuq_vendor/Helper/Color.dart';
import 'package:fisuq_vendor/Widget/desing.dart';
import 'package:fisuq_vendor/Widget/parameterString.dart';
import 'package:fisuq_vendor/Localization/Language_Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/OrdersModel/OrderModel.dart';
import '../../Provider/home_provider.dart';
import '../../Provider/privacyProvider.dart';
import '../../Provider/settingProvider.dart';
import '../../Widget/api.dart';
import '../../Widget/networkAvailablity.dart';
import '../../Widget/noNetwork.dart';
import '../../Widget/routes.dart';
import '../../Widget/sharedPreferances.dart';
import '../../Widget/simmerEffect.dart';
import '../../Widget/snackbar.dart';
import '../../Widget/systemChromeSettings.dart';
import '../../Widget/validation.dart';
import 'Widget/Charts/categoryChart.dart';
import 'Widget/Charts/dayLineChart.dart';
import 'Widget/Charts/monthDataChart.dart';
import 'Widget/Charts/weekDataChart.dart';
import 'Widget/appMaintanceDialog.dart';
import 'Widget/boxesDesingHome.dart';
import 'Widget/randomColorWidget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

ApiBaseHelper apiBaseHelper = ApiBaseHelper();
bool _isLoading = true;
bool isLoadingmore = true;
String? delPermission;
bool customerViewPermission = false;
Map<int, LineChartData>? chartList;
List colorList = [];
int? selectLan;
int? touchedIndex;
List<String> langCode = [
  ENGLISH,
  HINDI,
  CHINESE,
  SPANISH,
  ARABIC,
  RUSSIAN,
  JAPANESE,
  DEUTSCH
];

class _HomeState extends State<Home>
    with AutomaticKeepAliveClientMixin<Home>, TickerProviderStateMixin {
//==============================================================================
//============================= Variables Declaration ==========================
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<OrderModel> tempList = [];
  @override
  bool get wantKeepAlive => true;
  setStateProfile() {
    providerRequiestForData();
    getSallerDetail();
    providerRequiestForData();
    setState(() {});
    Routes.pop(context);
  }

  String? all,
      received,
      processed,
      shipped,
      delivered,
      cancelled,
      returned,
      awaiting;
  String? mobile;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  ScrollController? controller;

  String? activeStatus;
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<String> statusList = [
    ALL,
    PLACED,
    PROCESSED,
    SHIPED,
    DELIVERD,
    CANCLED,
    RETURNED,
    awaitingPayment
  ];

//===================================== For Chart ==============================
  int curChart = 0;

//============================= initState Method ===============================
  @override
  void initState() {
    callApi();
    context.read<HomeProvider>().getSalesReportRequest(context);
    SystemChromeSettings.setSystemButtomNavigationBarithTopAndButtom();
    SystemChromeSettings.setSystemUIOverlayStyleWithLightBrightNessStyle();
    //final pushNotificationService = PushNotificationService(context: context);
    //pushNotificationService.initialise();
    providerRequiestForData();
    getSallerDetail();
    buttonController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    buttonSqueezeanimation = Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
    controller = ScrollController(keepScrollOffset: true);

    super.initState();
  }

//==============================================================================
//============================= For Animation ==================================

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

//==============================================================================
//============================= Build Method ===================================

  @override
  Widget build(BuildContext context) {
    super.build(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: getBodyPart(),
      ),
    );
  }

//==============================================================================
//=============================== chart coding  ================================

  getChart() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: NeuContainer(
        child: SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: TextBL(
                        getTranslated(context, "ProductSales")!,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: curChart == 0
                              ? TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: primary,
                                  disabledForegroundColor: Colors.grey,
                                )
                              : null,
                          onPressed: () {
                            setState(
                              () {
                                curChart = 0;
                              },
                            );
                          },
                          child: TextBM(
                            getTranslated(context, "Day")!,
                          ),
                        ),
                        TextButton(
                          style: curChart == 1
                              ? TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: primary,
                                  disabledForegroundColor: Colors.grey,
                                )
                              : null,
                          onPressed: () {
                            setState(
                              () {
                                curChart = 1;
                              },
                            );
                          },
                          child: TextBM(
                            getTranslated(context, "Week")!,
                          ),
                        ),
                        TextButton(
                          style: curChart == 2
                              ? TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: primary,
                                  disabledForegroundColor: Colors.grey,
                                )
                              : null,
                          onPressed: () {
                            setState(
                              () {
                                curChart = 2;
                              },
                            );
                          },
                          child: TextBM(
                            getTranslated(context, "Month")!,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: LineChart(
                    chartList![curChart]!,
                    swapAnimationDuration: const Duration(milliseconds: 250),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//==============================================================================
//========================= get_seller_details API =============================

  Future<void> getSallerDetail() async {
    var parameter = {Id: context.read<SettingProvider>().CUR_USERID};
    context.read<SettingProvider>().CUR_USERID = await getPrefrence(Id);

    ApiBaseHelper().postAPICall(getSellerDetailsApi, parameter).then(
      (getdata) async {
        bool error = getdata["error"];
        if (!error) {
          var data = getdata["data"][0];
          CUR_BALANCE = double.parse(data[BALANCE]).toStringAsFixed(2);
          LOGO = data["logo"].toString();
          RATTING = data[Rating] ?? "";
          NO_OFF_RATTING = data[NoOfRatings] ?? "";
          var id = data[Id];
          var username = data[Username];
          mobile = data[Mobile];
          context.read<SettingProvider>().CUR_USERID = id!;
          CUR_USERNAME = username!;
          saveUserDetail(
            id!,
            username!,
            mobile!,
          );
        }
        setState(
          () {
            _isLoading = false;
          },
        );
      },
      onError: (error) {
        setSnackbar(
          error.toString(),
          context,
        );
      },
    );
  }

  setStateNow() {
    setState(() {});
  }

  Future<bool> onWillPopScope() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      setSnackbar(
        getTranslated(context, 'Press back again to Exit')!,
        context,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

//==============================================================================
//=========================== Body Part Implimentation =========================

  getBodyPart() {
    return WillPopScope(
        onWillPop: onWillPopScope,
        child: isNetworkAvail
            ? Consumer<HomeProvider>(
                builder: (context, value, child) {
                  chartList = {
                    0: dayData(value),
                    1: weekData(value),
                    2: monthData(value)
                  };
                  if (value.getCurrentStatus == HomeProviderStatus.isSuccsess) {
                    return _isLoading || supportedLocale == null
                        ? const ShimmerEffect()
                        : RefreshIndicator(
                            key: _refreshIndicatorKey,
                            onRefresh: _refresh,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  buildHeader(context, value),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 0),
                                    child: Row(
                                      children: [
                                        boxesDesingHome(
                                          'icon_balance',
                                          getTranslated(
                                              context, 'BALANCE_LBL')!,
                                          DesignConfiguration.getPriceFormat(
                                              context,
                                              double.parse(CUR_BALANCE))!,
                                          0,
                                          context,
                                        ),
                                        boxesDesingHome(
                                          'icon_report',
                                          getTranslated(context, 'Report')!,
                                          DesignConfiguration.getPriceFormat(
                                              context,
                                              double.parse(value
                                                  .grandFinalTotalOfSales))!,
                                          1,
                                          context,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 0),
                                    child: Row(
                                      children: [
                                        boxesDesingHome(
                                          'icon_soldout',
                                          getTranslated(
                                              context, "Sold Out Products")!,
                                          value.totalsoldOutCount,
                                          2,
                                          context,
                                        ),
                                        boxesDesingHome(
                                          'icon_lowstock',
                                          getTranslated(
                                              context, 'Low Stock Products')!,
                                          value.totallowStockCount,
                                          3,
                                          context,
                                        ),
                                      ],
                                    ),
                                  ),
                                  getChart(),
                                  catChart(value, context, setStateNow),
                                ],
                              ),
                            ),
                          );
                  } else if (value.getCurrentStatus ==
                      SystemProviderPolicyStatus.isFailure) {
                    return const ShimmerEffect();
                  }
                  return const ShimmerEffect();
                },
              )
            : noInternet(context, setStateNoInternate, buttonSqueezeanimation,
                buttonController));
  }

  Widget buildHeader(BuildContext context, HomeProvider value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 65, 10, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLL(
            "${getTranslated(context, 'Welcome')}, $CUR_USERNAME",
          ),
          const SizedBox(height: 20),
          NeuContainer(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextLL(
                        DesignConfiguration.getPriceFormat(
                              context,
                              double.parse(value.totalSalesAmount),
                            ) ??
                            '0.0',
                      ),
                      TextC(
                        getTranslated(context, "Total Sale")!,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      gethomePageTextDesing(RATTING, "Rating"),
                      gethomePageTextDesing(value.totalproductCount ?? '0',
                          getTranslated(context, "Total Product")!),
                      gethomePageTextDesing(value.totalorderCount ?? "0",
                          getTranslated(context, "Total orders")!),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  setStateNoInternate() async {
    _playAnimation();
    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        isNetworkAvail = await isNetworkAvailable();
        if (isNetworkAvail) {
          providerRequiestForData();
          getSallerDetail();
        } else {
          await buttonController!.reverse();
          setState(
            () {},
          );
        }
      },
    );
  }

//==============================================================================
//============================ Refresh Implimentation ==========================

  Future<void> _refresh() async {
    Completer<void> completer = Completer<void>();
    await Future.delayed(const Duration(seconds: 3)).then(
      (onvalue) {
        completer.complete();
        providerRequiestForData();
        getSallerDetail();
        setState(
          () {
            _isLoading = true;
          },
        );
      },
    );
    return completer.future;
  }

  @override
  void dispose() {
    buttonController!.dispose();
    super.dispose();
  }

  Future<void> callApi() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      await getSetting();
    } else {
      if (mounted) {
        setState(() {
          isNetworkAvail = false;
        });
      }
    }
    return;
  }

  Future<void> providerRequiestForData() async {
    await context.read<HomeProvider>().allocateAllData(context);
    String getlng = await getPrefrence(LAGUAGE_CODE) ?? '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectLan = langCode.indexOf(getlng == '' ? "en" : getlng);
  }

  Future<void> getSetting() async {
    Map parameter = {};
    ApiBaseHelper().postAPICall(getSettingsApi, parameter).then(
      (getdata) async {
        bool error = getdata['error'];
        String? msg = getdata['message'];

        if (!error) {
          var data = getdata['data']['system_settings'][0];
          supportedLocale = data["supported_locals"];
          Is_APP_IN_MAINTANCE = data['is_seller_app_under_maintenance'];
          MAINTENANCE_MESSAGE = data['message_for_seller_app'];
          Decimal_Digits = data['decimal_point']; // Painding
          setState(
            () {},
          );
          if (Is_APP_IN_MAINTANCE == "1") {
            appMaintenanceDialog(context);
          }
        } else {
          setSnackbar(
            msg!,
            context,
          );
        }
      },
      onError: (error) {
        setSnackbar(
          error.toString(),
          context,
        );
      },
    );
  }
}
//==============================================================================
//==============================================================================
