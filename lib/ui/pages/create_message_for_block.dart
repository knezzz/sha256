import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/utils/utils.dart';

class CreateMessageForBlock extends StatelessWidget {
  CreateMessageForBlock(this._value, this.input, this.initialValue, {Key key}) : super(key: key);

  final double _value;
  final List<int> input;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
//    print('Value:${_value.ceilToDouble()}');

    Size _size = textSize('00000000',
        Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontSize: 12.0, fontWeight: FontWeight.w900));

    Size _originalSize =
        textSize('00000000', Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900));

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: <Widget>[
          ...input.getRange(0, 16 + (48 * _value).round()).mapIndexed((int e, int index) {
            return Positioned(
              top: MediaQuery.of(context).size.height * 0.2 +
                  index * _size.height -
                  (_value * MediaQuery.of(context).size.height * 0.05),
              left: _originalSize.width * 0.2,
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
