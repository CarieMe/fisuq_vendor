import "package:flutter/material.dart";
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/order_details/order_detail.dart';
import 'package:vendor/screen/order_list/order_list.dart';
import 'package:vendor/screen/order_list/widget/maps.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/main/scale_route.dart';
import 'package:vendor/widget/validation.dart';

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
    Color back = statusColors[model.itemList![0].activeStatus!] ?? Colors.teal;
    final activeStatus =
        StringValidation.capitalize(model.itemList![0].activeStatus!);
    final label = statusMap[activeStatus] ?? activeStatus;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
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
                      decoration: BoxDecoration(
                        color: back,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: TextBL(label),
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
              size: 18,
              color: AppColors.rate2.withOpacity(0.8),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BmBol(data: label),
                BsInv(data: title),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
