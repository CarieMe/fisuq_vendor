import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/widget/design.dart';

class CompanyFooter extends StatelessWidget {
  const CompanyFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 50),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              DesignConfiguration.setSvgPath('logo3'),
              height: 50,
            ),
            const SizedBox(height: 15),
            const BsInv(data: 'Owned and operated by:'),
            const BlBol(data: 'Moustafa Ahmedy Fish Trading Co LLC'),
            const SizedBox(height: 15),
            const BlBol(data: '1.0.3+20'),
            const BsInv(data: 'Get the latest version'),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
