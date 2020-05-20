import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/extensions.dart';

class CreateMessageForBlock extends StatelessWidget {
  CreateMessageForBlock(this._value, this.input, this.initialValue, {Key key}) : super(key: key);

  final double _value;
  final List<int> input;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
//    print('Value:${_value.ceilToDouble()}');

    final int _foldAt = (MediaQuery.of(context).size.width / 96.0).floor();
    final double _difference = (MediaQuery.of(context).size.width - (96.0 * _foldAt));

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: <Widget>[
          ...input.getRange(0, 16 + (48 * _value).round()).mapIndexed((int e, int index) {
            return Positioned(
              top: MediaQuery.of(context).size.height * 0.2 +
                  1.5 +
                  index * 10.0 -
                  (_value * MediaQuery.of(context).size.height * 0.05),
              left: _difference + 3.0,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(e.toRadixString(2).padLeft(32, '0'),
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 12.0)),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
