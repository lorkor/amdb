import 'package:amdb/constants.dart';
import 'package:amdb/question.dart';

final quizContent = [
  QuestionData(
      'you invited your good friend to a party where they don\'t know many people. you realize they\'ve disappeared for a while. what do you do?',
      [
        MultipleChoiceSelection('don\'t worry about it. they\'ll be fine',
            {Category.amoeba: 0.8, Category.daddy: 0.1, Category.baby: 0.1}),
        MultipleChoiceSelection(
            'excuse yourself and do a round to search for them, to make sure they are having a good time.',
            {Category.mommy: 1.0}),
        MultipleChoiceSelection(
            'ask the people around you if they\'ve seen your friend',
            {Category.baby: 0.5, Category.amoeba: 0.5}),
        MultipleChoiceSelection('nothing for now, but find them 30 minutes before you plan on leaving to see if they want to come with you.',
            {Category.daddy: 1.0})
      ]),
      QuestionData(
      'you\'re planning a trip with a group. which of these sounds most like you?',
      [
        MultipleChoiceSelection(
            'you create and share a packing list with the group',
            {Category.mommy: 1.0}),
        MultipleChoiceSelection(
            'you find an array of options for fun activities and share them with the group',
            {Category.baby: 1.0}),
        MultipleChoiceSelection('you make sure everyone gets to the airport in time for the flight',
            {Category.daddy: 1.0}),
        MultipleChoiceSelection('you ask if anyone needs help with planning logistics',
            {Category.amoeba: 1.0})
      ]),
];
