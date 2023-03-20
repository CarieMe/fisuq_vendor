import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor/state/network/network_connection.dart';
import 'package:vendor/theming/base/app_color.dart';
import 'package:vendor/theming/dot/dot_loader.dart';
import 'package:vendor/theming/text/text_body.dart';
import 'package:vendor/theming/utils/utils_allert.dart';
import 'package:vendor/theming/utils/utils_icon_direction.dart';

class NetworkAvailability extends ConsumerWidget {
  const NetworkAvailability({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = ref.watch(connectedProvider);
    return Visibility(
      visible: !isConnected,
      replacement: const SizedBox.shrink(),
      child: GestureDetector(
        onTap: () {
          Allert.tap();
          AppSettings.openWIFISettings(callback: () {
            print("sample callback function called");
          });
        },
        child: Container(
          color: Theme.of(context).colorScheme.error,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    DotLoader(
                      color: AppColors.light2,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    const BlRev(data: 'No network! Check your connection'),
                  ],
                ),
                AppIconDirection.chevronInverse(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
