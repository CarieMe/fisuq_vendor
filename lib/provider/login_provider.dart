import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor/helper/api_base_helper.dart';
import 'dart:async';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/screen/authentication/login.dart';
import 'package:vendor/screen/dashboard/dashboard.dart';
import 'package:vendor/widget/shared_preferences.dart';
import 'package:vendor/widget/api.dart';

class LoginProvider extends ChangeNotifier {
  String? mobile, password, username, id;
  AnimationController? buttonController;
  get getMobilenumber => mobile;
  get getPassword => Password;

  Future<void> getLoginUser(
    BuildContext context,
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    Function updateNow,
  ) async {
    var data = {
      Mobile: mobile,
      Password: password,
    };

   await ApiBaseHelper().postAPICall(getUserLoginApi, data).then(
      (getdata) async {
        bool error = getdata["error"];
        String? msg = getdata["message"];
        if (!error) {
          setSnackbarScafold(scaffoldMessengerKey, context, msg!);
          var data = getdata["data"][0];
          id = data[Id];
          username = data[Username];
          mobile = data[Mobile];
          saveUserDetail(
            id!,
            username!,
            mobile!,
          );
          setPrefrenceBool(isLogin, true);
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) =>  const Dashboard(),
            ),
          );
        } else {
          await buttonController!.reverse();
          setSnackbarScafold(scaffoldMessengerKey, context, msg!);
          updateNow();
        }
      },
      onError: (error) {
        setSnackbarScafold(scaffoldMessengerKey, context, error.toString());
      },
    );
  }
}
