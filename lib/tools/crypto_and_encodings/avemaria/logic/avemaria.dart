import 'dart:math';

part 'package:gc_wizard/tools/crypto_and_encodings/avemaria/logic/avemaria_data.dart';

String decodeAveMaria(String chiffre) {
  List<String> result = [];
  List<String> code = chiffre.toLowerCase().split('  ');

<<<<<<< HEAD
  for (var word in code) {
    word.split(' ').forEach((letter) {
      if (_AVE_MARIA_DECODE[letter] == null) {
=======
  for (String word in code) {
    for (String letter in word.split(' ')) {
      if (_AVE_MARIA[letter] == null) {
>>>>>>> 05ad593f1ef25550d7cffee8a14d8c1246eab8e2
        result.add(' ');
      } else {
        result.add(_AVE_MARIA[letter]!);
      }
<<<<<<< HEAD
    });
=======
    }
>>>>>>> 05ad593f1ef25550d7cffee8a14d8c1246eab8e2
  }
  return result.join('');
}

String encodeAveMaria(String plain) {
  List<String> result = [];
  List<String> code = plain.toUpperCase().split(' ');
  var aveMaria = _AVE_MARIA.entries.toList();
  aveMaria.addAll(_AVE_MARIA_ENCODE_EXTENSION);

  for (String word in code) {
    for (String letter in word.split('')) {
      var results = aveMaria.where((entry) => entry.value == letter);
      if (results.isNotEmpty) {
        result.add(results.elementAt(Random().nextInt(results.length)).key);
      }
    }
<<<<<<< HEAD
  });
  return result.join(' ');
}
=======
    result.add(' ');
  }
  return result.join(' ').trim();
}
>>>>>>> 05ad593f1ef25550d7cffee8a14d8c1246eab8e2
