import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/Widget/routes.dart';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/localization/kanguage_constant.dart';
import 'package:vendor/screen/company_footer/company_footer.dart';
import 'package:vendor/screen/home_page/widget/app_maintenance.dart';
import 'package:vendor/screen/home_page/widget/box_design.dart';
import 'package:vendor/screen/home_page/widget/charts/category_chart.dart';
import 'package:vendor/screen/home_page/widget/charts/day_line_chart.dart';
import 'package:vendor/screen/home_page/widget/charts/month_data_chart.dart';
import 'package:vendor/screen/home_page/widget/charts/week_data_chart.dart';
import 'package:vendor/screen/order_list/new_order_list.dart';
import 'package:vendor/state/utility/navigation_provider.dart';
import 'package:vendor/widget/api.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/main/scaffold_main.dart';
import 'package:vendor/widget/network_availablity.dart';
import 'package:vendor/widget/shared_preferences.dart';
import 'package:vendor/widget/shimmer_effect.dart';
import 'package:vendor/widget/snackbar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vendor/helper/exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rev;

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

class _HomeState extends State<Home> {
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<OrderModel> tempList = [];

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
    providerRequiestForData();
    getSallerDetail();
    getUpdatedOrderList();
    controller = ScrollController(keepScrollOffset: true);
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
    timer = Timer.periodic(
      const Duration(seconds: 10),
      (Timer t) {
        orderListProvider.getOrderCount(context).then(
          (value) {
            if (sp.getBool('updateNewOrderCount') == true) {
              player.play(AssetSource(Allert.allert1));
              if (notificationActive == false) {
                //int count = sp.getInt('orderList') ?? 0;
                showNewOrder(
                  context,
                  sp,
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

  void showNewOrder(
    BuildContext context,
    SharedPreferences sp,
  ) async {
    await DesignConfiguration.dialogAnimate(
      context,
      StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
        int count = sp.getInt('orderList') ?? 0;
        return rev.Consumer(
          builder: (context, ref, child) {
            return Dialogs.getNewOrderDialog(
              context: context,
              title: 'You have a new order',
              content: 'There is a new order to confirm.',
              confirm: () {
                sp.setInt('orderList', count + 1);
                sp.setBool('updateNewOrderCount', false);
                ref.read(navProvider.notifier).selectPage(1);
                setState(() {
                  notificationActive = false;
                  player.stop();
                });
                Navigator.pop(context);
              },
              confirmLabel: 'Confirm',
              dismiss: () {
                Navigator.pop(context);
              },
              dismissLabel: 'Dismiss',
            );
          },
        );
      }),
      false,
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: MainScaffold(
        key: _scaffoldKey,
        title: "${Local.welcome}, $CUR_USERNAME",
        isBottom: false,
        body: WillPopScope(
          onWillPop: onWillPopScope,
          child: Consumer<HomeProvider>(
            builder: (context, value, child) {
              chartList = {
                0: dayData(value),
                1: weekData(value),
                2: monthData(value)
              };
              if (value.getCurrentStatus == HomeProviderStatus.isSuccsess) {
                return _isLoading || supportedLocale == null
                    ? const ShimmerEffect()
                    : CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    counters(value),
                                    const NewOrderList(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 10, 12, 5),
                                      child: HmBol(data: Local.report),
                                    ),
                                    getChart(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 10, 12, 5),
                                      child: HmBol(data: Local.products),
                                    ),
                                    catChart(value, context, setStateNow),
                                    const CompanyFooter()
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      );
              } else if (value.getCurrentStatus ==
                  SystemProviderPolicyStatus.isFailure) {
                return const ShimmerEffect();
              }
              return const ShimmerEffect();
            },
          ),
        ),
      ),
    );
  }

  getChart() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
      child: NeuContainer.simple(
        context: context,
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
                      child: BlNor(
                        data: Local.salesreport,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton.text(
                          data: Local.day,
                          isColored: curChart == 0 ? true : false,
                          onTap: () {
                            setState(
                              () {
                                curChart = 0;
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        AppButton.text(
                          data: Local.week,
                          isColored: curChart == 1 ? true : false,
                          onTap: () {
                            setState(
                              () {
                                curChart = 1;
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        AppButton.text(
                          data: Local.month,
                          isColored: curChart == 2 ? true : false,
                          onTap: () {
                            setState(
                              () {
                                curChart = 2;
                              },
                            );
                          },
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
                    swapAnimationCurve: Curves.linear,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
        setState(() {
          _isLoading = false;
        });
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
        Local.pressbackagaintoexit,
        context,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  counters(HomeProvider value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NeuContainer.simple(
            context: context,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HlBol(
                        data: DesignConfiguration.getPriceFormat(
                              context,
                              double.parse(value.overallSale!.toString()),
                            ) ??
                            '0.0',
                      ),
                      BlInv(
                        data: Local.totalsale,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          HsBol(
                            data: RATTING,
                          ),
                          const SizedBox(height: 10),
                          const BlInv(
                            data: "Rating",
                          )
                        ],
                      ),
                      Column(
                        children: [
                          HsBol(
                            data: value.totalproductCount ?? '0',
                          ),
                          const SizedBox(height: 10),
                          BlInv(
                            data: Local.totalproduct,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          HsBol(
                            data: value.totalorderCount ?? "0",
                          ),
                          const SizedBox(height: 10),
                          BlInv(
                            data: Local.totalorders,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              children: [
                boxesDesingHome(
                  'icon_balance',
                  Local.balance,
                  DesignConfiguration.getPriceFormat(
                      context, double.parse(CUR_BALANCE))!,
                  0,
                  context,
                ),
                boxesDesingHome(
                  'icon_report',
                  Local.report,
                  DesignConfiguration.getPriceFormat(
                      context, double.parse(value.grandFinalTotalOfSales))!,
                  1,
                  context,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              children: [
                boxesDesingHome(
                  'icon_soldout',
                  Local.soldout,
                  value.totalsoldOutCount,
                  2,
                  context,
                ),
                boxesDesingHome(
                  'icon_lowstock',
                  Local.lowinstock,
                  value.totallowStockCount,
                  3,
                  context,
                ),
              ],
            ),
          ),
        ],
      ),
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
