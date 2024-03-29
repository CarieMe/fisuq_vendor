import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/order_list/widget/common_design_field.dart';
import 'package:vendor/screen/order_list/widget/order_item.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/main/picker.dart';
import 'package:vendor/widget/styled/button_icon.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

OrderListProvider? orderListProvider;
int currentSelected = 0;

class _OrderListState extends State<OrderList> with TickerProviderStateMixin {
  setStateNow() {
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
  bool serachIsEnable = false;

  @override
  void initState() {
    currentSelected = 0;
    orderListProvider = Provider.of<OrderListProvider>(context, listen: false);
    orderListProvider!.initializeAllVariable();
    orderListProvider!.currentSelectedOrderType = '';
    orderListProvider!.scrollOffset = 0;
    Future.delayed(
      Duration.zero,
      () {
        orderListProvider!.appBarTitle = HmBol(
          data: Local.orders,
        );
        orderListProvider!.getOrder(setStateNow, context);
      },
    );

    orderListProvider!.buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    orderListProvider!.scrollController =
        ScrollController(keepScrollOffset: true);
    orderListProvider!.scrollController!
        .addListener(_transactionscrollListener);

    orderListProvider!.buttonSqueezeanimation = Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: orderListProvider!.buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );

    orderListProvider!.controller.addListener(
      () {
        if (orderListProvider!.controller.text.isEmpty) {
          if (mounted) {
            setState(
              () {
                orderListProvider!.searchText = "";
              },
            );
          }
        } else {
          if (mounted) {
            setState(
              () {
                orderListProvider!.searchText =
                    orderListProvider!.controller.text;
              },
            );
          }
        }

        if (orderListProvider!.lastsearch != orderListProvider!.searchText &&
            (orderListProvider!.searchText == '' ||
                (orderListProvider!.searchText.isNotEmpty))) {
          orderListProvider!.lastsearch = orderListProvider!.searchText;
          orderListProvider!.scrollLoadmore = true;
          orderListProvider!.scrollOffset = 0;
          orderListProvider!.getOrder(setStateNow, context);
        }
      },
    );

    super.initState();
  }

  _transactionscrollListener() {
    if (orderListProvider!.scrollController!.offset >=
            orderListProvider!.scrollController!.position.maxScrollExtent &&
        !orderListProvider!.scrollController!.position.outOfRange) {
      if (mounted) {
        setState(
          () {
            orderListProvider!.scrollLoadmore = true;
            orderListProvider!.getOrder(setStateNow, context);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _showContent(),
    );
  }

  void _handleSearchStart() {
    if (!mounted) return;
    setState(
      () {},
    );
  }

  Future<void> _refresh() {
    if (mounted) {
      orderListProvider!.initializeAllVariable();
      orderListProvider!.scrollOffset = 0;
      Future.delayed(
        Duration.zero,
        () {
          orderListProvider!.appBarTitle = HmBol(
            data: Local.orders,
          );
        },
      );
      setState(
        () {},
      );
    }
    return orderListProvider!.getOrder(setStateNow, context);
  }

  void _handleSearchEnd() {
    if (!mounted) return;
    setState(
      () {
        serachIsEnable = false;
        orderListProvider!.controller.clear();
      },
    );
  }

  _showContent() {
    return NotificationListener<ScrollNotification>(
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              buildAppbar(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 20, left: 5, right: 0),
                child: SizedBox(
                  width: width,
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CommanDesingWidget(
                        title: Local.order,
                        icon: Icons.shopping_cart,
                        index: 0,
                        onTapAction: null,
                        update: setStateNow,
                      ),
                      CommanDesingWidget(
                        title: Local.receivedlbl,
                        icon: Icons.archive,
                        index: 1,
                        onTapAction: orderListProvider!.statusList[1],
                        update: setStateNow,
                      ),
                      CommanDesingWidget(
                        title: Local.processedlbl,
                        icon: Icons.work,
                        index: 2,
                        onTapAction: orderListProvider!.statusList[2],
                        update: setStateNow,
                      ),
                      CommanDesingWidget(
                        title: Local.shipedlbl,
                        icon: Icons.airport_shuttle,
                        index: 3,
                        onTapAction: orderListProvider!.statusList[3],
                        update: setStateNow,
                      ),
                      CommanDesingWidget(
                        title: Local.deliveredlabel,
                        icon: Icons.assignment_turned_in,
                        index: 4,
                        onTapAction: orderListProvider!.statusList[4],
                        update: setStateNow,
                      ),
                      CommanDesingWidget(
                        title: Local.cancelledlabel,
                        icon: Icons.delete,
                        index: 5,
                        onTapAction: orderListProvider!.statusList[5],
                        update: setStateNow,
                      ),
                      CommanDesingWidget(
                        title: Local.returnedlbl,
                        icon: Icons.upload,
                        index: 6,
                        onTapAction: orderListProvider!.statusList[6],
                        update: setStateNow,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 0),
              _filterRow(),
              const SizedBox(height: 20),
              orderListProvider!.scrollNodata
                  ? SizedBox(
                      height: height * 0.5,
                      child: DesignConfiguration.getNoItem(context))
                  : Flexible(
                      child: RefreshIndicator(
                        key: orderListProvider!.refreshIndicatorKey,
                        onRefresh: _refresh,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: orderListProvider!.scrollController,
                            padding: const EdgeInsetsDirectional.only(
                                start: 10, end: 10),
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: orderListProvider!.orderList.length,
                            itemBuilder: (context, index) {
                              OrderModel? item;
                              try {
                                item = orderListProvider!.orderList.isEmpty
                                    ? null
                                    : orderListProvider!.orderList[index];
                                if (orderListProvider!.scrollLoadmore &&
                                    index ==
                                        (orderListProvider!.orderList.length -
                                            1) &&
                                    orderListProvider!.scrollController!
                                            .position.pixels <=
                                        0) {
                                  orderListProvider!
                                      .getOrder(setStateNow, context);
                                }
                              } on Exception catch (_) {}
                              return item == null
                                  ? Container()
                                  : MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: OrderIteam(
                                        index: index,
                                        update: setStateNow,
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          orderListProvider!.scrollGettingData
              ? Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                    color: Theme.of(context).indicatorColor,
                    radius: 20,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildAppbar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 56, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: serachIsEnable
                ? TextFild(
                    controller: orderListProvider!.controller,
                    hintText: Local.search,
                    autofocus: true,
                  )
                : HmBol(
                    data: Local.orders,
                  ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 0,
            child: ButtonIcon(
              onPressed: () {
                if (!mounted) return;
                setState(
                  () {
                    if (serachIsEnable == false) {
                      serachIsEnable = true;
                      _handleSearchStart();
                    } else {
                      _handleSearchEnd();
                    }
                  },
                );
              },
              data: Icon(
                serachIsEnable
                    ? CupertinoIcons.multiply_circle_fill
                    : CupertinoIcons.search,
                size: 24,
              ),
            ),
          ),
          // PopupMenuButton(
          //   color: Theme.of(context).canvasColor,
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(10),
          //     ),
          //   ),
          //   icon: const Icon(
          //     Icons.more_vert,
          //     color: AppColors.primary,
          //     size: 24,
          //   ),
          //   onSelected: (dynamic value) {
          //     switch (value) {
          //       case 0:
          //         return () {
          //           orderListProvider!.currentSelectedOrderType = '';
          //           _refresh();
          //         }();
          //       case 1:
          //         return () {
          //           orderListProvider!.currentSelectedOrderType = 'simple';
          //           _refresh();
          //         }();
          //       case 2:
          //         return () {
          //           orderListProvider!.currentSelectedOrderType = 'digital';
          //           _refresh();
          //         }();
          //     }
          //   },
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          //     const PopupMenuItem(
          //       value: 0,
          //       child: ListTile(
          //         dense: true,
          //         contentPadding:
          //             EdgeInsetsDirectional.only(start: 0.0, end: 0.0),
          //         leading: Icon(
          //           Icons.format_align_justify,
          //           color: primary,
          //           size: 25,
          //         ),
          //         title: TextBS("All"),
          //       ),
          //     ),
          //     const PopupMenuItem(
          //       value: 1,
          //       child: ListTile(
          //         dense: true,
          //         contentPadding:
          //             EdgeInsetsDirectional.only(start: 0.0, end: 0.0),
          //         leading: Icon(
          //           Icons.redeem,
          //           color: primary,
          //           size: 25,
          //         ),
          //         title: TextBS("Simple"),
          //       ),
          //     ),
          //     const PopupMenuItem(
          //       value: 2,
          //       child: ListTile(
          //         dense: true,
          //         contentPadding:
          //             EdgeInsetsDirectional.only(start: 0.0, end: 0.0),
          //         leading: Icon(
          //           Icons.memory,
          //           color: primary,
          //           size: 20,
          //         ),
          //         title: TextBS("Digital"),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Future<void> _playAnimation() async {
    try {
      await orderListProvider!.buttonController!.forward();
    } on TickerCanceled {
      debugPrint('cancelled');
    }
  }

  _filterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: AppButton.outline(
                small: true,
                color: true,
                data: Local.startdate,
                onTap: () {
                  Picker.pickDate(
                      context: context,
                      initialDateTime: orderListProvider!.startDate,
                      onDateTimeChanged: (DateTime newdate) {
                        setState(
                          () {
                            orderListProvider!.startDate = newdate;
                            orderListProvider!.start = DateFormat('dd-MM-yyyy')
                                .format(orderListProvider!.startDate);
                            if (orderListProvider!.start != null &&
                                orderListProvider!.end != null) {
                              orderListProvider!.scrollLoadmore = true;
                              orderListProvider!.scrollOffset = 0;
                              orderListProvider!.getOrder(setStateNow, context);
                            }
                          },
                        );
                      });
                }),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: AppButton.outline(
                small: true,
                color: true,
                data: Local.enddate,
                onTap: () {
                  Picker.pickDate(
                    context: context,
                    initialDateTime: orderListProvider!.startDate,
                    onDateTimeChanged: (DateTime newdate) {
                      setState(
                        () {
                          orderListProvider!.endDate = newdate;
                          orderListProvider!.end = DateFormat('dd-MM-yyyy')
                              .format(orderListProvider!.endDate);
                          if (orderListProvider!.start != null &&
                              orderListProvider!.end != null) {
                            orderListProvider!.scrollLoadmore = true;
                            orderListProvider!.scrollOffset = 0;
                            orderListProvider!.getOrder(setStateNow, context);
                          }
                        },
                      );
                    },
                  );
                }),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: AppButton.outline(
                small: true,
                color: true,
                data: 'Refresh',
                onTap: () {
                  setState(
                    () {
                      orderListProvider!.start = null;
                      orderListProvider!.end = null;
                      orderListProvider!.startDate = DateTime.now();
                      orderListProvider!.endDate = DateTime.now();
                      orderListProvider!.scrollLoadmore = true;
                      orderListProvider!.scrollOffset = 0;
                    },
                  );
                  orderListProvider!.getOrder(setStateNow, context);
                }),
          ),
        ],
      ),
    );
  }
}
