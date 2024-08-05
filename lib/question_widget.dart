import 'package:amdb/constants.dart';
import 'package:amdb/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizQuestion extends StatefulWidget {
  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  Category _category = Category.unknown;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    final theme = Theme.of(context);
    final headerStyle = theme.textTheme.displaySmall!
        .copyWith(color: theme.colorScheme.primaryFixedDim);
    final questionStyle =
        TextStyle(color: theme.colorScheme.onPrimaryFixedVariant, fontSize: 15);
    final radioSelectionStyle =
        TextStyle(color: theme.colorScheme.onPrimaryFixedVariant, fontSize: 15);

    // TODO: fill column children with contents of question data. create a static file of questions.
    return Column(
        children: [Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Text("find your amdb", style: headerStyle),
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text('which best describes you?', style: questionStyle)),
          RadioListTile<Category>(
            title: Text('mommy', style: radioSelectionStyle),
            value: Category.mommy,
            groupValue: _category,
            onChanged: (Category? value) {
              setState(() {
                _category = Category.mommy;
              });
            },
          ),
          RadioListTile<Category>(
            title: Text('daddy', style: radioSelectionStyle),
            value: Category.daddy,
            groupValue: _category,
            onChanged: (Category? value) {
              setState(() {
                _category = Category.daddy;
              });
            },
          ),
          RadioListTile<Category>(
            title: Text('amoeba', style: radioSelectionStyle),
            value: Category.amoeba,
            groupValue: _category,
            onChanged: (Category? value) {
              setState(() {
                _category = Category.amoeba;
              });
            },
          ),
          RadioListTile<Category>(
            title: Text('baby', style: radioSelectionStyle),
            value: Category.baby,
            groupValue: _category,
            onChanged: (Category? value) {
              setState(() {
                _category = Category.baby;
              });
            },
          ),
        ]),
        Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: OutlinedButton(
                // TODO: make this only visible if last questions
                // TODO: make this clickable only if radio button selected.
                onPressed: () {
                  appState.computeResult();
                  appState.completeQuestion(_category);
                },
                child: Text('get result'),
              )
            )
        ]);
  }
}
