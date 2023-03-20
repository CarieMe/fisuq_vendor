import 'package:flutter/material.dart';
import 'package:vendor/helper/theming.dart';

class BasicScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;
  final bool leading;
  const BasicScaffold({
    Key? key,
    required this.body,
    required this.title,
    required this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: HmBol(data: title),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: leading,
        leading: leading ? AppIconDirection.getLeadingIcon(context) : null,
        actions: actions ?? [],
        scrolledUnderElevation: 0.0,
      ),
      body: body,
    );
  }
}
