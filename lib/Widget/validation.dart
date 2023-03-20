import 'package:flutter/material.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/localization/demo_localization.dart';

class StringValidation {
// product name velidatation

  static String? validateThisFieldRequered(
      String? value, BuildContext context) {
    if (value!.isEmpty) {
      return Local.thisfieldisrequired;
    }
    return null;
  }

// password verification

  static String? validatePass(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return Local.passwordrequired;
    } else if (value.length <= 5) {
      return Local.passwordrequired;
    } else {
      return null;
    }
  }

// sort detail velidatation

  static String? sortdescriptionvalidate(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return Local.shortdescription;
    }
    if (value.length < 3) {
      return Local.minimam5characterisrequired;
    }
    return null;
  }

// product name velidatation

  static String? validateProduct(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return Local.productnamerequired;
    }
    if (value.length < 3) {
      return Local.validproductname;
    }
    return null;
  }

//mobile verification

  static String? validateMob(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return Local.mobilerequired;
    }
    if (value.length < 5) {
      return Local.mobileno;
    }
    return null;
  }

// command for many fields

  static String? validateField(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return Local.fieldrequired;
    } else {
      return null;
    }
  }

// name validation

  static String? validateUserName(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return Local.usernamerequired;
    }
    if (value.length <= 1) {
      return Local.usernamelenth;
    }
    return null;
  }

  static String capitalize(String s) {
    if (s == "") {
      return "";
    } else {
      return s[0].toUpperCase() + s.substring(1);
    }
  }
}

//for the translation of string
String? getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context)!.translate(key);
}
