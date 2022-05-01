import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final appTitle = 'Quiz App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: const MyBody(),
      ),
    );
  }
}

class MyBody extends StatelessWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: textButtonList);
  }

  Widget _buildTextButton(String text) => TextButton(
        style: TextButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
        onPressed: _onPressed,
        child: Text(text),
      );

  _onPressed() {
    print('Test');
  }
}

final List<String> textList = ['テスト', 'チェスト', 'ゲスト'];

final List<Widget> textButtonList = (textList.map(
  (e) => buildTextButton(e),
)).toList();

TextButton buildTextButton(String text) => TextButton(
      style: TextButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
      onPressed: () {},
      child: Text(text),
    );
