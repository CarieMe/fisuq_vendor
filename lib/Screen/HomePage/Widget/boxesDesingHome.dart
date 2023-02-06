import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:fisuq_vendor/theming/helper/const_corners.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../Provider/walletProvider.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/routes.dart';
import '../../ProductList/product_list.dart';
import '../../WalletHistory/WalletHistory.dart';

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
              builder: (context) => ProductList(
                flag: "sold",
                fromNavbar: false,
              ),
            ),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ProductList(
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: Corners.cornerMd,
            border: Border.all(
              color: Theme.of(context).indicatorColor.withOpacity(0.1),
              width: .5,
            ),
            color: Theme.of(context).canvasColor,
          ),
          height: 141,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  DesignConfiguration.setSvgPath(svg),
                  color: AppColor.primary.withOpacity(0.7),
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 10),
                TextLL(
                  numberCounting ?? "",
                ),
                TextBS(title),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
