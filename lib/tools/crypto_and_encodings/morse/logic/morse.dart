import 'package:audioplayers/audioplayers.dart';
import 'package:gc_wizard/utils/collection_utils.dart';

part 'package:gc_wizard/tools/crypto_and_encodings/morse/logic/morse_data.dart';

final Map<String, AssetSource> MORSE_TONE = {
  '.' : AssetSource('audio/morseSymbolDit.mp3'),  // 1 dit
  '-' : AssetSource('audio/morseSymbolDah.mp3'),  // 1 dah = 3 dit
  ',' : AssetSource('audio/morseSpaceSymbol.mp3'),  // 1 dit Pause zwischen dit/dah
  String.fromCharCode(8195) : AssetSource('audio/morseSpaceLetter.mp3'),  // 3 dit Pause zwischen Buchstaben
  '|' : AssetSource('audio/morseSpaceWord.mp3'),  // 7 dit Pause zwischen Wörter
};

enum MORSE_CODE {MORSE_ITU, AMERICAN, STEINHEIL, GERKE}

final Map<MORSE_CODE, String> MORSE_CODES = {
  MORSE_CODE.MORSE_ITU: 'Morse (ITU)',
  MORSE_CODE.AMERICAN: 'Morse',
  MORSE_CODE.GERKE: 'Gerke',
  MORSE_CODE.STEINHEIL: 'Steinheil',
};

final Map<MORSE_CODE, Map<String, String>> _AZTO_MORSE_CODE = {
  MORSE_CODE.MORSE_ITU: _AZToMorse,
  MORSE_CODE.AMERICAN: _AZToMorseOriginal,
  MORSE_CODE.GERKE: _AZToGerke,
  MORSE_CODE.STEINHEIL: _AZToSteinheil,
};

final Map<MORSE_CODE, Map<String, String>> _MORSE_CODETOAZ = {
  MORSE_CODE.MORSE_ITU: _MorseToAZ,
  MORSE_CODE.AMERICAN: _MorseOriginalToAZ,
  MORSE_CODE.GERKE: _GerkeToAZ,
  MORSE_CODE.STEINHEIL: _SteinheilToAZ,
};


String encodeMorse(String input, MORSE_CODE code) {
  if (input.isEmpty) return '';

  return input.toUpperCase().split('').map((character) {
    if (character == ' ') return '|';

    var morse = _AZTO_MORSE_CODE[code]?[character];
    return morse ?? '';
  }).join(String.fromCharCode(8195)); // using wide space
}

String decodeMorse(String input, MORSE_CODE code) {
  if (input.isEmpty) return '';

  return input.split(RegExp(r'[^\.\-/\|]')).map((morse) {
    if (morse == '|' || morse == '/') return ' ';

    var character = _MORSE_CODETOAZ[code]?[morse];
    return character ?? '';
  }).join();
}
