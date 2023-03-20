import 'dart:async';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/widget/api.dart';

class SalesReportRepository {
  // for add faqs.
  static Future<Map<String, dynamic>> getSalesReportRequest({
    var parameter,
  }) async {
    try {
      var taxDetail =
          await ApiBaseHelper().postAPICall(getSalesListApi, parameter);

      return taxDetail;
    } on Exception catch (e) {
      throw ApiException('Something went wrong $e');
    }
  }
}
