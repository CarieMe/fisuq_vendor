import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/wallet_history/widget/list_item.dart';
import 'package:vendor/widget/api.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/main/scaffold_main.dart';
import 'package:vendor/widget/main/single_bottom_sheet.dart';
import 'package:vendor/widget/network_availablity.dart';
import 'package:vendor/widget/routes.dart';
import 'package:vendor/widget/shared_preferences.dart';
import 'package:vendor/widget/shimmer_effect.dart';
import 'package:vendor/widget/snackbar.dart';
import 'package:vendor/widget/validation.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({Key? key}) : super(key: key);

  @override
  _WalletHistoryState createState() => _WalletHistoryState();
}

bool isLoadingmore = true;
int offset = 0;
int total = 0;

class _WalletHistoryState extends State<WalletHistory>
    with TickerProviderStateMixin {
  TextEditingController amountController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? amount, msg;
  ScrollController controller = ScrollController();
  TextEditingController? amtC, bankDetailC;
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  List<GetWithdrawelReq> tempList = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) =>
        context.read<WalletTransactionProvider>().getUserTransaction(context));
    super.initState();
    getSallerBalance();
    controller.addListener(_scrollListener);
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
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
    amtC = TextEditingController();
    bankDetailC = TextEditingController();
  }

  _scrollListener() async {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (mounted) {
        if (context.read<WalletTransactionProvider>().hasMoreData) {
          setState(
            () {
              isLoadingmore = true;
            },
          );
          await context
              .read<WalletTransactionProvider>()
              .getUserTransaction(context)
              .then(
            (value) {
              setState(
                () {
                  isLoadingmore = false;
                },
              );
            },
          );
        }
      }
    }
  }

  getSallerBalance() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      context.read<SettingProvider>().CUR_USERID = await getPrefrence(Id);

      var parameter = {Id: context.read<SettingProvider>().CUR_USERID};
      apiBaseHelper.postAPICall(getSellerDetailsApi, parameter).then(
        (getdata) async {
          bool error = getdata["error"];

          if (!error) {
            var data = getdata["data"][0];
            CUR_BALANCE = double.parse(data[BALANCE]).toStringAsFixed(2);
          }
          setState(() {});
        },
        onError: (error) {
          setSnackbar(
            error.toString(),
            context,
          );
          setState(() {});
        },
      );
    } else {
      if (mounted) {
        setState(
          () {
            isNetworkAvail = false;
          },
        );
      }
    }
    return null;
  }

  getBalanceShower() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: NeuContainer.simple(
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextLL(
                DesignConfiguration.getPriceFormat(
                    context, double.parse(CUR_BALANCE))!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextTL(
                    " ${Local.currentbalance}",
                  ),
                ],
              ),
              AppIcons.basic(
                icon: 'wallet',
                size: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    Completer<void> completer = Completer<void>();
    await Future.delayed(const Duration(seconds: 3)).then(
      (onvalue) {
        completer.complete();
        offset = 0;
        total = 0;
        setState(
          () {},
        );
        Future.delayed(Duration.zero).then((value) => context
            .read<WalletTransactionProvider>()
            .getUserTransaction(context));
        getSallerBalance();
      },
    );
    return completer.future;
  }

  // send withdrawel request

  Future<void> sendRequest() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      var parameter = {
        UserId: context.read<SettingProvider>().CUR_USERID,
        Amount: amtC!.text.toString(),
        PaymentAddress: bankDetailC!.text.toString()
      };

      apiBaseHelper.postAPICall(sendWithDrawalRequestApi, parameter).then(
        (getdata) {
          bool error = getdata["error"];
          String? msg = getdata["message"];

          if (!error) {
            setSnackbar(
              msg!,
              context,
            );
            setState(
              () {},
            );
            Future.delayed(Duration.zero).then((value) => context
                .read<WalletTransactionProvider>()
                .getUserTransaction(context));
            _refresh();
          } else {
            setSnackbar(
              msg!,
              context,
            );
          }
        },
      );
    } else {
      if (mounted) {
        setState(
          () {
            isNetworkAvail = false;
          },
        );
      }
    }

    return;
  }

  _showDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(circularBorderRadius5),
                ),
              ),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                      child: Text(
                        Local.sendrequest,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: primary),
                      ),
                    ),
                    const Divider(color: lightBlack),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (val) =>
                                  StringValidation.validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: Local.withdrwalamt,
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: lightBlack,
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: amtC,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              validator: (val) =>
                                  StringValidation.validateField(val, context),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: BANK_DETAIL,
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: lightBlack,
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: bankDetailC,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    Local.cancel,
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: lightBlack, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Routes.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    Local.sendlbl,
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () {
                    final form = _formkey.currentState!;
                    if (form.validate()) {
                      form.save();
                      sendRequest();
                      Routes.pop(context);
                      offset = 0;
                      total = 0;
                      Future.delayed(Duration.zero).then(
                        (value) => context
                            .read<WalletTransactionProvider>()
                            .getUserTransaction(context),
                      );
                    }
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Wallet History",
      isBottom: true,
      bottomSheet: SingleBottom(
          label1: Local.withdrawmoney,
          function1: () {
            _showDialog();
          }),
      body: Consumer<WalletTransactionProvider>(
        builder: (context, value, child) {
          if (value.getCurrentStatus == WalletStatus.isSuccsess) {
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: Column(
                children: [
                  getBalanceShower(),
                  value.userTransactions.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text(Local.nodatafound),
                          ),
                        )
                      : MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: Flexible(
                            child: ListView.builder(
                              controller: controller,
                              shrinkWrap: true,
                              itemCount: (offset < total)
                                  ? value.userTransactions.length + 1
                                  : value.userTransactions.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return (index ==
                                            value.userTransactions.length &&
                                        isLoadingmore)
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : ListIteamsWidget(
                                        index: index,
                                        tranList: value.userTransactions,
                                      );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            );
          } else if (value.getCurrentStatus == WalletStatus.isFailure) {
            return const ShimmerEffect();
          }
          return const ShimmerEffect();
        },
      ),
    );
  }

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  setStateNoInternate() async {
    _playAnimation();
    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        isNetworkAvail = await isNetworkAvailable();
        if (isNetworkAvail) {
          Future.delayed(Duration.zero).then((value) => context
              .read<WalletTransactionProvider>()
              .getUserTransaction(context));
        } else {
          await buttonController!.reverse();
          setState(
            () {},
          );
        }
      },
    );
  }
}
