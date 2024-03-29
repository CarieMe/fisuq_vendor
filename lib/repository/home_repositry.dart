import 'dart:async';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/widget/api.dart';
class HomeRepository {
  //This method is used to fetch System policies {e.g. Privacy Policy, T&C etc..}
  static Future<String> fetchSalesReport({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var grandFinalTotal =
          await ApiBaseHelper().postAPICall(getSalesListApi, parameter);
      String temp = grandFinalTotal["grand_final_total"];
      return temp;
    } on Exception catch (e) {
      throw ApiException('Something went wrong');
    }
  }

  static Future<Map<String, dynamic>> fetchGetStatics({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var policy =
          await ApiBaseHelper().postAPICall(getStatisticsApi, parameter);
       return policy;
    } on Exception catch (e) {
      throw ApiException('Something went wrong');
    }
  }
}
