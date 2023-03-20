import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vendor/Widget/routes.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/provider/wallet_provider.dart';
import 'package:vendor/screen/product_list/product_list.dart';
import 'package:vendor/screen/wallet_history/wallet_history.dart';
import 'package:vendor/widget/dialog_animate.dart';
import 'package:vendor/widget/parameter_string.dart';
import 'package:vendor/widget/validation.dart';

commanDesingButtons(
  int flex,
  int index,
  IconData icon,
  String title,
  String? data,
  BuildContext context,
) {
  return Expanded(
    flex: flex,
    child: InkWell(
      onTap: () {
        if (index == 0) {
          Routes.navigateToOrderList(context);
        } else if (index == 1) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>
                  ChangeNotifierProvider<WalletTransactionProvider>(
                create: (context) => WalletTransactionProvider(),
                child: const WalletHistory(),
              ),
            ),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ProductList(
                flag: '',
                fromNavbar: false,
              ),
            ),
          );
        } else if (index == 4) {
          //rating
        } else if (index == 5) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ProductList(
                flag: "sold",
                fromNavbar: false,
              ),
            ),
          );
        } else if (index == 6) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ProductList(
                flag: "low",
                fromNavbar: false,
              ),
            ),
          );
        } else if (index == 7) {
          Routes.navigateToSalesReport(context);
        }
      },
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: primary,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                data ?? "",
                style: const TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
