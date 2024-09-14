import 'package:flutter/material.dart';

TextStyle getHeaderTextStyle(ThemeData theme) {
  return TextStyle(
        fontFamily: 'Sora',
        fontSize: 35.0,
        fontWeight: FontWeight.w500,
        color: theme.colorScheme.primary);
}

TextStyle getQuestionTextStyle(ThemeData theme) {
  return TextStyle(
      fontFamily: 'Sora',
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      color: theme.colorScheme.primary);
}

TextStyle getBodyTextStyle(ThemeData theme) {
  return TextStyle(
      fontFamily: 'Mukta',
      color: theme.colorScheme.onSecondaryFixedVariant, fontSize: 15.0);
}