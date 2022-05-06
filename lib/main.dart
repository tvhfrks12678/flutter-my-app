import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      _quiz = quizzes[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(40),
      child: Column(
        children: [
          displayQuiz(),
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
    return Text(
      "Q. ${_quiz!.question}",
      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
      softWrap: true,
    );
  }

  Widget choiceButoon(String choiceWord) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  child: Text(choiceWord),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget displayChoiceList() {
    List<Widget> textList = [];
    if (_quiz != null) {
      List<String> choices = _quiz!.choices;
      textList = choices.asMap().entries.map((entity) {
        int index = entity.key + 1;
        String choice = entity.value;
        String choiceWord = "$index. $choice";
        return Column(children: [
          choiceButoon(choiceWord),
          const SizedBox(
            height: 10,
          )
        ]);
      }).toList();
    }
    return Column(
      children: textList,
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expanded Row Sample'),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.amber,
                height: 100,
              ),
            ),
            Container(
              color: Colors.blue,
              height: 100,
              width: 50,
            ),
            Expanded(
              child: Container(
                color: Colors.amber,
                height: 100,
              ),
            ),
          ],
        ),
      ),
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
