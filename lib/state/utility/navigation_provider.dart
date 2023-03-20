import 'package:flutter_riverpod/flutter_riverpod.dart';

final navProvider = StateNotifierProvider<NavigationNotifier, PageState>(
  (ref) => NavigationNotifier(),
);

enum NavPage { home, orders, stock, products, profile }

class NavigationNotifier extends StateNotifier<PageState> {
  NavigationNotifier() : super(const PageState.initial());

  void selectPage(int i) {
    switch (i) {
      case 0:
        state = PageState(page: NavPage.home, index: i);
        break;
      case 1:
        state = PageState(page: NavPage.orders, index: i);
        break;
      case 2:
        state = PageState(page: NavPage.stock, index: i);
        break;
      case 3:
        state = PageState(page: NavPage.products, index: i);
        break;
      case 4:
        state = PageState(page: NavPage.profile, index: i);
        break;
    }
  }
}

// @immutable
class PageState {
  final NavPage page;
  final int index;

  const PageState({
    required this.page,
    required this.index,
  });

  const PageState.initial()
      : page = NavPage.home,
        index = 0;

  @override
  bool operator ==(covariant PageState other) =>
      identical(this, other) || (page == other.page && index == other.index);

  @override
  int get hashCode => Object.hash(
        page,
        index,
      );
}
