import "package:flutter/material.dart";
import 'package:vendor/helper/theming.dart';
import 'package:vendor/model/orders_model/order_model.dart';
import 'package:vendor/widget/design.dart';

class PriceDetail extends StatelessWidget {
  final List<OrderModel> tempList;
  const PriceDetail({
    Key? key,
    required this.tempList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: NeuContainer.simple(
        context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BsInv(
                data: Local.pricedetails,
              ),
              Divider(color: Theme.of(context).indicatorColor),
              priceData("", "pricelabel", tempList[0].subTotal!, "", context),
              priceData(
                  "+ ", "deliverycharge", tempList[0].delCharge!, "", context),
              //todo
              priceData("+ ", "servicecharge", tempList[0].serviceCharge!, "",
                  context),
              priceData(" +", "taxamount", tempList[0].taxAmt!,
                  "(${tempList[0].taxPer!})", context),
              priceData("- ", "promocodediscount", tempList[0].promoDis!, "",
                  context),
              priceData(
                  "- ", "walletbalance", tempList[0].walBal!, "", context),
              Divider(
                color: Theme.of(context).indicatorColor,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlInv(
                      data: "${Local.payabletxt} :",
                    ),
                    HsBol(
                      data: DesignConfiguration.getPriceFormat(
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
            "${Local.priceLabel[label]} : $tax",
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
