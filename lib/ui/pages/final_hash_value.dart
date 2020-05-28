import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/hash/sha256.dart';
import 'package:sha256/utils/utils.dart';

class FinalHashValue extends StatelessWidget {
  FinalHashValue(this._value, this.input, this.initialHashValue, this.shaModel, {Key key}) : super(key: key);

  final double _value;
  final List<int> input;
  final List<int> initialHashValue;

  final Sha256 shaModel;

  @override
  Widget build(BuildContext context) {
    Size _originalSize =
        textSize('00000000', Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900));

    Size _mainSize = textSize('00000000',
        Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900, fontSize: 20.0));
    Size _prefixSize = textSize('a = ',
        Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900, fontSize: 20.0));

    Size _blockSize = textSize(''.padRight(32, '0'),
        Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 18.0));

    String _messageSchedule = input
        .fold(StringBuffer(), (StringBuffer sb, int value) => sb..writeln(value.toRadixString(2).padLeft(32, '0')))
        .toString();

    double _opacity = map(min(0.2, _value), 0.0, 0.2, 1.0, 0.0);

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: [
          ...shaModel.shaModel.hashValue.initialHashValue.mapIndexed((int value, int index) {
            String _text;
            _text = shaModel.shaModel.hashValue.calculatedHashValue[index].toRadixString(2).padLeft(32, '0');

            if (_value < 0.1) {
              _text = _text;
            } else if (_value < 0.2) {
              _text = _text + ' + ';
            } else if (_value < 0.4) {
              _text = _text + ' + ' + value.toRadixString(2).padLeft(32, '0');
            } else if (_value < 0.5) {
              _text = _text + ' + ' + value.toRadixString(2).padLeft(32, '0') + ' = ';
            } else if (_value < 0.8) {
              _text = ((value + shaModel.shaModel.hashValue.calculatedHashValue[index]) % pow(2, 32))
                  .floor()
                  .toRadixString(2)
                  .padLeft(32, '0');
            } else {
              _text = ((value + shaModel.shaModel.hashValue.calculatedHashValue[index]) % pow(2, 32))
                  .floor()
                  .toRadixString(16)
                  .padLeft(8, '0');
            }

            return Positioned(
              top: MediaQuery.of(context).size.height * 0.1 +
                  24.0 +
                  textSize(
                          'Getting initial hash value',
                          Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0))
                      .height +
                  index * _mainSize.height,
              left: MediaQuery.of(context).size.width / 2 -
                  (_mainSize.width * 2) -
                  (_prefixSize.width / 2) -
                  ((MediaQuery.of(context).size.width / 2 - (_mainSize.width * 2) - (_prefixSize.width / 2)) *
                      min(map(_value, 1.0, 0.0, 1.0, 0.0), map(_value, 1.0, 0.0, 0.0, 0.7))),
              child: Text(
                '${['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'][index]} = $_text',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                textAlign: TextAlign.start,
              ),
            );
          }).toList(),
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
                ],
              ),
            ),
          ),
          Opacity(
            opacity: _opacity,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * 0.4,
                  left: _originalSize.width * 0.2,
                  child: Text(
                    _messageSchedule,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 18.0),
                  ),
                ),
                Positioned(
                  top: -MediaQuery.of(context).size.height * 0.4 + (63 * _blockSize.height),
                  left: _originalSize.width * 0.2 + _blockSize.width,
                  child: Text(
                    '<-',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 18.0),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.5,
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
                          't = ${63}',
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
                          'T1 = Σ1(e) + Ch(e, f, g) + h + K[${63}] + W[${63}]',
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
                          'T1 = ${shaModel.shaModel.tempWord1[63].toRadixString(2).padLeft(32, '0')}',
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
                          'T2 = ${shaModel.shaModel.tempWord2[63].toRadixString(2).padLeft(32, '0')}',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
