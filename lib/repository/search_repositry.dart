import 'dart:async';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/widget/api.dart';

class SearchRepository {

  static Future<Map<String, dynamic>> getProducts({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var loginDetail =
          await ApiBaseHelper().postAPICall(getProductsApi, parameter);

      return loginDetail;
    } on Exception catch (e) {
      throw ApiException('Something went wrong');
    }
  }
}