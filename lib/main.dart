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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Column(
            children: const [
              GetUserName(documentId: 'gu51bxc3Cc6ydVe7TB31'),
              AddQuiz(),
            ],
          ),
        ),
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  const GetUserName({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exit");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
              "Full Name: ${data['full_name']} Company Name: ${data['company']}");
        }

        return const Text("loading");
      },
    );
  }
}

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

const List<Map<String, dynamic>> quizList = [
  {
    'question': 'ウクライナのルハーンシク州のルビージュネ出身のMMA選手は？',
    'choices': ['ヒョードル', 'スターリング', 'マゴメドフ', 'ガヌー'],
    'answerNo': 0
  },
  {
    'question': 'オデッサへのミサイル攻撃で死亡した赤ん坊は？',
    'choices': ['生後36ヶ月', '生後3ヶ月', '生後5ヶ月', '生後9ヶ月'],
    'answerNo': 1
  },
  {
    'question': '2022年4月にウクライナで初確認されたと言われているロシアの最新の戦車は？',
    'choices': ['T-90M', 'T-72', 'T-80', 'T-60'],
    'answerNo': 0
  },
];
