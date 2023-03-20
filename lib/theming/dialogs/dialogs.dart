import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor/theming/text/text_body.dart';
import 'package:vendor/theming/text/text_buttons.dart';
import 'package:vendor/theming/text/text_title.dart';
import 'package:vendor/theming/utils/utils_allert.dart';
import 'package:vendor/theming/utils/utils_corners.dart';
import 'package:vendor/theming/utils/utils_shapes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static loadDialog({
    required BuildContext context,
    required bool dismissible,
    required Widget child,
  }) async {
    await showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: dismissible,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      barrierColor: Theme.of(context).shadowColor.withOpacity(.8),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Dialog(
              elevation: 5,
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: Shapes.dialog(context),
              clipBehavior: Clip.antiAlias,
              child: child,
            ),
          ),
        );
      },
    );
  }

  static doubleFunction({
    required BuildContext context,
    required String title,
    required String content,
    required void Function() confirm,
    required String confirmLabel,
    required void Function() dismiss,
    required String dismissLabel,
    required bool dismissible,
  }) {
    return loadDialog(
      context: context,
      dismissible: dismissible,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TlBol(data: title),
                  const SizedBox(height: 10),
                  BlCen(data: content),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Allert.tap();
                      dismiss;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          border: Border(
                            right: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                              width: 0.5,
                            ),
                            top: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                              width: .75,
                            ),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Center(
                          child: BNN(data: dismissLabel),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Allert.tap();
                      confirm;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          border: Border(
                            left: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                              width: 0.5,
                            ),
                            top: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                              width: .75,
                            ),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Center(
                          child: BNN(data: confirmLabel),
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
  }

  static singleFunction({
    required BuildContext context,
    required String title,
    required String content,
    required void Function() confirm,
    required String confirmLabel,
    required bool dismissible,
  }) {
    return loadDialog(
      context: context,
      dismissible: dismissible,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TlBol(data: title),
                  const SizedBox(height: 10),
                  BlCen(data: content),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Allert.tap();
                confirm;
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: .75,
                      ),
                    )),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                  child: Center(
                    child: BNN(data: confirmLabel),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showLoader(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Theme.of(context).shadowColor.withOpacity(.8),
      pageBuilder: (_, __, ___) {
        return Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 100),
          child: Dialog(
            elevation: 5,
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: Shapes.dialog(context),
            clipBehavior: Clip.antiAlias,
            child: Container(
                width: 150,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: Corners.br12,
                  border: Border.all(
                    color: Theme.of(context).indicatorColor.withOpacity(0.2),
                    width: 0.1,
                  ),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CupertinoActivityIndicator(
                      animating: true,
                      radius: 15,
                    ),
                    SizedBox(height: 20),
                    BlNor(data: 'Loading . . .'),
                  ],
                )),
          ),
        );
      },
    );
  }

  static getNewOrderDialog({
    required BuildContext context,
    required String title,
    required String content,
    required void Function() confirm,
    required String confirmLabel,
    required void Function() dismiss,
    required String dismissLabel,
  }) {
    return Dialog(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        side: BorderSide(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Consumer(builder: (context, ref, child) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TlBol(data: title),
                    const SizedBox(height: 10),
                    BlCen(data: content),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Allert.tap();
                        dismiss();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            border: Border(
                              right: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                                width: 0.5,
                              ),
                              top: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                                width: .75,
                              ),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          child: Center(
                            child: BNN(data: dismissLabel),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Allert.tap();
                        confirm();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            border: Border(
                              left: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                                width: 0.5,
                              ),
                              top: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                                width: .75,
                              ),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          child: Center(
                            child: BNN(data: confirmLabel),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
