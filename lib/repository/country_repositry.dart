import 'dart:async';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/widget/api.dart';

class CountryRepository {
  // for add faqs.
  static Future<Map<String, dynamic>> setCountry({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var loginDetail =
          await ApiBaseHelper().postAPICall(getCountriesDataApi, parameter);

      return loginDetail;
    } on Exception catch (e) {
      throw ApiException('Something went wrong');
    }
  }
}