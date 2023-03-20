import 'dart:async';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/widget/api.dart';

class OrderListRepository {
  static Future<Map<String, dynamic>> getOrders({
    var parameter,
  }) async {
    try {
      var taxDetail =
          await ApiBaseHelper().postAPICall(getOrdersApi, parameter);

      return taxDetail;
    } on Exception catch (e) {
      throw ApiException('Something went wrong $e');
    }
  }
}
