import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class AddPaddingPage extends StatelessWidget {
  AddPaddingPage(this._value, this.input, this.initialValue, {Key key}) : super(key: key);

  final double _value;
  final String input;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    final int size = initialValue.length * 8;
    final int k = (448 - size - 1) % 512;

    Size _size = textSize('00000000',
        Theme.of(context).textTheme.headline5.copyWith(fontSize: 24.0, height: 1.05, fontWeight: FontWeight.w900));

    final int _foldAt = (MediaQuery.of(context).size.width / _size.width).round();

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: kBottomNavigationBarHeight / 2,
            width: MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: map(min(1.0, _value + 0.6), 0.6, 1.0, 0.0, 1.0),
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                child: Center(
                  child: Text(
                    'This method of separating the message with a 1 and including the message size (64bit) in the padding is known as Merkle–Damgård strengthening (MD strengthening)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w300, height: 1.05, fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: map(min(1.0, _value + 0.8), 0.8, 1.0, 0.0, 1.0),
              child: Center(
                child: Text(
                  'Padding: ${initialValue.length * 8} + ${_substring() - initialValue.length * 8} = ${_substring()} bits',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 24.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: _size.width * 0.2,
            width: _size.width * _foldAt * MediaQuery.of(context).textScaleFactor,
            child: Container(
              alignment: Alignment.topLeft,
              child: DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 24.0),
                child: Text(
                  input.substring(0, _substring()),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  int _substring() {
    if (_value > 0.9) {
      return input.length;
    }

    if (_value > 0.7) {
      return input.length - 64;
    }

    if (_value > 0.4) {
      return initialValue.length * 8 +
          ((input.length - 64 - (initialValue.length * 8)) * map(_value, 0.4, 0.7, 0.0, 1.0)).toInt();
    }

    if (_value > 0.1) {
      return initialValue.length * 8 + 1;
    }

    return initialValue.length * 8;
  }
}
