import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/utils.dart';

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

    Size _oneCharSize =
        textSize('0', Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900)) * 0.95;

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
                paintCursorAboveText: true,
                scrollPhysics: NeverScrollableScrollPhysics(),
                focusNode: _node,
                cursorOpacityAnimates: true,
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                controller: _controller,
                style: Theme.of(context).textTheme.headline5.copyWith(height: 1.05, fontWeight: FontWeight.w900),
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
                children: <Widget>[
                  ..._controller.text.split('').mapIndexed((String s, int index) {
                    return Positioned(
                      top: MediaQuery.of(context).size.height * (0.5 - (_value * 0.3)) +
                          (index * 60.0 * min(1.0, _value)),
                      left: index * _oneCharSize.width - (index * _oneCharSize.width * min(1.0, _value)),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(height: 1.05, fontWeight: FontWeight.w900),
                              ),
                            ),
                            Positioned(
                              left:
                                  MediaQuery.of(context).size.width * 0.3 * (max(0.0, (min(1.0, _value) - 0.6)) / 0.4),
                              child: Container(
                                child: Opacity(
                                  opacity: max(0.0, (min(1.0, _value) - 0.6)) / 0.4,
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
                              left:
                                  MediaQuery.of(context).size.width * 0.6 * (max(0.0, (min(1.0, _value) - 0.6)) / 0.4),
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Opacity(
                                  opacity: max(0.0, (min(1.0, _value) - 0.6)) / 0.4,
                                  child: Text(
                                    s.codeUnits.first.toRadixString(2).padLeft(8, '0'),
                                    style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  Positioned(
                    top: MediaQuery.of(context).size.height * (0.5 - (_value * 0.3)) - 60.0,
                    width: MediaQuery.of(context).size.width,
                    height: 80.0,
                    child: Opacity(
                      opacity: max(0.0, (min(1.0, _value) - 0.8)) / 0.2,
                      child: Container(
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
                              left:
                                  MediaQuery.of(context).size.width * 0.3 * (max(0.0, (min(1.0, _value) - 0.6)) / 0.4),
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
                              left:
                                  MediaQuery.of(context).size.width * 0.6 * (max(0.0, (min(1.0, _value) - 0.6)) / 0.4),
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Binary',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(fontWeight: FontWeight.w900, fontSize: 16.0),
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
            ),
          ),
        )
      ],
    );
  }
}
