// https://www.geocaching.com/geocache/GC9R4YE_barossa-121

import 'package:gc_wizard/tools/crypto_and_encodings/substitution/logic/substitution.dart';
import 'package:gc_wizard/tools/science_and_technology/spelling_alphabets/_common/spelling_alphabets_data.dart';

String encodeSpellingAlphabets(String plain, SPELLING language) {
  List<String> result = [];
  Map<String, String> alphabet = SPELLING_ALPHABETS[language]!;

<<<<<<< HEAD
  plain.toUpperCase().split('').forEach((letter) {
=======
  if (plain.isEmpty) return '';

  plain.toUpperCase().split('').forEach((letter){
>>>>>>> 05ad593f1ef25550d7cffee8a14d8c1246eab8e2
    if (alphabet[letter] != null) {
      result.add(alphabet[letter]!.toUpperCase());
    }
  });
  return result.join(' ');
}

String decodeSpellingAlphabets(String chiffre, SPELLING language) {
  Map<String, String> alphabet = {};

  if (chiffre.isEmpty) return '';

  SPELLING_ALPHABETS[language]!.forEach((key, value) {
    alphabet[value.toUpperCase()] = key;
  });

<<<<<<< HEAD
  chiffre.toUpperCase().split(' ').forEach((word) {
    if (alphabet[word] == null) {
      result.add(' ');
    } else {
      result.add(alphabet[word]!);
    }
  });
  return result.join('');
}
=======
  return substitution(chiffre.toUpperCase(), alphabet, caseSensitive: false).replaceAll(' ', '');
}
>>>>>>> 05ad593f1ef25550d7cffee8a14d8c1246eab8e2
