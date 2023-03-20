import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/screen/app_product/add_product.dart';
import 'package:vendor/screen/edit_product/edit_product.dart';


class TaxProvider extends ChangeNotifier {
  String errorMessage = '';

  Future<bool> setTax(bool fromAddProduct) async {
    try {
      var result = await TaxRepository.setTax();
      bool error = result['error'];
      errorMessage = result['message'];
      if (!error) {
        var data = result['data'];
        if (fromAddProduct) {
          addProvider!.taxesList =
              (data as List).map((data) => TaxesModel.fromJson(data)).toList();
        } else {
          editProvider!.taxesList =
              (data as List).map((data) => TaxesModel.fromJson(data)).toList();
        }
      }
      return error;
    } catch (e) {
      errorMessage = e.toString();
      return true;
    }
  }
}
