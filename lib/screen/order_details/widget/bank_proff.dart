import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/model/orders_model/order_model.dart';
import 'package:vendor/theming/buttons/button_text.dart';

class BankProof extends StatelessWidget {
  final OrderModel model;
  const BankProof({super.key, required this.model});

  void _launchURL(String url) async => await canLaunchUrl(Uri.parse(url))
      ? await launchUrl(Uri.parse(url))
      : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return NeuContainer.simple(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: model.attachList!.length, //original file ma joe levu
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonText(
                    data: "${Local.attachment} ${i + 1}",
                    isColored: true,
                    onPressed: () {
                      _launchURL(model.attachList![i].attachment!);
                    },
                  ),
                  AppIcons.basic(icon: 'delete'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
