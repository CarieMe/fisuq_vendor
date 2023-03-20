import 'package:vendor/state/network/network_connection.dart';
import 'package:vendor/theming/buttons/button_edit.dart';
import 'package:vendor/theming/buttons/button_icon.dart';
import 'package:vendor/theming/buttons/button_main.dart';
import 'package:vendor/theming/buttons/button_outline.dart';
import 'package:vendor/theming/buttons/button_settings.dart';
import 'package:vendor/theming/buttons/button_text.dart';
import 'package:vendor/theming/utils/utils_allert.dart';
import 'package:vendor/theming/utils/utils_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppButton {
  static main({
    required String data,
    required void Function() onTap,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final isConnected = ref.watch(connectedProvider);
        return ButtonMain(
          data: data,
          onPressed: isConnected
              ? () {
                  Allert.tap();
                  onTap();
                }
              : null,
        );
      },
    );
  }

  static outline({
    required String data,
    required void Function() onTap,
    required bool color,
    required bool small,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final isConnected = ref.watch(connectedProvider);
        return ButtonOutline(
          data: data,
          color: color,
          small: small,
          onPressed: isConnected
              ? () {
                  Allert.tap();
                  onTap();
                }
              : null,
        );
      },
    );
  }

  static text({
    required String data,
    required void Function() onTap,
    required bool isColored,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final isConnected = ref.watch(connectedProvider);
        return ButtonText(
          data: data,
          isColored: isColored,
          onPressed: isConnected
              ? () {
                  Allert.tap();
                  onTap();
                }
              : null,
        );
      },
    );
  }

  static settings({
    required String title,
    required String img,
    bool? top,
    required void Function() onTap,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final isConnected = ref.watch(connectedProvider);
        return ButtonSettings(
          img: img,
          title: title,
          top: top,
          onPressed: isConnected
              ? () {
                  Allert.tap();
                  onTap();
                }
              : null,
        );
      },
    );
  }

  static edit({
    required String title,
    required String label,
    required String img,
    bool? top,
    required void Function() onTap,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final isConnected = ref.watch(connectedProvider);
        return ButtonEdit(
          img: img,
          title: title,
          label: label,
          top: top,
          onPressed: isConnected
              ? () {
                  Allert.tap();
                  onTap();
                }
              : null,
        );
      },
    );
  }

  static icon({
    required String img,
    required double size,
    required void Function() onTap,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final isConnected = ref.watch(connectedProvider);
        return ButtonIcon(
          data: AppIcons.basic(
            icon: img,
            size: size,
          ),
          onPressed: isConnected
              ? () {
                  Allert.tap();
                  onTap();
                }
              : null,
        );
      },
    );
  }
}
