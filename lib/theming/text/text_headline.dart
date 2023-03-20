import 'package:vendor/theming/base/app_color.dart';
import 'package:flutter/material.dart';

//NORMAL STYLE
class HlNor extends StatelessWidget {
  final String data;
  const HlNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}

//BOLD STYLE
class HlBol extends StatelessWidget {
  final String data;
  const HlBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class HlCol extends StatelessWidget {
  final String data;
  final Color color;
  const HlCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class HlErr extends StatelessWidget {
  final String data;
  const HlErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class HlInv extends StatelessWidget {
  final String data;
  const HlInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class HlSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const HlSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class HlRev extends StatelessWidget {
  final String data;
  const HlRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class HlPri extends StatelessWidget {
  final String data;
  const HlPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class HlSec extends StatelessWidget {
  final String data;
  const HlSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class HlTer extends StatelessWidget {
  final String data;
  const HlTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}

//NORMAL STYLE
class HmNor extends StatelessWidget {
  final String data;
  const HmNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

//BOLD STYLE
class HmBol extends StatelessWidget {
  final String data;
  const HmBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class HmCol extends StatelessWidget {
  final String data;
  final Color color;
  const HmCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class HmErr extends StatelessWidget {
  final String data;
  const HmErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class HmInv extends StatelessWidget {
  final String data;
  const HmInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class HmSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const HmSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class HmRev extends StatelessWidget {
  final String data;
  const HmRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class HmPri extends StatelessWidget {
  final String data;
  const HmPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class HmSec extends StatelessWidget {
  final String data;
  const HmSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class HmTer extends StatelessWidget {
  final String data;
  const HmTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}

class HsNor extends StatelessWidget {
  final String data;
  const HsNor({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

//BOLD STYLE
class HsBol extends StatelessWidget {
  final String data;
  const HsBol({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

//COLOR STYLE
class HsCol extends StatelessWidget {
  final String data;
  final Color color;
  const HsCol({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: color,
          ),
    );
  }
}

//ERROR STYLE
class HsErr extends StatelessWidget {
  final String data;
  const HsErr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}

//INACTIVE STYLE
class HsInv extends StatelessWidget {
  final String data;
  const HsInv({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}

//STYLED STYLE
class HsSty extends StatelessWidget {
  final String data;
  final TextStyle style;
  const HsSty({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

//REVERSED STYLE
class HsRev extends StatelessWidget {
  final String data;
  const HsRev({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).highlightColor,
          ),
    );
  }
}

//PRIMARY STYLE
class HsPri extends StatelessWidget {
  final String data;
  const HsPri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.primary,
          ),
    );
  }
}

//SECONDARY STYLE
class HsSec extends StatelessWidget {
  final String data;
  const HsSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.secondary,
          ),
    );
  }
}

//TERTIARY STYLE
class HsTer extends StatelessWidget {
  final String data;
  const HsTer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.tertiary,
          ),
    );
  }
}
