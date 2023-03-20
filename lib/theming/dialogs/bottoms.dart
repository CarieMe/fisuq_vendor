import 'dart:io';
import 'package:vendor/theming/utils/utils_corners.dart';
import 'package:flutter/material.dart';

class Bottoms {
  static void showBottomDialog({
    required BuildContext context,
    required Widget child,
    VoidCallback? onClosed,
    bool useSafeArea = false,
  }) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useSafeArea: useSafeArea,
        elevation: 0,
        barrierColor: Colors.transparent,
        builder: (context) => _builder(
              context,
              child,
              onClosed,
            )).whenComplete(() {
      if (onClosed != null) onClosed();
    });
  }

  static Widget _builder(
    BuildContext context,
    Widget child,
    VoidCallback? onClosed,
  ) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: Platform.isIOS
              ? Corners.modalRadiusIos
              : Corners.modalRadiusAndroid,
        ),
        child: child,
      ),
    );
  }

  static void fullDialog({
    required BuildContext context,
    required Widget child,
    VoidCallback? onClosed,
    bool useSafeArea = false,
  }) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useSafeArea: useSafeArea,
        elevation: 0,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 1.0,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: Platform.isIOS
                    ? Corners.modalRadiusIos
                    : Corners.modalRadiusAndroid,
              ),
              child: child,
            ),
          );
        }).whenComplete(() {
      if (onClosed != null) onClosed();
    });
  }

  static void quarlerDialog({
    required BuildContext context,
    required Widget child,
    VoidCallback? onClosed,
    bool useSafeArea = false,
  }) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useSafeArea: useSafeArea,
        elevation: 0,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: Platform.isIOS
                    ? Corners.modalRadiusIos
                    : Corners.modalRadiusAndroid,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: child,
            ),
          );
        }).whenComplete(() {
      if (onClosed != null) onClosed();
    });
  }

  static void mediumDialog({
    required BuildContext context,
    required Widget child,
    VoidCallback? onClosed,
    bool useSafeArea = false,
  }) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useSafeArea: useSafeArea,
        elevation: 0,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: Platform.isIOS
                    ? Corners.modalRadiusIos
                    : Corners.modalRadiusAndroid,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: child,
            ),
          );
        }).whenComplete(() {
      if (onClosed != null) onClosed();
    });
  }

  static void smallDialog({
    required BuildContext context,
    required Widget child,
    VoidCallback? onClosed,
    bool useSafeArea = false,
  }) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useSafeArea: useSafeArea,
        elevation: 0,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: Platform.isIOS
                    ? Corners.modalRadiusIos
                    : Corners.modalRadiusAndroid,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: child,
            ),
          );
        }).whenComplete(() {
      if (onClosed != null) onClosed();
    });
  }

  static void customDialog({
    required BuildContext context,
    required Widget child,
    required double height,
    required double padding,
    VoidCallback? onClosed,
    bool useSafeArea = false,
  }) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useSafeArea: useSafeArea,
        elevation: 0,
        //barrierColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(padding),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: Platform.isIOS
                    ? Corners.modalRadiusIos
                    : Corners.modalRadiusAndroid,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: child,
            ),
          );
        }).whenComplete(() {
      if (onClosed != null) onClosed();
    });
  }
}
