import 'package:flutter/material.dart';

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
  // SizedBox(width: 50),
  TextBlue(),
  // TextItem(fontSize: 50, fontFamily: 'Futura', fontColor: Colors.green),
  TextItem(fontSize: 40, fontFamily: 'Futura', fontColor: Colors.red),
  IconItem(iconSize: 50, iconColor: Colors.blue),
  IconItem(iconSize: 50, iconColor: Colors.red),
];

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(Icons.account_circle, size: 50),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter McFlutter',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Text('Experienced App Develop'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('123 Main Street'),
            Text('415-555-0198'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [],
        )
      ],
    );
  }
}

final List<IconEntity> iconList = [
  IconEntity(50, Colors.blue),
  IconEntity(50, Colors.red),
];

var iconItemList = iconList.map((item) {
  return item;
});

class IconEntity {
  final double fontSize;
  final Color iconColor;

  IconEntity(this.fontSize, this.iconColor);
}

class IconItem extends StatelessWidget {
  const IconItem({
    Key? key,
    required this.iconSize,
    required this.iconColor,
  }) : super(key: key);

  final double? iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.widgets,
      size: iconSize,
      color: iconColor,
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
