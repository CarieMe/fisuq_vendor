import 'package:vendor/theming/base/app_color.dart';
import 'package:flutter/material.dart';

//NORMAL STYLE
class LlNor extends StatelessWidget {
  final String data;
  const LlNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}

//BOLD STYLE
class LlBol extends StatelessWidget {
  final String data;
  const LlBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class LlCol extends StatelessWidget {
  final String data;
  final Color color;
  const LlCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class LlErr extends StatelessWidget {
  final String data;
  const LlErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class LlInv extends StatelessWidget {
  final String data;
  const LlInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class LlSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const LlSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class LlRev extends StatelessWidget {
  final String data;
  const LlRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class LlPri extends StatelessWidget {
  final String data;
  const LlPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class LlSec extends StatelessWidget {
  final String data;
  const LlSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class LlTer extends StatelessWidget {
  final String data;
  const LlTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}

//NORMAL STYLE
class LmNor extends StatelessWidget {
  final String data;
  const LmNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}

//BOLD STYLE
class LmBol extends StatelessWidget {
  final String data;
  const LmBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class LmCol extends StatelessWidget {
  final String data;
  final Color color;
  const LmCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class LmErr extends StatelessWidget {
  final String data;
  const LmErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class LmInv extends StatelessWidget {
  final String data;
  const LmInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class LmSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const LmSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class LmRev extends StatelessWidget {
  final String data;
  const LmRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class LmPri extends StatelessWidget {
  final String data;
  const LmPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class LmSec extends StatelessWidget {
  final String data;
  const LmSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class LmTer extends StatelessWidget {
  final String data;
  const LmTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}

class LsNor extends StatelessWidget {
  final String data;
  const LsNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}

//BOLD STYLE
class LsBol extends StatelessWidget {
  final String data;
  const LsBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class LsCol extends StatelessWidget {
  final String data;
  final Color color;
  const LsCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class LsErr extends StatelessWidget {
  final String data;
  const LsErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class LsInv extends StatelessWidget {
  final String data;
  const LsInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class LsSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const LsSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class LsRev extends StatelessWidget {
  final String data;
  const LsRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class LsPri extends StatelessWidget {
  final String data;
  const LsPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class LsSec extends StatelessWidget {
  final String data;
  const LsSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class LsTer extends StatelessWidget {
  final String data;
  const LsTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}
