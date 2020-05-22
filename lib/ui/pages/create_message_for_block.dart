import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/hash/functions.dart';
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
        Theme.of(context).textTheme.headline5.copyWith(height: 1.0, fontSize: 16.0, fontWeight: FontWeight.w900));

    Size _originalSize =
        textSize('00000000', Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900));

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: <Widget>[
          ...input
              .getRange(0, 16 + min(48, (48 * _value).round() + (_value > 0.0 ? 1 : 0)))
              .mapIndexed((int e, int index) {
            int _current = 16 + (48 * _value).round();

            String _getString() {
              if (_current >= input.length) {
                return '';
              }

              StringBuffer _sb = StringBuffer();

              if ((_current - 2) == index ||
                  (_current - 7) == index ||
                  (_current - 15) == index ||
                  (_current - 16) == index) {
                _sb.write(' -->');

                if ((_current - 15) == index) {
                  _sb.write(' σ0 ${sigma0(e).toRadixString(2).padLeft(32, '0')}');
                } else if ((_current - 2) == index) {
                  _sb.write(' σ1 ${sigma1(e).toRadixString(2).padLeft(32, '0')}');
                } else {
                  _sb.write('${e.toRadixString(2).padLeft(32, '0').padLeft(36)}');
                }
              }

              if (_current == index) {
                _sb.write(' = σ1(t-2) + (t-7) + σ0(t-15) + (t-16)');
              }

              return _sb.toString();
            }

            return Positioned(
              top: MediaQuery.of(context).size.height * 0.2 +
                  index * _size.height -
                  (_value * MediaQuery.of(context).size.height * 0.1),
              left: _originalSize.width * 0.2,
              child: Row(
                children: [
                  Text(e.toRadixString(2).padLeft(32, '0'),
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 16.0)),
                  Text(_getString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w300, height: 1.05, fontSize: 18.0)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
