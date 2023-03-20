import 'dart:async';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/widget/api.dart';

class CategoryRepository {
  static Future<Map<String, dynamic>> setCategory({
    required Map<dynamic, dynamic> parameter,
  }) async {
    try {
     
      var taxDetail =
          await ApiBaseHelper().postAPICall(getCategoriesApi, parameter);

      return taxDetail;
    } on Exception catch (e) {
      throw ApiException('Something went wrong');
    }
  }
}
