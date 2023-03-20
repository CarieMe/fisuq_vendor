import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/localization/kanguage_constant.dart';
import 'package:vendor/main.dart';
import 'package:vendor/provider/privacy_provider.dart';
import 'package:vendor/provider/setting_provider.dart';
import 'package:vendor/provider/wallet_provider.dart';
import 'package:vendor/screen/app_product/add_product.dart';
import 'package:vendor/screen/authentication/login.dart';
import 'package:vendor/screen/company_footer/company_footer.dart';
import 'package:vendor/screen/home_page/home.dart';
import 'package:vendor/screen/home_page/widget/logout.dart';
import 'package:vendor/screen/order_list/order_list.dart';
import 'package:vendor/screen/product_list/product_list.dart';
import 'package:vendor/screen/profile/profile.dart';
import 'package:vendor/screen/stock_management/stock_management_list.dart';
import 'package:vendor/screen/term_feed/policys.dart';
import 'package:vendor/screen/wallet_history/wallet_history.dart';
import 'package:vendor/widget/api.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/dialog_animate.dart';
import 'package:vendor/widget/network_availablity.dart';
import 'package:vendor/widget/parameter_string.dart';
import 'package:vendor/widget/shared_preferences.dart';
import 'package:vendor/widget/snackbar.dart';

class DrawerWidget extends StatefulWidget {
  final Function? setstaterofile;
  const DrawerWidget({super.key, this.setstaterofile});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int currentIndex = 0;
  String? verifyPassword;
  String? errorTrueMessage;
  List<String?> languageList = [];
  final passwordController = TextEditingController();
  FocusNode? passFocus = FocusNode();
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        languageList = [
          Local.english,
          Local.hindi,
          Local.chinese,
          Local.arabic,
          Local.russian
        ];
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  spacer() {
    return Container(
      height: 1.5,
      color: Theme.of(context).colorScheme.background,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      children: <Widget>[
        _getHeader(),
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 6),
          child: BlInv(data: 'PRODUCTS'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
          child: NeuContainer.simple(
            context: context,
            child: Column(
              children: [
                settingsItem(Local.orders, AssetSvg.proMyorder, true),
                spacer(),
                settingsItem(Local.wallethistory, AssetSvg.wallet, false),
                spacer(),
                settingsItem(Local.product, AssetSvg.wallet, false),
                spacer(),
                settingsItem(Local.stockmanagement, AssetSvg.wallet, false),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 6),
          child: BlInv(data: 'POLICIES'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
          child: NeuContainer.simple(
            context: context,
            child: Column(
              children: [
                settingsItem(Local.changelanguage, AssetSvg.proLanguage, true),
                spacer(),
                settingsItem(Local.termsandconditions, AssetSvg.proTc, false),
                spacer(),
                settingsItem(Local.privacypolicy, AssetSvg.proPp, false),
                spacer(),
                settingsItem(Local.contactus, AssetSvg.proAontactUs, false),
                settingsItem(Local.shippingpolicy, AssetSvg.wallet, false),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 6),
          child: BlInv(data: 'SECURITY'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
          child: NeuContainer.simple(
            context: context,
            child: Column(
              children: [
                settingsItem(Local.deleteaccount, AssetSvg.deleteUser, true),
                spacer(),
                settingsItem(Local.logout, AssetSvg.proLogout, false),
              ],
            ),
          ),
        ),
        const CompanyFooter()
        //_getDrawerItem(Local.orders, Icons.shopping_basket_outlined),
        //const Divider(),
        // _getDrawerItem(
        //     Local.wallethistory, Icons.account_balance_wallet_outlined),
        // _getDrawerItem(
        //     Local.products, Icons.production_quantity_limits_outlined),
        // _getDrawerItem(Local.stockmanagement, Icons.add_box_outlined),
        // const Divider(),
        // _getDrawerItem(Local.addproduct, Icons.add),
        // _getDrawerItem(Local.changelanguage, Icons.translate),
        // const Divider(),
        // _getDrawerItem(Local.termsandconditions, Icons.speaker_notes_outlined),
        // _getDrawerItem(Local.privacypolicy, Icons.lock_outline),
        // const Divider(),
        // _getDrawerItem(Local.contactus, Icons.contact_page),
        // _getDrawerItem(Local.returnpolicy, Icons.assignment_returned_outlined),
        // _getDrawerItem(Local.shippingpolicy, Icons.local_shipping_outlined),
        // const Divider(),
        // _getDrawerItem(Local.deleteaccount, Icons.delete),
        // _getDrawerItem(Local.logout, Icons.logout),
      ],
    );
  }

  _getHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: LOGO != ""
                  ? AppImages.cachedImage(
                      imageurlString: LOGO,
                      context: context,
                      boxFit: BoxFit.contain,
                      heightvalue: 100,
                      widthvalue: 100,
                      placeHolderSize: 100,
                    )
                  : AppImages.placeholder(size: 100),
            ),
            const SizedBox(height: 10),
            HsBol(
              data: CUR_USERNAME!,
            ),
            BlInv(
              data: Local.walletbalance +
                  DesignConfiguration.getPriceFormat(
                    context,
                    double.parse(CUR_BALANCE),
                  )!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton.text(
                  data: Local.editprofilelabel,
                  isColored: false,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const Profile(),
                      ),
                    ).then(
                      (value) {
                        widget.setstaterofile;
                      },
                    );
                    setState(
                      () {},
                    );
                  },
                ),
                const SizedBox(width: 10),
                AppIconDirection.chevron(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  settingsItem(String title, String icon, bool top) {
    return AppButton.settings(
      top: top,
      title: title,
      img: AssetSvg.proMyorder,
      onTap: () {
        if (title == Local.orders) {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => const OrderList(),
          //   ),
          // );
        } else if (title == Local.wallethistory) {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) =>
          //         ChangeNotifierProvider<WalletTransactionProvider>(
          //       create: (context) => WalletTransactionProvider(),
          //       child: const WalletHistory(),
          //     ),
          //   ),
          // );
        } else if (title == Local.products) {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => const ProductList(
          //       flag: '',
          //       fromNavbar: false,
          //     ),
          //   ),
          // );
        } else if (title == Local.changelanguage) {
          languageDialog();
        } else if (title == Local.termsandconditions) {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => ChangeNotifierProvider<SystemProvider>(
          //       create: (context) => SystemProvider(),
          //       child: Policy(
          //         title: Local.termconditions,
          //       ),
          //     ),
          //   ),
          // );
        } else if (title == Local.deleteaccount) {
          currentIndex = 0;
          deleteAccountDailog();
        } else if (title == Local.contactus) {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => ChangeNotifierProvider<SystemProvider>(
          //       create: (context) => SystemProvider(),
          //       child: Policy(
          //         title: Local.contactus,
          //       ),
          //     ),
          //   ),
          // );
        } else if (title == Local.privacypolicy) {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => ChangeNotifierProvider<SystemProvider>(
          //       create: (context) => SystemProvider(),
          //       child: Policy(
          //         title: Local.privacypolicy,
          //       ),
          //     ),
          //   ),
          // );
        } else if (title == Local.privacypolicy) {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => ChangeNotifierProvider<SystemProvider>(
          //       create: (context) => SystemProvider(),
          //       child: Policy(
          //         title: Local.returnpolicy,
          //       ),
          //     ),
          //   ),
          // );
        } else if (title == Local.shippingpolicy) {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => ChangeNotifierProvider<SystemProvider>(
          //       create: (context) => SystemProvider(),
          //       child: Policy(
          //         title: Local.shippingpolicy,
          //       ),
          //     ),
          //   ),
          // );
        } else if (title == Local.logout) {
          logOutDailog(context);
        } else if (title == Local.addproduct) {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => const AddProduct(),
          //   ),
          // );
        } else if (title == Local.stockmanagement) {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => StockManagementList(
          //       fromNavbar: false,
          //     ),
          //   ),
          // );
        }
      },
    );
  }

  _getDrawerItem(String title, IconData icn) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(circularBorderRadius50),
          bottomRight: Radius.circular(circularBorderRadius50),
        ),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icn,
          color: grad1Color,
        ),
        title: Text(
          title,
          style: const TextStyle(color: black, fontSize: textFontSize15),
        ),
        onTap: () {
          if (title == Local.orders) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => OrderList(),
              ),
            );
          } else if (title == Local.wallethistory) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<WalletTransactionProvider>(
                  create: (context) => WalletTransactionProvider(),
                  child: const WalletHistory(),
                ),
              ),
            );
          } else if (title == Local.products) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ProductList(
                  flag: '',
                  fromNavbar: false,
                ),
              ),
            );
          } else if (title == Local.changelanguage) {
            languageDialog();
          } else if (title == Local.termsandconditions) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: Local.termconditions,
                  ),
                ),
              ),
            );
          } else if (title == Local.deleteaccount) {
            currentIndex = 0;
            deleteAccountDailog();
          } else if (title == Local.contactus) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: Local.contactus,
                  ),
                ),
              ),
            );
          } else if (title == Local.privacypolicy) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: Local.privacypolicy,
                  ),
                ),
              ),
            );
          } else if (title == Local.privacypolicy) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: Local.returnpolicy,
                  ),
                ),
              ),
            );
          } else if (title == Local.shippingpolicy) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: Local.shippingpolicy,
                  ),
                ),
              ),
            );
          } else if (title == Local.logout) {
            logOutDailog(context);
          } else if (title == Local.addproduct) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AddProduct(),
              ),
            );
          } else if (title == Local.stockmanagement) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => StockManagementList(
                  fromNavbar: false,
                ),
              ),
            );
          }
        },
      ),
    );
  }

//==============================================================================
//============================= Language Implimentation ========================

  languageDialog() async {
    await dialogAnimate(
      context,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          return AlertDialog(
            elevation: 0,
            contentPadding: const EdgeInsets.all(0.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(circularBorderRadius5),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                  child: Text(
                    Local.chooselanguagelable,
                    style: Theme.of(this.context).textTheme.subtitle1!.copyWith(
                          color: primary,
                        ),
                  ),
                ),
                const Divider(color: lightBlack),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: getLngList(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

//==============================================================================
//======================== Language List Generate ==============================
  //enum Local { english, arabic, hindi, russian, chinese }

  Map<String, Locale> languageMap = {
    'English': const Locale('en', 'US'),
    'العربية': const Locale('ar', 'AE'),
    'हिंदी': const Locale('hi', 'IN'),
    'Русский': const Locale('ru', 'RU'),
    '中文': const Locale('zh', 'CN'),
  };
  Map<String, String> languageNames = {
    'en': 'English',
    'ar': 'العربية',
    'hi': 'हिंदी',
    'ru': 'Русский',
    'zh': '中文',
  };

  List<Locale> locals = [
    const Locale('en', 'US'),
    const Locale('ar', 'AE'),
    const Locale('hi', 'IN'),
    const Locale('ru', 'RU'),
    const Locale('zh', 'CN'),
  ];

  List<Widget> getLngList(BuildContext context) {
    return locals.asMap().entries.map((entry) {
      int index = entry.key;
      return InkWell(
        onTap: () async {
          Allert.tap();
          selectLan = index;
          Locale selectedLocale = locals[index];
          var locale = EasyLocalization.of(context)!.locale;
          if (locale != selectedLocale) {
            await EasyLocalization.of(context)!.setLocale(selectedLocale);
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 25.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectLan == index ? grad2Color : white,
                      border: Border.all(color: grad2Color),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: selectLan == index
                          ? const Icon(
                              Icons.check,
                              size: 17.0,
                              color: white,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank,
                              size: 15.0,
                              color: white,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 15.0,
                    ),
                    child: Text(
                      languageNames[locals[index].languageCode]!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: lightBlack),
                    ),
                  )
                ],
              ),
              index == locals.length - 1
                  ? Container(
                      margin: const EdgeInsetsDirectional.only(
                        bottom: 10,
                      ),
                    )
                  : const Divider(
                      color: lightBlack,
                    ),
            ],
          ),
        ),
      );
    }).toList();
  }

//=================================== delete user dialog =======================
//==============================================================================

  deleteAccountDailog() async {
    await dialogAnimate(
      context,
      StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(circularBorderRadius5),
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //==================
                // when currentIndex == 0
                //==================
                currentIndex == 0
                    ? Text(
                        Local.deleteaccount,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Container(),
                currentIndex == 0
                    ? const SizedBox(
                        height: 10,
                      )
                    : Container(),
                currentIndex == 0
                    ? Text(
                        Local.allrequestongoing,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle2!
                            .copyWith(),
                      )
                    : Container(),
                //==================
                // when currentIndex == 1
                //==================
                currentIndex == 1
                    ? Text(
                        Local.pleaseverifypassword,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                              color: black,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Container(),
                currentIndex == 1
                    ? const SizedBox(
                        height: 25,
                      )
                    : Container(),
                currentIndex == 1
                    ? Container(
                        height: 53,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: lightWhite1,
                          borderRadius:
                              BorderRadius.circular(circularBorderRadius10),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: textFontSize13),
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(passFocus);
                          },
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: passwordController,
                          focusNode: passFocus,
                          textInputAction: TextInputAction.next,
                          onChanged: (String? value) {
                            verifyPassword = value;
                          },
                          onSaved: (String? value) {
                            verifyPassword = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 5,
                            ),
                            suffixIconConstraints: const BoxConstraints(
                                minWidth: 40, maxHeight: 20),
                            hintText: Local.passwordhint,
                            hintStyle: const TextStyle(
                                color: grey,
                                fontWeight: FontWeight.bold,
                                fontSize: textFontSize13),
                            fillColor: lightWhite,
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    : Container(),
                //==================
                // when currentIndex == 2
                //==================

                currentIndex == 2
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
                //==================
                // when currentIndex == 2
                //==================
                currentIndex == 3
                    ? Center(
                        child: Text(
                          errorTrueMessage ??
                              Local.somethingerrorpleasetryagain,
                        ),
                      )
                    : Container(),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  currentIndex == 0
                      ? TextButton(
                          child: Text(
                            Local.logoutno,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                  color: lightBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        )
                      : Container(),
                  currentIndex == 0
                      ? TextButton(
                          child: Text(
                            Local.logoutyes,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                currentIndex = 1;
                              },
                            );
                          },
                        )
                      : Container(),
                ],
              ),
              currentIndex == 1
                  ? TextButton(
                      child: Text(
                        Local.deletenow,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: () async {
                        setState(
                          () {
                            currentIndex = 2;
                          },
                        );
                        var mobile = await getPrefrence(Mobile);
                        await checkNetwork(mobile ?? "").then(
                          (value) {
                            setState(
                              () {
                                currentIndex = 3;
                              },
                            );
                          },
                        );
                      },
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Future<void> checkNetwork(
    String mobile,
  ) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      deleteAccountAPI(mobile);
    } else {
      Future.delayed(const Duration(seconds: 2)).then(
        (_) async {
          if (mounted) {
            setState(
              () {
                isNetworkAvail = false;
              },
            );
          }
        },
      );
    }
  }

  Future<void> deleteAccountAPI(String mobile) async {
    var data = {
      UserId: context.read<SettingProvider>().CUR_USERID,
      "mobile": mobile,
      "password": verifyPassword
    };

    ApiBaseHelper().postAPICall(deleteSellerApi, data).then(
      (getdata) async {
        bool error = getdata['error'];
        String? msg = getdata['message'];
        if (!error) {
          currentIndex = 0;
          verifyPassword = "";
          setSnackbar(msg!, context);
          clearUserSession(context);
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (context) => const Login(),
              ),
              (Route<dynamic> route) => false);
        } else {
          errorTrueMessage = msg;
          currentIndex = 4;
          setState(() {});
          verifyPassword = "";
          setSnackbar(msg!, context);
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
