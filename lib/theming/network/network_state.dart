import 'package:flutter/foundation.dart' show immutable;
import 'package:vendor/theming/network/network_provider.dart';

@immutable
class NetworkState {
  final ConnectivityStatus? status;
  final bool connected;

  const NetworkState({
    required this.status,
    required this.connected,
  });

  const NetworkState.connected()
      : status = ConnectivityStatus.isConnected,
        connected = true;

  NetworkState copiedWithIsConnected(bool connected) => NetworkState(
        status: status,
        connected: connected,
      );

  @override
  bool operator ==(covariant NetworkState other) =>
      identical(this, other) ||
      (status == other.status && connected == other.connected);

  @override
  int get hashCode => Object.hash(
        status,
        connected,
      );
}
