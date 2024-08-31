import 'package:amdb/constants.dart';
import 'package:amdb/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amdb/question_data.dart';
import 'package:amdb/question.dart';

const headerWidth = 700.0;
const headerPadding = EdgeInsets.only(top: 20.0, bottom: 10.0, right: 50.0, left: 50.0);
const bodyWidth = 600.0;
const bodyPadding = EdgeInsets.only(right: 50.0, left: 50.0);

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
    final questionStyle =
        TextStyle(color: theme.colorScheme.onPrimaryFixed, fontSize: 18);
    final radioSelectionStyle =
        TextStyle(color: theme.colorScheme.onPrimaryFixedVariant, fontSize: 15);

    List<Widget> columnChildren = [];

    for (MultipleChoiceSelection selection in questionData.selections) {
      columnChildren.add(RadioListTile<Map<Category, double>>(
        title: Text(selection.selectionText, style: radioSelectionStyle),
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
        child: Text(questionData.questionText, style: questionStyle)),
      Container(
        width: bodyWidth,
        padding: bodyPadding,
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
            child: Text(buttonText),
          )),
      Container(
          width: 180,
          padding: EdgeInsets.only(top: 20.0),
          child:
              LinearProgressIndicator(value: appState.getProgressPercentage()))
    ]);
  }
}
