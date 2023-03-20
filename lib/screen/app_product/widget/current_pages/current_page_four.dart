import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor/screen/app_product/widget/current_pages/pages/widget/add_current_selected_board.dart';
import 'package:vendor/screen/app_product/widget/current_pages/pages/widget/add_selected_position_one.dart';
import 'package:vendor/screen/app_product/widget/current_pages/pages/widget/add_selected_position_three.dart';
import 'package:vendor/screen/app_product/widget/current_pages/pages/widget/add_selected_position_two.dart';

currentPage4(
  BuildContext context,
  Function setState,
  Function updateCity,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      additionalInfo(context, setState, updateCity),
    ],
  );
}

additionalInfo(
  BuildContext context,
  Function setState,
  Function updateCity,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      currentSelectedPossitionBord(context, setState),
      selectionPossitionZero(context, setState, updateCity),
      selectionPossitionOne(context, setState),
      selectionPossitionTwo(context, setState),
    ],
  );
}
