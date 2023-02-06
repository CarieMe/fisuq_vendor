import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:flutter/material.dart';
import 'package:fisuq_vendor/Widget/validation.dart';
import '../SalesReport.dart';
import 'getRowFields.dart';

class GetGeneralDataShower extends StatelessWidget {
  const GetGeneralDataShower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 5,
        right: 5,
      ),
      child: NeuContainer(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetRowFields(
                title: getTranslated(context, "Total Orders :")!,
                value: salesProvider!.totalReports,
                simple: true,
              ),
              GetRowFields(
                title: getTranslated(context, "Grand Total :")!,
                value: salesProvider!.totalDeliveryCharge,
                simple: false,
              ),
              GetRowFields(
                title: getTranslated(context, "Total Delivery Charge :")!,
                value: salesProvider!.grandFinalTotal,
                simple: false,
              ),
              GetRowFields(
                title: getTranslated(context, "ServiceCharge")!,
                value: serviceCharge(),
                simple: false,
              ),
              const Divider(),
              GetRowFields(
                title: getTranslated(context, "Grand Final Total :")!,
                value: salesProvider!.grandTotal,
                simple: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String serviceCharge() {
    var grandtotal = double.parse(salesProvider!.grandTotal);
    var delivery = double.parse(salesProvider!.grandFinalTotal);
    var total = double.parse(salesProvider!.totalDeliveryCharge);
    var services = (grandtotal - total) - delivery;
    var service = services.toString();
    return service;
  }
}
