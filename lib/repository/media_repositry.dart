import 'dart:async';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/widget/api.dart';
class MediaRepository {
  // for add faqs.
  static Future<Map<String, dynamic>> getMedia(
    {
    var parameter,
  }
  ) async {
    try {
     var taxDetail =
          await ApiBaseHelper().postAPICall(getMediaApi, parameter);

      return taxDetail;
    } on Exception catch (e) {
      throw ApiException('Something went wrong');
    }
  }
}
