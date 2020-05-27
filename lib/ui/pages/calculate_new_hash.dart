import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/hash/functions.dart';
import 'package:sha256/hash/sha256.dart';
import 'package:sha256/utils/utils.dart';

class CalculateNewHash extends StatelessWidget {
  CalculateNewHash(this._value, this.input, this.initialHashValue, this.shaModel, {Key key}) : super(key: key);

  final double _value;
  final List<int> input;
  final List<int> initialHashValue;

  final Sha256 shaModel;

  List<int> _getAtStep(double progress) {
    final List<int> _newHash = List<int>.of(shaModel.shaModel.hashValue.initialHashValue);

    List<int>.generate((64 * progress).floor(), (int i) => i).forEach((int i) {
      final int _firstTemp = getTemporaryWordFirstHelper(shaModel, i, _newHash);
      final int _secondTemp = getTemporaryWordSecondHelper(i, _newHash);

      _newHash.insert(0, 0);
      _newHash[0] = (_firstTemp + _secondTemp) % pow(2, 32);
      _newHash[4] = (_newHash[4] + _firstTemp) % pow(2, 32);
      _newHash.removeLast();
    });

    return _newHash;
  }

  @override
  Widget build(BuildContext context) {
    Size _originalSize =
        textSize('00000000', Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900));
    Size _blockSize = textSize(''.padRight(32, '0'),
        Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 14.0));

    String _messageSchedule = input
        .fold(StringBuffer(), (StringBuffer sb, int value) => sb..writeln(value.toRadixString(2).padLeft(32, '0')))
        .toString();

    double _miniProgress = map(_value, 0.0, _value / 64, 0.0, 1.0) % 1.0;

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: _originalSize.width * 0.2,
            child: Text(
              _messageSchedule,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 14.0),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1 + ((_value * 63) * _blockSize.height),
            left: _originalSize.width * 0.2 + _blockSize.width,
            child: Text(
              '<-',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 14.0),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Temporary variables',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0)),
                  SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    't = ${(_value * 63).floor()}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'T1 = Σ1(e) + Ch(e, f, g) + h + K[${(_value * 63).floor()}] + W[${(_value * 63).floor()}]',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'T2 = Σ0(a) + Maj(a, b, c)',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 36.0,
                  ),
                  Text(
                    'T1 = ${shaModel.shaModel.tempWord1[(_value * 63).floor()].toRadixString(2).padLeft(32, '0')}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'T2 = ${shaModel.shaModel.tempWord2[(_value * 63).floor()].toRadixString(2).padLeft(32, '0')}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: [
                  Text('Getting initial hash value',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0)),
                  SizedBox(
                    height: 24.0,
                  ),
                  ..._getAtStep(_value).mapIndexed((int value, int index) {
                    String _text;

                    if (_miniProgress > 0.5 && index == 0) {
                      _text = ''.padLeft(32);
                    } else {
                      _text = value.toRadixString(2).padLeft(32, '0');
                    }

                    return Text(
                      '${['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'][index]} = $_text',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                      textAlign: TextAlign.start,
                    );
                  }).toList()
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1 +
                24.0 +
                textSize(
                        'Getting initial hash value',
                        Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0))
                    .height,
            width: MediaQuery.of(context).size.width + _originalSize.width * 5,
            child: Center(
              child: Column(
                children: initialHashValue.mapIndexed((int value, int index) {
                  String _text = '';

                  if (_miniProgress > 0.5) {
                    _text += ' ↓';
                  }

                  return Text(
                    '$_text',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                    textAlign: TextAlign.start,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

int getTemporaryWordFirstHelper(Sha256 model, int value, List<int> list) {
  int _usigmaOne = usigma1(list[4]);
  int _choose = choice(list[4], list[5], list[6]);

  return (_usigmaOne + _choose + list[7] + model.shaModel.messageSchedule[value] + model.constants.constants[value]) %
      (pow(2, 32).round());
}

int getTemporaryWordSecondHelper(int value, List<int> list) {
  int _usigmaZero = usigma0(list[0]);
  int _majority = majority(list[0], list[1], list[2]);

  return (_usigmaZero + _majority) % (pow(2, 32).round());
}
