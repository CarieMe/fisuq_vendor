import 'package:vendor/theming/base/app_color.dart';
import 'package:flutter/material.dart';

//NORMAL STYLE
class BNL extends StatelessWidget {
  final String data;
  const BNL({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class BNW extends StatelessWidget {
  final String data;
  const BNW({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class BNN extends StatelessWidget {
  final String data;
  const BNN({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class BNM extends StatelessWidget {
  final String data;
  const BNM({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.light3,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class BNS extends StatelessWidget {
  final String data;
  const BNS({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.light3,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}

class BCL extends StatelessWidget {
  final String data;
  const BCL({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class BCM extends StatelessWidget {
  final String data;
  const BCM({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.primary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class BCS extends StatelessWidget {
  final String data;
  const BCS({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}

class BTC extends StatelessWidget {
  final String data;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;

  const BTC({
    super.key,
    required this.data,
    this.color,
    this.size,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: color ?? AppColors.primary,
            fontSize: size ?? 16,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
    );
  }
}
