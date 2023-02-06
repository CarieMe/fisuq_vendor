import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Model/OrdersModel/OrderModel.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/validation.dart';

class PriceDetail extends StatelessWidget {
  final List<OrderModel> tempList;
  const PriceDetail({
    Key? key,
    required this.tempList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: NeuContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextIB(
                data: getTranslated(context, "PRICE_DETAIL")!,
                size: 16,
              ),
              Divider(color: Theme.of(context).indicatorColor),
              priceData("", "PRICE_LBL", tempList[0].subTotal!, "", context),
              priceData(
                  "+ ", "DELIVERY_CHARGE", tempList[0].delCharge!, "", context),
              //todo
              priceData("+ ", "ServiceCharge", tempList[0].serviceCharge!, "",
                  context),
              priceData(" +", "TAXPER", tempList[0].taxAmt!,
                  "(${tempList[0].taxPer!})", context),
              priceData("- ", "PROMO_CODE_DIS_LBL", tempList[0].promoDis!, "",
                  context),
              priceData("- ", "WALLET_BAL", tempList[0].walBal!, "", context),

              Divider(
                color: Theme.of(context).indicatorColor,
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 0, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextI(
                      "${getTranslated(context, "PAYABLE")!} :",
                      size: 14,
                    ),
                    TextBL(
                      DesignConfiguration.getPriceFormat(
                          context, double.parse(totalPayable()))!,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String totalPayable() {
    var total = double.parse(tempList[0].total!);
    var extra = double.parse(tempList[0].serviceCharge!);
    var amount = total + extra;
    var payable = amount.toStringAsFixed(2);
    return payable;
  }

  Padding priceData(
      String pre, String label, String amount, String tax, context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextI(
            "${getTranslated(context, label)!} : $tax",
            size: 14,
          ),
          TextTM(
            '$pre${DesignConfiguration.getPriceFormat(context, double.parse(amount))!}',
          )
        ],
      ),
    );
  }
}
