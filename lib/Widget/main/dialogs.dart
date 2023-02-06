import 'package:fisuq_vendor/Widget/desing.dart';
import 'package:fisuq_vendor/Widget/styled/neuro_containder.dart';
import 'package:fisuq_vendor/Widget/validation.dart';
import 'package:fisuq_vendor/theming/helper/const_corners.dart';
import 'package:fisuq_vendor/theming/text/text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Dialogs {
  static showLoader(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
      pageBuilder: (_, __, ___) {
        return Dialog(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: Corners.cornerMd,
              border: Border.all(
                color: Theme.of(context).indicatorColor.withOpacity(0.2),
                width: 0.1,
              ),
              color: Theme.of(context).backgroundColor,
            ),
            child: NeuContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Lottie.asset(
                        DesignConfiguration.setLottiePath('voice'),
                        repeat: true,
                        height: 100,
                      ),
                      const SizedBox(height: 30),
                      const TextI('Loading . . . ', size: 18),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showNoInternet(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
      pageBuilder: (_, __, ___) {
        return Dialog(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: Corners.cornerMd,
              border: Border.all(
                color: Theme.of(context).indicatorColor.withOpacity(0.2),
                width: 0.1,
              ),
              color: Theme.of(context).backgroundColor,
            ),
            child: NeuContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Lottie.asset(
                        DesignConfiguration.setLottiePath('wifi'),
                        repeat: true,
                        height: 100,
                      ),
                      const SizedBox(height: 30),
                      TextLL(
                        getTranslated(context, 'NO_INTERNET')!.toUpperCase(),
                      ),
                      const SizedBox(height: 30),
                      TextI(
                        getTranslated(context, 'NO_INTERNET_DISC')!,
                        size: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showCartLoader(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
      pageBuilder: (_, __, ___) {
        return Dialog(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: Corners.cornerMd,
              border: Border.all(
                color: Theme.of(context).indicatorColor.withOpacity(0.2),
                width: 0.1,
              ),
              color: Theme.of(context).backgroundColor,
            ),
            child: NeuContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Lottie.asset(
                        DesignConfiguration.setLottiePath('cart'),
                        repeat: true,
                        height: 100,
                      ),
                      const SizedBox(height: 30),
                      const TextI('Loading . . . ', size: 18),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showLoaderw({
    required BuildContext context,
    void Function()? confirm,
    void Function()? dismiss,
    void Function()? single,
    String? confirmLabel,
    String? dismissLabel,
    String? singleLabel,
    String? image = 'wifi',
    bool singleButton = true,
    bool withImage = true,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
      pageBuilder: (_, __, ___) {
        return Dialog(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: SizedBox(
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                withImage
                    ? Column(
                        children: [
                          Lottie.asset(
                            DesignConfiguration.setLottiePath('voice'),
                            repeat: true,
                            height: 100,
                          ),
                          TextC('No Internet', size: 18),
                          const SizedBox(height: 10),
                          TextIC(
                            getTranslated(context, 'LOGOUTTXT')!,
                            size: 15,
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextC('No Internet', size: 18),
                            const SizedBox(height: 10),
                            TextIC(
                              getTranslated(context, 'LOGOUTTXT')!,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                singleButton
                    ? InkWell(
                        onTap: single,
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).cardColor.withOpacity(.5),
                              border: Border(
                                right: BorderSide(
                                  color: Theme.of(context).highlightColor,
                                  width: 0.5,
                                ),
                                top: BorderSide(
                                  color: Theme.of(context).highlightColor,
                                  width: .75,
                                ),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Center(
                              child: TextBM(singleLabel ?? ''),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: dismiss,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(.5),
                                    border: Border(
                                      right: BorderSide(
                                        color: Theme.of(context).highlightColor,
                                        width: 0.5,
                                      ),
                                      top: BorderSide(
                                        color: Theme.of(context).highlightColor,
                                        width: .75,
                                      ),
                                    )),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Center(
                                    child: TextBM(dismissLabel ?? ''),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: confirm,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(.5),
                                    border: Border(
                                      left: BorderSide(
                                        color: Theme.of(context).highlightColor,
                                        width: 0.5,
                                      ),
                                      top: BorderSide(
                                        color: Theme.of(context).highlightColor,
                                        width: .75,
                                      ),
                                    )),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Center(
                                    child: TextBM(confirmLabel ?? ''),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
