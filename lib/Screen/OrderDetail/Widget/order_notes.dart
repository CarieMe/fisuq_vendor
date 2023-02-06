import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';
import '../../../Model/OrdersModel/OrderModel.dart';
import '../../../Widget/validation.dart';

class OrderNotes extends StatelessWidget {
  final OrderModel? model;
  const OrderNotes({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final req = model!.request;
    String notes = 'No Notes';
    String request = '';
    List<String> note = [];
    List<String> requestList = [];
    if (req != null && req.isNotEmpty && req != '' && req != '-') {
      var noteList = req.split('_');
      notes = noteList[0];
      var reqList = noteList[1];

      var clean = reqList.substring(0, reqList.length - 2).substring(1);

      requestList = clean.split(', ');
    }

    return req != null && req.isNotEmpty
        ? NeuContainer(
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
                        const TextI(
                          'Order Notes',
                          size: 16,
                        ),
                        TextBL(notes),
                        const SizedBox(height: 5),
                        requestList.isEmpty
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextI(
                                    'Order Request:',
                                    size: 16,
                                  ),
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeBottom: true,
                                    removeTop: true,
                                    child: ListView.builder(
                                      itemCount: requestList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, i) {
                                        return TextBL('- ${requestList[i]}');
                                      },
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
