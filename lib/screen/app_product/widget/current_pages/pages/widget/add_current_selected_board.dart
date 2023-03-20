import 'package:flutter/material.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/app_product/add_product.dart';
import 'package:vendor/widget/validation.dart';

currentSelectedPossitionBord(
  BuildContext context,
  Function setState,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            addProvider!.curSelPos = 0;
            setState(() {});
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(circularBorderRadius5),
              color: addProvider!.curSelPos == 0
                  ? primary
                  : const Color(0xfff5f5f5),
            ),
            child: Center(
              child: Text(
                Local.generalinformation,
                style: TextStyle(
                  color: addProvider!.curSelPos == 0 ? white : black,
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            addProvider!.curSelPos = 1;
            setState(() {});
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(circularBorderRadius5),
              color: addProvider!.curSelPos == 1
                  ? primary
                  : const Color(0xfff5f5f5),
            ),
            child: Center(
              child: Text(
                Local.attributes,
                style: TextStyle(
                  color: addProvider!.curSelPos == 1 ? white : black,
                ),
              ),
            ),
          ),
        ),
      ),
      addProvider!.productType == 'variable_product'
          ? Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  addProvider!.curSelPos = 2;
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(circularBorderRadius5),
                    color: addProvider!.curSelPos == 2
                        ? primary
                        : const Color(0xfff5f5f5),
                  ),
                  child: Center(
                    child: Text(
                      Local.variations,
                      style: TextStyle(
                        color: addProvider!.curSelPos == 2 ? white : black,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Container(),
    ],
  );
}
