import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/extensions.dart';

class CreateBlockPage extends StatelessWidget {
  CreateBlockPage(this._value, this.input, this.initialValue, {Key key}) : super(key: key);

  final double _value;
  final List<String> input;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
//    print('Value:${_value.ceilToDouble()}');

    final int _foldAt = 8;
    final double _difference = (MediaQuery.of(context).size.width - (27.0 * _foldAt));

    final int _originalFoldAt = (MediaQuery.of(context).size.width / 96.0).floor();
    final double _originalDifference = (MediaQuery.of(context).size.width - (96.0 * _originalFoldAt));

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: input.mapIndexed((String e, int index) {
          return Positioned(
            top: MediaQuery.of(context).size.height * 0.2 + 1.5,
            left: _originalDifference * 2 + 3.0 - (_value * _originalDifference),
            width: (map(_value, 1, 0, _foldAt, _originalFoldAt) - 1) * map(_value, 1, 0, 27.0, 93.0),
            child: Container(
              alignment: Alignment.centerRight,
              child: DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 24.0 - (12 * _value)),
                child: Text(e),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

num map(num value, [num iStart = 0, num iEnd = pi * 2, num oStart = 0, num oEnd = 1.0]) =>
    ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;
