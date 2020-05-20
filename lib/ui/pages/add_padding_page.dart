import 'dart:math';

import 'package:flutter/material.dart';

class AddPaddingPage extends StatelessWidget {
  AddPaddingPage(this._value, this.input, this.initialValue, {Key key}) : super(key: key);

  final double _value;
  final String input;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    final int size = initialValue.length * 8;
    final int k = (448 - size - 1) % 512;

    print('k is $k');

    final int _foldAt = (MediaQuery.of(context).size.width / 96.0).floor();
    final double _difference = (MediaQuery.of(context).size.width - (96.0 * _foldAt));

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2 + 1.5,
            left: _difference * 2 + 3.0,
            width: (_foldAt - 1) * 93.0,
            child: Container(
              alignment: Alignment.topCenter,
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
