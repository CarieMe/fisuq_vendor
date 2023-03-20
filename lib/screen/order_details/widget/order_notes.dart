import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:vendor/helper/theming.dart';
import 'package:vendor/model/orders_model/order_model.dart';

class OrderNotes extends StatelessWidget {
  final OrderModel? model;
  const OrderNotes({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeuContainer.simple(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BsInv(
                    data: 'Order Notes',
                  ),
                  BmBol(data: getNote()),
                  const SizedBox(height: 5),
                  list().isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BsInv(
                              data: 'Order Requests',
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: list().map(
                                (string) {
                                  var split = string.split('break');
                                  var name = split[0].trim();
                                  var n = name == '-' || name == ''
                                      ? ''
                                      : '$name - ';
                                  var reque = split.last.trim();
                                  var tra = reque == '' ? 'No notes' : reque;
                                  var data = Local.map[tra];
                                  var d = data ?? 'No request';
                                  return BmBol(data: '$n$d');
                                },
                              ).toList(),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getNote() {
    var note = 'No notes';
    var stringData = model!.request.toString();
    if (stringData != '-' || stringData != '' || stringData != '|_|') {
      var split = stringData.split('|_|');
      if (split.isNotEmpty) {
        var one = split[0].trim();
        if (one.isNotEmpty) {
          note = one;
        }
      }
    }
    return note;
  }

  List<String> list() {
    List<String> req = [];
    var stringData = model!.request.toString();
    if (stringData != '-' ||
        stringData != ' ' ||
        stringData != '' ||
        stringData != '|_|') {
      var split = stringData.split('|_|');
      var st2 = split[1];
      var data1 = st2.replaceAll('[', '');
      var data2 = data1.replaceAll(']', '');

      var data3 = data2.split(',');
      req.addAll(data3);
    }
    return req;
  }
}
