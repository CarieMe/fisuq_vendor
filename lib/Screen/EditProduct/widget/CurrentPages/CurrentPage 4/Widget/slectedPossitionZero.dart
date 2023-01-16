// import 'package:flutter/material.dart';
// import 'package:sellermultivendor/Screen/EditProduct/widget/getCommannWidget.dart';
// import 'package:sellermultivendor/Screen/EditProduct/widget/getIconSelectionDesingWidget.dart';

// import '../../../../../../Widget/validation.dart';
// import '../../../../EditProduct.dart';

// selectionPossitionZero(
//   BuildContext context,
//   Function setStateNow,
//   Function updateCity,
// ) {
//   return editProvider!.curSelPos == 0
//       ? Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             getCommanSizedBox(),
//             getPrimaryCommanText(
//                 getTranslated(context, "Type Of Product")!, false),
//             getCommanSizedBox(),

//             getIconSelectionDesing(
//               getTranslated(context, "Select Type")!,
//               9,
//               context,
//               setStateNow,
//             ),
//             editProvider!.productType == 'simple_product'
//                 ? getCommanSizedBox()
//                 : Container(),
//             editProvider!.productType == 'simple_product'
//                 ? getCommanSizedBox()
//                 : Container(),
//             editProvider!.productType == 'simple_product'
//                 ? Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: getPrimaryCommanText(
//                             getTranslated(context, "PRICE_LBL")!, true),
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: getCommanInputTextField(
//                           //logic painding
//                           " ",
//                           10,
//                           0.06,
//                           1,
//                           3, context,
//                         ),
//                       ),
//                     ],
//                   )
//                 : Container(),
//             // For Simple Product

//             editProvider!.productType == 'simple_product'
//                 ? getCommanSizedBox()
//                 : Container(),

//             editProvider!.productType == 'simple_product'
//                 ? Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: getPrimaryCommanText(
//                             getTranslated(context, "Special Price")!, true),
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: getCommanInputTextField(
//                           //logic painding
//                           " ",
//                           11,
//                           0.06,
//                           1,
//                           3, context,
//                         ),
//                       ),
//                     ],
//                   )
//                 : Container(),
//             editProvider!.productType == 'simple_product'
//                 ? getCommanSizedBox()
//                 : Container(),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 5,
//                   child: getPrimaryCommanText(
//                       getTranslated(context, "Enable Stock Management")!, true),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: CheckboxListTile(
//                     value: editProvider!.isStockSelected ?? false,
//                     onChanged: (bool? value) {
//                       editProvider!.isStockSelected = value!;
//                       setStateNow();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             editProvider!.isStockSelected != null &&
//                     editProvider!.isStockSelected == true &&
//                     editProvider!.productType == 'simple_product'
//                 ? Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: getPrimaryCommanText(
//                                 getTranslated(context, "SKU")!, true),
//                           ),
//                           Expanded(
//                             flex: 3,
//                             child: getCommanInputTextField(
//                               //logic painding
//                               " ",
//                               12,
//                               0.06,
//                               1,
//                               2, context,
//                             ),
//                           ),
//                         ],
//                       ),
//                       getCommanSizedBox(),
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: getPrimaryCommanText(
//                                 getTranslated(context, "Total Stock")!, true),
//                           ),
//                           Expanded(
//                             flex: 3,
//                             child: getCommanInputTextField(
//                               " ",
//                               13,
//                               0.06,
//                               1,
//                               3,
//                               context,
//                             ),
//                           ),
//                         ],
//                       ),
//                       getCommanSizedBox(),
//                       getIconSelectionDesing(
//                         getTranslated(context, "Select Stock Status")!,
//                         10,
//                         context,
//                         setStateNow,
//                       ),
//                     ],
//                   )
//                 : Container(),
//             editProvider!.productType == 'simple_product'
//                 ? getCommanSizedBox()
//                 : Container(),
//             editProvider!.productType == 'simple_product'
//                 ? getCommanSizedBox()
//                 : Container(),
//             editProvider!.productType == 'simple_product'
//                 ? getCommonButton(getTranslated(context, "Save Settings")!, 4,
//                     setStateNow, context)
//                 : Container(),

//             editProvider!.isStockSelected != null &&
//                     editProvider!.isStockSelected == true &&
//                     editProvider!.productType == 'variable_product'
//                 ? getPrimaryCommanText(
//                     getTranslated(context, "Choose Stock Management Type")!,
//                     false)
//                 : Container(),
//             editProvider!.productType == 'variable_product'
//                 ? getCommanSizedBox()
//                 : Container(),
//             editProvider!.isStockSelected != null &&
//                     editProvider!.isStockSelected == true &&
//                     editProvider!.productType == 'variable_product'
//                 ? getIconSelectionDesing(
//                     getTranslated(context, "Select Stock Status")!,
//                     11,
//                     context,
//                     setStateNow,
//                   )
//                 : Container(),
//             editProvider!.productType == 'variable_product' &&
//                     editProvider!.variantStockLevelType == "product_level" &&
//                     editProvider!.isStockSelected != null &&
//                     editProvider!.isStockSelected == true
//                 ? Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       getCommanSizedBox(),
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: getPrimaryCommanText(
//                                 getTranslated(context, "SKU")!, true),
//                           ),
//                           Expanded(
//                             flex: 3,
//                             child: getCommanInputTextField(
//                               " ",
//                               14,
//                               0.06,
//                               1,
//                               2,
//                               context,
//                             ),
//                           ),
//                         ],
//                       ),
//                       getCommanSizedBox(),
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: getPrimaryCommanText(
//                                 getTranslated(context, "Total Stock")!, true),
//                           ),
//                           Expanded(
//                             flex: 3,
//                             child: getCommanInputTextField(
//                               " ",
//                               15,
//                               0.06,
//                               1,
//                               3,
//                               context,
//                             ),
//                           ),
//                         ],
//                       ),
//                       getPrimaryCommanText("Stock Status", false),
//                       getCommanSizedBox(),
//                       getIconSelectionDesing(
//                         getTranslated(context, "Select Stock Status")!,
//                         12,
//                         context,
//                         setStateNow,
//                       ),
//                     ],
//                   )
//                 : Container(),
//             getCommanSizedBox(),
//             getCommanSizedBox(),

//             editProvider!.productType == 'variable_product' &&
//                     editProvider!.variantStockLevelType == "product_level"
//                 ? getCommonButton(getTranslated(context, "Save Settings")!, 5,
//                     setStateNow, context)
//                 : Container(),

//             editProvider!.productType == 'variable_product' &&
//                     editProvider!.variantStockLevelType == "variable_level"
//                 ? getCommonButton(getTranslated(context, "Save Settings")!, 6,
//                     setStateNow, context)
//                 : Container(),
//           ],
//         )
//       : Container();
// }
