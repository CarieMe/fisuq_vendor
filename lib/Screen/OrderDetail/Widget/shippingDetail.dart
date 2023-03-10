import 'dart:io';
import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Helper/Color.dart';
import '../../../Helper/Constant.dart';
import '../../../Model/OrdersModel/OrderModel.dart';
import '../../../Widget/validation.dart';
import '../../HomePage/home.dart';

class ShippingDetail extends StatelessWidget {
  final List<OrderModel> tempList;
  const ShippingDetail({
    Key? key,
    required this.tempList,
  }) : super(key: key);
  _launchCaller() async {
    var url = "tel:${tempList[0].mobile}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: NeuContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextIB(
                data: getTranslated(context, "SHIPPING_DETAIL")!,
                size: 16,
              ),
              Divider(color: Theme.of(context).indicatorColor),
              TextBL(
                tempList[0].orderRecipientPerson != null &&
                        tempList[0].orderRecipientPerson!.isNotEmpty
                    ? StringValidation.capitalize(
                        tempList[0].orderRecipientPerson!)
                    : " ",
              ),
              TextI(
                () {
                  return tempList[0].address != null ||
                          tempList[0].address != ""
                      ? StringValidation.capitalize(tempList[0].address!)
                      : "";
                }(),
                size: 16,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: customerViewPermission
                        ? InkWell(
                            onTap: _launchCaller,
                            child: NeuContainer(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.call,
                                      size: 15,
                                      color: primary,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    TextC(
                                      tempList[0].mobile!,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: NeuContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.map,
                                size: 15,
                                color: primary,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextC('View Map', size: 16),
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        var url = '';
                        if (Platform.isAndroid) {
                          url =
                              "https://www.google.com/maps/dir/?api=1&destination=${tempList[0].latitude},${tempList[0].longitude}&travelmode=driving&dir_action=navigate";
                        } else {
                          url =
                              "http://maps.apple.com/?saddr=&daddr=${tempList[0].latitude},${tempList[0].longitude}&directionsmode=driving&dir_action=navigate";
                        }
                        await launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
