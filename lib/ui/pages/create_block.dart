import 'dart:math';

import 'package:flutter/material.dart';

class CreateBlockPage extends StatelessWidget {
  CreateBlockPage(this._value, this.input, this.initialValue, {Key key}) : super(key: key);

  final double _value;
  final List<String> input;
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
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.19,
                    left: MediaQuery.of(context).size.width * 0.05 + 10,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w900, height: 1.05, fontSize: 24.0),
                        child: Text(
                          input.first,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
