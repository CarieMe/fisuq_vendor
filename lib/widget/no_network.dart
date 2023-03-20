import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/widget/appbar.dart';
import 'package:vendor/widget/button_design.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/shimmer_effect.dart';
import 'package:vendor/widget/validation.dart';

Widget noInternet(
  BuildContext context,
  setStateNoInternate,
  Animation<dynamic>? buttonSqueezeanimation,
  AnimationController? buttonController,
) {
  return Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          noIntImage(),
          noIntText(context),
          noIntDec(context),
          AppBtn(
            title: Local.tryagain,
            btnAnim: buttonSqueezeanimation,
            btnCntrl: buttonController,
            onBtnSelected: setStateNoInternate,
          )
        ],
      ),
    ),
  );
}

noIntImage() {
  return Image.asset(
    DesignConfiguration.setPngPath('no_internet'),
    fit: BoxFit.contain,
  );
}

noIntText(BuildContext context) {
  return Text(
    Local.nointernat,
    style: Theme.of(context).textTheme.headline5!.copyWith(
          color: primary,
          fontWeight: FontWeight.normal,
        ),
  );
}

noIntDec(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
    child: Text(
      Local.nointernetdescription,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            color: lightBlack2,
            fontWeight: FontWeight.normal,
          ),
    ),
  );
}
