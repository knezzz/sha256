import 'dart:math';

import 'package:sha256/hash/constants.dart';
import 'package:sha256/hash/functions.dart';
import 'package:sha256/hash/model.dart';

class Sha256 {
  ShaMessage shaModel = ShaMessage.empty();
  Constants constants = Constants();

  Duration timeToComplete;

  Sha256(String message) {
    final DateTime _start = DateTime.now();

    print('Hashing message: $message');
    shaModel = shaModel.copyWith(input: message);

    print('Fold binary array');
    shaModel = shaModel.copyWith(foldedMessage: foldBinaryArray());

    print('Pad message so it\'s 512 bites');
    shaModel = shaModel.copyWith(paddedMessage: padMessage());

    print('Get blocs of the message');
    shaModel = shaModel.copyWith(messageBlocs: getMessageBlocs());

    print('For each message bloc generate sixty-four word message schedule');
    shaModel = shaModel.copyWith(
        messageSchedule: shaModel.messageBlocs
            .map(messageSchedule)
            .fold(<int>[], (List<int> previousValue, List<int> element) => previousValue..addAll(element)));

    List<int> _temp1 = <int>[];
    List<int> _temp2 = <int>[];

    List<int>.generate(64, (int i) => i).forEach((int i) {
      _temp1.add(getTemporaryWordFirst(i));
      _temp2.add(getTemporaryWordSecond(i));
    });

    shaModel = shaModel.copyWith(tempWord1: _temp1, tempWord2: _temp2);

    timeToComplete = DateTime.now().difference(_start);
  }

  String foldBinaryArray() {
    final String _foldedMessage = shaModel.input.codeUnits
        .map((int e) => e.toRadixString(2))
        .fold(StringBuffer(), (StringBuffer sb, String s) => sb..write(s.padLeft(8, '0')))
        .toString();

    print('Folded: $_foldedMessage');

    return _foldedMessage;
  }

  String padMessage() {
    String _message;
    final int size = shaModel.foldedMessage.length;
    final int k = (448 - size - 1) % 512;
    _message = shaModel.foldedMessage + '1' + ('0' * k) + size.toRadixString(2).padLeft(64, '0');

    print('Message length: $size');
    print('Needed padding: $k');
    print(_message);

    return _message;
  }

  List<String> getMessageBlocs() {
    final List<String> _blocks = <String>[];
    String message = shaModel.paddedMessage;

    while (message.isNotEmpty) {
      final String _value = message.substring(0, min(512, message.codeUnits.length)).padLeft(512, '0');
      print('[${_blocks.length}] - $_value');

      _blocks.add(_value);
      message = message.replaceRange(0, min(512, message.codeUnits.length), '').trim();
    }

    return _blocks;
  }

  List<int> messageSchedule(String messageBloc) {
    final int blocSize = messageBloc.codeUnits.length;
    final List<int> _schedule = <int>[];

    while (messageBloc.isNotEmpty) {
      final String _value = messageBloc.substring(0, min(32, messageBloc.codeUnits.length)).padLeft(32, '0');
      print('[${_schedule.length}] $_value');
      _schedule.add(int.parse(_value, radix: 2));
      messageBloc = messageBloc.replaceRange(0, min(32, messageBloc.codeUnits.length), '').trim();
    }

    print(_schedule.length);
    for (int i = 16; i <= 63; i++) {
      final int _value =
          (sigma1(_schedule[i - 2]) + _schedule[i - 7] + sigma0(_schedule[i - 15]) + _schedule[i - 16]) % (pow(2, 32));

      _schedule.add(_value);

      print('[${_schedule.length}] $_value');
    }

    return _schedule;
  }

  int getTemporaryWordFirst(int value) {
    int _usigmaOne = usigma1(shaModel.hashValue.initialHashValue[4]);
    int _choose = choice(shaModel.hashValue.initialHashValue[4], shaModel.hashValue.initialHashValue[5],
        shaModel.hashValue.initialHashValue[6]);

    return (_usigmaOne +
            _choose +
            shaModel.hashValue.initialHashValue[7] +
            shaModel.messageSchedule[value] +
            constants.constants[value]) %
        (pow(2, 32).round());
  }

  int getTemporaryWordSecond(int value) {
    int _usigmaZero = usigma0(shaModel.hashValue.initialHashValue[0]);
    int _majority = majority(shaModel.hashValue.initialHashValue[0], shaModel.hashValue.initialHashValue[1],
        shaModel.hashValue.initialHashValue[2]);

    return (_usigmaZero + _majority) % (pow(2, 32).round());
  }
}
