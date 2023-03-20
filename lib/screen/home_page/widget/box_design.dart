import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/provider/wallet_provider.dart';
import 'package:vendor/screen/product_list/product_list.dart';
import 'package:vendor/screen/wallet_history/wallet_history.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/routes.dart';

boxesDesingHome(
  String svg,
  String title,
  String? numberCounting,
  int index,
  BuildContext context,
) {
  return Expanded(
    child: InkWell(
      onTap: () {
        if (index == 0) {
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
        } else if (index == 1) {
          Routes.navigateToSalesReport(context);
        } else if (index == 2) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const ProductList(
                flag: "sold",
                fromNavbar: false,
              ),
            ),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const ProductList(
                flag: "low",
                fromNavbar: false,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          end: index == 0 || index == 2 ? 7.5 : 0.0,
          start: index == 1 || index == 3 ? 7.5 : 0.0,
        ),
        child: NeuContainer.simple(
          context: context,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HsBol(
                  data: numberCounting ?? "",
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SvgPicture.asset(
                      DesignConfiguration.setSvgPath(svg),
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    BsInv(data: title),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
