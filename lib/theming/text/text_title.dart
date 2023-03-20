import 'package:vendor/theming/base/app_color.dart';
import 'package:flutter/material.dart';

//NORMAL STYLE
class TlNor extends StatelessWidget {
  final String data;
  const TlNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

//BOLD STYLE
class TlBol extends StatelessWidget {
  final String data;
  const TlBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class TlCol extends StatelessWidget {
  final String data;
  final Color color;
  const TlCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class TlErr extends StatelessWidget {
  final String data;
  const TlErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class TlInv extends StatelessWidget {
  final String data;
  const TlInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class TlSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const TlSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class TlRev extends StatelessWidget {
  final String data;
  const TlRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class TlPri extends StatelessWidget {
  final String data;
  const TlPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class TlSec extends StatelessWidget {
  final String data;
  const TlSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class TlTer extends StatelessWidget {
  final String data;
  const TlTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}

//NORMAL STYLE
class TmNor extends StatelessWidget {
  final String data;
  const TmNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

//BOLD STYLE
class TmBol extends StatelessWidget {
  final String data;
  const TmBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class TmCol extends StatelessWidget {
  final String data;
  final Color color;
  const TmCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class TmErr extends StatelessWidget {
  final String data;
  const TmErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class TmInv extends StatelessWidget {
  final String data;
  const TmInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class TmSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const TmSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class TmRev extends StatelessWidget {
  final String data;
  const TmRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class TmPri extends StatelessWidget {
  final String data;
  const TmPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class TmSec extends StatelessWidget {
  final String data;
  const TmSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class TmTer extends StatelessWidget {
  final String data;
  const TmTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}

class TsNor extends StatelessWidget {
  final String data;
  const TsNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

//BOLD STYLE
class TsBol extends StatelessWidget {
  final String data;
  const TsBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class TsCol extends StatelessWidget {
  final String data;
  final Color color;
  const TsCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class TsErr extends StatelessWidget {
  final String data;
  const TsErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class TsInv extends StatelessWidget {
  final String data;
  const TsInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class TsSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const TsSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class TsRev extends StatelessWidget {
  final String data;
  const TsRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class TsPri extends StatelessWidget {
  final String data;
  const TsPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class TsSec extends StatelessWidget {
  final String data;
  const TsSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class TsTer extends StatelessWidget {
  final String data;
  const TsTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}
