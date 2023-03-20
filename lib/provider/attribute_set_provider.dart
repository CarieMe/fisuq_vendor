import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/screen/app_product/add_product.dart';
import 'package:vendor/screen/edit_product/edit_product.dart';

class AttributeProvider extends ChangeNotifier {
  String errorMessage = '';

  Future<bool> setAttributeSet(bool fromAddProduct) async {
    try {
      var result = await AttributeRepository.setAttributeset();
      bool error = result['error'];
      errorMessage = result['message'];
      if (!error) {
        var data = result['data'];
        if (fromAddProduct) {
          addProvider!.attributeSetList = (data as List)
              .map(
                (data) => AttributeSetModel.fromJson(data),
              )
              .toList();
        } else {
          editProvider!.attributeSetList = (data as List)
              .map(
                (data) => AttributeSetModel.fromJson(data),
              )
              .toList();
        }
      }
      return error;
    } catch (e) {
      errorMessage = e.toString();
      return true;
    }
  }

  Future<bool> setAttributes(bool fromAddProduct) async {
    try {
      var result = await AttributeRepository.attributeset();
      bool error = result['error'];
      errorMessage = result['message'];
      if (!error) {
        var data = result['data'];
        if (fromAddProduct) {
          addProvider!.attributesList = (data as List)
              .map(
                (data) => AttributeModel.fromJson(data),
              )
              .toList();
          for (var element in addProvider!.attributesList) {
            addProvider!.selectedAttributeValues[element.id!] = [];
          }
        } else {
          editProvider!.attributesList = (data as List)
              .map(
                (data) => AttributeModel.fromJson(data),
              )
              .toList();
          for (var element in editProvider!.attributesList) {
            editProvider!.selectedAttributeValues[element.id!] = [];
          }
        }
      }
      return error;
    } catch (e) {
      errorMessage = e.toString();
      return true;
    }
  }

  Future<bool> setAttributesValue(bool fromAddProduct) async {
    try {
      var result = await AttributeRepository.attributeValue();
      bool error = result['error'];
      errorMessage = result['message'];
      if (!error) {
        var data = result['data'];
        if (fromAddProduct) {
          addProvider!.attributesValueList = (data as List)
              .map(
                (data) => AttributeValueModel.fromJson(data),
              )
              .toList();
          for (var element in addProvider!.attributesList) {
            addProvider!.selectedAttributeValues[element.id!] = [];
          }
        } else {
          editProvider!.attributesValueList = (data as List)
              .map(
                (data) => AttributeValueModel.fromJson(data),
              )
              .toList();
        }
      }
      return error;
    } catch (e) {
      errorMessage = e.toString();
      return true;
    }
  }
}
