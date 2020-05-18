int getParsedNumber(List<int> list) => int.parse(
    list.fold(StringBuffer(), (StringBuffer previousValue, int byte) => previousValue..write(byte)).toString(),
    radix: 2);

List<int> parseToList(String value) => value.split('').map(int.parse).toList();

List<int> rightShift(int amount, List<int> list) {
  final List<int> _list = List<int>.from(list);

  for (int i = 0; i < amount; i++) {
    _list.removeLast();
    _list.insert(0, 0);
  }

  return _list;
}

List<int> rightRotate(int amount, List<int> list) {
  final List<int> _list = List<int>.from(list);

  for (int i = 0; i < amount; i++) {
    final int _removed = _list.removeLast();
    _list.insert(0, _removed);
  }

  return _list;
}

List<int> exclusiveOr(List<int> firstList, List<int> secondList) {
  assert(firstList.length == secondList.length);

  final List<int> _result = <int>[];

  for (int i = 0; i < firstList.length; i++) {
    _result.add(firstList[i] != secondList[i] ? 1 : 0);
  }

  return _result;
}

List<int> addition(List<int> firstList, List<int> secondList) {
  final int _first = getParsedNumber(firstList);
  final int _second = getParsedNumber(secondList);

  return (_first + _second).toRadixString(2).split('').map(int.parse).toList();
}

extension ShaList on List<int> {
  List<int> operator ^(dynamic other) {
    if (other is List<int>) {
      return exclusiveOr(this, other);
    }

    return this;
  }
}
