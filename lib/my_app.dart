import 'package:flutter/material.dart';
import 'package:my_app/views/quizzes/my_quiz.dart';

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
        body: const MyQuiz(),
      ),
    );
  }
}
