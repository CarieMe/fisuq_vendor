import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';


enum WalletStatus {
  initial,
  inProgress,
  isSuccsess,
  isFailure,
  isMoreLoading,
}

class WalletTransactionProvider extends ChangeNotifier {
  WalletStatus _transactionStatus = WalletStatus.initial;
  List<GetWithdrawelReq> userTransactions = [];
  String errorMessage = '';
  int _transationListOffset = 0, _transactionPerPage = perPage;

  bool hasMoreData = false;

  get getCurrentStatus => _transactionStatus;

  changeStatus(WalletStatus status) {
    _transactionStatus = status;
    notifyListeners();
  }

  Future<void> getUserTransaction(BuildContext context) async {
    try {
      if (!hasMoreData) {
        changeStatus(WalletStatus.inProgress);
      }

      var parameter = {
        UserId: context.read<SettingProvider>().CUR_USERID,
        LIMIT: _transactionPerPage.toString(),
        OFFSET: _transationListOffset.toString(),
        // USER_ID: CUR_USERID,
      };
      Map<String, dynamic> result =
          await WithDrawelRepository.fetchUserWithDrawelReq(
              parameter: parameter);
      List<GetWithdrawelReq> tempList = [];

      (result['transactionsList'] as List).forEach((element) {
        tempList.add(element);
      });

      userTransactions.addAll(tempList);

      if (int.parse(result['totalTransactions']) > _transationListOffset) {
        _transationListOffset += _transactionPerPage;
        hasMoreData = true;
      } else {
        hasMoreData = false;
      }
      changeStatus(WalletStatus.isSuccsess);
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      changeStatus(WalletStatus.isFailure);
      notifyListeners();
    }
  }
}
