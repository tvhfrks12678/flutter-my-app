import 'package:flutter/material.dart';

class ChoiceList extends StatelessWidget {
  const ChoiceList({
    Key? key,
    required this.choiceList,
  }) : super(key: key);

  final List<String> choiceList;

  @override
  Widget build(BuildContext context) {
    List<Widget> textList = [];

    List<String> choices = choiceList;
    textList = choices.asMap().entries.map((entity) {
      int index = entity.key + 1;

      String choice = entity.value;
      return Column(children: [
        _buildChoiceButton("${index.toString()}.", choice),
      ]);
    }).toList();

    return Column(
      children: textList,
    );
  }

  Widget _buildChoiceButton(String index, String choiceWord) {
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
}
