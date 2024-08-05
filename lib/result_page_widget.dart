import 'package:flutter/material.dart';

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