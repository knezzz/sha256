import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class FoldBinaryPage extends StatelessWidget {
  FoldBinaryPage(this._value, this.input, {Key key}) : super(key: key);

  final double _value;
  final String input;

  @override
  Widget build(BuildContext context) {
    Size _size =
        textSize('00000000', Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900));

    return Opacity(
      opacity: min(1.0, _value.ceilToDouble()),
      child: Stack(
        children: <Widget>[
          ...input.split('').mapIndexed((String s, int index) {
            final int _foldAt = (MediaQuery.of(context).size.width / _size.width).round();

            return Positioned(
              top: MediaQuery.of(context).size.height * 0.2 +
                  (index * 60.0) -
                  _value * (60.0 * index) +
                  _value * (index ~/ _foldAt) * _size.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 80.0 - (_value * (80.0 - _size.height)),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.05,
                      child: Opacity(
                        opacity: 1 - max(0.0, (min(1.0, _value * 3))),
                        child: Text(
                          s,
                          style:
                              Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900),
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
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(height: 1.05, fontWeight: FontWeight.w900, color: Colors.white60),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.6 * (1 - _value) +
                          ((index % _foldAt) *
                              ((_size.width - 0.75) * MediaQuery.of(context).textScaleFactor) *
                              _value) +
                          _size.width * 0.2 * _value,
                      width: map(_value, 0, 1, MediaQuery.of(context).size.width * 0.35, _size.width),
                      child: Container(
                        alignment: Alignment(1 - _value * 2, 0.0),
                        child: Text(
                          s.codeUnits.first.toRadixString(2).padLeft(8, '0'),
                          style:
                              Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2 - 60.0,
            width: MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: 1 - max(0.0, (min(1.0, _value * 3))),
              child: Container(
                height: 80.0 - (_value * (80.0 - _size.height)),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.05,
                      child: Text(
                        'Character',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(height: 1.05, fontWeight: FontWeight.w900, fontSize: 16.0),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.3,
                      child: Container(
                        child: Text(
                          'ASCII code',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(height: 1.05, fontWeight: FontWeight.w900, fontSize: 16.0),
                        ),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.6 * (1 - _value) + _size.width * 0.2 * _value,
                      width: map(_value, 0, 1, MediaQuery.of(context).size.width * 0.35, _size.width),
                      child: Container(
                        alignment: Alignment(1 - _value * 2, 0.0),
                        child: Text(
                          'Binary',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(height: 1.05, fontWeight: FontWeight.w900, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
