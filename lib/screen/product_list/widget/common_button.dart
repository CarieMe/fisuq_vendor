import "package:flutter/material.dart";
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/theming.dart';

class CommanButton extends StatelessWidget {
  final bool selected;
  final String title;
  const CommanButton({
    Key? key,
    required this.selected,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).indicatorColor.withOpacity(0.3),
            width: .5,
          ),
          borderRadius:
              const BorderRadius.all(Radius.circular(circularBorderRadius5)),
          gradient: LinearGradient(
            colors: [
              selected ? AppColors.primary : Theme.of(context).canvasColor,
              selected ? AppColors.secondary : Theme.of(context).canvasColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0, 1],
            tileMode: TileMode.clamp,
          ),
          boxShadow: [
            selected
                ? const BoxShadow()
                : const BoxShadow(
                    color: blarColor,
                    offset: Offset(0, 0),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BmBol(data: title),
          ),
        ),
      ),
    );
  }
}

commanBtn(String title, bool fromNoDesing, bool outoffStock, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          width: .5,
        ),
        color: fromNoDesing
            ? outoffStock
                ? AppColors.red
                : AppColors.green
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(circularBorderRadius5),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BmBol(
            data: title,
          ),
        ),
      ),
    ),
  );
}
