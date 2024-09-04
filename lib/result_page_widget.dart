import 'package:amdb/page_widget.dart';
import 'package:amdb/text_style.dart';
import 'package:flutter/material.dart';
import 'package:amdb/constants.dart';

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

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        alignment: Alignment.center,
        width: bodyWidth,
        padding: headerPadding,
        child: Text(resultMessage, style: getHeaderTextStyle(theme))),
      Container(
          width: bodyWidth,
          padding: resultBodyPadding,
          child: Text(primaryMessage,
              style: getBodyTextStyle(theme))),
      Container(
          width: bodyWidth,
          padding: resultBodyPadding,
          child: Text(secondaryMessage,
              style: getBodyTextStyle(theme))),
    ]);
  }
}