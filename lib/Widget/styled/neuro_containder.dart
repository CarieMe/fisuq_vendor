import 'package:fisuq_vendor/theming/helper/const_corners.dart';
import 'package:flutter/material.dart';

class NeuContainer extends StatelessWidget {
  final Widget child;
  const NeuContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Corners.cornerMd,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: Corners.cornerMd,
          border: Border.all(
            color: Theme.of(context).indicatorColor.withOpacity(0.3),
            width: .5,
          ),
          color: Theme.of(context).canvasColor.withOpacity(1),
        ),
        child: child,
      ),
    );
  }
}

class NeuContainerProduct extends StatelessWidget {
  final Widget child;
  const NeuContainerProduct({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Corners.cornerMd,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Theme.of(context).highlightColor.withOpacity(0.2),
            width: 1,
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: child,
      ),
    );
  }
}

class NeuContainerRound extends StatelessWidget {
  final Widget child;
  const NeuContainerRound({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: Corners.cornerLg,
        border: Border.all(
          color: Theme.of(context).highlightColor.withOpacity(0.2),
          width: 1,
        ),
        color: Theme.of(context).backgroundColor,
      ),
      child: child,
    );
  }
}

class NeuContainerCustom extends StatelessWidget {
  final Widget child;
  final Color color;
  final BorderRadiusGeometry? borderRadius;
  const NeuContainerCustom({
    super.key,
    required this.child,
    required this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? Corners.cornerLg,
        border: Border.all(
          color: Theme.of(context).highlightColor.withOpacity(0.2),
          width: 1,
        ),
        color: color,
      ),
      child: child,
    );
  }
}

class NeuContainerSearch extends StatelessWidget {
  final Widget child;
  const NeuContainerSearch({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: Corners.cornerFl,
        border: Border.all(
          color: Theme.of(context).highlightColor.withOpacity(.8),
          width: 1,
        ),
        color: Theme.of(context).shadowColor.withOpacity(.3),
      ),
      child: child,
    );
  }
}
