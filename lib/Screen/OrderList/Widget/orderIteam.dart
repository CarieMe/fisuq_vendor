import 'package:fisuq_vendor/Widget/main/scale_route.dart';
import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';
import '../../../Model/OrdersModel/OrderModel.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/parameterString.dart';
import '../../../Widget/validation.dart';
import '../../OrderDetail/OrderDetail.dart';
import '../OrderList.dart';

class OrderIteam extends StatelessWidget {
  final int index;
  final Function update;
  const OrderIteam({
    Key? key,
    required this.index,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderModel model = orderListProvider!.orderList[index];
    Color back;
    if ((model.itemList![0].activeStatus!) == DELIVERD) {
      back = AppColor.green;
    } else if ((model.itemList![0].activeStatus!) == SHIPED) {
      back = AppColor.orange;
    } else if ((model.itemList![0].activeStatus!) == CANCLED ||
        model.itemList![0].activeStatus! == RETURNED) {
      back = AppColor.red;
    } else if ((model.itemList![0].activeStatus!) == PROCESSED) {
      back = AppColor.purple;
    } else if ((model.itemList![0].activeStatus!) == PROCESSED) {
      back = AppColor.purple;
    } else if (model.itemList![0].activeStatus! == "awaiting") {
      back = AppColor.gray;
    } else {
      back = Colors.teal;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: NeuContainer(
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
                      decoration: BoxDecoration(
                        color: back,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: TextBT(
                          () {
                            if (StringValidation.capitalize(
                                    model.itemList![0].activeStatus!) ==
                                "Received") {
                              return getTranslated(context, "RECEIVED_LBL")!;
                            } else if (StringValidation.capitalize(
                                    model.itemList![0].activeStatus!) ==
                                "Processed") {
                              return getTranslated(context, "PROCESSED_LBL")!;
                            } else if (StringValidation.capitalize(
                                    model.itemList![0].activeStatus!) ==
                                "Shipped") {
                              return getTranslated(context, "SHIPED_LBL")!;
                            } else if (StringValidation.capitalize(
                                    model.itemList![0].activeStatus!) ==
                                "Delivered") {
                              return getTranslated(context, "DELIVERED_LBL")!;
                            } else if (StringValidation.capitalize(
                                    model.itemList![0].activeStatus!) ==
                                "Awaiting") {
                              return getTranslated(context, "AWAITING_LBL")!;
                            } else if (StringValidation.capitalize(
                                    model.itemList![0].activeStatus!) ==
                                "Cancelled") {
                              return getTranslated(context, "CANCELLED_LBL")!;
                            } else if (StringValidation.capitalize(
                                    model.itemList![0].activeStatus!) ==
                                "Returned") {
                              return getTranslated(context, "RETURNED_LBL")!;
                            } else {
                              return StringValidation.capitalize(
                                  model.itemList![0].activeStatus!);
                            }
                          }(),
                        ),
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
                        title: getTranslated(context, "Order_No")!,
                      ),
                      OTL(
                        label: DesignConfiguration.getPriceFormat(
                            context, double.parse(getTotalAmount(model)))!,
                        icon: Icons.money,
                        title: getTranslated(context, "PayableTXT")!,
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
          onTap: () async {
            await Navigator.push(
              context,
              ScaleRoute(
                page: OrderDetail(
                  id: model.id,
                ),
              ),
            ).then(
              (value) {
                orderListProvider!.getOrder(update, context);
                update();
              },
            );
          },
        ),
      ),
    );
  }

  String getTotalAmount(OrderModel model) {
    var total = double.parse(model.total!);
    var extra = double.parse(model.serviceCharge!);
    var amount = total + extra;
    var payable = amount.toStringAsFixed(2);
    return payable;
  }
}

class OTL extends StatelessWidget {
  final String label;
  final String title;
  final IconData icon;
  const OTL({
    super.key,
    required this.label,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: Icon(
              icon,
              size: 20,
              color: AppColor.rate2.withOpacity(0.8),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBL(label),
                TextI(title, size: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
