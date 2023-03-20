import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/provider/order_new_list_provider.dart';
import 'package:vendor/screen/order_list/widget/order_item.dart';
import 'package:vendor/state/utility/navigation_provider.dart';
import 'package:vendor/theming/dot/dot_loader.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/validation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rev;

class NewOrderList extends StatefulWidget {
  const NewOrderList({super.key});

  @override
  State<NewOrderList> createState() => _NewOrderListState();
}

class _NewOrderListState extends State<NewOrderList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderListNewProvider()..startTimer(),
      child: Consumer<OrderListNewProvider>(
        builder: (_, provider, __) {
          return Column(
            children: [
              StreamBuilder<List<OrderModel>>(
                stream: provider.newOrdersStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<OrderModel> newOrderList = snapshot.data!;
                    if (newOrderList.isEmpty) {
                      return const WaitingNewOrder(
                        title: 'Waiting for new orders',
                      );
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HmBol(data: Local.orders),
                                HsBol(
                                    data:
                                        '( ${newOrderList.length.toString()} )'),
                              ],
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: newOrderList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                OrderModel model = newOrderList[index];
                                return NewOrderItem(model: model);
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  } else if (snapshot.hasError) {
                    return const HmErr(data: 'Something went wrong');
                  } else {
                    if (!snapshot.hasData) {
                      return const WaitingNewOrder(
                        title: 'Waiting for new orders',
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                },
              ),
              StreamBuilder<List<OrderModel>>(
                stream: provider.shippedStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<OrderModel> shippedOrdersList = snapshot.data!;
                    if (shippedOrdersList.isEmpty) {
                      return const WaitingNewOrder(
                        title: 'Waiting for shipped orders',
                      );
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HmBol(data: Local.shipedlbl),
                                HsBol(
                                    data:
                                        '( ${shippedOrdersList.length.toString()} )'),
                              ],
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: shippedOrdersList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                OrderModel model = shippedOrdersList[index];
                                return ShippedOrderItem(model: model);
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  } else if (snapshot.hasError) {
                    return const HmErr(data: 'Something went wrong');
                  } else {
                    if (!snapshot.hasData) {
                      return const WaitingNewOrder(
                        title: 'Waiting for shipped orders',
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class WaitingNewOrder extends StatelessWidget {
  final String title;
  const WaitingNewOrder({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: NeuContainer.simple(
        context: context,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Column(
              children: [
                const DotLoader(
                  color: AppColors.primary,
                  size: 24,
                ),
                HmBol(data: title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewOrderItem extends StatelessWidget {
  const NewOrderItem({
    super.key,
    required this.model,
  });

  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    return rev.Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: NeuContainer.simple(
          context: context,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 0,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 6),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: TextBL(Local.receivedlbl),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          OTL(
                            label: model.name != null && model.name!.isNotEmpty
                                ? StringValidation.capitalize(model.name!)
                                : " ",
                            icon: Icons.person,
                            title: 'Customer',
                          ),
                          OTL(
                            label: " ${model.mobile!}",
                            icon: Icons.call,
                            title: 'Contact',
                          ),
                          OTL(
                            label: model.orderDate!,
                            icon: Icons.calendar_month,
                            title: "Date",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        OTL(
                          label: model.id!,
                          icon: Icons.note,
                          title: Local.orderno,
                        ),
                        OTL(
                          label: DesignConfiguration.getPriceFormat(
                              context, double.parse(getTotalAmount(model)))!,
                          icon: Icons.money,
                          title: Local.payabletxt,
                        ),
                        OTL(
                          label: model.payMethod!,
                          icon: Icons.payment,
                          title: 'Payment',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Allert.tap();
              ref.read(navProvider.notifier).selectPage(1);
              // await Navigator.push(
              //   context,
              //   ScaleRoute(
              //     page: OrderDetail(
              //       id: model.id,
              //     ),
              //   ),
              // );
            },
          ),
        ),
      );
    });
  }

  String getTotalAmount(OrderModel model) {
    var total = double.parse(model.total!);
    var extra = double.parse(model.serviceCharge!);
    var amount = total + extra;
    var payable = amount.toStringAsFixed(2);
    return payable;
  }
}

class ShippedOrderItem extends StatelessWidget {
  const ShippedOrderItem({
    super.key,
    required this.model,
  });

  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    Set<String> displayedDeliveries = {};
    return rev.Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: NeuContainer.simple(
          context: context,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: [
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: model.itemList!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = model.itemList![index];
                        if (!displayedDeliveries.contains(data.deliverBy!)) {
                          displayedDeliveries.add(data.deliverBy!);
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(CupertinoIcons.person_circle,
                                        size: 20),
                                    const SizedBox(width: 10),
                                    HsBol(data: 'Captain ${data.deliverBy!}'),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlBol(
                                        data: model.itemList!.length > 1
                                            ? '${data.name!} + ${(model.itemList!.length - 1).toString()} more'
                                            : data.name!),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NeuContainer.simple(
                          context: context,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BsBol(
                                  data: DesignConfiguration.getPriceFormat(
                                      context,
                                      double.parse(getTotalAmount(model)))!,
                                ),
                                const BsInv(data: 'Amount'),
                              ],
                            ),
                          ),
                        ),
                        NeuContainer.simple(
                          context: context,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BsBol(
                                  data: model.payMethod!,
                                ),
                                const BsInv(data: 'Pay'),
                              ],
                            ),
                          ),
                        ),
                        NeuContainer.simple(
                          context: context,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BsBol(
                                  data: model.delTime!,
                                ),
                                const BsInv(data: 'Time'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  //   child: BlCol(
                  //     data:
                  //         'Completion: ${Tools.getTimeago(getDeliveryTime())}',
                  //     color: AppColors.primary,
                  //   ),
                  // ),
                ],
              ),
            ),
            onTap: () {
              Allert.tap();
              ref.read(navProvider.notifier).selectPage(1);
            },
          ),
        ),
      );
    });
  }

  // String getDeliveryTime() {
  //   var prefDate = model.delDate;
  //   var preftime = model.delTime;
  //   var t = preftime!.split(' ');
  //   //var time1 = '${t[0]} ${t[4]}';
  //   var time2 = '${t[2]} ${t[3]}';
  //   var delTime = '$prefDate $time2';
  //   var formats = DateFormat('dd-MM-yyyy hh:mm a').parse(delTime);
  //   var epoch = formats.millisecondsSinceEpoch;
  //   return epoch.toString();
  // }

  String getTotalAmount(OrderModel model) {
    var total = double.parse(model.total!);
    var extra = double.parse(model.serviceCharge!);
    var amount = total + extra;
    var payable = amount.toStringAsFixed(2);
    return payable;
  }
}
