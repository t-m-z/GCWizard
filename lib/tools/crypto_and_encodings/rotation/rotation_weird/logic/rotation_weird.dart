Map<String, String> rotationWeird(String input, String key) {

  final defaultAlphabetAlpha = 'abcdefghijklmnopqrstuvwxyz';
  final extendedAlphabetDigits = 'abcdefghijklmnopqrstuvwxyzäöüß';

  List<int?> rotateData = [];

  for (String number in key.split(' ')) {
    if (int.tryParse(number).toString() != 'null') {
      rotateData.add(int.parse(number));
    }
  }

  input = input.toLowerCase();

  String alphabet = defaultAlphabetAlpha;
  if (input.contains('ä') || input.contains('ö') || input.contains('ü') || input.contains('ß')) {
    alphabet = extendedAlphabetDigits;
  }

  String resultAdd = '';
  String resultSub = '';

  int keyLength = rotateData.length;

  int i = 0;
  int j = 0;
  while (i < input.length) {
    if (alphabet.contains(input[i])) {
      resultAdd = resultAdd + _rotate(input[i], rotateData[j % keyLength]!, alphabet);
      resultSub = resultSub + _rotate(input[i], -rotateData[j % keyLength]!, alphabet);
      j++;
    } else {
      resultAdd = resultAdd + input[i];
      resultSub = resultSub + input[i];
    }
    i++;
  }

  return {
    'ADD': resultAdd,
    'SUB': resultSub,
  };
}

String _rotate(String char, int key, String alphabet) {
  var alphabetLength = alphabet.length;
  var index = alphabet.indexOf(char);
  var newIndex = (index + key) % alphabetLength;
  return alphabet[newIndex];
}
