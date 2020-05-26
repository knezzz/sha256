import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/utils/utils.dart';

class InitialHashValue extends StatelessWidget {
  InitialHashValue(this._value, this.input, this.initialValue, this.initialHashValue, {Key key}) : super(key: key);

  final double _value;
  final List<int> input;
  final List<int> initialHashValue;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    Size _originalSize =
        textSize('00000000', Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900));

    Size _mySize = textSize('00000000',
        Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900, fontSize: 20.0));

    String _messageSchedule = input
        .fold(StringBuffer(), (StringBuffer sb, int value) => sb..writeln(value.toRadixString(2).padLeft(32, '0')))
        .toString();

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2 - MediaQuery.of(context).size.height * 0.1,
            left: _originalSize.width * 0.2,
            child: Text(
              _messageSchedule,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 14.0),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Opacity(
                opacity: map(min(0.1, _value), 0.0, 0.1, 0.0, 1.0),
                child: Column(
                  children: [
                    Text('Getting initial hash value',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0)),
                    SizedBox(
                      height: 24.0,
                    ),
                    ...initialHashValue.mapIndexed((int value, int index) {
                      String _text;

                      if (_value <= 0.15) {
                        _text = '√' + [2, 3, 5, 7, 11, 13, 17, 19][index].toString();
                      } else if (_value <= 0.3) {
                        _text = sqrt([2, 3, 5, 7, 11, 13, 17, 19][index]).toStringAsPrecision(10);
                      } else if (_value <= 0.45) {
                        _text = (sqrt([2, 3, 5, 7, 11, 13, 17, 19][index]) % 1).toStringAsPrecision(9);
                      } else if (_value <= 0.6) {
                        _text = (sqrt([2, 3, 5, 7, 11, 13, 17, 19][index]) % 1).toStringAsPrecision(9) + ' * 2 ^ 32';
                      } else if (_value <= 0.75) {
                        _text = value.toString();
                      } else {
                        _text = value.toRadixString(2).padRight(32, '0');
                      }

                      _text = _text.padRight(32);

                      return Text(
                        '${['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'][index]} = $_text',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                        textAlign: TextAlign.start,
                      );
                    }).toList()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
