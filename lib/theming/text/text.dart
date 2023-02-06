import 'package:fisuq_vendor/theming/colors/app_colors.dart';
import 'package:flutter/material.dart';

class TextDL extends StatelessWidget {
  const TextDL(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!,
    );
  }
}

class TextDM extends StatelessWidget {
  const TextDM(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayMedium!,
    );
  }
}

class TextDS extends StatelessWidget {
  const TextDS(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displaySmall!,
    );
  }
}

class TextHL extends StatelessWidget {
  const TextHL(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineLarge!,
    );
  }
}

class TextHM extends StatelessWidget {
  const TextHM(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineMedium!,
    );
  }
}

class TextHS extends StatelessWidget {
  const TextHS(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineSmall!,
    );
  }
}

class TextLL extends StatelessWidget {
  const TextLL(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelLarge!,
    );
  }
}

class TextLM extends StatelessWidget {
  const TextLM(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelMedium!,
    );
  }
}

class TextLS extends StatelessWidget {
  const TextLS(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelSmall!,
    );
  }
}

class TextBL extends StatelessWidget {
  const TextBL(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!,
    );
  }
}

class TextBM extends StatelessWidget {
  const TextBM(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium!,
    );
  }
}

class TextBS extends StatelessWidget {
  const TextBS(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    final lines = '\n'.allMatches(data).length + 2;
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall,
      textAlign: lines >= 1 ? TextAlign.left : TextAlign.center,
    );
  }
}

class TextTL extends StatelessWidget {
  const TextTL(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge!,
    );
  }
}

class TextTM extends StatelessWidget {
  const TextTM(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!,
    );
  }
}

class TextTS extends StatelessWidget {
  const TextTS(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!,
    );
  }
}

class TextC extends StatelessWidget {
  const TextC(this.data, {super.key, required this.size});
  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: size,
            color: AppColor.primary,
          ),
    );
  }
}

class TextI extends StatelessWidget {
  const TextI(this.data, {super.key, required this.size});
  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: size,
            color: Theme.of(context).disabledColor.withOpacity(.7),
          ),
    );
  }
}

class TextIL extends StatelessWidget {
  const TextIL(this.data, {super.key, required this.size, required this.max});
  final String data;
  final double size;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: max,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: size,
            color: Theme.of(context).disabledColor.withOpacity(.7),
          ),
    );
  }
}

class TextIC extends StatelessWidget {
  const TextIC(this.data, {super.key, required this.size});
  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: size,
            color: Theme.of(context).disabledColor.withOpacity(.7),
          ),
    );
  }
}

class TextCO extends StatelessWidget {
  const TextCO(
    this.data, {
    super.key,
    required this.size,
    this.color,
  });
  final String data;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: size,
            color: color ?? AppColor.primary,
          ),
    );
  }
}

class TextB extends StatelessWidget {
  const TextB(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: AppColor.light0),
    );
  }
}

class TextStrike extends StatelessWidget {
  const TextStrike(this.data, this.size, {super.key});
  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: size,
            decoration: TextDecoration.lineThrough,
          ),
    );
  }
}

class TextDiscount extends StatelessWidget {
  const TextDiscount(this.data, this.size, {super.key});
  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColor.primary,
            fontSize: size,
          ),
    );
  }
}

class TextCenter extends StatelessWidget {
  const TextCenter(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium!,
    );
  }
}

class TextRating extends StatelessWidget {
  const TextRating(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: AppColor.rate1,
          ),
    );
  }
}

class TextIB extends StatelessWidget {
  const TextIB({super.key, required this.data, required this.size});
  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: size,
            color: Theme.of(context).disabledColor.withOpacity(.7),
          ),
    );
  }
}

class TextBT extends StatelessWidget {
  const TextBT(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColor.light1,
          ),
    );
  }
}
