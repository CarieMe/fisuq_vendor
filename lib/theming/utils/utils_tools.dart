import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Tools {
  const Tools._();
  // static Uri parsed(String data) {
  //   var link = Uri.parse('${PrivateString.baseUrl}$data');
  //   return link;
  // }

  static String? formatPrice({
    required double price,
    required String loc,
    required String cur,
    required String dec,
  }) {
    return NumberFormat.currency(
      locale: Platform.localeName,
      name: loc,
      symbol: cur,
      decimalDigits: int.parse(dec),
    ).format(price).toString();
  }

  static String getHsn() {
    const chars = '1234567890';
    Random rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    var id = getRandomString(5);
    var date =
        DateTime.now().millisecondsSinceEpoch.remainder(1000000000).toString();
    String uniqueID = date + id;

    return uniqueID;
  }

  static getTimeago(String date) {
    DateTime recordDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    return timeago.format(recordDate, allowFromNow: true);
  }
}
