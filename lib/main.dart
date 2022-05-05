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

const appTitle = 'ウクライナ侵略 DE クイズ';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ウクライナ侵略 DE クイズ'),
        ),
        body: Center(
          child: Column(
            children: const [
              AddQuiz(),
              QuizWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

const List<Map<String, dynamic>> quizList = [
  {
    'question': 'ウクライナのルハーンシク州のルビージュネ出身のMMA選手は？',
    'choices': [
      'ヒョードル',
      'スターリング',
      'マゴメドフ',
      'ガヌー',
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
    'question': '2022年4月にウクライナで初確認されたと言われているロシアの最新の戦車は？',
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
    'answerNo': 0
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
  late List<Quiz> _quizzes;
  late Quiz _quiz;

  @override
  void initState() {
    loadQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        displayQuiz(),
        TextButton(
          onPressed: printQuizList,
          child: Text(
            'print QuizList',
          ),
        ),
      ],
    );
  }

  Widget displayQuiz() {
    return Text(_quiz.question);
  }

  printQuizList() {
    print(_quizzes);
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
}
