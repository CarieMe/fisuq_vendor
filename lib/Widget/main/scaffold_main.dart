import 'dart:io';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool isBottom;
  final Widget? bottomSheet;
  final List<Widget>? actions;
  const MainScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.isBottom,
    this.bottomSheet,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        automaticallyImplyLeading:
            Platform.isIOS || Platform.isMacOS ? true : false,
        elevation: 1,
        backgroundColor: Theme.of(context).backgroundColor,
        title: TextLL(title),
        centerTitle: false,
        actions: actions ?? [],
      ),
      body: body,
      bottomSheet: isBottom ? bottomSheet : null,
    );
  }
}
