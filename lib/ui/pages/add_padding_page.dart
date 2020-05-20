import 'dart:math';

import 'package:flutter/material.dart';

import '../../extensions.dart';

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
        Theme.of(context).textTheme.headline5.copyWith(fontSize: 24.0, height: 1.0, fontWeight: FontWeight.w900));

    final double _foldAt = (MediaQuery.of(context).size.width / _size.width).ceilToDouble();

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2 + 1.5,
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
                  input.substring(
                      0, initialValue.length * 8 + ((input.length - (initialValue.length * 8)) * _value).toInt()),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
