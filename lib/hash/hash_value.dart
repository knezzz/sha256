import 'dart:math';

class HashValue {
  final List<int> initialHashValue = <int>[2, 3, 5, 7, 11, 13, 17, 19].map<int>((int e) {
    return ((sqrt(e) - sqrt(e).floor()) * pow(2, 32)).floor();
  }).toList();

  String temporaryWordFirst;
  String temporaryWordSecond;
}
