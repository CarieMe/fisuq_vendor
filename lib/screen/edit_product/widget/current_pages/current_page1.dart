import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:vendor/screen/edit_product/edit_product.dart';
import 'package:vendor/screen/edit_product/widget/current_pages/current_page3.dart';
import 'package:vendor/screen/edit_product/widget/edit_common_button.dart';
import 'package:vendor/screen/edit_product/widget/edit_common_selection.dart';
import 'package:vendor/screen/edit_product/widget/edit_common_widget.dart';
import 'package:vendor/widget/validation.dart';

currentPage1(
  BuildContext context,
  Function update,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      getPrimaryCommanText(getTranslated(context, "PRODUCTNAME_LBL")!, false),
      getCommanSizedBox(),
      getCommanInputTextField(
        getTranslated(context, "PRODUCTHINT_TXT")!,
        1,
        0.06,
        1,
        2,
        context,
      ),
      getCommanSizedBox(),
      Row(
        children: [
          getPrimaryCommanText(getTranslated(context, "Tags")!, false),
          const SizedBox(width: 10),
          Flexible(
            fit: FlexFit.loose,
            child: getSecondaryCommanText(
              getTranslated(context, "(These tags help you in search result)")!,
            ),
          ),
        ],
      ),
      getCommanSizedBox(),
      getCommanInputTextField(
        getTranslated(context,
            "Type in some tags for example AC, Cooler, Flagship Smartphones, Mobiles, Sport etc..")!,
        3,
        0.06,
        1,
        2,
        context,
      ),
      getCommanSizedBox(),
      getPrimaryCommanText("Product Type", false),
      getCommanSizedBox(),
      getIconSelectionDesing(
          getTranslated(context, "Select Tax")!, 15, context, update),
      getCommanSizedBox(),
      getPrimaryCommanText(getTranslated(context, "Select Tax")!, false),
      getCommanSizedBox(),
      getIconSelectionDesing(
        getTranslated(context, "Select Tax")!,
        1,
        context,
        update,
      ),
      getCommanSizedBox(),
      editProvider!.currentSellectedProductIsPysical
          ? getPrimaryCommanText(
              getTranslated(context, "Select Indicator")!, false)
          : Container(),
      editProvider!.currentSellectedProductIsPysical
          ? getCommanSizedBox()
          : Container(),
      editProvider!.currentSellectedProductIsPysical
          ? getIconSelectionDesing(
              getTranslated(context, "Select Indicator")!,
              2,
              context,
              update,
            )
          : Container(),
      editProvider!.currentSellectedProductIsPysical
          ? getCommanSizedBox()
          : Container(),
      getPrimaryCommanText(getTranslated(context, "Made In")!, false),
      getCommanSizedBox(),
      getIconSelectionDesing(
        getTranslated(context, "Made In")!,
        3,
        context,
        update,
      ),
      getCommanSizedBox(),
      editProvider!.currentSellectedProductIsPysical
          ? getPrimaryCommanText('HSN Code', false)
          : Container(),
      editProvider!.currentSellectedProductIsPysical
          ? getCommanSizedBox()
          : Container(),
      editProvider!.currentSellectedProductIsPysical
          ? getCommanInputTextField(
              getTranslated(context, 'HSN Code')!,
              16,
              0.06,
              1,
              2,
              context,
            )
          : Container(),
      editProvider!.currentSellectedProductIsPysical
          ? getCommanSizedBox()
          : Container(),
      Row(
        children: [
          Expanded(
            flex: 2,
            child: getPrimaryCommanText(
                getTranslated(context, "ShortDescription")!, true),
          ),
          Expanded(
            flex: 2,
            child: getCommonButton(
              (editProvider!.sortDescription == "" ||
                      editProvider!.sortDescription == null)
                  ? getTranslated(context, "Add Sort Description")!
                  : getTranslated(context, "Edit Sort Description")!,
              7,
              update,
              context,
            ),
          ),
        ],
      ),
      (editProvider!.sortDescription == "" ||
              editProvider!.sortDescription == null)
          ? Container()
          : getCommanSizedBox(),
      (editProvider!.sortDescription == "" ||
              editProvider!.sortDescription == null)
          ? Container()
          : getDescription(false),
    ],
  );
}
