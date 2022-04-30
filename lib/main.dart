import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutters'),
        ),
        body: const MyWidget(),
      ),
    );
  }
}

const List<Widget> list = [
  BlueBox(),
  // Spacer(flex: 1),
  // SizedBox(
  //   width: 100,
  //   child: BlueBox(),
  // ),
  // const Expanded(child: BlueBox()),
  // BlueBox(),
  // SizedBox(width: 50),
  // BlueBox(),
  TextBlue(),
  TextItem(fontSize: 50, fontFamily: 'Futura', fontColor: Colors.green),
  TextItem(fontSize: 40, fontFamily: 'Futura', fontColor: Colors.red)
];

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: list,
    );
  }
}

class TextItem extends StatelessWidget {
  const TextItem({
    Key? key,
    required this.fontSize,
    required this.fontFamily,
    required this.fontColor,
  }) : super(key: key);

  final double? fontSize;
  final String? fontFamily;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hey1',
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: fontColor,
      ),
    );
  }
}

class TextBlue extends StatelessWidget {
  const TextBlue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Hey1',
      style: TextStyle(
        fontSize: 30,
        fontFamily: 'Futura',
        color: Colors.blue,
      ),
    );
  }
}

class BlueBox extends StatelessWidget {
  const BlueBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class BiggerBlueBox extends StatelessWidget {
  const BiggerBlueBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
