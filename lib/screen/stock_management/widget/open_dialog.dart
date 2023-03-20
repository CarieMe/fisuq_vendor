import 'package:flutter/material.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/stock_management/stock_management_list.dart';
import 'package:vendor/widget/button_design.dart';

getButtonDesing(
  IconData icon,
) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: AppColors.primary,
        style: BorderStyle.solid,
        width: 1.0,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Icon(
        icon,
        size: 24,
      ),
    ),
  );
}

FocusNode? stockFocus;
Future<void> manageStockDialog(
  BuildContext context,
  String title,
  String stockValue,
  String variantId,
) async {
  controllerForStock.text = '0';
  bool? addValue = true;
  bool selectTypeValue = false;
  await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (
          BuildContext ctx,
          StateSetter setState,
        ) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(circularBorderRadius25),
                    topRight: Radius.circular(circularBorderRadius25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.8,
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(ctx);
                            },
                            child: const Icon(
                              Icons.close,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${Local.currentstock} : ",
                            ),
                            Container(
                              width: 80,
                              height: 25,
                              decoration: BoxDecoration(
                                color: lightWhite,
                                borderRadius: BorderRadius.circular(
                                    circularBorderRadius5),
                                border: Border.all(
                                  color: lightBlack2,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  stockValue == '' ? '0' : stockValue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Text("${Local.quantity} : "),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    int temp =
                                        int.parse(controllerForStock.text);
                                    // stockFocus!.unfocus();
                                    controllerForStock.text =
                                        temp == 0 ? '1' : (temp + 1).toString();
                                    setState(() {});
                                  },
                                  child: getButtonDesing(Icons.add),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: width * 0.2,
                                  height: 25,
                                  child: Center(
                                    child: TextFormField(
                                      controller: controllerForStock,
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(stockFocus);
                                      },
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                        color: fontColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      focusNode: stockFocus,
                                      onSaved: (value) {
                                        stockFocus!.unfocus();
                                      },
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        counterStyle: const TextStyle(
                                            height: double.minPositive),
                                        filled: true,
                                        fillColor: lightWhite,
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                                minWidth: 40, maxHeight: 20),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: fontColor),
                                          borderRadius: BorderRadius.circular(
                                              circularBorderRadius7),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: lightWhite),
                                          borderRadius: BorderRadius.circular(
                                              circularBorderRadius8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    int temp =
                                        int.parse(controllerForStock.text);
                                    if (controllerForStock.text == '' ||
                                        controllerForStock.text == '0') {
                                      controllerForStock.text = '0';
                                    } else {
                                      controllerForStock.text =
                                          (temp - 1).toString();
                                    }
                                    setState(() {});
                                  },
                                  child: getButtonDesing(Icons.remove),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${Local.type} : "),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    addValue = true;
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: addValue == null
                                          ? white
                                          : addValue!
                                              ? primary
                                              : white,
                                      border: Border.all(
                                        color: black,
                                        style: BorderStyle.solid,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Icon(
                                        Icons.done,
                                        color: white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                    vertical: 2.0,
                                  ),
                                  child: Text(Local.add),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    addValue = false;
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: addValue == null
                                          ? white
                                          : addValue!
                                              ? white
                                              : primary,
                                      border: Border.all(
                                        color: black,
                                        style: BorderStyle.solid,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Icon(
                                        Icons.done,
                                        color: white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                    vertical: 2.0,
                                  ),
                                  child: Text(
                                    Local.subtract,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      selectTypeValue
                          ? Text(
                              Local.notselectedyet,
                              style: const TextStyle(color: red),
                            )
                          : Container(),
                      SimBtn(
                        onBtnSelected: () {
                          if (addValue == null) {
                            selectTypeValue = true;
                            setState(() {});
                          } else if (controllerForStock.text == '' ||
                              controllerForStock.text == '0') {
                            selectTypeValue = false;
                            setState(() {});
                          } else {
                            selectTypeValue = false;
                            isUpdateDone = true;
                            setState(() {});
                            stockManagementProvider!.setStockValue(
                              variantId,
                              context,
                              addValue!,
                              controllerForStock.text.toString(),
                              stockValue,
                            );
                            Navigator.pop(ctx);
                          }
                        },
                        title: Local.submit,
                        size: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class EditDialogContent extends StatefulWidget {
  final String title;
  final String stockValue;
  final String variantId;
  const EditDialogContent({
    super.key,
    required this.title,
    required this.stockValue,
    required this.variantId,
  });

  @override
  State<EditDialogContent> createState() => _EditDialogContentState();
}

class _EditDialogContentState extends State<EditDialogContent> {
  final TextEditingController controllerForStock =
      TextEditingController(text: '0');
  bool? addValue = true;
  bool selectTypeValue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    HlBol(
                      data: widget.title,
                    ),
                    const BlInv(
                      data: 'Variety',
                    ),
                  ],
                ),
                Column(
                  children: [
                    HlBol(
                      data: widget.stockValue == '' ? '0' : widget.stockValue,
                    ),
                    BlInv(
                      data: Local.quantity,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Allert.tap();
                        int temp = int.parse(controllerForStock.text);
                        controllerForStock.text =
                            temp == 0 ? '1' : (temp + 1).toString();
                      },
                      child: getButtonDesing(Icons.add),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: width * 0.4,
                      child: Center(
                        child: TextFormField(
                          controller: controllerForStock,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(stockFocus);
                          },
                          keyboardType: TextInputType.number,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 90,
                              ),
                          focusNode: stockFocus,
                          onSaved: (value) {
                            stockFocus!.unfocus();
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            counterText: "",
                            counterStyle:
                                const TextStyle(height: double.minPositive),
                            filled: true,
                            fillColor: AppColors.empty,
                            prefixIconConstraints: const BoxConstraints(
                                minWidth: 40, maxHeight: 20),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: fontColor),
                              borderRadius:
                                  BorderRadius.circular(circularBorderRadius7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.empty),
                              borderRadius:
                                  BorderRadius.circular(circularBorderRadius8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Allert.tap();
                        int temp = int.parse(controllerForStock.text);
                        if (controllerForStock.text == '' ||
                            controllerForStock.text == '0') {
                          controllerForStock.text = '0';
                        } else {
                          controllerForStock.text = (temp - 1).toString();
                        }
                      },
                      child: getButtonDesing(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
          ),
          selectTypeValue
              ? BlErr(
                  data: Local.notselectedyet,
                )
              : Container(),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AppButton.main(
                      data: Local.add,
                      onTap: () {
                        addValue = true;
                        if (addValue == null) {
                          selectTypeValue = true;
                        } else if (controllerForStock.text == '' ||
                            controllerForStock.text == '0') {
                          selectTypeValue = false;
                        } else {
                          selectTypeValue = false;
                          isUpdateDone = true;
                          stockManagementProvider!.setStockValue(
                            widget.variantId,
                            context,
                            addValue!,
                            controllerForStock.text.toString(),
                            widget.stockValue,
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: AppButton.main(
                      data: Local.subtract,
                      onTap: () {
                        addValue = false;
                        if (addValue == null) {
                          selectTypeValue = true;
                        } else if (controllerForStock.text == '' ||
                            controllerForStock.text == '0') {
                          selectTypeValue = false;
                        } else {
                          selectTypeValue = false;
                          isUpdateDone = true;
                          stockManagementProvider!.setStockValue(
                            widget.variantId,
                            context,
                            addValue!,
                            controllerForStock.text.toString(),
                            widget.stockValue,
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
