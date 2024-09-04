import 'package:amdb/constants.dart';
import 'package:amdb/main.dart';
import 'package:amdb/question_widget.dart';
import 'package:amdb/result_page_widget.dart';
import 'package:amdb/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* Base page class that watches app state and renders appropriate root app page. */
class AmdbPage extends StatefulWidget {
  @override
  State<AmdbPage> createState() => _PageState();
}

class _PageState extends State<AmdbPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    final theme = Theme.of(context);
    switch (appState.getCurrentPageId()) {
      case landingPageId:
        return renderLandingPage(appState, theme);
      case quizPageId:
        return renderQuizPage(appState);
      case resultPageId:
        return renderResultPage(appState);
    }
    return Scaffold();
  }

  /* Renders the full landing page. */
  AmdbBasePage renderLandingPage(AppState appState, ThemeData theme) {
    return AmdbBasePage(
      pageContents: Column(
        children: [
          LandingStaticContentContainer(),
          Padding(
            padding: buttonPadding,
            child: OutlinedButton(
              onPressed: () {
                appState.navigateToQuizPage();
              },
              child: Text('find out now', style: getBodyTextStyle(theme)),
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
            padding: buttonPadding,
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
        body: ListView(padding: EdgeInsets.all(25.0), children: <Widget>[
      Align(alignment: Alignment.topCenter, child: pageContents)
    ]));
  }
}
