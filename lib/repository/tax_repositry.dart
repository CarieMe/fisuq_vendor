import 'dart:async';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/widget/api.dart';

class TaxRepository {
  // for add faqs.
  static Future<Map<String, dynamic>> setTax(
  ) async {
    try {
      var parameter = {};
      var taxDetail =
          await ApiBaseHelper().postAPICall(getTaxesApi, parameter);

      return taxDetail;
    } on Exception catch (e) {
      throw ApiException('Something went wrong');
    }
  }
}