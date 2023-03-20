import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:vendor/helper/theming.dart';
import 'package:vendor/model/orders_model/order_model.dart';
// import 'package:vendor/widget/validation.dart';

class OrderBasicDetail extends StatelessWidget {
  final OrderModel? model;
  const OrderBasicDetail({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeuContainer.simple(
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
                  data: "${Local.orderid} - ",
                ),
                BmBol(data: model!.id!),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BsInv(
                  data: "${Local.orderdate} - ",
                ),
                BmBol(
                  data: model!.orderDate!,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BsInv(
                  data: "${Local.paymentmethod} - ",
                ),
                BmBol(
                  data: model!.payMethod!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
