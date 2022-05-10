import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    'choices': [
      'エメリヤーエンコ・ヒョードル',
      'マリナ・モロズ',
      'ハビブ・ヌルマゴメドフ',
      'ニキータ・クリロフ',
    ],
    'answerNo': 0,
    'media': {
      'sourceUrl':
          'https://twitter.com/Flash43191300/status/1516779347457318920',
      'imageUrl':
          'https://pbs.twimg.com/media/FQyuxPMXoAk-qNk?format=jpg&name=medium'
    },
    'supplement': '画像はロシアによって破壊されたルビージュネ',
  },
  {
    'question': 'ロシアのオデッサへの住宅へのミサイル攻撃で死亡した母親ヴァレリアの娘キラは生後何ヶ月だった？',
    'choices': [
      '生後48ヶ月',
      '生後3ヶ月',
      '生後1ヶ月',
      '生後12ヶ月',
    ],
    'answerNo': 1,
    'media': {
      'sourceUrl':
          'https://twitter.com/myroslavapetsa/status/1517990210017050627',
      'imageUrl':
          'https://pbs.twimg.com/media/FRD8C2_XwAAl-zL?format=jpg&name=large'
    },
    'supplement': '',
  },

// https://twitter.com/olya_rudenko/status/1517971752097361920
// 母親は亡くなる前にインスタに「今までで最高の40週間。女の子は今1ヶ月。パパが初めてのお花をプレゼントしてくれた。全く新しいレベルの幸せだ。」と投稿していた。

  // {
  //   'question': '2022年4月にウクライナで初確認されたと言われているロシアの新型戦車は？',
  //   'choices': [
  //     'T-90M',
  //     'T-72',
  //     'T-80',
  //     'T-60',
  //   ],
  //   'answerNo': 0
  // },
  // {
  //   'question': 'ハルキウ州のイジュームから南東に45kmのドネツク州の人口2万の街の名前は？',
  //   'choices': [
  //     'オデッサ',
  //     'マリウポリ',
  //     'キーウ',
  //     'リマン',
  //   ],
  //   'answerNo': 3
  // },
];
