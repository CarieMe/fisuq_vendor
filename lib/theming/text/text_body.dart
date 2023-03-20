import 'package:vendor/theming/base/app_color.dart';
import 'package:flutter/material.dart';

//NORMAL STYLE
class BlNor extends StatelessWidget {
  final String data;
  const BlNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}

//NORMAL CENTER STYLE
class BlCen extends StatelessWidget {
  final String data;
  const BlCen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.center,
    );
  }
}

//BOLD STYLE
class BlBol extends StatelessWidget {
  final String data;
  const BlBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class BlCol extends StatelessWidget {
  final String data;
  final Color color;
  const BlCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class BlErr extends StatelessWidget {
  final String data;
  const BlErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class BlInv extends StatelessWidget {
  final String data;
  const BlInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class BlSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const BlSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class BlRev extends StatelessWidget {
  final String data;
  const BlRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
    );
  }
}

//PRIMARY STYLE
class BlPri extends StatelessWidget {
  final String data;
  const BlPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class BlSec extends StatelessWidget {
  final String data;
  const BlSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class BlTer extends StatelessWidget {
  final String data;
  const BlTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}

//NORMAL STYLE
class BmNor extends StatelessWidget {
  final String data;
  const BmNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

//BOLD STYLE
class BmBol extends StatelessWidget {
  final String data;
  const BmBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class BmCol extends StatelessWidget {
  final String data;
  final Color color;
  const BmCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class BmErr extends StatelessWidget {
  final String data;
  const BmErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class BmInv extends StatelessWidget {
  final String data;
  const BmInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class BmSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const BmSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class BmRev extends StatelessWidget {
  final String data;
  const BmRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class BmPri extends StatelessWidget {
  final String data;
  const BmPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class BmSec extends StatelessWidget {
  final String data;
  const BmSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class BmTer extends StatelessWidget {
  final String data;
  const BmTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}

class BsNor extends StatelessWidget {
  final String data;
  const BsNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

//BOLD STYLE
class BsBol extends StatelessWidget {
  final String data;
  const BsBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class BsCol extends StatelessWidget {
  final String data;
  final Color color;
  const BsCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class BsErr extends StatelessWidget {
  final String data;
  const BsErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class BsInv extends StatelessWidget {
  final String data;
  const BsInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class BsSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const BsSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class BsRev extends StatelessWidget {
  final String data;
  const BsRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class BsPri extends StatelessWidget {
  final String data;
  const BsPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class BsSec extends StatelessWidget {
  final String data;
  const BsSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class BsTer extends StatelessWidget {
  final String data;
  const BsTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}
