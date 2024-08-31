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
    final headerStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primaryFixedDim,
    );
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        alignment: Alignment.center,
        width: bodyWidth,
        padding: headerPadding,
        child: Text(resultMessage, style: headerStyle)),
      Container(
          width: bodyWidth,
          padding: resultBodyPadding,
          child: Text(primaryMessage,
              style:
                  TextStyle(color: theme.colorScheme.onPrimaryFixedVariant))),
      Container(
          width: bodyWidth,
          padding: resultBodyPadding,
          child: Text(secondaryMessage,
              style:
                  TextStyle(color: theme.colorScheme.onPrimaryFixedVariant))),
    ]);
  }
}