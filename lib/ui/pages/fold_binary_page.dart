import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../extensions.dart';

class FoldBinaryPage extends StatelessWidget {
  FoldBinaryPage(this._value, this.input, {Key key}) : super(key: key);

  final double _value;
  final String input;

  @override
  Widget build(BuildContext context) {
    print('Value:${_value.ceilToDouble()}');

    Size _size =
        textSize('00000000', Theme.of(context).textTheme.headline5.copyWith(height: .84, fontWeight: FontWeight.w900));
    print(_size);

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: input.split('').mapIndexed((String s, int index) {
          final int _foldAt = (MediaQuery.of(context).size.width / _size.width).round();

          return Positioned(
            top: MediaQuery.of(context).size.height * 0.2 +
                (index * 60.0) -
                _value * (60.0 * index) +
                _value * (index ~/ _foldAt) * _size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: 80.0 - (_value * 60.0),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: Opacity(
                      opacity: 1 - max(0.0, (min(1.0, _value * 3))),
                      child: Text(
                        s,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.3,
                    child: Container(
                      child: Opacity(
                        opacity: 1 - max(0.0, (min(1.0, _value * 3))),
                        child: Text(
                          s.codeUnits.first.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.6 * (1 - _value) -
                        ((1 * (index % _foldAt)) * (_size.width - 0.75) * -_value) *
                            MediaQuery.of(context).textScaleFactor,
                    width: map(_value, 0, 1, MediaQuery.of(context).size.width * 0.35, _size.width),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        s.codeUnits.first.toRadixString(2).padLeft(8, '0'),
                        style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
