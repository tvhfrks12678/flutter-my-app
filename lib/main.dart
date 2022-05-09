// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

const appTitle = 'ウクライナ DE クイズ';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const QuizWidget(),
      ),
    );
  }
}

class QuizWidget extends StatefulWidget {
  const QuizWidget({Key? key}) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

CollectionReference quizzesReference =
    FirebaseFirestore.instance.collection('quizzes');

class Quiz {
  final String question;
  final List<String> choices;
  final int answerNo;

  const Quiz(this.question, this.choices, this.answerNo);
}

final Uri _url =
    Uri.parse('https://twitter.com/Flash43191300/status/1516779347457318920');

_launchUrl() async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}

class _QuizWidgetState extends State<QuizWidget> {
  List<Quiz>? _quizzes;
  Quiz? _quiz;

  @override
  void initState() {
    super.initState();
    loadQuizzes();
  }

  Future<void> loadQuizzes() async {
    QuerySnapshot querySnapshot = await quizzesReference.get();
    List<QueryDocumentSnapshot> queryDocumentSnapshotList = querySnapshot.docs;

    List<Quiz> quizzes = queryDocumentSnapshotList.map(
      (queryDocumentSnapshot) {
        Map<String, dynamic> data =
            queryDocumentSnapshot.data() as Map<String, dynamic>;
        return Quiz(
          data['question'],
          List<String>.from(data['choices']),
          data['answerNo'],
        );
      },
    ).toList();

    setState(() {
      _quizzes = quizzes;
      _quiz = quizzes[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          displayQuiz(),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          displayChoiceList(),
        ],
      ),
    );
  }

  Widget displayQuiz() {
    if (_quiz == null) {
      return const Text(
        '',
      );
    }

    return Container(
      padding: const EdgeInsets.only(top: 10, right: 10, bottom: 0, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.blue,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Q.',
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.5),
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Text(
                  _quiz!.question,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
                'https://pbs.twimg.com/media/FQyuxPMXoAk-qNk?format=jpg&name=medium'),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "画像はロシアによって破壊されたルビージュネ",
              textAlign: TextAlign.right,
            ),
          ),
          diplayLink(),
        ],
      ),
    );
  }

  Widget diplayLink() {
    return TextButton(
      onPressed: _launchUrl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          FaIcon(
            FontAwesomeIcons.twitter,
            size: 15,
          ),
          Text('(@Flash43191300)'),
        ],
      ),
    );
  }

  Widget buildChoiceButton(String index, String choiceWord) {
    const choiceTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Row(
          children: [
            Text(
              index,
              style: choiceTextStyle,
            ),
            const SizedBox(
              width: 3,
            ),
            Flexible(
              child: Text(
                choiceWord,
                style: choiceTextStyle,
              ),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  Widget displayChoiceList() {
    List<Widget> textList = [];
    if (_quiz != null) {
      List<String> choices = _quiz!.choices;
      textList = choices.asMap().entries.map((entity) {
        int index = entity.key + 1;

        String choice = entity.value;
        return Column(children: [
          buildChoiceButton("${index.toString()}.", choice),
        ]);
      }).toList();
    }
    return Column(
      children: textList,
    );
  }
}

const List<Map<String, dynamic>> quizList = [
  {
    'question': 'ウクライナのルハーンシク州のルビージュネ出身のMMA選手は？',
    'choices': [
      'エメリヤーエンコ・ヒョードル',
      'マリナ・モロズ',
      'ハビブ・ヌルマゴメドフ',
      'ニキータ・クリロフ',
    ],
    'answerNo': 0
  },
  {
    'question': 'ロシアのオデッサへの住宅へのミサイル攻撃で死亡した赤ん坊は？',
    'choices': [
      '生後36ヶ月',
      '生後3ヶ月',
      '生後5ヶ月',
      '生後9ヶ月',
    ],
    'answerNo': 1
  },
  {
    'question': '2022年4月にウクライナで初確認されたと言われているロシアの新型戦車は？',
    'choices': [
      'T-90M',
      'T-72',
      'T-80',
      'T-60',
    ],
    'answerNo': 0
  },
  {
    'question': 'ハルキウ州のイジュームから南東に45kmのドネツク州の人口2万の街の名前は？',
    'choices': [
      'オデッサ',
      'マリウポリ',
      'キーウ',
      'リマン',
    ],
    'answerNo': 3
  },
];

class AddQuiz extends StatelessWidget {
  const AddQuiz({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference quizzes =
        FirebaseFirestore.instance.collection('quizzes');
    Future<void> addQuizz(Map<String, dynamic> quiz) {
      return quizzes
          .add(quiz)
          .then((value) => print("Quiz Added: $value"))
          .catchError((error) => print('Failed to add quiz: $error'));
    }

    addQuizzes() {
      for (Map<String, dynamic> quiz in quizList) {
        addQuizz(quiz);
      }
    }

    return TextButton(
      onPressed: addQuizzes,
      child: const Text(
        'Add Quizzes',
      ),
    );
  }
}
