import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:vendor/helper/theming.dart';
import 'package:vendor/model/orders_model/order_model.dart';

class OrderDelivery extends StatelessWidget {
  final OrderModel? model;
  const OrderDelivery({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //getDeliveryTime(context);
    return model!.delDate != null && model!.delDate!.isNotEmpty
        ? Column(
            children: [
              NeuContainer.simple(
                context: context,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BsInv(
                            data: Local.prefereddeliverydate,
                          ),
                          BmBol(data: model!.delDate ?? 'No date'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BsInv(data: Local.prefereddeliverydate),
                          BmBol(data: model!.delTime ?? 'No time'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              NeuContainer.simple(
                context: context,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        // HmCol(
                        //   data: Tools.getTimeago(getDeliveryTime(context)),
                        //   color: AppColors.primary,
                        // ),
                        BmInv(
                          data: 'Order Delivery',
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        : const SizedBox.shrink();
  }

  //  String getDeliveryTime() {
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
}
