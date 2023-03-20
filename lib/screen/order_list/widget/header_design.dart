import "package:flutter/material.dart";
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/order_list/order_list.dart';
import 'package:vendor/screen/order_list/widget/common_design_field.dart';

class DetailHeaderOne extends StatelessWidget {
  Function setStateNow;
  DetailHeaderOne({
    Key? key,
    required this.setStateNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          CommanDesingWidget(
            title: Local.order,
            icon: Icons.shopping_cart,
            index: 0,
            onTapAction: null,
            update: setStateNow,
          ),
          CommanDesingWidget(
            title: Local.receivedlbl,
            icon: Icons.archive,
            index: 1,
            onTapAction: orderListProvider!.statusList[1],
            update: setStateNow,
          ),
          CommanDesingWidget(
            title: Local.processedlbl,
            icon: Icons.work,
            index: 2,
            onTapAction: orderListProvider!.statusList[2],
            update: setStateNow,
          ),
        ],
      ),
    );
  }
}

class DetailHeaderTwo extends StatelessWidget {
  Function setStateNow;
  DetailHeaderTwo({Key? key, required this.setStateNow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommanDesingWidget(
          title: Local.shipedlbl,
          icon: Icons.airport_shuttle,
          index: 3,
          onTapAction: orderListProvider!.statusList[3],
          update: setStateNow,
        ),
        CommanDesingWidget(
          title: Local.deliveredlabel,
          icon: Icons.assignment_turned_in,
          index: 4,
          onTapAction: orderListProvider!.statusList[4],
          update: setStateNow,
        ),

        // index = 5
        CommanDesingWidget(
          title: Local.cancelledlabel,
          icon: Icons.cancel,
          index: 5,
          onTapAction: orderListProvider!.statusList[5],
          update: setStateNow,
        ),

        CommanDesingWidget(
          title: Local.returnedlbl,
          icon: Icons.upload,
          index: 6,
          onTapAction: orderListProvider!.statusList[6],
          update: setStateNow,
        )
      ],
    );
  }
}
