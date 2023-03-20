import 'dart:async';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/widget/api.dart';

class WithDrawelRepository {
  ///This method is used to getTransactionsOfUSer
  static Future<Map<String, dynamic>> fetchUserWithDrawelReq({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var transactionsList =
          await ApiBaseHelper().postAPICall(getWithDrawalRequestApi, parameter);

      return {
        'totalTransactions': transactionsList['total'].toString(),
        'transactionsList': (transactionsList['data'] as List)
            .map((transactionsData) =>
                (GetWithdrawelReq.fromJson(transactionsData)))
            .toList()
      };
    } on Exception catch (e) {
      throw ApiException('Something went wrong');
    }
  }
}
