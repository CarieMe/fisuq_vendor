import 'package:flutter/material.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/sales_report/sales_report.dart';
import 'package:vendor/screen/sales_report/widget/get_row_field.dart';
import 'package:vendor/widget/validation.dart';

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
      child: NeuContainer.simple(
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetRowFields(
                title: Local.totalorders,
                value: salesProvider!.totalReports,
                simple: true,
              ),
              GetRowFields(
                title: Local.grandtotal,
                value: salesProvider!.totalDeliveryCharge,
                simple: false,
              ),
              GetRowFields(
                title: Local.totaldeliverycharge,
                value: salesProvider!.grandFinalTotal,
                simple: false,
              ),
              GetRowFields(
                title: Local.servicecharge,
                value: serviceCharge(),
                simple: false,
              ),
              const Divider(),
              GetRowFields(
                title: Local.grandfinaltotal,
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
