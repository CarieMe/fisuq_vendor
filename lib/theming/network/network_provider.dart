import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor/theming/network/network_state.dart';

enum ConnectivityStatus {
  notDetermined,
  isConnected,
  isDisonnected,
}

final networkStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, NetworkState>((ref) {
  return ConnectivityStatusNotifier();
});

class ConnectivityStatusNotifier extends StateNotifier<NetworkState> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  ConnectivityStatusNotifier() : super(const NetworkState.connected()) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          state = const NetworkState(
            status: ConnectivityStatus.isConnected,
            connected: true,
          );
          break;
        case ConnectivityResult.none:
          state = const NetworkState(
            status: ConnectivityStatus.isDisonnected,
            connected: false,
          );
          break;
        case ConnectivityResult.bluetooth:
          break;
        case ConnectivityResult.ethernet:
          break;
        case ConnectivityResult.vpn:
          break;
        case ConnectivityResult.other:
          break;
      }
    });
  }
}
