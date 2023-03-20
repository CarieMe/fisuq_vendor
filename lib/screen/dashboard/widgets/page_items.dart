import 'package:vendor/screen/dashboard_old/profileagain.dart';
import 'package:vendor/screen/home_page/home.dart';
import 'package:vendor/screen/order_list/order_list.dart';
import 'package:vendor/screen/product_list/product_list.dart';
import 'package:vendor/screen/stock_management/stock_management_list.dart';

class PageItems {
  static page(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const OrderList();
      case 2:
        return const ProductList(
          flag: "",
          fromNavbar: true,
        );
      case 3:
        return const StockManagementList(fromNavbar: true);
      case 4:
        return const ProfileAgain();
      default:
        return const Home();
    }
  }
}
