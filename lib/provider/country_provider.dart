import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/screen/app_product/add_product.dart';
import 'package:vendor/screen/edit_product/edit_product.dart';

class CountryProvider extends ChangeNotifier {
  String errorMessage = '';

  Future<bool> setCountrys(bool isSearchCity, bool fromAddProduct) async {
    try {
      var parameter = {
        LIMIT: perPage.toString(),
        OFFSET: fromAddProduct
            ? addProvider!.countryOffset.toString()
            : editProvider!.cityOffset.toString(),
      };
      if (isSearchCity) {
        parameter[SEARCH] = fromAddProduct
            ? addProvider!.countryController.text
            : editProvider!.cityController.text;
        parameter[OFFSET] = '0';
        if (fromAddProduct) {
          addProvider!.countrySearchLIst.clear();
        } else {
          editProvider!.citySearchLIst.clear();
        }
      }
      var result = await CountryRepository.setCountry(parameter: parameter);
      bool error = result['error'];
      errorMessage = result['message'];
      if (!error) {
        var data = result['data'];
        if (fromAddProduct) {
          addProvider!.countryList =
              (data as List).map((data) => CountryModel.fromJson(data)).toList();
          addProvider!.countrySearchLIst.addAll(addProvider!.countryList);
        } else {
          editProvider!.cityList =
              (data as List).map((data) => CountryModel.fromJson(data)).toList();
          editProvider!.citySearchLIst.addAll(editProvider!.cityList);
        }
      }
      if (fromAddProduct) {
        addProvider!.countryLoading = false;
        addProvider!.isLoadingMoreCity = false;
        addProvider!.isProgress = false;
        addProvider!.countryOffset += perPage;
      } else {
        editProvider!.cityLoading = false;
        editProvider!.isLoadingMoreCity = false;
        editProvider!.isProgress = false;
        editProvider!.cityOffset += perPage;
        if (editProvider!.cityState != null) {
          // editProvider!.cityState!(() {});
        }
      }
      return error;
    } catch (e) {
      errorMessage = e.toString();
      return true;
    }
  }
}
