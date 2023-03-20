import 'dart:io';

import 'package:vendor/theming/text/text.dart';
import 'package:flutter/material.dart';

class SliverScaffold extends StatelessWidget {
  final String title;
  final Widget background;
  final Widget tabs;
  final Widget body;
  final bool isBottom;
  final Widget? bottomSheet;
  final List<Widget>? actions;

  const SliverScaffold({
    super.key,
    required this.title,
    required this.background,
    required this.tabs,
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            automaticallyImplyLeading:
                Platform.isIOS || Platform.isMacOS ? true : false,
            elevation: 1,
            backgroundColor: Theme.of(context).backgroundColor,
            actions: actions ?? [],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: TextLL(title),
              background: background,
            ),
          ),
          // SliverPersistentHeader(
          //   delegate: _SliverAppBarDelegate(tabs),
          //   pinned: true,
          // ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                body,
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.tabs);

  final Widget tabs;

  @override
  double get minExtent => 200;
  @override
  double get maxExtent => 200;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: tabs);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
