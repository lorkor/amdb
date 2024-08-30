import 'package:amdb/constants.dart';
import 'package:amdb/question.dart';

final quizContent = [
  QuestionData(
      'you invited your good friend to a party where they don\'t know many people. you realize they\'ve disappeared for a while. what do you do?',
      [
        MultipleChoiceSelection('don\'t worry about it. they\'ll be fine',
            {Category.amoeba: 0.6, Category.baby: 0.4}),
        MultipleChoiceSelection(
            'excuse yourself and do a round to search for them, to make sure they are having a good time.',
            {Category.mommy: 1.0}),
        MultipleChoiceSelection(
            'ask the people around you if they\'ve seen your friend',
            {Category.baby: 0.6, Category.amoeba: 0.4}),
        MultipleChoiceSelection(
            'nothing for now, but find them 30 minutes before you plan on leaving to see if they want to come with you.',
            {Category.daddy: 1.0})
      ]),
  QuestionData(
      'you\'re planning a trip with a group. which of these sounds most like you?',
      [
        MultipleChoiceSelection(
            'you create and share a packing list with the group',
            {Category.mommy: 1.0}),
        MultipleChoiceSelection(
            'you find options for fun activities and share them with the group',
            {Category.baby: 1.0}),
        MultipleChoiceSelection(
            'you make sure everyone gets to the airport in time for the flight',
            {Category.daddy: 1.0}),
        MultipleChoiceSelection(
            'you ask if anyone needs help with planning logistics',
            {Category.amoeba: 1.0})
      ]),
      QuestionData(
      'you have guests visiting you from out of town. what\'s your hosting style?',
      [
        MultipleChoiceSelection(
            'pick them up from the airport and make sure they know their way around the area',
            {Category.daddy: 1.0}),
        MultipleChoiceSelection(
            'you mostly go about your day-to-day, inviting them to join you for all the activities',
            {Category.baby: 1.0}),
        MultipleChoiceSelection(
            'ask them well in advance about what they\'re interested in doing, and stock your fridge with their favorite foods before they arrived',
            {Category.mommy: 1.0}),
        MultipleChoiceSelection(
            'play by ear, you\'ll figure things out when they arrive',
            {Category.amoeba: 1.0})
      ]),
];
