

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

