import 'dart:html';

/*
  simple minded approach:
  var textWithout = text.replaceAll(',', '').replaceAll(';', '').
  replaceAll('.', '').replaceAll('\n', ' ');
 */

/*
  http://www.regular-expressions.info/reference.html
  \w : word characters (letters, digits, and underscores)
  \W : negation of \w
 */

List fromTextToLetters(String text) {
  //var regexp = new RegExp("[,;:.?!()'`’“\"\n]");
  var regexp = new RegExp(r"(\W)");
  var textWithout = text.replaceAll(regexp, '');
  return textWithout.split('');
}

Map analyzeLetterFrequency(List letterList) {
  var letterFrequencyMap = new Map();
  for (var w in letterList) {
    var letter = w.trim();
    if (letter != '') {
      if (!letterFrequencyMap.containsKey(letter)) {
        letterFrequencyMap[letter] = 0;
      }
      letterFrequencyMap[letter] = letterFrequencyMap[letter] + 1;
    }
  }
  return letterFrequencyMap;
}

List sortLetters(Map letterFrequencyMap) {
  var letterLetterFrequencyMap = new Map<String, String>();
  letterFrequencyMap.forEach((k, v) =>
      letterLetterFrequencyMap[k] = '${k}: ${v.toString()}');
  List sortedLetterList = letterLetterFrequencyMap.values.toList();
  sortedLetterList.sort((m,n) => m.compareTo(n));
  return sortedLetterList;
}

void main() {
  TextAreaElement textArea = document.querySelector('#text');
  TextAreaElement lettersArea = document.querySelector('#letters');
  ButtonElement lettersButton = document.querySelector('#frequency');
  ButtonElement clearButton = document.querySelector('#clear');
  lettersButton.onClick.listen((MouseEvent e) {
    lettersArea.value = 'Adam thinks that there are that many of each letter: \n';
    var text = textArea.value.trim();
    if (text != '') {
      var lettersList = fromTextToLetters(textArea.value);
      var lettersMap = analyzeLetterFrequency(lettersList);
      var sortedLettersList = sortLetters(lettersMap);
      sortedLettersList.forEach((letter) =>
          lettersArea.value = '${lettersArea.value} \n${letter}');
    }
  });
  clearButton.onClick.listen((MouseEvent e) {
    textArea.value = '';
    lettersArea.value = '';
  });
}


