import 'package:flutter/material.dart';
import 'package:fisuq_vendor/Helper/Constant.dart';
import '../../../Helper/Color.dart';
import '../../../Model/OrdersModel/OrderModel.dart';
import '../../../Widget/validation.dart';

class OrderBasicDetail extends StatelessWidget {
  Order_Model? model;
  OrderBasicDetail({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(circularBorderRadius5)),
        color: white,
        boxShadow: [
          BoxShadow(
              color: blarColor,
              offset: Offset(0, 0),
              blurRadius: 4,
              spreadRadius: 0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    "${getTranslated(context, "ORDER_ID_LBL")!} - ",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: grey3,
                          fontWeight: FontWeight.w400,
                          fontFamily: "PlusJakartaSans",
                          fontStyle: FontStyle.normal,
                          fontSize: textFontSize14,
                        ),
                  ),
                  Text(
                    model!.id!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontFamily: 'PlusJakartaSans',
                          color: black,
                          fontSize: textFontSize14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    "${getTranslated(context, "ORDER_DATE")!} - ",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: grey3,
                          fontWeight: FontWeight.w400,
                          fontFamily: "PlusJakartaSans",
                          fontStyle: FontStyle.normal,
                          fontSize: textFontSize14,
                        ),
                  ),
                  Text(
                    model!.orderDate!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontFamily: 'PlusJakartaSans',
                          color: black,
                          fontSize: textFontSize14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "${getTranslated(context, "PAYMENT_MTHD")!} - ",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: grey3,
                        fontWeight: FontWeight.w400,
                        fontFamily: "PlusJakartaSans",
                        fontStyle: FontStyle.normal,
                        fontSize: textFontSize14,
                      ),
                ),
                Text(
                  model!.payMethod!,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontFamily: 'PlusJakartaSans',
                        color: black,
                        fontSize: textFontSize14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
