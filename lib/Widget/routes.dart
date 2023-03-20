import 'package:flutter/cupertino.dart';
import 'package:vendor/main.dart';
import 'package:vendor/screen/app_product/add_product.dart';
import 'package:vendor/screen/authentication/seller_registration.dart';
import 'package:vendor/screen/order_list/order_list.dart';
import 'package:vendor/screen/profile/profile.dart';
import 'package:vendor/screen/sales_report/sales_report.dart';
import 'package:vendor/screen/search/search.dart';

// comman Rout For All Screen
class Routes {
  // pop the current page
  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  // simple routes
  static navigateToMyApp(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Vendor(),
      ),
    );
  }

  static navigateToAddProduct(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const AddProduct(),
      ),
    );
  }

  static navigateToSearch(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Search(),
      ),
    );
  }

  static navigateToSellerRegister(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const SellerRegister(),
      ),
    );
  }

  static navigateToOrderList(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const OrderList(),
      ),
    );
  }

  static navigateToSalesReport(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const SalesReport(),
      ),
    );
  }

  static navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const Profile(),
      ),
    );
  }
}
