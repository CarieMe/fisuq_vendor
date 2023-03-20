import 'package:flutter/material.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/provider/setting_provider.dart';
import 'package:vendor/screen/edit_product/edit_product.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_brand.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_category.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_city.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_deliverable.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_digital_video.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_indicator.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_product_pde.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_status.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_stock_management.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_tax.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_till.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_varaint_stock.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_video.dart';
import 'package:vendor/screen/edit_product/widget/dialogs/edit_select_zip.dart';
import 'package:vendor/screen/edit_product/widget/edit_common_widget.dart';
import 'package:vendor/widget/snackbar.dart';
import 'package:vendor/widget/validation.dart';

getIconSelectionDesing(
  String title,
  int index,
  BuildContext context,
  Function update,
) {
  return InkWell(
    onTap: () {
      if (index == 1) {
        taxesDialog(context, update);
      } else if (index == 2) {
        indicatorDialog(context, update);
      } else if (index == 3) {
        cityDialog(context, update);
      } else if (index == 4) {
        editProvider!.deliverableZipcodes = null;
        deliverableTypeDialog(context, update);
      } else if (index == 5) {
        categorySelectButtomSheet(context, update);
      } else if (index == 6) {
        zipcodeDialog(context, update);
      } else if (index == 7) {
        tillWhichStatusDialog(context, update);
      } else if (index == 8) {
        videoselectionDialog(context, update);
      } else if (index == 9) {
        FocusScope.of(context).requestFocus(FocusNode());
        setSnackbar(
          getTranslated(context, "You can't Change Product Type")!,
          context,
        );
      } else if (index == 10) {
        FocusScope.of(context).requestFocus(FocusNode());
        stockStatusDialog(context, update);
      } else if (index == 11) {
        variountProductStockManagementTypeDialog(context, update);
      } else if (index == 12) {
        variantStockStatusDialog("product", 0, context, update);
      } else if (index == 13) {
        brandSelectButtomSheet(context, update);
      } else if (index == 14) {
        digitalProductVideoTypeDialog(context, update);
      } else if (index == 15) {
        productTypePDDialog(context, update);
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: grey1,
        borderRadius: BorderRadius.circular(circularBorderRadius10),
        border: Border.all(
          color: grey2,
          width: 2,
        ),
      ),
      width: width,
      height: height * 0.06,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 9,
              child: getSecondaryCommanText(
                () {
                  if (index == 1) {
                    if (editProvider!.selectedTaxID == null ||
                        editProvider!.selectedTaxID == 0) {
                      return "${getTranslated(context, "Select Tax")!} ${getTranslated(context, "0%")!}";
                    }

                    () {
                      final taxesID = editProvider!.taxesList
                          .where(
                            (element) =>
                                element.id == editProvider!.taxId!.toString(),
                          )
                          .toList();

                      return "${taxesID.first.title!} ${taxesID.first.percentage!}";
                    }();

                    // return title;
                  } else if (index == 2) {
                    if (editProvider!.indicatorValue == '0') {
                      return getTranslated(context, "None")!;
                    } else if (editProvider!.indicatorValue == '1') {
                      return getTranslated(context, "Veg")!;
                    } else if (editProvider!.indicatorValue == '2') {
                      return getTranslated(context, "Non-Veg")!;
                    }
                    return title;
                  } else if (index == 3) {
                    if (editProvider!.madeIn != null) {
                      return "${getTranslated(context, "Made In")!} ${editProvider!.madeIn!}";
                    }
                    return title;
                  } else if (index == 4) {
                    if (editProvider!.deliverabletypeValue == '0') {
                      return getTranslated(context, "None")!;
                    } else if (editProvider!.deliverabletypeValue == '1') {
                      return getTranslated(context, "All")!;
                    } else if (editProvider!.deliverabletypeValue == '2') {
                      return getTranslated(context, "Include")!;
                    } else if (editProvider!.deliverabletypeValue == '3') {
                      return getTranslated(context, "Exclude")!;
                    }
                  } else if (index == 5) {
                    if (editProvider!.selectedCatName != null) {
                      return editProvider!.selectedCatName!;
                    }
                  } else if (index == 6) {
                    if (editProvider!.deliverableZipcodes != null) {
                      return editProvider!.deliverableZipcodes!;
                    }
                  } else if (index == 7) {
                    if (editProvider!.tillwhichstatus == 'received') {
                      return getTranslated(context, "RECEIVED_LBL")!;
                    } else if (editProvider!.tillwhichstatus == 'processed') {
                      return getTranslated(context, "PROCESSED_LBL")!;
                    } else if (editProvider!.tillwhichstatus == 'shipped') {
                      return getTranslated(context, "SHIPED_LBL")!;
                    }
                  } else if (index == 8) {
                    if (editProvider!.selectedTypeOfVideo == 'vimeo') {
                      return getTranslated(context, "Vimeo")!;
                    } else if (editProvider!.selectedTypeOfVideo == 'youtube') {
                      return getTranslated(context, "Youtube")!;
                    } else if (editProvider!.selectedTypeOfVideo ==
                        'Self Hosted') {
                      return "Self Hosted";
                    }
                  } else if (index == 9) {
                    if (editProvider!.productType == 'simple_product') {
                      return getTranslated(context, "Simple Product")!;
                    } else if (editProvider!.productType ==
                        'variable_product') {
                      return getTranslated(context, "Variable Product")!;
                    } else if (editProvider!.productType == 'digital_product') {
                      return 'Digital Product';
                    }
                  } else if (index == 10) {
                    if (editProvider!.simpleproductStockStatus == '1') {
                      return getTranslated(context, "In Stock")!;
                    } else if (editProvider!.simpleproductStockStatus != null) {
                      return getTranslated(context, "Out Of Stock")!;
                    }
                  } else if (index == 11) {
                    if (editProvider!.variantStockLevelType ==
                        'product_level') {
                      return getTranslated(
                        context,
                        "Product Level (Stock Will Be Managed Generally)",
                      )!;
                    } else if (editProvider!.variantStockLevelType != null) {
                      return getTranslated(
                        context,
                        "Variable Level (Stock Will Be Managed Variant Wise)",
                      )!;
                    }
                  } else if (index == 12) {
                    if (editProvider!.stockStatus == '1') {
                      return getTranslated(context, "In Stock")!;
                    } else if (editProvider!.stockStatus != null) {
                      return getTranslated(context, "Out Of Stock")!;
                    }
                  } else if (index == 13) {
                    if (editProvider!.selectedBrandName != null) {
                      return editProvider!.selectedBrandName!;
                    }
                  } else if (index == 14) {
                    if (editProvider!
                            .selectedDigitalProductTypeOfDownloadLink !=
                        null) {
                      return editProvider!
                          .selectedDigitalProductTypeOfDownloadLink!;
                    }
                  } else if (index == 15) {
                    return editProvider!.currentSellectedProductIsPysical
                        ? "Physical Product"
                        : "Digital Product";
                  }
                  return title;
                }(),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.arrow_drop_down_outlined,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
