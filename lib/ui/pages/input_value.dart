import 'dart:math';

import 'package:flutter/material.dart';

import '../../extensions.dart';

class InputValuePage extends StatelessWidget {
  InputValuePage(this._value, this._controller, {Key key}) : super(key: key);

  final TextEditingController _controller;
  final double _value;
  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (_value == 0.0) {
      _node.requestFocus();
    }

    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          child: Opacity(
            opacity: 1 - min(1.0, _value.ceilToDouble()),
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: EditableText(
                cursorWidth: 16.0,
                scrollPhysics: NeverScrollableScrollPhysics(),
                focusNode: _node,
                controller: _controller,
                style: Theme.of(context).textTheme.headline5,
                cursorColor: Theme.of(context).cursorColor,
                backgroundCursorColor: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
        Opacity(
          opacity: min(1.0, _value.ceilToDouble()),
          child: Container(
            child: Center(
              child: Stack(
                children: _controller.text.split('').mapIndexed((String s, int index) {
                  return Positioned(
                    top: MediaQuery.of(context).size.height * (0.5 - (_value * 0.35)) +
                        (index * 60.0 * min(1.0, _value)),
                    left: index * 11.5 - (index * 11.5 * min(1.0, _value)),
                    width: MediaQuery.of(context).size.width,
                    height: 80.0,
                    child: Container(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.05,
                            child: Text(
                              s,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.3 * (max(0.0, (min(1.0, _value) - 0.6)) / 0.4),
                            child: Container(
                              child: Opacity(
                                opacity: max(0.0, (min(1.0, _value) - 0.6)) / 0.4,
                                child: Text(
                                  s.codeUnits.first.toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.6 * (max(0.0, (min(1.0, _value) - 0.6)) / 0.4),
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Opacity(
                                opacity: max(0.0, (min(1.0, _value) - 0.6)) / 0.4,
                                child: Text(
                                  s.codeUnits.first.toRadixString(2),
                                  style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w900),
                                ),
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
