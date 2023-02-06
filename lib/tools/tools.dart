import 'dart:math';

class Tools {
  static getHeroID() {
    const _chars = '1234567890';
    Random _rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    var id = getRandomString(1);
    var date =
        DateTime.now().millisecondsSinceEpoch.remainder(1000000000).toString();
    var uniqueID = date + id;
    return uniqueID.toString();
  }
}
