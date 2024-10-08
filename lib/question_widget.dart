import 'package:amdb/constants.dart';
import 'package:amdb/main.dart';
import 'package:amdb/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amdb/question_data.dart';
import 'package:amdb/question.dart';

const headerWidth = 700.0;
const bodyWidth = 675.0;

class QuizQuestion extends StatefulWidget {
  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  Map<Category, double> _categoryScores = {};
  bool _isOptionSelected = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    final theme = Theme.of(context);

    QuestionData questionData = quizContent[appState.questionIndex];
    return getQuizQuestionFromData(appState, theme, questionData);
  }

  bool isOptionSelected() {
    return _isOptionSelected;
  }

  Column getQuizQuestionFromData(
      AppState appState, ThemeData theme, QuestionData questionData) {
    List<Widget> columnChildren = [];

    for (MultipleChoiceSelection selection in questionData.selections) {
      columnChildren.add(RadioListTile<Map<Category, double>>(
        title: Text(selection.selectionText, style: getBodyTextStyle(theme)),
        value: selection.categoryScores,
        groupValue: _categoryScores,
        onChanged: (Map<Category, double>? value) {
          setState(() {
            _categoryScores = selection.categoryScores;
            _isOptionSelected = true;
          });
        },
      ));
    }

    String buttonText = 'next question';
    if (appState.isLastQuestion()) {
      buttonText = 'get result';
    }

    // TODO: add animation for progress bar
    return Column(children: [
      Container(
          width: headerWidth,
          padding: headerPadding,
          child: Text(questionData.questionText,
              style: getQuestionTextStyle(theme))),
      Container(
          width: bodyWidth,
          padding: questionBodyPadding,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: columnChildren)),
      Padding(
          padding: buttonPadding,
          child: OutlinedButton(
            onPressed: !isOptionSelected()
                ? null
                : () {
                    appState.completeQuestion(_categoryScores);
                    appState.computeResult();
                    _isOptionSelected = false;
                  },
            child: Text(buttonText, style: getBodyTextStyle(theme)),
          )),
      Container(
          width: 180,
          padding: buttonPadding,
          child:
              LinearProgressIndicator(value: appState.getProgressPercentage()))
    ]);
  }
}
