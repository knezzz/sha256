import 'dart:math';

import 'package:flutter/material.dart';

import '../../extensions.dart';

class FoldBinaryPage extends StatelessWidget {
  FoldBinaryPage(this._value, this.input, {Key key}) : super(key: key);

  final double _value;
  final String input;

  @override
  Widget build(BuildContext context) {
    print('Value:${_value.ceilToDouble()}');

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: input.split('').mapIndexed((String s, int index) {
          final int _foldAt = (MediaQuery.of(context).size.width / 96.0).floor();
          final double _difference = (MediaQuery.of(context).size.width - (96.0 * _foldAt));

          return Positioned(
            top: MediaQuery.of(context).size.height * 0.2 +
                (index * 60.0) -
                _value * (60.0 * index) +
                _value * (index ~/ (_foldAt - 1)) * 20.0,
            left: index * 11.5 - (index * 11.5),
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
                        ((1 * (index % (_foldAt - 1))) * (92.0 * -_value)) +
                        (_value * _difference * 2),
                    width: map(_value, 0, 1, MediaQuery.of(context).size.width * 0.35, 96.0),
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

num map(num value, [num iStart = 0, num iEnd = pi * 2, num oStart = 0, num oEnd = 1.0]) =>
    ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;
