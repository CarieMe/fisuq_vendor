import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';
import '../../../Model/OrdersModel/OrderModel.dart';
import '../../../Widget/validation.dart';

class OrderBasicDetail extends StatelessWidget {
  final OrderModel? model;
  const OrderBasicDetail({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeuContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextI(
                  "${getTranslated(context, "ORDER_ID_LBL")!} - ",
                  size: 16,
                ),
                TextBL(model!.id!),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                TextI(
                  "${getTranslated(context, "ORDER_DATE")!} - ",
                  size: 16,
                ),
                TextBL(
                  model!.orderDate!,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                TextI(
                  "${getTranslated(context, "PAYMENT_MTHD")!} - ",
                  size: 16,
                ),
                TextBL(
                  model!.payMethod!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
