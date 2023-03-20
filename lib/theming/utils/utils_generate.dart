import 'dart:convert';
import 'dart:math';

String generateSecretKey() {
  final random = Random.secure();
  final values = List<int>.generate(32, (i) => random.nextInt(256));
  return base64Url.encode(values);
}
