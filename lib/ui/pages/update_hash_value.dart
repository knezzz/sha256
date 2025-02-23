import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/hash/sha256.dart';
import 'package:sha256/utils/utils.dart';

class UpdateHashValue extends StatelessWidget {
  UpdateHashValue(this._value, this.input, this.initialHashValue, this.shaModel, {Key key}) : super(key: key);

  final double _value;
  final List<int> input;
  final List<int> initialHashValue;

  final Sha256 shaModel;

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
            top: MediaQuery.of(context).size.height * 0.1,
            left: _originalSize.width * 0.2,
            child: Text(
              _messageSchedule,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 18.0),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: map(max(0.0, min(0.2, _value - 0.2)), 0.0, 0.2, 0.0, 1.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Temporary variables',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0)),
                    SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      't = ',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'T1 = Σ1(e) + Ch(e, f, g) + h + K[t] + W[t]',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'T2 = Σ0(a) + Maj(a, b, c)',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 36.0,
                    ),
                    Text(
                      'T1 = ',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'T2 = ',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 20.0),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Center(
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

                    _text = value.toRadixString(2).padLeft(32, '0');

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
        ],
      ),
    );
  }
}
