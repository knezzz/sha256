import 'dart:math';

import 'package:sha256/hash/functions.dart';
import 'package:sha256/hash/model.dart';

class Sha256 {
  ShaMessage shaModel = ShaMessage.empty();

  Sha256(String message) {
    final DateTime _start = DateTime.now();

    print('Hashing message: $message');
    shaModel = shaModel.copyWith(input: message);

    print('Message to bytes:');
    shaModel = shaModel.copyWith(bytes: toBytes(message));

    print('Byte array to binary:');
    shaModel = shaModel.copyWith(message: bytesListToBinary());

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

    print('Done in: ${DateTime.now().difference(_start).inMilliseconds}');

    getTemporaryWordFirst(0);
    getTemporaryWordSecond(0);
  }

  List<int> toBytes(String message) {
    final List<int> _bytes = message.codeUnits;

    print('Bytes: $_bytes');
    return _bytes;
  }

  List<String> bytesListToBinary() {
    final List<String> _message = shaModel.bytes.map((int i) => i.toRadixString(2)).toList();

    print('Binary: $_message');

    return _message;
  }

  String foldBinaryArray() {
    final String _foldedMessage =
        shaModel.message.fold(StringBuffer(), (StringBuffer sb, String s) => sb..write(s.padLeft(8, '0'))).toString();

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

  void getTemporaryWordFirst(int value) {
    int _usigmaOne = usigma1(shaModel.hashValue.initialHashValue[4]);
    int _choose = choice(shaModel.hashValue.initialHashValue[4], shaModel.hashValue.initialHashValue[5],
        shaModel.hashValue.initialHashValue[6]);

    print('T1');
    print(((_usigmaOne +
                _choose +
                shaModel.hashValue.initialHashValue[7] +
                shaModel.messageSchedule[value] +
                int.parse('01000010100010100010111110011000', radix: 2)) %
            (pow(2, 32).round()))
        .toRadixString(2)
        .padLeft(32, '0'));
  }

  void getTemporaryWordSecond(int value) {
    int _usigmaZero = usigma0(shaModel.hashValue.initialHashValue[0]);
    int _majority = majority(shaModel.hashValue.initialHashValue[0], shaModel.hashValue.initialHashValue[1],
        shaModel.hashValue.initialHashValue[2]);

    print('T2');
    print(((_usigmaZero + _majority) % (pow(2, 32).round())).toRadixString(2).padLeft(32, '0'));
  }
}
