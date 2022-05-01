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
        // body: Center(
        //   child: Container(
        //     margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
        //     height: 600,
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         SizedBox(
        //           width: 440,
        //           child: leftColumn,
        //         ),
        //         // const MyWidget(),
        //       ],
        //     ),
        //   ),
        // ),
        body: const Center(
          child: MyImageWidget(),
        ),
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  const MyImageWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildStack();
  }

  Widget _buildStack() {
    return Stack(
      alignment: const Alignment(0.6, 0.6),
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('images/lake.jpg'),
          radius: 100,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.black45,
          ),
          child: const Text(
            'Mia B',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList() {
    return ListView(children: [
      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
      _tile('United Artists Stonestown Twin', '501 Buckingham Way',
          Icons.theaters),
      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
      _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      const Divider(),
      _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
      _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
      _tile('La Ciccia', '291 30th St', Icons.restaurant),
    ]);
  }

  ListTile _tile(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildGrid() => GridView.extent(
        maxCrossAxisExtent: 150,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridTileList(30),
      );

  List<Container> _buildGridTileList(int count) => List.generate(
        count,
        (i) => Container(
          child: Column(
            children: [
              Text('title: $i'),
              Image.asset('images/lake.jpg'),
            ],
          ),
        ),
      );

  // Container
  Widget _buildImageColumn() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black26,
      ),
      child: Column(
        children: [
          _buildImageRow(1),
          _buildImageRow(3),
        ],
      ),
    );
  }

  Widget _buildDecoratedImage(int imageIndex) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.black38),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          margin: const EdgeInsets.all(4),
          child: Image.asset('images/pic1.jpg'),
        ),
      );

  Widget _buildImageRow(int imageIndex) => Row(
        children: [
          _buildDecoratedImage(imageIndex),
          _buildDecoratedImage(imageIndex + 1),
        ],
      );
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        iconTextList,
        ratings,
        stars,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset('images/lake.jpg'),
            ),
            Expanded(
              flex: 2,
              child: Image.asset('images/lake.jpg'),
            ),
            Expanded(
              child: Image.asset('images/lake.jpg'),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.green[500]),
            Icon(Icons.star, color: Colors.green[500]),
            Icon(Icons.star, color: Colors.green[500]),
            const Icon(Icons.star, color: Colors.black),
            const Icon(Icons.star, color: Colors.black),
          ],
        ),
      ],
    );
  }
}

final leftColumn = Container(
  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
  child: Column(
    children: [
      iconTextList,
      ratings,
    ],
  ),
);

const descTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

final iconTextList = DefaultTextStyle.merge(
  style: descTextStyle,
  child: Container(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.kitchen, color: Colors.green[500]),
            const Text('PREP:'),
            const Text('25 min'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.timer, color: Colors.green[500]),
            const Text('COOK:'),
            const Text('1 hr'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.restaurant, color: Colors.green[500]),
            const Text('FEEDS:'),
            const Text('4-6'),
          ],
        ),
      ],
    ),
  ),
);

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

var stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    const Icon(Icons.star, color: Colors.black),
    const Icon(Icons.star, color: Colors.black),
  ],
);

final ratings = Container(
  padding: const EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      stars,
      const Text(
        '170 Reviews',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: 20,
        ),
      ),
    ],
  ),
);

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
