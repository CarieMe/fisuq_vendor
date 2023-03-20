import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendor/theming/network/network_provider.dart';

part 'network_connection.g.dart';

@riverpod
bool connected(ConnectedRef ref) {
  final networkState = ref.watch(networkStatusProvider);
  return networkState.connected;
}
