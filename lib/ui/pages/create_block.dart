import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/utils/utils.dart';

class CreateBlockPage extends StatelessWidget {
  CreateBlockPage(this._value, this.input, this.initialValue, {Key key}) : super(key: key);

  final double _value;
  final List<String> input;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    final int _foldAt = 4;

    Size _sizeBig = textSize('00000000',
        Theme.of(context).textTheme.headline5.copyWith(fontSize: 24.0, height: 1.05, fontWeight: FontWeight.w900));
    Size _sizeSmall = textSize('00000000',
        Theme.of(context).textTheme.headline5.copyWith(fontSize: 12.0, height: 1.05, fontWeight: FontWeight.w900));

    final int _originalFoldAt = ((MediaQuery.of(context).size.width - (_sizeBig.width * 0.4)) / _sizeBig.width).floor();

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: input.mapIndexed((String e, int index) {
          return Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: _sizeBig.width * 0.2,
            width: map(_value, 0, 1, _sizeBig.width * _originalFoldAt, _sizeSmall.width * _foldAt),
            child: Container(
              alignment: Alignment.centerRight,
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                    fontSize: _value < 0.4 ? 24.0 : map(_value, 0.4, 1.0, 24.0, 12.0)),
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
