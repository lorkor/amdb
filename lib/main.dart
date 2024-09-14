import 'package:amdb/constants.dart';
import 'package:amdb/page_widget.dart';
import 'package:amdb/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amdb/question_data.dart';

void main() {
  runApp(const AmdbApp());
}

class AmdbApp extends StatelessWidget {
  const AmdbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'amdb assessment',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: AmdbPage(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  String currentPageId = landingPageId;
  int questionIndex = 0;
  late Category primary;
  late Category secondary;
  Map<Category, double> results = {
    Category.mommy: 0,
    Category.daddy: 0,
    Category.amoeba: 0,
    Category.baby: 0
  };

  void resetResult() {
    questionIndex = 0;
    results = {
      Category.mommy: 0,
      Category.daddy: 0,
      Category.amoeba: 0,
      Category.baby: 0
    };
    currentPageId = landingPageId;
    notifyListeners();
  }

  void navigateToQuizPage() {
    currentPageId = quizPageId;
    notifyListeners();
  }

  bool isLastQuestion() {
    return questionIndex == quizContent.length - 1;
  }

  String getCurrentPageId() {
    if (questionIndex == quizContent.length) {
      return resultPageId;
    } else {
      return currentPageId;
    }
  }

  double getProgressPercentage() {
    return questionIndex / quizContent.length;
  }

  void completeQuestion(Map<Category, double> resultScores) {
    for (MapEntry<Category, double> categoryScore in resultScores.entries) {
      double cumulativeCategoryScore = (results[categoryScore.key] != null)
          ? 0.0
          : results[categoryScore.key]!;
      results[categoryScore.key] =
          cumulativeCategoryScore + categoryScore.value;
    }
    questionIndex += 1;
    notifyListeners();
  }

  Category getCategoryWithMax(Category? ignoreCategory) {
    var maxValue = 0.0;
    var bestCategory = Category.unknown;

    for (MapEntry<Category, double> categoryResult in results.entries) {
      var score = categoryResult.value;
      var category = categoryResult.key;
      if (score >= maxValue && category != ignoreCategory) {
        maxValue = score;
        bestCategory = category;
      }
    }
    return bestCategory;
  }

  void computeResult() {
    primary = getCategoryWithMax(null);
    secondary = getCategoryWithMax(/*ignoreCategory=*/ primary);
    notifyListeners();
  }
}

/* Styles and renders container for static content on the landing page. */
class LandingStaticContentContainer extends StatelessWidget {
  const LandingStaticContentContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text('what\'s your amdb?', style: getHeaderTextStyle(theme)),
      Padding(
          padding: bodyPadding,
          child: Text('not your mother\'s personality test. usefulness TBD.',
              style: (getBodyTextStyle(theme)))),
    ]);
  }
}
