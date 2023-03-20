import 'dart:async';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/widget/api.dart';

class ReviewListRepository {
  // for add faqs.
  static Future<Map<String, dynamic>> getReviewList(
    {
    var parameter,
  }
  ) async {
    try {
     var taxDetail =
          await ApiBaseHelper().postAPICall(getProductRatingApi, parameter);

      return taxDetail;
    } on Exception catch (e) {
      throw ApiException('Something went wrong');
    }
  }
}