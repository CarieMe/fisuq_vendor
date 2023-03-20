import 'package:vendor/theming/base/app_color.dart';
import 'package:flutter/material.dart';

//NORMAL STYLE
class DlNor extends StatelessWidget {
  final String data;
  const DlNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

//BOLD STYLE
class DlBol extends StatelessWidget {
  final String data;
  const DlBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class DlCol extends StatelessWidget {
  final String data;
  final Color color;
  const DlCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class DlErr extends StatelessWidget {
  final String data;
  const DlErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class DlInv extends StatelessWidget {
  final String data;
  const DlInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class DlSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const DlSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class DlRev extends StatelessWidget {
  final String data;
  const DlRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class DlPri extends StatelessWidget {
  final String data;
  const DlPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class DlSec extends StatelessWidget {
  final String data;
  const DlSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class DlTer extends StatelessWidget {
  final String data;
  const DlTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}

//NORMAL STYLE
class DmNor extends StatelessWidget {
  final String data;
  const DmNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

//BOLD STYLE
class DmBol extends StatelessWidget {
  final String data;
  const DmBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class DmCol extends StatelessWidget {
  final String data;
  final Color color;
  const DmCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class DmErr extends StatelessWidget {
  final String data;
  const DmErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class DmInv extends StatelessWidget {
  final String data;
  const DmInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class DmSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const DmSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class DmRev extends StatelessWidget {
  final String data;
  const DmRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class DmPri extends StatelessWidget {
  final String data;
  const DmPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class DmSec extends StatelessWidget {
  final String data;
  const DmSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class DmTer extends StatelessWidget {
  final String data;
  const DmTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}

class DsNor extends StatelessWidget {
  final String data;
  const DsNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

//BOLD STYLE
class DsBol extends StatelessWidget {
  final String data;
  const DsBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class DsCol extends StatelessWidget {
  final String data;
  final Color color;
  const DsCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class DsErr extends StatelessWidget {
  final String data;
  const DsErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class DsInv extends StatelessWidget {
  final String data;
  const DsInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class DsSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const DsSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class DsRev extends StatelessWidget {
  final String data;
  const DsRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class DsPri extends StatelessWidget {
  final String data;
  const DsPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class DsSec extends StatelessWidget {
  final String data;
  const DsSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class DsTer extends StatelessWidget {
  final String data;
  const DsTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}
