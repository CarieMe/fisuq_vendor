import 'package:flutter/material.dart';
import 'package:vendor/helper/theming.dart';

class DoubleBottom extends StatelessWidget {
  final String label1;
  final String label2;
  final String? icon1;
  final String? icon2;
  final void Function() function1;
  final void Function() function2;
  const DoubleBottom({
    super.key,
    required this.label1,
    required this.label2,
    required this.function1,
    required this.function2,
    this.icon1,
    this.icon2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: AppButton.main(
              data: label1,
              onTap: function1,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: AppButton.main(
              data: label2,
              onTap: function2,
            ),
          ),
        ],
      ),
    );
  }
}
