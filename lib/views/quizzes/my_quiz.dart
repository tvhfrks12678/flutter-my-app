import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/views/quizzes/add_quiz.dart';
import 'package:my_app/views/quizzes/choice_list.dart';
import 'package:my_app/models/quizzes/quiz.dart';
import 'package:my_app/views/quizzes/quiz_question.dart';

class MyQuiz extends StatefulWidget {
  const MyQuiz({Key? key}) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

CollectionReference quizzesReference =
    FirebaseFirestore.instance.collection('quizzes');

class _QuizWidgetState extends State<MyQuiz> {
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
          data['media']['sourceUrl'],
          data['media']['imageUrl'],
          data['supplement'],
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
    if (_quiz == null) {
      return Text('Loding');
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          QuizQuestion(quiz: _quiz!),
          const SizedBox(
            height: 10,
          ),
          ChoiceList(choiceList: _quiz!.choices),
        ],
      ),
    );
  }
}
