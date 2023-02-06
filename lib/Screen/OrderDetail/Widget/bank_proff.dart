import 'package:fisuq_vendor/Widget/styled/button_text.dart';
import 'package:fisuq_vendor/Widget/styled/icon_main.dart';
import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Helper/Color.dart';
import '../../../Model/OrdersModel/OrderModel.dart';
import '../../../Widget/validation.dart';

class BankProof extends StatelessWidget {
  final OrderModel model;
  const BankProof({super.key, required this.model});

  void _launchURL(String url) async => await canLaunchUrl(Uri.parse(url))
      ? await launchUrl(Uri.parse(url))
      : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return NeuContainer(
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
                    data: "${getTranslated(context, "Attachment")!} ${i + 1}",
                    isLarge: true,
                    isColored: true,
                    onPressed: () {
                      _launchURL(model.attachList![i].attachment!);
                    },
                  ),
                  const IconMain(icon: 'delete'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
