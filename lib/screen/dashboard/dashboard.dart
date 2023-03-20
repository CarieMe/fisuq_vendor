import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor/screen/dashboard/widgets/nav_items.dart';
import 'package:vendor/screen/dashboard/widgets/page_items.dart';
import 'package:vendor/state/utility/navigation_provider.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = ref.watch(navProvider);
    ///// you will get the report
    return Scaffold(
      body: PageItems.page(navigation.index),
      bottomNavigationBar: const NavItems(),
    );
  }
}
