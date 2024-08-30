import 'package:amdb/constants.dart';
import 'package:amdb/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amdb/question_data.dart';
import 'package:amdb/question.dart';

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
    final headerStyle = theme.textTheme.displaySmall!
        .copyWith(color: theme.colorScheme.primaryFixedDim);
    final questionStyle =
        TextStyle(color: theme.colorScheme.onPrimaryFixedVariant, fontSize: 15);
    final radioSelectionStyle =
        TextStyle(color: theme.colorScheme.onPrimaryFixedVariant, fontSize: 15);

    List<Widget> columnChildren = [Text("find your amdb", style: headerStyle)];
    columnChildren.add(Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(questionData.questionText, style: questionStyle)));

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
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnChildren),
      Padding(
          padding: EdgeInsets.only(top: 15.0),
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
          padding: EdgeInsets.only(top: 30.0),
          child:
              LinearProgressIndicator(value: appState.getProgressPercentage()))
    ]);
  }
}
