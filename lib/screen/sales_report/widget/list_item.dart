import 'package:flutter/material.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/sales_report/sales_report.dart';
import 'package:vendor/screen/sales_report/widget/get_row_field.dart';
import 'package:vendor/widget/validation.dart';

class ListIteam extends StatelessWidget {
  int index;
  ListIteam({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 5.0,
        bottom: 10.0,
        left: 5.0,
      ),
      child: NeuContainer.simple(
        context: context,
        child: InkWell(
          borderRadius: BorderRadius.circular(circularBorderRadius5),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextBL(
                      "${Local.name} : ${salesProvider!.tranList[index].name ?? ''}",
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: const BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(circularBorderRadius5),
                        ),
                      ),
                      child: Text(
                        StringValidation.capitalize(
                            salesProvider!.tranList[index].paymentMethod!),
                        style: const TextStyle(
                          color: white,
                          fontSize: textFontSize14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(),
                GetRowFields(
                  title: "${Local.order} : ",
                  value: salesProvider!.tranList[index].id!,
                  simple: true,
                ),
                GetRowFields(
                  title: "${Local.dateandtime} : ",
                  value: salesProvider!.tranList[index].dateAdded!,
                  simple: true,
                ),
                GetRowFields(
                  title: "${Local.total} : ",
                  value: salesProvider!.tranList[index].total!,
                  simple: false,
                ),
                GetRowFields(
                  title: "${Local.taxamount} : ",
                  value: salesProvider!.tranList[index].taxAmount!,
                  simple: false,
                ),
                GetRowFields(
                  title: "${Local.discount} : ",
                  value: salesProvider!.tranList[index].discountedPrice!,
                  simple: false,
                ),
                GetRowFields(
                  title: "${Local.deliverycharge} : ",
                  value: salesProvider!.tranList[index].deliveryCharge!,
                  simple: false,
                ),
                GetRowFields(
                  title: "${Local.servicecharge} : ",
                  value: salesProvider!.tranList[index].serviceCharge ?? "0",
                  simple: false,
                ),
                const Divider(),
                GetRowFields(
                  title: "${Local.finaltotal} : ",
                  value: salesProvider!.tranList[index].finalTotal!,
                  simple: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
