

import 'package:flutter/material.dart';

// Navigation Constants.
const landingPageId = 'landing';
const quizPageId = 'quizPage';
const resultPageId = 'result';

// Styling Constants.
const headerWidth = 700.0;
const headerPadding = EdgeInsets.only(top: 20.0, bottom: 10.0, right: 25.0, left: 25.0);

const bodyWidth = 600.0;
const bodyPadding = EdgeInsets.only(top:10.0, right: 25.0, left: 25.0);
const questionBodyPadding = EdgeInsets.only(right: 25.0, left: 25.0);
const resultBodyPadding = EdgeInsets.only(top:20.0, right: 25.0, left: 25.0);
const buttonPadding = EdgeInsets.only(top:20.0);

// Data constants.
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

