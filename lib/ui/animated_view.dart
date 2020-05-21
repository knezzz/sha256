import 'package:flutter/material.dart';
import 'package:sha256/ui/pages/add_padding_page.dart';
import 'package:sha256/ui/pages/create_block.dart';
import 'package:sha256/ui/pages/create_message_for_block.dart';
import 'package:sha256/ui/pages/fold_binary_page.dart';
import 'package:sha256/ui/pages/input_value.dart';

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
    'Initial hash value'
  ];
  Sha256 _sha256 = Sha256('abc');

  TextEditingController _controller;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _pageController = PageController(initialPage: 0);

    _controller.addListener(() {
      _sha256 = Sha256(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return InputValuePage(_value, _controller);
              } else if (_value <= 2.0) {
                return FoldBinaryPage(_value - 1, _controller.text);
              } else if (_value <= 3.0) {
                return AddPaddingPage(_value - 2, _sha256.shaModel.paddedMessage, _controller.text);
              } else if (_value <= 4.0) {
                return CreateBlockPage(_value - 3, _sha256.shaModel.messageBlocs, _controller.text);
              } else if (_value <= 5.0) {
                return CreateMessageForBlock(_value - 4, _sha256.shaModel.messageSchedule, _controller.text);
              } else {
                return Container(
                  child: SizedBox.shrink(),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              _pageController.previousPage(duration: Duration(seconds: 2), curve: Curves.easeInOut);
            },
          ),
          FloatingActionButton(
            onPressed: () {
              _pageController.nextPage(duration: Duration(seconds: 2), curve: Curves.easeInOut);
            },
          ),
        ],
      ),
    );
  }
}
