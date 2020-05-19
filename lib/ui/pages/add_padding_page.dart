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
//    print('Value:${_value.ceilToDouble()}');

    return Stack(
      children: <Widget>[
        Opacity(
          opacity: min(1.0, _value.ceilToDouble()),
          child: Container(
            child: Center(
              child: Stack(
                children: <Widget>[
                  ...initialValue.split('').mapIndexed((String s, int index) {
                    return Positioned(
                      top: MediaQuery.of(context).size.height * 0.15 + (index ~/ 4) * 20.0,
                      left: index * 11.5 - (index * 11.5),
                      width: MediaQuery.of(context).size.width,
                      height: 80.0,
                      child: Container(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Positioned(
                              left: -((1 * (index % 4)) * (MediaQuery.of(context).size.width * 0.224 * -1.0)) -
                                  (MediaQuery.of(context).size.width * 0.05),
                              width: MediaQuery.of(context).size.width * 0.35,
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
                  ...List<int>.generate((_value * (64 - initialValue.codeUnits.length)).toInt(), (int index) => index)
                      .map<Widget>((int s) {
                    int index = initialValue.length + s;

                    return Positioned(
                      top: MediaQuery.of(context).size.height * 0.15 + (index ~/ 4) * 20.0,
                      left: index * 11.5 - (index * 11.5),
                      width: MediaQuery.of(context).size.width,
                      height: 80.0,
                      child: Container(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Positioned(
                              left: -((1 * (index % 4)) * (MediaQuery.of(context).size.width * 0.224 * -1.0)) -
                                  (MediaQuery.of(context).size.width * 0.05),
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  input
                                      .split('')
                                      .getRange(index * 8, index * 8 + 8)
                                      .fold(StringBuffer(), (StringBuffer buffer, String s) => buffer..write(s))
                                      .toString(),
                                  style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
