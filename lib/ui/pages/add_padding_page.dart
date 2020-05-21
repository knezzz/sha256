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
            top: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: _value,
              child: Center(
                child: Text(
                  'Adding $k bits of padding. Message has to be 512 bits',
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
