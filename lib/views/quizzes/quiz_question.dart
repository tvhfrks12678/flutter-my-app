import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/models/quizzes/quiz.dart';
import 'package:my_app/values/quizzes/twitter_id.dart';

class QuizQuestion extends StatelessWidget {
  const QuizQuestion({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 10, bottom: 0, left: 10),
      decoration: _quizQuestionFrameBorder(),
      child: Column(
        children: [
          _quizQuestionText(context),
          const SizedBox(
            height: 10,
          ),
          _quizQuestionImage(),
          _quizQuestionSupplement(),
          _sourceLink(),
        ],
      ),
    );
  }

  Widget _quizQuestionText(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 3,
            ),
            Text(
              'Q.',
              style:
                  DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
            ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Text(
            quiz.question,
            style: const TextStyle(
              fontSize: 20,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _quizQuestionSupplement() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        quiz.supplement,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _quizQuestionImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(quiz.imageUrl),
    );
  }

  void _launchUrl() async {
    String url = quiz.sourceUrl;
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Could not launch $uri';
  }

  Widget _sourceLink() {
    return SizedBox(
      height: 30,
      child: TextButton(
        onPressed: _launchUrl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const FaIcon(
              FontAwesomeIcons.twitter,
              size: 15,
            ),
            Text(TwitterId(quiz.sourceUrl).value),
          ],
        ),
      ),
    );
  }

  BoxDecoration _quizQuestionFrameBorder() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: Colors.blue,
        width: 1.0,
      ),
    );
  }
}
