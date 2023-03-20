import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/screen/authentication/login.dart';
import 'package:vendor/widget/shared_preferences.dart';
import 'package:vendor/widget/validation.dart';

logOutDailog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(circularBorderRadius5),
              ),
            ),
            content: Text(
              getTranslated(context, "LOGOUTTXT")!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: primary),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  getTranslated(context, "LOGOUTNO")!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: lightBlack, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(
                  getTranslated(context, "LOGOUTYES")!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: primary, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  clearUserSession(context);
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const Login(),
                      ),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        },
      );
    },
  );
}
