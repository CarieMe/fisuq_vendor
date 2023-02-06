import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Helper/Constant.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/validation.dart';

class GetRowFields extends StatelessWidget {
  String title;
  String value;
  bool simple;
  GetRowFields({
    Key? key,
    required this.value,
    required this.title,
    required this.simple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final finalTotal = "${getTranslated(context, 'Final Total')} : ";
    final grandTotal = getTranslated(context, "Grand Final Total :");
    return title == finalTotal || title == grandTotal
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextIB(data: title, size: 16),
              TextIB(
                data: () {
                  if (simple) {
                    return value;
                  } else {
                    return DesignConfiguration.getPriceFormat(
                      context,
                      double.parse(value),
                    )!;
                  }
                }(),
                size: 16,
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextI(title, size: 14),
              TextI(
                () {
                  if (simple) {
                    return value;
                  } else {
                    return DesignConfiguration.getPriceFormat(
                      context,
                      double.parse(value),
                    )!;
                  }
                }(),
                size: 14,
              ),
            ],
          );
  }
}
