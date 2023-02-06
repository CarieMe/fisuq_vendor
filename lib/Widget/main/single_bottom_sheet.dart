import 'package:fisuq_vendor/Widget/styled/button_main.dart';
import 'package:flutter/material.dart';

class SingleBottom extends StatelessWidget {
  final String label1;
  final void Function() function1;
  const SingleBottom({
    super.key,
    required this.label1,
    required this.function1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: ButtonMain(
        data: label1,
        onPressed: function1,
      ),
    );
  }
}
