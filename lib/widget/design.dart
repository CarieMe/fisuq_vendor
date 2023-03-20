import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';

class DesignConfiguration {
  static setSvgPath(String name) {
    return 'assets/images/SVG/$name.svg';
  }

  static setPngPath(String name) {
    return 'assets/images/PNG/$name.png';
  }

  static setLottiePath(String name) {
    return 'assets/animation/$name.json';
  }

  static placeHolder(double height) {
    return AssetImage(
      setPngPath('placeholder'),
    );
  }

  static String? getPriceFormat(
    BuildContext context,
    double price,
  ) {
    return NumberFormat.currency(
      locale: Platform.localeName,
      name: supportedLocale,
      symbol: CUR_CURRENCY,
      decimalDigits: int.parse(Decimal_Digits),
    ).format(price).toString();
  }

  static erroWidget(double size) {
    return Image.asset(
      setPngPath('placeholder'),
      height: size,
      width: size,
    );
  }

  //for no iteam
  static Widget getNoItem(BuildContext context) {
    return Center(
      child: Text(
        Local.noitemfound,
      ),
    );
  }

// progress
  static Widget showCircularProgress(
    bool isProgress,
    Color color,
  ) {
    if (isProgress) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  static Widget showLoader(
    bool isProgress,
    BuildContext context,
  ) {
    if (isProgress) {
      return Center(
        child: CupertinoActivityIndicator(
          animating: true,
          color: Theme.of(context).indicatorColor,
          radius: 20,
        ),
      );
    }
    return const SizedBox.shrink();
  }

// Container Decoration
  static back() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [grad1Color, grad2Color],
        stops: [0, 1],
      ),
    );
  }

  static getCacheNotworkImage({
    required String imageurlString,
    required BuildContext context,
    required BoxFit? boxFit,
    required double? heightvalue,
    required double? widthvalue,
    required double? placeHolderSize,
  }) {
    return CachedNetworkImage(
      imageUrl: imageurlString,
      placeholder: (context, url) {
        return DesignConfiguration.erroWidget(placeHolderSize ?? 50);
      },
      errorWidget: (context, error, stackTrace) {
        return Container(
          child: DesignConfiguration.erroWidget(placeHolderSize ?? 50),
        );
      },
      fadeInCurve: Curves.linear,
      fadeOutCurve: Curves.linear,
      fadeInDuration: const Duration(
        milliseconds: 150,
      ),
      memCacheHeight: 100,
      //memCacheWidth: 500,
      fadeOutDuration: const Duration(
        milliseconds: 150,
      ),

      fit: boxFit,
      height: heightvalue,
      width: widthvalue,
    );
  }

// Container Decoration
  static shadow() {
    return const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: white,
        )
      ],
    );
  }

  static dialogAnimate(BuildContext context, Widget dialge, bool dismissible) {
    return showGeneralDialog(
      barrierColor: Theme.of(context).shadowColor.withOpacity(.6),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(opacity: a1.value, child: dialge),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: dismissible,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    );
  }
}