import 'dart:io';
import 'package:vendor/theming/utils/utils_design.dart';
import 'package:flutter/material.dart';

class AppImages {
  static placeholder({required double size}) {
    return SizedBox(
      height: size,
      width: size,
      child: Icon(
        Icons.account_circle,
        color: Colors.white,
        size: size,
      ),
    );
  }

  static logoNetwork({required double size, required String logo}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage('$logo?auto=compress&cs=tinysrgb&dpr=1&w=500'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  static logoFile({required double size, required File logo}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: FileImage(logo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  static cachedImage({
    required String imageurlString,
    required BuildContext context,
    required BoxFit boxFit,
    required double heightvalue,
    required double widthvalue,
    required double placeHolderSize,
  }) {
    return FadeInImage.assetNetwork(
      image: imageurlString,
      placeholder: SetPath.setPngPath('placeholder'),
      width: widthvalue,
      height: heightvalue,
      fit: boxFit,
      fadeInDuration: const Duration(
        milliseconds: 100,
      ),
      fadeOutDuration: const Duration(
        milliseconds: 100,
      ),
      fadeInCurve: Curves.linear,
      fadeOutCurve: Curves.linear,
      imageErrorBuilder: (context, error, stackTrace) {
        return placeholder(size: placeHolderSize);
      },
    );
  }
}
