import 'package:amdb/constants.dart';
import 'package:amdb/page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

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
        title: 'amdb personality assessment',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Page(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  final _random = Random();
  String currentPageId = landingPageId;
  late Category primary;
  late Category secondary;
  var results = {
    Category.mommy: 0,
    Category.daddy: 0,
    Category.amoeba: 0,
    Category.baby: 0
  };
  var progressPercentage = 0;

  void resetResult() {
    progressPercentage = 0;
    currentPageId = landingPageId;
    results = {
      Category.mommy: 0,
      Category.daddy: 0,
      Category.amoeba: 0,
      Category.baby: 0
    };
    notifyListeners();
  }

  void navigateToQuizPage() {
    currentPageId = quizPageId;
    notifyListeners();
  }

  String getCurrentPageId() {
    if (progressPercentage == 100) {
      return resultPageId;
    } else {
      return currentPageId;
    }
  }

  void completeQuestion(Category category) {
    progressPercentage = 100;
    if (results[category] != null) {
      results[category] = (results[category])! + 1;
    }
    notifyListeners();
  }

  void computeResult() {
    primary = quadrants[_random.nextInt(quadrants.length)];
    secondary = quadrants[_random.nextInt(quadrants.length)];
    while (secondary == primary) {
      secondary = quadrants[_random.nextInt(quadrants.length)];
    }
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
    final headerStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primaryFixedDim,
    );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('what\'s your amdb?', style: headerStyle),
      Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text('not your mother\'s personality test. usefulness TBD.',
              style: (TextStyle(
                  color: theme.colorScheme.onPrimaryFixedVariant,
                  fontSize: 15)))),
    ]);
  }
}

