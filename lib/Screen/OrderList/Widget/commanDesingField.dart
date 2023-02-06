import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Helper/Constant.dart';
import '../OrderList.dart';

class CommanDesingWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;
  final String? onTapAction;
  final Function update;
  const CommanDesingWidget({
    Key? key,
    required this.icon,
    required this.index,
    required this.title,
    required this.onTapAction,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: NeuContainer(
        child: SizedBox(
          width: 95,
          height: 55,
          child: InkWell(
            onTap: () {
              currentSelected = index;
              orderListProvider!.activeStatus = onTapAction;
              orderListProvider!.scrollLoadmore = true;
              orderListProvider!.scrollOffset = 0;
              orderListProvider!.getOrder(update, context);
              update();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 15.0,
                    top: 8.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 18,
                        color: AppColor.primary.withOpacity(0.5),
                      ),
                      const SizedBox(width: 5),
                      TextLM(
                        () {
                          if (index == 0) {
                            if (orderListProvider!.all != null) {
                              return orderListProvider!.all!;
                            } else {
                              return "";
                            }
                          } else if (index == 1) {
                            if (orderListProvider!.received != null) {
                              return orderListProvider!.received!;
                            } else {
                              return "";
                            }
                          } else if (index == 2) {
                            if (orderListProvider!.processed != null) {
                              return orderListProvider!.processed!;
                            } else {
                              return "";
                            }
                          } else if (index == 3) {
                            if (orderListProvider!.shipped != null) {
                              return orderListProvider!.shipped!;
                            } else {
                              return "";
                            }
                          } else if (index == 4) {
                            if (orderListProvider!.delivered != null) {
                              return orderListProvider!.delivered!;
                            } else {
                              return "";
                            }
                          } else if (index == 5) {
                            if (orderListProvider!.cancelled != null) {
                              return orderListProvider!.cancelled!;
                            } else {
                              return "";
                            }
                          } else if (index == 6) {
                            if (orderListProvider!.returned != null) {
                              return orderListProvider!.returned!;
                            } else {
                              return "";
                            }
                          } else {
                            return "";
                          }
                        }(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 15.0,
                  ),
                  child: TextTL(title),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
