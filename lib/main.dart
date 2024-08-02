import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

const landingPageId = 'landing';
const quizPageId = 'quizPage';
const resultPageId = 'result';
const quadrantDescriptions = {
  Category.mommy:
      'as a mommy, you are nurturing and caring. you actively anticipate others\' needs, and are a comforting presence to those around you.',
  Category.daddy:
      'as a daddy, you get things done. you\'re a problem solver and a go-getter.',
  Category.amoeba: 'como se dice amoeba en español?',
  Category.baby:
      'as a baby, you bring fresh eyes and carefree fun to every situation. you might need to be taken care of sometimes, but isn\'t that what we all want?'
};
const quadrants = [
  Category.mommy,
  Category.daddy,
  Category.amoeba,
  Category.baby
];

enum Category {
  unknown(stringRep: 'unknown'),
  mommy(stringRep: 'mommy'),
  daddy(stringRep: 'daddy'),
  amoeba(stringRep: 'amoeba'),
  baby(stringRep: 'baby');

  const Category({
    required this.stringRep,
  });

  final String stringRep;
}

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

class Page extends StatefulWidget {
  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    switch (appState.getCurrentPageId()) {
      case landingPageId:
        return renderLandingPage(appState);
      case quizPageId:
        return renderQuizPage(appState);
      case resultPageId:
        return renderResultPage(appState);
    }
    return Scaffold();
  }

  /* Renders the full landing page. */
  AmdbBasePage renderLandingPage(AppState appState) {
    return AmdbBasePage(
      pageContents: Column(
        children: [
          LandingStaticContentContainer(),
          Padding(
            // TODO: pull out common button styling
            padding: EdgeInsets.only(top: 15.0),
            child: OutlinedButton(
              onPressed: () {
                appState.navigateToQuizPage();
              },
              child: Text('find out now'),
            ),
          ),
        ],
      ),
    );
  }

  AmdbBasePage renderQuizPage(appState) {
    return AmdbBasePage(pageContents: Column(children: [QuizQuestion()]));
  }

  /* Renders the full result page. */
  AmdbBasePage renderResultPage(AppState appState) {
    var primary = appState.primary;
    var secondary = appState.secondary;

    var resultMessage = 'you are ${primary.stringRep} ${secondary.stringRep}!';
    var primaryMessage = quadrantDescriptions[primary].toString();
    var secondaryMessage = quadrantDescriptions[secondary].toString();
    return AmdbBasePage(
      pageContents: Column(
        children: [
          AssessmentResult(
              resultMessage: resultMessage,
              primaryMessage: primaryMessage,
              secondaryMessage: secondaryMessage),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: OutlinedButton(
              onPressed: () {
                appState.resetResult();
              },
              child: Text('return home'),
            ),
          ),
        ],
      ),
    );
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

/* Styles and renders the assessment result and descriptions. */
class AssessmentResult extends StatelessWidget {
  const AssessmentResult({
    super.key,
    required this.resultMessage,
    required this.primaryMessage,
    required this.secondaryMessage,
  });

  final String resultMessage;
  final String primaryMessage;
  final String secondaryMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primaryFixedDim,
    );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(resultMessage, style: headerStyle),
      Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(primaryMessage,
              style:
                  TextStyle(color: theme.colorScheme.onPrimaryFixedVariant))),
      Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(secondaryMessage,
              style:
                  TextStyle(color: theme.colorScheme.onPrimaryFixedVariant))),
    ]);
  }
}

/* Sets common styling for all pages in amdb app. */
class AmdbBasePage extends StatelessWidget {
  const AmdbBasePage({
    super.key,
    required this.pageContents,
  });

  final Widget pageContents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Align(alignment: Alignment.topLeft, child: pageContents)));
  }
}
