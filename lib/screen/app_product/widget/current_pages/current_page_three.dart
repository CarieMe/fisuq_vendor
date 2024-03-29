import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/screen/app_product/add_product.dart';
import 'package:vendor/screen/app_product/widget/get_add_button.dart';
import 'package:vendor/screen/app_product/widget/get_add_images.dart';
import 'package:vendor/screen/app_product/widget/get_add_selection.dart';
import 'package:vendor/screen/app_product/widget/get_add_textfield.dart';
import 'package:vendor/screen/app_product/widget/get_add_widget.dart';
import 'package:vendor/widget/validation.dart';

currentPage3(
  BuildContext context,
  Function setState,
  Function updateCitys,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            flex: 2,
            child: getPrimaryCommanText(
                getTranslated(context, "Product Main Image")!, true),
          ),
          Expanded(
            flex: 2,
            child: getCommonButtonAdd(
                getTranslated(context, "Upload")!, 1, setState, context),
          ),
        ],
      ),
      addProvider!.productImage != '' ? getCommanSizedBox() : Container(),
      addProvider!.productImage != '' ? getCommanSizedBox() : Container(),
      addProvider!.productImage != '' ? selectedMainImageShow() : Container(),
      getCommanSizedBox(),
      getCommanSizedBox(),
      Row(
        children: [
          Expanded(
            flex: 2,
            child: getPrimaryCommanText(
                getTranslated(context, "Product Other Images")!, true),
          ),
          Expanded(
            flex: 2,
            child: getCommonButtonAdd(
                getTranslated(context, "Upload")!, 2, setState, context),
          ),
        ],
      ),
      addProvider!.otherImageUrl.isNotEmpty ? getCommanSizedBox() : Container(),
      addProvider!.otherImageUrl.isNotEmpty ? getCommanSizedBox() : Container(),
      addProvider!.otherImageUrl.isNotEmpty
          ? uploadedOtherImageShow(setState)
          : Container(),
      getCommanSizedBox(),
      getPrimaryCommanText(getTranslated(context, "Select Video Type")!, false),
      getCommanSizedBox(),
      getIconSelectionDesing(
          getTranslated(context, "not Selected Yet!(ex. Vimeo, Youtube)")!,
          8,
          context,
          setState,
          updateCitys),
      getCommanSizedBox(),
      (addProvider!.selectedTypeOfVideo == 'vimeo' ||
              addProvider!.selectedTypeOfVideo == 'youtube')
          ? getCommanInputTextField(
              addProvider!.selectedTypeOfVideo == 'vimeo'
                  ? getTranslated(
                      context,
                      "Paste Vimeo Video link / url ...!",
                    )!
                  : addProvider!.selectedTypeOfVideo == 'youtube'
                      ? getTranslated(
                          context,
                          "Paste Youtube Video link / url...!",
                        )!
                      : getTranslated(context, "Self Hosted")!,
              9,
              0.06,
              1,
              2,
              context,
            )
          : addProvider!.selectedTypeOfVideo == 'Self Hosted'
              ? Column(
                  children: [
                    videoUpload(context, setState),
                    selectedVideoShow(),
                  ],
                )
              : Container(),
      getCommanSizedBox(),
      Row(
        children: [
          Expanded(
            flex: 2,
            child: getPrimaryCommanText(
                getTranslated(context, 'Product Description')!, true),
          ),
          Expanded(
            flex: 2,
            child: getCommonButtonAdd(
                (addProvider!.description == "" ||
                        addProvider!.description == null)
                    ? getTranslated(context, "Add Description")!
                    : getTranslated(context, "Edit Description")!,
                3,
                setState,
                context),
          ),
        ],
      ),
      (addProvider!.description == "" || addProvider!.description == null)
          ? Container()
          : getCommanSizedBox(),
      (addProvider!.description == "" || addProvider!.description == null)
          ? Container()
          : getDescription(true),
    ],
  );
}

//==============================================================================
//=========================== Description ======================================

getDescription(bool fromdescription) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(circularBorderRadius5),
      border: Border.all(
        color: primary,
      ),
    ),
    width: width,
    child: Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: HtmlWidget(
        fromdescription
            ? addProvider!.description ?? ""
            : addProvider!.sortDescription ?? "",
        onErrorBuilder: (context, element, error) =>
            Text('$element error: $error'),
        onLoadingBuilder: (context, element, loadingProgress) =>
            const CircularProgressIndicator(),
        onTapUrl: (url) {
          launchUrl(
            Uri.parse(url),
          );
          return true;
        },
        renderMode: RenderMode.column,
        textStyle: const TextStyle(fontSize: textFontSize14),
      ),
    ),
  );
}
