import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Helper/Constant.dart';

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
              selected ? AppColor.primary : Theme.of(context).canvasColor,
              selected ? AppColor.secondary : Theme.of(context).canvasColor,
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
            child: TextBS(title),
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
          color: Theme.of(context).indicatorColor.withOpacity(0.5),
          width: .5,
        ),
        color: fromNoDesing
            ? outoffStock
                ? AppColor.red.withOpacity(.5)
                : AppColor.green.withOpacity(.5)
            : Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(circularBorderRadius5),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextTL(
            title,
          ),
        ),
      ),
    ),
  );
}
