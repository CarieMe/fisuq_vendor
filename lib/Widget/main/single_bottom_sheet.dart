import 'package:flutter/material.dart';
import 'package:vendor/helper/theming.dart';

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
      child: AppButton.main(
        data: label1,
        onTap: function1,
      ),
    );
  }
}
