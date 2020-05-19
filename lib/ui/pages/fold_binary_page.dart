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

    return Stack(
      children: <Widget>[
        Opacity(
          opacity: min(1.0, _value.ceilToDouble()),
          child: Container(
            child: Center(
              child: Stack(
                children: input.split('').mapIndexed((String s, int index) {
                  return Positioned(
                    top: MediaQuery.of(context).size.height * 0.15 + (index * (60.0 - (36 * _value))),
                    left: index * 11.5 - (index * 11.5),
                    width: MediaQuery.of(context).size.width,
                    height: 80.0,
                    child: Container(
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
                            left: MediaQuery.of(context).size.width * 0.6 -
                                (MediaQuery.of(context).size.width * 0.35 * _value),
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                s.codeUnits.first.toRadixString(2),
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
            ),
          ),
        )
      ],
    );
  }
}
