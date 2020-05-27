import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/hash/sha256.dart';
import 'package:sha256/utils/utils.dart';

class EndHashValue extends StatelessWidget {
  EndHashValue(this._value, this.input, this.initialHashValue, this.shaModel, {Key key}) : super(key: key);

  final double _value;
  final List<int> input;
  final List<int> initialHashValue;

  final Sha256 shaModel;

  @override
  Widget build(BuildContext context) {
    double _fontSize = 20.0 + (_value * 12.0);

    Size _originalSize = textSize('00000000',
        Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900, fontSize: _fontSize));
    Size _prefixSize = textSize('a = ',
        Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900, fontSize: _fontSize));

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: <Widget>[
          ...shaModel.shaModel.hashValue.calculatedHashValue.mapIndexed((int value, int index) {
            String _text;

            _text = ((value + shaModel.shaModel.hashValue.initialHashValue[index]) % pow(2, 32))
                .floor()
                .toRadixString(16)
                .padLeft(8, '0');

            return Positioned(
              top: MediaQuery.of(context).size.height * 0.1 +
                  24.0 +
                  textSize(
                          'Getting initial hash value',
                          Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: _fontSize))
                      .height +
                  index * _originalSize.height -
                  (index * _originalSize.height * _value) +
                  (_value * MediaQuery.of(context).size.height * 0.2),
              left: MediaQuery.of(context).size.width / 2 -
                  (_originalSize.width * 2) -
                  (_prefixSize.width / 2) +
                  (index * _originalSize.width * _value) -
                  (_originalSize.width * 2.5 * _value),
              child: Row(
                children: [
                  Opacity(
                    opacity: map(min(0.4, _value), 0.0, 0.4, 1.0, 0.0),
                    child: Text(
                      '${['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'][index]} = ',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: _fontSize),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Text(
                    '$_text',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: _fontSize),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            );
          }).toList(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width / 2 - (_originalSize.width * 2) - (_prefixSize.width / 2),
            child: Opacity(
              opacity: map(min(0.4, _value), 0.0, 0.4, 0.0, 1.0),
              child: Text(
                '\"${shaModel.shaModel.input}\" hashes to:',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: _fontSize),
                textAlign: TextAlign.start,
              ),
            ),
          )
        ],
      ),
    );
  }
}
