import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';
import '../../../Model/OrdersModel/OrderModel.dart';
import '../../../Widget/validation.dart';

class OrderDelivery extends StatelessWidget {
  final OrderModel? model;
  const OrderDelivery({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return model!.delDate != null && model!.delDate!.isNotEmpty
        ? NeuContainer(
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
                        getTranslated(context, "PREFER_DATE_TIME")!,
                        size: 16,
                      ),
                      TextBL(model!.delDate!),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      TextI(
                        getTranslated(context, "PREFER_DATE_TIME")!,
                        size: 16,
                      ),
                      TextBL(
                        model!.delTime!,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
