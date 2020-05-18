import 'package:flutter/material.dart';
import 'package:sha256/hash/sha256.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'abc');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: _steps.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _steps[index],
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Expanded(
                  child: _getInput(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _sha256 = Sha256(_controller.text);
          });
        },
      ),
    );
  }

  Widget _inputText(String value) {
    return Text(
      value,
      style: Theme.of(context).textTheme.subtitle1,
      textAlign: TextAlign.center,
    );
  }

  Widget _getInput(int index) {
    if (index == 0) {
      return TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Value',
        ),
      );
    }

    if (index == 1) {
      return ListView.separated(
        itemCount: _sha256.shaModel.input.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                _sha256.shaModel.input.split('')[index],
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              Text(
                _sha256.shaModel.bytes[index].toString(),
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              Text(
                _sha256.shaModel.message[index].padLeft(8, '0'),
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      );
    }

    if (index == 2) {
      return _inputText(_sha256.shaModel.foldedMessage.toString());
    }

    if (index == 3) {
      return _inputText(_sha256.shaModel.paddedMessage.toString());
    }

    if (index == 4) {
      return ListView.separated(
        itemCount: _sha256.shaModel.messageBlocs.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('[${index}${']'}'),
              Flexible(child: Text('[${_sha256.shaModel.messageBlocs[index].padLeft(32, '0')}]')),
            ],
          );
        },
      );
    }

    if (index == 5) {
      return ListView.separated(
        itemCount: _sha256.shaModel.messageSchedule.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('W$index'),
              Flexible(child: Text('${_sha256.shaModel.messageSchedule[index].toRadixString(2).padLeft(32, '0')}')),
            ],
          );
        },
      );
    }

    if (index == 6) {
      return ListView.separated(
        itemCount: _sha256.shaModel.hashValue.initialHashValue.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'][index]} ='),
              Flexible(
                  child:
                      Text('${_sha256.shaModel.hashValue.initialHashValue[index].toRadixString(2).padLeft(32, '0')}')),
            ],
          );
        },
      );
    }

    return SizedBox.shrink();
  }
}
