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

  int _page = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _pageController = PageController(initialPage: 0);

    _pageController.addListener(() {
      if (mounted) {
        setState(() {
          _page = _pageController.page.round();
        });
      }
    });

    _controller.addListener(() {
      _sha256 = Sha256(_controller.text);
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          _pageController.animateToPage(value, duration: Duration(seconds: 3), curve: Curves.easeInOut);
        },
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).cursorColor,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.input), title: Text('Input')),
          BottomNavigationBarItem(icon: Icon(Icons.update), title: Text('Parsed value')),
          BottomNavigationBarItem(icon: Icon(Icons.unfold_less), title: Text('Folded value')),
          BottomNavigationBarItem(icon: Icon(Icons.space_bar), title: Text('Padding')),
          BottomNavigationBarItem(icon: Icon(Icons.content_cut), title: Text('Cut in message blocks')),
          BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('Create message schedule')),
        ],
      ),
    );
  }
}
