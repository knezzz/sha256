import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sha256/ui/pages/add_padding_page.dart';
import 'package:sha256/ui/pages/calculate_new_hash.dart';
import 'package:sha256/ui/pages/create_block.dart';
import 'package:sha256/ui/pages/create_message_for_block.dart';
import 'package:sha256/ui/pages/end_hash_value.dart';
import 'package:sha256/ui/pages/final_hash_value.dart';
import 'package:sha256/ui/pages/fold_binary_page.dart';
import 'package:sha256/ui/pages/initial_hash_value.dart';
import 'package:sha256/ui/pages/input_value.dart';
import 'package:sha256/ui/pages/update_hash_value.dart';
import 'package:sha256/utils/utils.dart';

import '../hash/sha256.dart';

class AnimatedScreen extends StatefulWidget {
  AnimatedScreen({Key key}) : super(key: key);

  @override
  _AnimatedScreenState createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  List<String> _steps = <String>[
    'Input value',
    'Parsed input',
    'Folded value',
    'Add padding',
    'Cut into message blocks',
    'Create message schedule for each block',
    'Initial hash value',
    'Update hash value',
    'Calculate hash value',
    'Add hash value',
    'End hash value',
  ];
  String _initialHashValue = 'abc';

  Sha256 _sha256 = Sha256.init();

  TextEditingController _controller;
  PageController _pageController;

  List<int> _animationSpeeds = <int>[0, 2750, 7500, 15000, 30000, 60000];

  int _currentAnimationSpeed = 0;

  int _page = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _initialHashValue);

    _pageController = PageController(initialPage: 0, viewportFraction: 0.6);

    _pageController.addListener(() {
      if (mounted) {
        setState(() {
          _page = _pageController.page.round();
        });
      }
    });

    _controller.addListener(() {
      if (_sha256.shaModel.input == _controller.text) {
        return;
      }

      setState(() {
        _sha256 = Sha256(_controller.text);
        _animationSpeeds[0] = _sha256.timeToComplete.inMicroseconds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemCount: _steps.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(36.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _steps[index],
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _pageController,
            builder: (BuildContext context, Widget widget) {
              double _value = _pageController?.page ?? 0.0;

              if (_value <= 1.0) {
                return Stack(
                  children: [
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: Opacity(
                        opacity: map(min(1.0, _value + 0.8), 0.8, 1.0, 1.0, 0.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              Text(
                                'Animation speed:',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headline5.copyWith(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 26.0,
                                      color: Theme.of(context).accentColor,
                                    ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: _animationSpeeds.mapIndexed((int i, int index) {
                                  if (index == _currentAnimationSpeed) {
                                    return RaisedButton(
                                      color: Theme.of(context).accentColor,
                                      shape: RoundedRectangleBorder(),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '$i ms',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.button.copyWith(
                                                color: Theme.of(context).scaffoldBackgroundColor,
                                              ),
                                        ),
                                      ),
                                    );
                                  }

                                  return OutlineButton(
                                    borderSide: BorderSide(width: 1.0, color: Theme.of(context).accentColor),
                                    shape: RoundedRectangleBorder(),
                                    onPressed: () {
                                      setState(() {
                                        _currentAnimationSpeed = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '$i ms',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.button.copyWith(
                                              color: Theme.of(context).accentColor,
                                            ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.125,
                      child: Opacity(
                        opacity: map(min(1.0, _value + 0.8), 0.8, 1.0, 1.0, 0.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '   ↑\n\n1000x slower than real-time',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline5.copyWith(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 16.0,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InputValuePage(
                      _value,
                      _controller,
                      timeToComplete: _sha256?.timeToComplete ?? Duration.zero,
                    ),
                  ],
                );
              } else if (_value <= 2.0) {
                return FoldBinaryPage(_value - 1, _controller.text);
              } else if (_value <= 3.0) {
                return AddPaddingPage(_value - 2, _sha256.shaModel.paddedMessage, _controller.text);
              } else if (_value <= 4.0) {
                return CreateBlockPage(_value - 3, _sha256.shaModel.messageBlocs, _controller.text);
              } else if (_value <= 5.0) {
                return CreateMessageForBlock(_value - 4, _sha256.shaModel.messageSchedule, _controller.text);
              } else if (_value <= 6.0) {
                return InitialHashValue(_value - 5, _sha256.shaModel.messageSchedule, _controller.text,
                    _sha256.shaModel.hashValue.initialHashValue);
              } else if (_value <= 7.0) {
                return UpdateHashValue(
                    _value - 6, _sha256.shaModel.messageSchedule, _sha256.shaModel.hashValue.initialHashValue, _sha256);
              } else if (_value <= 8.0) {
                return CalculateNewHash(
                    _value - 7, _sha256.shaModel.messageSchedule, _sha256.shaModel.hashValue.initialHashValue, _sha256);
              } else if (_value <= 9.0) {
                return FinalHashValue(
                    _value - 8, _sha256.shaModel.messageSchedule, _sha256.shaModel.hashValue.initialHashValue, _sha256);
              } else if (_value <= 10.0) {
                return EndHashValue(
                    _value - 9, _sha256.shaModel.messageSchedule, _sha256.shaModel.hashValue.initialHashValue, _sha256);
              } else {
                return Container(
                  child: SizedBox.shrink(),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _animateToPage,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).cursorColor,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.input), title: Text('Input')),
          BottomNavigationBarItem(icon: Icon(Icons.compare), title: Text('Parsed value')),
          BottomNavigationBarItem(icon: Icon(Icons.unfold_less), title: Text('Folded value')),
          BottomNavigationBarItem(icon: Icon(Icons.space_bar), title: Text('Padding')),
          BottomNavigationBarItem(icon: Icon(Icons.content_cut), title: Text('Cut in message blocks')),
          BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('Create message schedule')),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), title: Text('Initial hash value')),
          BottomNavigationBarItem(icon: Icon(Icons.update), title: Text('Update hash value')),
          BottomNavigationBarItem(icon: Icon(Icons.laptop_chromebook), title: Text('Calculate hash value')),
          BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('Add hash value')),
          BottomNavigationBarItem(icon: Icon(Icons.done), title: Text('End hash value')),
        ],
      ),
    );
  }

  void _animateToPage(int page) async {
    int _pages = (_page - page).abs();

    double _speed = (_animationSpeeds[_currentAnimationSpeed] / _steps.length).ceilToDouble();

    _pageController.animateToPage(page,
        duration: Duration(milliseconds: (_pages * _speed).ceil()), curve: Curves.linear);
  }
}
