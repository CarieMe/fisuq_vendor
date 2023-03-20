import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/stock_management/widget/open_dialog.dart';
import 'package:vendor/screen/wallet_history/wallet_history.dart';
import 'package:vendor/theming/main/basic_scaffold.dart';
import 'package:vendor/widget/button_design.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/network_availablity.dart';
import 'package:vendor/widget/no_network.dart';
import 'package:vendor/widget/routes.dart';
import 'package:vendor/widget/shimmer_effect.dart';

class StockManagementList extends StatefulWidget {
  final bool fromNavbar;

  const StockManagementList({Key? key, required this.fromNavbar})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => StateProductStock();
}

StockProviderProvider? stockManagementProvider;
bool isUpdateDone = false;

final TextEditingController controllerForStock = TextEditingController();

class StateProductStock extends State<StockManagementList>
    with TickerProviderStateMixin {
  setStateNow() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controllerForStock.text = '';
    stockManagementProvider =
        Provider.of<StockProviderProvider>(context, listen: false);
    stockManagementProvider!.initializaedVariableWithDefualtValue();
    stockManagementProvider!.controller.addListener(_scrollListener);
    stockManagementProvider!.getProduct("0", context, setStateNow);
    stockManagementProvider!.buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    stockManagementProvider!.buttonSqueezeanimation = Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: stockManagementProvider!.buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  @override
  void dispose() {
    stockManagementProvider!.buttonController!.dispose();
    stockManagementProvider!.controller.removeListener(() {});
    for (int i = 0; i < stockManagementProvider!.controllers.length; i++) {
      stockManagementProvider!.controllers[i].dispose();
    }
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await stockManagementProvider!.buttonController!.forward();
    } on TickerCanceled {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BasicScaffold(
      key: stockManagementProvider!.scaffoldKey,
      title: Local.stockmanagement,
      leading: widget.fromNavbar ? false : true,
      actions: [
        Material(
          color: Colors.transparent,
          child: PopupMenuButton(
            elevation: 0,
            color: Theme.of(context).colorScheme.background,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 24,
            ),
            onSelected: (dynamic value) {
              Allert.tap();
              switch (value) {
                case 0:
                  return filterDialog();
                case 1:
                  return sortDialog();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 0,
                child: ListTile(
                  dense: true,
                  contentPadding:
                      const EdgeInsetsDirectional.only(start: 0.0, end: 0.0),
                  leading: const Icon(
                    Icons.tune,
                    color: fontColor,
                    size: 25,
                  ),
                  title: BmNor(
                    data: Local.filter,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: ListTile(
                  dense: true,
                  contentPadding:
                      const EdgeInsetsDirectional.only(start: 0.0, end: 0.0),
                  leading: const Icon(Icons.sort, color: fontColor, size: 20),
                  title: BmNor(
                    data: Local.sort,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      body: isNetworkAvail
          ? Stack(
              children: <Widget>[
                Column(
                  children: [
                    Flexible(
                      child: _showForm(),
                    ),
                  ],
                ),
                DesignConfiguration.showCircularProgress(
                  stockManagementProvider!.isProgress,
                  primary,
                ),
              ],
            )
          : noInternet(
              context,
              setStateNoInternate,
              stockManagementProvider!.buttonSqueezeanimation,
              stockManagementProvider!.buttonController,
            ),
    );
  }

  setStateNoInternate() async {
    _playAnimation();
    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        isNetworkAvail = await isNetworkAvailable();
        if (isNetworkAvail) {
          stockManagementProvider!.offset = 0;
          stockManagementProvider!.total = 0;
          stockManagementProvider!.getProduct('0', context, setStateNow);
        } else {
          await stockManagementProvider!.buttonController!.reverse();
          if (mounted) setState(() {});
        }
      },
    );
  }

  Widget listItem(int index) {
    if (index < stockManagementProvider!.productList.length) {
      Product? model = stockManagementProvider!.productList[index];
      stockManagementProvider!.totalProduct = model.total;
      String stockType = '';
      if (model.stockType == "null") {
        stockType = "Not enabled";
      } else if (model.stockType == "1" || model.stockType == "0") {
        stockType = "Global";
      } else if (model.stockType == "2") {
        stockType = "Varient wise";
      }
      if (stockManagementProvider!.controllers.length < index + 1) {
        stockManagementProvider!.controllers.add(TextEditingController());
      }
      if (model.prVarientList!.isNotEmpty) {
        stockManagementProvider!.controllers[index].text =
            model.prVarientList![model.selVarient!].cartCount!;
        double price =
            double.parse(model.prVarientList![model.selVarient!].disPrice!);
        if (price == 0) {
          price = double.parse(model.prVarientList![model.selVarient!].price!);
        }
      }
      stockManagementProvider!.items = List<String>.generate(
          model.totalAllow != "" ? int.parse(model.totalAllow!) : 10,
          (i) => (i + 1).toString());
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: NeuContainer.simple(
          context: context,
          child: InkWell(
            onTap: () {
              if (model.stockType == "2") {
              } else {
                manageStockDialog(
                  context,
                  model.name!,
                  model.stockType == "1"
                      ? model.prVarientList![0].stock ?? ''
                      : model.stock ?? '',
                  model.prVarientList![0].id!,
                ).then(
                  (value) async {
                    if (isUpdateDone) {
                      isUpdateDone = false;
                      if (mounted) {
                        setState(
                          () {
                            stockManagementProvider!.isLoading = true;
                            stockManagementProvider!.offset = 0;
                            stockManagementProvider!.total = 0;
                            stockManagementProvider!.productList.clear();
                          },
                        );
                      }
                      Future.delayed(const Duration(
                        seconds: 01,
                      )).then(
                        (_) {
                          stockManagementProvider!
                              .getProduct("0", context, setStateNow);
                        },
                      );
                    } else {
                      isUpdateDone = false;
                      setState(() {});
                    }
                  },
                );
              }
            },
            borderRadius: BorderRadius.circular(circularBorderRadius5),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 12.0,
                        start: 12.0,
                        end: 12.0,
                        bottom: 5.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: 12.0,
                            ),
                            child: Hero(
                              tag: "$index${model.id}+ $index${model.name}",
                              child: NeuContainer.product(
                                context: context,
                                child: DesignConfiguration.getCacheNotworkImage(
                                  boxFit: BoxFit.cover,
                                  context: context,
                                  heightvalue: 70.0,
                                  placeHolderSize: 70.0,
                                  imageurlString: model.image!,
                                  widthvalue: 100.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: BlBol(
                                    data: model.name!,
                                  ),
                                ),
                                model.prVarientList!.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          children: <Widget>[
                                            BmInv(
                                              data: "${Local.pricelabel} : ",
                                            ),
                                            model.prVarientList!.isNotEmpty
                                                ? BlBol(
                                                    data: double.parse(model
                                                                .prVarientList![
                                                                    model
                                                                        .selVarient!]
                                                                .disPrice!) !=
                                                            0
                                                        ? DesignConfiguration
                                                            .getPriceFormat(
                                                            context,
                                                            double.parse(model
                                                                .prVarientList![
                                                                    model
                                                                        .selVarient!]
                                                                .disPrice!),
                                                          )!
                                                        : "",
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    BmInv(
                                      data: '${Local.quantity} : ',
                                    ),
                                    BlBol(
                                      data: model.stockType == "2"
                                          ? model.totalStock == null ||
                                                  model.totalStock! == ""
                                              ? "0"
                                              : model.totalStock!
                                          : model.stockType == "1"
                                              ? model.prVarientList![0].stock ==
                                                          null ||
                                                      model.prVarientList![0]
                                                              .stock ==
                                                          ""
                                                  ? "0"
                                                  : model
                                                      .prVarientList![0].stock!
                                              : model.stock == null ||
                                                      model.stock! == ""
                                                  ? "0"
                                                  : model.stock!,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    model.stockType == "2"
                        ? SizedBox(
                            height: 80,
                            child: ListView.builder(
                              itemCount: model.prVarientList!.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                final value = model.prVarientList![index];
                                return InkWell(
                                  onTap: () {
                                    print(value.varient_value!);
                                    Bottoms.mediumDialog(
                                      context: context,
                                      child: EditDialogContent(
                                        title: value.varient_value!,
                                        stockValue: value.stock ?? '',
                                        variantId: value.id!,
                                      ),
                                      onClosed: () {
                                        _refresh();
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                    child: NeuContainer.colorOutline(
                                      context: context,
                                      color: (value.stock != '' ||
                                              value.stock != '0')
                                          ? Theme.of(context)
                                              .colorScheme
                                              .outlineVariant
                                          : AppColors.red,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            value.stock != ''
                                                ? HsBol(
                                                    data: '(${value.stock})',
                                                  )
                                                : const HsErr(
                                                    data: '!',
                                                  ),
                                            BsInv(data: value.varient_value!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          )
                        : SizedBox(
                            width: width,
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              children: model.prVarientList!.map(
                                (value) {
                                  return InkWell(
                                    onTap: () {
                                      manageStockDialog(
                                        context,
                                        value.varient_value!,
                                        value.stock ?? '',
                                        value.id!,
                                      ).then(
                                        (value) async {
                                          if (isUpdateDone) {
                                            isUpdateDone = false;
                                            if (mounted) {
                                              setState(
                                                () {
                                                  stockManagementProvider!
                                                      .isLoading = true;
                                                  stockManagementProvider!
                                                      .offset = 0;
                                                  stockManagementProvider!
                                                      .total = 0;
                                                  stockManagementProvider!
                                                      .productList
                                                      .clear();
                                                },
                                              );
                                            }
                                            Future.delayed(const Duration(
                                              seconds: 01,
                                            )).then(
                                              (_) {
                                                stockManagementProvider!
                                                    .getProduct("0", context,
                                                        setStateNow);
                                              },
                                            );
                                          } else {
                                            isUpdateDone = false;
                                            setState(() {});
                                          }
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                        left: 8.0,
                                        top: 0.0,
                                        bottom: 8.0,
                                      ),
                                      child: NeuContainer.colorOutline(
                                        context: context,
                                        color: (value.stock != '' ||
                                                value.stock != '0')
                                            ? Theme.of(context)
                                                .colorScheme
                                                .outlineVariant
                                            : AppColors.red,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RichText(
                                            text: TextSpan(
                                              text: '${value.varient_value!}  ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: value.stock != ''
                                                      ? '(${value.stock})'
                                                      : '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  getAppbar() {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: white,
      iconTheme: const IconThemeData(color: primary),
      title: Text(
        Local.products,
        style: const TextStyle(
          color: grad2Color,
        ),
      ),
      elevation: 5,
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: DesignConfiguration.shadow(),
            child: InkWell(
              borderRadius: BorderRadius.circular(circularBorderRadius5),
              onTap: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsetsDirectional.only(end: 4.0),
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: primary,
                  size: 30,
                ),
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(circularBorderRadius5),
            onTap: () {
              Routes.navigateToSearch(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.search,
                color: primary,
                size: 25,
              ),
            ),
          ),
        ),
        Container(
          width: 40,
          margin: const EdgeInsetsDirectional.only(top: 10, bottom: 10, end: 5),
          child: Material(
            color: Colors.transparent,
            child: PopupMenuButton(
              padding: EdgeInsets.zero,
              onSelected: (dynamic value) {
                switch (value) {
                  case 0:
                    return filterDialog();
                  case 1:
                    return sortDialog();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    dense: true,
                    contentPadding:
                        const EdgeInsetsDirectional.only(start: 0.0, end: 0.0),
                    leading: const Icon(
                      Icons.tune,
                      color: fontColor,
                      size: 25,
                    ),
                    title: Text(
                      Local.filter,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    dense: true,
                    contentPadding:
                        const EdgeInsetsDirectional.only(start: 0.0, end: 0.0),
                    leading: const Icon(Icons.sort, color: fontColor, size: 20),
                    title: Text(
                      Local.sort,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void sortDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ButtonBarTheme(
          data: const ButtonBarThemeData(
            alignment: MainAxisAlignment.center,
          ),
          child: AlertDialog(
            elevation: 2.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  circularBorderRadius5,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.all(0.0),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 19.0, bottom: 16.0),
                    child: Text(
                      Local.sortby,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const Divider(color: lightBlack),
                  TextButton(
                    child: Text(
                      Local.toprated,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: lightBlack,
                          ),
                    ),
                    onPressed: () {
                      stockManagementProvider!.sortBy = '';
                      stockManagementProvider!.orderBy = 'DESC';
                      if (mounted) {
                        setState(
                          () {
                            stockManagementProvider!.isLoading = true;
                            stockManagementProvider!.total = 0;
                            stockManagementProvider!.offset = 0;
                            stockManagementProvider!.productList.clear();
                          },
                        );
                      }
                      stockManagementProvider!
                          .getProduct("1", context, setStateNow);
                      Navigator.pop(context, 'option 1');
                    },
                  ),
                  const Divider(color: lightBlack),
                  TextButton(
                      child: Text(
                        Local.newestfirst,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: lightBlack,
                            ),
                      ),
                      onPressed: () {
                        stockManagementProvider!.sortBy = 'p.date_added';
                        stockManagementProvider!.orderBy = 'DESC';
                        if (mounted) {
                          setState(() {
                            stockManagementProvider!.isLoading = true;
                            stockManagementProvider!.total = 0;
                            stockManagementProvider!.offset = 0;
                            stockManagementProvider!.productList.clear();
                          });
                        }
                        stockManagementProvider!
                            .getProduct("0", context, setStateNow);
                        Navigator.pop(context, 'option 1');
                      }),
                  const Divider(color: lightBlack),
                  TextButton(
                      child: Text(
                        Local.oldestfirst,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: lightBlack),
                      ),
                      onPressed: () {
                        stockManagementProvider!.sortBy = 'p.date_added';
                        stockManagementProvider!.orderBy = 'ASC';
                        if (mounted) {
                          setState(() {
                            stockManagementProvider!.isLoading = true;
                            stockManagementProvider!.total = 0;
                            stockManagementProvider!.offset = 0;
                            stockManagementProvider!.productList.clear();
                          });
                        }
                        stockManagementProvider!
                            .getProduct("0", context, setStateNow);
                        Navigator.pop(context, 'option 2');
                      }),
                  const Divider(color: lightBlack),
                  TextButton(
                      child: Text(
                        Local.lowtohigh,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: lightBlack),
                      ),
                      onPressed: () {
                        stockManagementProvider!.sortBy = 'pv.price';
                        stockManagementProvider!.orderBy = 'ASC';
                        if (mounted) {
                          setState(() {
                            stockManagementProvider!.isLoading = true;
                            stockManagementProvider!.total = 0;
                            stockManagementProvider!.offset = 0;
                            stockManagementProvider!.productList.clear();
                          });
                        }
                        stockManagementProvider!
                            .getProduct("0", context, setStateNow);
                        Navigator.pop(context, 'option 3');
                      }),
                  const Divider(color: lightBlack),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 5.0),
                    child: TextButton(
                      child: Text(
                        Local.lowtohigh,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: lightBlack),
                      ),
                      onPressed: () {
                        stockManagementProvider!.sortBy = 'pv.price';
                        stockManagementProvider!.orderBy = 'DESC';
                        if (mounted) {
                          setState(
                            () {
                              stockManagementProvider!.isLoading = true;
                              stockManagementProvider!.total = 0;
                              stockManagementProvider!.offset = 0;
                              stockManagementProvider!.productList.clear();
                            },
                          );
                        }
                        stockManagementProvider!
                            .getProduct("0", context, setStateNow);
                        Navigator.pop(context, 'option 4');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _scrollListener() {
    if (stockManagementProvider!.controller.offset >=
            stockManagementProvider!.controller.position.maxScrollExtent &&
        !stockManagementProvider!.controller.position.outOfRange) {
      if (mounted) {
        if (mounted) {
          setState(
            () {
              isLoadingmore = true;
              if (stockManagementProvider!.offset <
                  stockManagementProvider!.total)
                stockManagementProvider!.getProduct("0", context, setStateNow);
            },
          );
        }
      }
    }
  }

  Future<void> _refresh() {
    if (mounted) {
      setState(
        () {
          stockManagementProvider!.isLoading = true;
          isLoadingmore = true;
          stockManagementProvider!.offset = 0;
          stockManagementProvider!.total = 0;
          stockManagementProvider!.productList.clear();
        },
      );
    }
    return stockManagementProvider!.getProduct("0", context, setStateNow);
  }

  _showForm() {
    return stockManagementProvider!.isLoading
        ? const ShimmerEffect()
        : stockManagementProvider!.productList.isEmpty
            ? DesignConfiguration.getNoItem(context)
            : RefreshIndicator(
                key: stockManagementProvider!.refreshIndicatorKey,
                onRefresh: _refresh,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeLeft: true,
                  removeRight: true,
                  removeBottom: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: stockManagementProvider!.controller,
                    itemCount: (stockManagementProvider!.offset <
                            stockManagementProvider!.total)
                        ? stockManagementProvider!.productList.length + 1
                        : stockManagementProvider!.productList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return (index ==
                                  stockManagementProvider!.productList.length &&
                              isLoadingmore)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : listItem(index);
                    },
                  ),
                ),
              );
  }

  productDeletDialog(
    String productName,
    String id,
    BuildContext cntx,
  ) async {
    String pName = productName;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(circularBorderRadius5),
                ),
              ),
              content: Text(
                "${Local.sure} \"  $pName \" ${Local.product}",
                style: Theme.of(this.context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: fontColor),
              ),
              actions: <Widget>[
                TextButton(
                    child: Text(
                      Local.logoutno,
                      style: Theme.of(this.context)
                          .textTheme
                          .subtitle2!
                          .copyWith(
                              color: lightBlack, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }),
                TextButton(
                  child: Text(
                    Local.logoutyes,
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: fontColor, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Routes.pop(context);
                    stockManagementProvider!.deleteProductApi(
                      id,
                      cntx,
                      setStateNow,
                    );

                    setState(
                      () {
                        stockManagementProvider!.isLoading = true;
                        isLoadingmore = true;
                        stockManagementProvider!.offset = 0;
                        stockManagementProvider!.total = 0;
                        stockManagementProvider!.productList.clear();
                        stockManagementProvider!
                            .getProduct("0", context, setStateNow);
                      },
                    );
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  void filterDialog() {
    if (stockManagementProvider!.filterList!.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius10),
        ),
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 30.0),
                    child: AppBar(
                      backgroundColor: lightWhite,
                      title: Text(
                        Local.filter,
                        style: const TextStyle(
                          color: fontColor,
                        ),
                      ),
                      elevation: 5,
                      leading: Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            decoration: DesignConfiguration.shadow(),
                            child: Card(
                              elevation: 0,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                    circularBorderRadius5),
                                onTap: () => Navigator.of(context).pop(),
                                child: const Padding(
                                  padding: EdgeInsetsDirectional.only(end: 4.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      actions: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 10.0),
                          alignment: Alignment.center,
                          child: InkWell(
                            child: Text(
                              Local.cleafilters,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: fontColor,
                                  ),
                            ),
                            onTap: () {
                              if (mounted) {
                                setState(
                                  () {
                                    stockManagementProvider!.selectedId.clear();
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: lightWhite,
                      padding: const EdgeInsetsDirectional.only(
                        start: 7.0,
                        end: 7.0,
                        top: 7.0,
                      ),
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: lightWhite,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  padding: const EdgeInsetsDirectional.only(
                                      top: 10.0),
                                  itemCount: stockManagementProvider!
                                      .filterList!.length,
                                  itemBuilder: (context, index) {
                                    stockManagementProvider!.attsubList =
                                        stockManagementProvider!
                                            .filterList![index]
                                                ['attribute_values']
                                            .split(',');

                                    stockManagementProvider!.attListId =
                                        stockManagementProvider!
                                            .filterList![index]
                                                ['attribute_values_id']
                                            .split(',');

                                    if (stockManagementProvider!.filter == "") {
                                      stockManagementProvider!.filter =
                                          stockManagementProvider!
                                              .filterList![0]["name"];
                                    }

                                    return InkWell(
                                      onTap: () {
                                        if (mounted) {
                                          setState(
                                            () {
                                              stockManagementProvider!.filter =
                                                  stockManagementProvider!
                                                          .filterList![index]
                                                      ['name'];
                                            },
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20,
                                                top: 10.0,
                                                bottom: 10.0),
                                        decoration: BoxDecoration(
                                          color: stockManagementProvider!
                                                      .filter ==
                                                  stockManagementProvider!
                                                          .filterList![index]
                                                      ['name']
                                              ? white
                                              : lightWhite,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(
                                                circularBorderRadius7),
                                            bottomLeft: Radius.circular(
                                              7,
                                            ),
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          stockManagementProvider!
                                              .filterList![index]['name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                color: stockManagementProvider!
                                                            .filter ==
                                                        stockManagementProvider!
                                                                .filterList![
                                                            index]['name']
                                                    ? fontColor
                                                    : lightBlack,
                                                fontWeight: FontWeight.normal,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsetsDirectional.only(top: 10.0),
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    stockManagementProvider!.filterList!.length,
                                itemBuilder: (context, index) {
                                  if (stockManagementProvider!.filter ==
                                      stockManagementProvider!
                                          .filterList![index]["name"]) {
                                    stockManagementProvider!.attsubList =
                                        stockManagementProvider!
                                            .filterList![index]
                                                ['attribute_values']
                                            .split(',');

                                    stockManagementProvider!.attListId =
                                        stockManagementProvider!
                                            .filterList![index]
                                                ['attribute_values_id']
                                            .split(',');
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: stockManagementProvider!
                                          .attListId!.length,
                                      itemBuilder: (context, i) {
                                        return CheckboxListTile(
                                          dense: true,
                                          title: Text(
                                              stockManagementProvider!
                                                  .attsubList![i],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: lightBlack,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                          value: stockManagementProvider!
                                              .selectedId
                                              .contains(stockManagementProvider!
                                                  .attListId![i]),
                                          activeColor: primary,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          onChanged: (bool? val) {
                                            if (mounted) {
                                              setState(
                                                () {
                                                  if (val == true) {
                                                    stockManagementProvider!
                                                        .selectedId
                                                        .add(
                                                            stockManagementProvider!
                                                                .attListId![i]);
                                                  } else {
                                                    stockManagementProvider!
                                                        .selectedId
                                                        .remove(
                                                            stockManagementProvider!
                                                                .attListId![i]);
                                                  }
                                                },
                                              );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(stockManagementProvider!.total.toString()),
                              Text(Local.productsfound),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SimBtn(
                          size: 0.4,
                          title: Local.apply,
                          onBtnSelected: () {
                            stockManagementProvider!.selId =
                                stockManagementProvider!.selectedId.join(',');
                            if (mounted) {
                              setState(
                                () {
                                  stockManagementProvider!.isLoading = true;
                                  stockManagementProvider!.total = 0;
                                  stockManagementProvider!.offset = 0;
                                  stockManagementProvider!.productList.clear();
                                },
                              );
                            }
                            stockManagementProvider!
                                .getProduct("0", context, setStateNow);
                            Navigator.pop(context, 'Product Filter');
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
      );
    }
  }
}
