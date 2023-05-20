import 'package:audioplayers/audioplayers.dart';
import 'package:gc_wizard/utils/collection_utils.dart';

final Map<String, AssetSource> MORSE_TONE = {
  '.': AssetSource('audio/morseSymbolDit.mp3'), // 1 dit
  '-': AssetSource('audio/morseSymbolDah.mp3'), // 1 dah = 3 dit
  ',': AssetSource('audio/morseSpaceSymbol.mp3'), // 1 dit Pause zwischen dit/dah
  String.fromCharCode(8195): AssetSource('audio/morseSpaceLetter.mp3'), // 3 dit Pause zwischen Buchstaben
  '|': AssetSource('audio/morseSpaceWord.mp3'), // 7 dit Pause zwischen Wörter
};

const Map<String, String> AZToMorse = {
  'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 'F': '..-.', 'G': '--.', 'H': '....', 'I': '..',
  'J': '.---', 'K': '-.-', 'L': '.-..', 'M': '--',
  'N': '-.', 'O': '---', 'P': '.--.', 'Q': '--.-', 'R': '.-.', 'S': '...', 'T': '-', 'U': '..-', 'V': '...-',
  'W': '.--', 'X': '-..-', 'Y': '-.--', 'Z': '--..',
  '1': '.----', '2': '..---', '3': '...--', '4': '....-', '5': '.....', '6': '-....', '7': '--...', '8': '---..',
  '9': '----.', '0': '-----',
  '\u00C5': '.--.-', //Å
  '\u00C0': '.--.-', //À
  '\u00C4': '.-.-', //Ä
  '\u00C8': '.-..-', //È
  '\u00C9': '..-..', //É
  '\u00D6': '---.', //Ö
  '\u00DC': '..--', //Ü
  '\u00DF': '...--..', //ß
  '\u00D1': '--.--', //Ñ
  'CH': '----', '.': '.-.-.-', ',': '--..--', ':': '---...', ';': '-.-.-.', '?': '..--..', '@': '.--.-.',
  '-': '-....-', '_': '..--.-', '(': '-.--.', ')': '-.--.-', '\'': '.----.', '=': '-...-', '+': '.-.-.', '/': '-..-.',
  '!': '-.-.--'
};

// Å has same code as À, so À replaces Å in mapping; Å will not occur in this map
final MorseToAZ = switchMapKeyValue(AZToMorse);

String encodeMorse(String input) {
  if (input.isEmpty) return '';

  return input.toUpperCase().split('').map((character) {
    if (character == ' ') return '|';

    var morse = AZToMorse[character];
    return morse ?? '';
  }).join(String.fromCharCode(8195)); // using wide space
}

String decodeMorse(String input) {
  if (input.isEmpty) return '';

  return input.split(RegExp(r'[^\.\-/\|]')).map((morse) {
    if (morse == '|' || morse == '/') return ' ';

    var character = MorseToAZ[morse];
    return character ?? '';
  }).join();
}
