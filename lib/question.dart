import 'package:amdb/constants.dart';

// TODO: create a constant file of actual quiz questions. eventually just do this in a config.
class QuestionData {
  String questionText;
  List<MultipleChoiceSelection> selections;

  QuestionData(this.questionText, this.selections);

}

class MultipleChoiceSelection {
  String selectionText;
  // Mapping of amdb category to score for the question.
  Map<Category, double> categoryScores;

  MultipleChoiceSelection(this.selectionText, this.categoryScores);
}