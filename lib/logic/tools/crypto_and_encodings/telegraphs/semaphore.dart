import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final Map<String, List<String>> CODEBOOK_SEMAPHORE = {
  'A': ['l4', 'r5'],
  'B': ['l3', 'r5'],
  'C': ['l2', 'r5'],
  'D': ['l1', 'r5'],
  'E': ['l5', 'r2'],
  'F': ['l5', 'r3'],
  'G': ['l5', 'r4'],
  'H': ['l3', 'l4'],
  'I': ['l2', 'l4'],
  'J': ['l1', 'r3'],
  'K': ['l4', 'r1'],
  'L': ['l4', 'r2'],
  'M': ['l4', 'r3'],
  'N': ['l4', 'r4'],
  'O': ['l2', 'l3'],
  'P': ['l3', 'r1'],
  'Q': ['l3', 'r2'],
  'R': ['l3', 'r3'],
  'S': ['l3', 'r4'],
  'T': ['l2', 'r1'],
  'U': ['l2', 'r2'],
  'V': ['l1', 'r4'],
  'W': ['r2', 'r3'],
  'X': ['r2', 'r4'],
  'Y': ['l2', 'r3'],
  'Z': ['r3', 'r4'],
  '0': ['l4', 'r1'],
  '1': ['l4', 'r5'],
  '2': ['l3', 'r5'],
  '3': ['l2', 'r5'],
  '4': ['l1', 'r5'],
  '5': ['l5', 'r2'],
  '6': ['l5', 'r3'],
  '7': ['l5', 'r4'],
  '8': ['l3', 'l4'],
  '9': ['l2', 'l4'],
  'symboltables_semaphore_cancel': ['l2', 'r4'],
  //'symboltables_semaphore_correct':['l2', 'r5'],
  'symboltables_semaphore_error': ['l2', 'l4', 'r2', 'r4'],
  //'symboltables_semaphore_attention': ['l2', 'r2'],
  'symboltables_semaphore_letters_following': ['l1', 'r3'],
  'symboltables_semaphore_numerals_following': ['l1', 'r2'],
  'symboltables_semaphore_rest': ['l5', 'r5'],
};

final Map<String, String> LETTER2DIGIT = {
  '1': 'A',
  '2': 'B',
  '3': 'C',
  '4': 'D',
  '5': 'E',
  '6': 'F',
  '7': 'G',
  '8': 'H',
  '9': 'I',
  '0': 'K',
};

final Map<String, String> DIGIT2LETTER = switchMapKeyValue(LETTER2DIGIT);

final NUMBER = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'};

final LETTER = {
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
};

List<List<String>> encodeSemaphore(String input) {
  if (input == null) return [];

  List<String> inputs = input.toUpperCase().split('');
  List<List<String>> result = [];
  bool number_follows = false;
  bool letter_follows = false;
  for (int i = 0; i < inputs.length; i++) {
    if (LETTER.contains(inputs[i]) && !letter_follows) {
      letter_follows = true;
      number_follows = false;
      result.add(CODEBOOK_SEMAPHORE['symboltables_semaphore_letters_following']);
    }
    if (NUMBER.contains(inputs[i]) && !number_follows) {
      number_follows = true;
      letter_follows = false;
      result.add(CODEBOOK_SEMAPHORE['symboltables_semaphore_numerals_following']);
    }
    if (CODEBOOK_SEMAPHORE[inputs[i]] != null) result.add(CODEBOOK_SEMAPHORE[inputs[i]]);
  }
  return result;
}

Map<String, dynamic> decodeSemaphore(List<String> inputs) {
  if (inputs == null || inputs.length == 0) return {'displays': <List<String>>[], 'chars': []};

  var displays = <List<String>>[];
  var segment = <String>[];
  bool number_follows = false;
  bool letter_follows = true;

  Map<List<String>, String> CODEBOOK = switchMapKeyValue(CODEBOOK_SEMAPHORE);

  inputs.forEach((element) {
    segment = _stringToSegment(element);
    displays.add(segment);
  });

  List<String> text = inputs.where((input) => input != null).map((input) {
    var char = '';
    var charH = '';
    var symbol = '';

    if (CODEBOOK.map((key, value) => MapEntry(key.join(), value.toString()))[input.split('').join()] == null) {
      char = char + UNKNOWN_ELEMENT;
    } else {
      symbol = CODEBOOK.map((key, value) => MapEntry(key.join(), value.toString()))[input.split('').join()];
      if (symbol == 'symboltables_semaphore_letters_following' ||
          symbol == 'symboltables_semaphore_numerals_following' ||
          symbol == 'symboltables_semaphore_cancel' ||
          symbol == 'symboltables_semaphore_error' ||
          symbol == 'symboltables_semaphore_rest') {
        switch (symbol) {
          case 'symboltables_semaphore_letters_following':
            if (letter_follows) char = char + 'J';
            number_follows = false;
            letter_follows = true;
            break;
          case 'symboltables_semaphore_numerals_following':
            number_follows = true;
            letter_follows = false;
            break;
          case 'symboltables_semaphore_rest':
            char = char + ' ';
            break;
          case 'symboltables_semaphore_cancel':
          case 'symboltables_semaphore_error':
            char = char + symbol;
            break;
        }
      } else {
        if (letter_follows) if (LETTER.contains(symbol))
          charH = symbol;
        else
          charH = LETTER2DIGIT[symbol];
        else if (NUMBER.contains(symbol))
          charH = symbol;
        else
          charH = DIGIT2LETTER[symbol];

        if (charH != null) char = char + charH;
      }
    }

    return char;
  }).toList();

  return {'displays': displays, 'chars': text};
}

List<String> _stringToSegment(String input) {
  List<String> result = [];
  int j = 0;
  for (int i = 0; i < input.length / 2; i++) {
    result.add(input[j] + input[j + 1]);
    j = j + 2;
  }
  return result;
}
