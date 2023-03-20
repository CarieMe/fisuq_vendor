import 'package:flutter/material.dart';
import 'package:vendor/theming/strings/translated.dart';
import 'package:vendor/theming/text/text_body.dart';
import 'package:vendor/theming/text/text_label.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/validation.dart';

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
    final finalTotal = "${Local.finaltotal} : ";
    final grandTotal = Local.grandfinaltotal;
    return title == finalTotal || title == grandTotal
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BmInv(data: title),
              BmBol(
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
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LlInv(data: title),
              LlBol(
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
              ),
            ],
          );
  }
}
