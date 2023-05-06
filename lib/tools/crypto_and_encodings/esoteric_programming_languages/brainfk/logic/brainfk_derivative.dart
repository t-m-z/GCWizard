
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/brainfk/logic/brainfk.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/substitution/logic/substitution.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/string_utils.dart';

class BrainfkDerivatives {
  late Map<String, String> substitutions;
  final String? commandDelimiter;

  BrainfkDerivatives({
      required String pointerShiftLeftInstruction,
      required String pointerShiftRightInstruction,
      required String decreaseValueInstruction,
      required String increaseValueInstruction,
      required String startLoopInstruction,
      required String endLoopInstruction,
      required String inputInstruction,
      required String outputInstruction,
      this.commandDelimiter,
  }) {
    substitutions = {
      pointerShiftRightInstruction: '>',
      pointerShiftLeftInstruction: '<',
      increaseValueInstruction: '+',
      decreaseValueInstruction: '-',
      outputInstruction: '.',
      inputInstruction: ',',
      startLoopInstruction: '[',
      endLoopInstruction: ']'
    };
  }

    String interpretBrainfkDerivatives(String code, {String? input}) {
    if (code.isEmpty) return '';

    String brainfk = '';

    List<String> derivate = [];
    for (MapEntry<String, String> entry in substitutions.entries) {
      derivate.add(entry.key);
    }
    derivate.sort((a, b) => a.length.compareTo(b.length));
    derivate = derivate.reversed.toList();

    bool breakLoop = false;
    while (code.isNotEmpty) {
      breakLoop = false;
      for (var command in derivate){
        if (code.startsWith(command)){
          brainfk += substitutions[command]!;
          code = code.substring(command.length);
          breakLoop = true;
          break;
        }
      }
      if (!breakLoop) {
        code = code.substring(1);
      }
    }

    return interpretBrainfk(brainfk, input: input);
  }

  String generateBrainfkDerivative(String text) {
    if (text.isEmpty) return '';

    var brainfk = generateBrainfk(text);
    if (commandDelimiter != null && commandDelimiter!.isNotEmpty) {
      brainfk = insertEveryNthCharacter(brainfk, 1, commandDelimiter!);
    }

    return substitution(brainfk, switchMapKeyValue(substitutions));
  }
}

// https://esolangs.org/wiki/Trivial_brainfuck_substitution

final BrainfkDerivatives BRAINFKDERIVATIVE_OMAM = BrainfkDerivatives(
    pointerShiftRightInstruction: 'hold your horses now',
    pointerShiftLeftInstruction: 'sleep until the sun goes down',
    increaseValueInstruction: 'through the woods we ran',
    decreaseValueInstruction: 'deep into the mountain sound',
    outputInstruction: 'don' "'" 't listen to a word i say',
    inputInstruction: 'the screams all sound the same',
    startLoopInstruction: 'though the truth may vary',
    endLoopInstruction: 'this ship will carry',
    commandDelimiter: '\n');

final BrainfkDerivatives BRAINFKDERIVATIVE_REVOLUTION9 = BrainfkDerivatives(
    pointerShiftRightInstruction: 'It' "'" 's alright',
    pointerShiftLeftInstruction: 'turn me on, dead man',
    increaseValueInstruction: 'Number 9',
    decreaseValueInstruction: 'if you become naked',
    outputInstruction: 'The Beatles',
    inputInstruction: 'Paul is dead',
    startLoopInstruction: 'Revolution 1',
    endLoopInstruction: 'Revolution 9',
    commandDelimiter: '\n');

final BrainfkDerivatives BRAINFKDERIVATIVE_DETAILEDFK = BrainfkDerivatives(
    pointerShiftRightInstruction: 'MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT',
    pointerShiftLeftInstruction: 'MOVE THE MEMORY POINTER ONE CELL TO THE LEFT',
    increaseValueInstruction: 'INCREMENT THE CELL UNDER THE MEMORY POINTER BY ONE',
    decreaseValueInstruction: 'DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE',
    outputInstruction: 'PRINT THE CELL UNDER THE MEMORY POINTER' "'" 'S VALUE AS AN ASCII CHARACTER',
    inputInstruction:
        'REPLACE THE CELL UNDER THE MEMORY POINTER' "'" 'S VALUE WITH THE ASCII CHARACTER CODE OF USER INPUT',
    endLoopInstruction: 'IF THE CELL UNDER THE MEMORY POINTER' "'" 'S VALUE IS ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE ] COMMAND IN BRAINFUCK',
    startLoopInstruction: 'IF THE CELL UNDER THE MEMORY POINTER' "'" 'S VALUE IS NOT ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE [ COMMAND IN BRAINFUCK',
    commandDelimiter: '\n');

final BrainfkDerivatives BRAINFKDERIVATIVE_GERMAN = BrainfkDerivatives(
    pointerShiftRightInstruction: 'Links',
    pointerShiftLeftInstruction: 'Rechts',
    increaseValueInstruction: 'Addition',
    decreaseValueInstruction: 'Subtraktion',
    outputInstruction: 'Eingabe',
    inputInstruction: 'Ausgabe',
    startLoopInstruction: 'Schleifenanfang',
    endLoopInstruction: 'Schleifenende',
    commandDelimiter: '\n');

final BrainfkDerivatives BRAINFKDERIVATIVE_COLONOSCOPY = BrainfkDerivatives(
    pointerShiftRightInstruction: ';};',
    pointerShiftLeftInstruction: ';{;',
    increaseValueInstruction: ';;};',
    decreaseValueInstruction: ';;{;',
    outputInstruction: ';;;};',
    inputInstruction: ';;;{;',
    startLoopInstruction: '{{;',
    endLoopInstruction: '}};',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_KONFK = BrainfkDerivatives(
    pointerShiftRightInstruction: 'うんうんうん',
    pointerShiftLeftInstruction: 'うんうんたん',
    increaseValueInstruction: 'うんたんうん',
    decreaseValueInstruction: 'うんたんたん',
    outputInstruction: 'たんうんうん',
    inputInstruction: 'たんうんたん',
    startLoopInstruction: 'たんたんうん',
    endLoopInstruction: 'たんたんたん',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_FKBEES = BrainfkDerivatives(
    pointerShiftRightInstruction: 'f',
    pointerShiftLeftInstruction: 'u',
    increaseValueInstruction: 'c',
    decreaseValueInstruction: 'k',
    outputInstruction: 'b',
    inputInstruction: 'e',
    startLoopInstruction: 'E',
    endLoopInstruction: 's',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_PSSCRIPT = BrainfkDerivatives(
    pointerShiftRightInstruction: '8=D',
    pointerShiftLeftInstruction: '8==D',
    increaseValueInstruction: '8===D',
    decreaseValueInstruction: '8====D',
    outputInstruction: '8=====D',
    inputInstruction: '8======D',
    startLoopInstruction: '8=======D',
    endLoopInstruction: '8========D',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_ALPHK = BrainfkDerivatives(
    pointerShiftRightInstruction: 'a',
    pointerShiftLeftInstruction: 'c',
    increaseValueInstruction: 'e',
    decreaseValueInstruction: 'i',
    outputInstruction: 'j',
    inputInstruction: 'o',
    startLoopInstruction: 'p',
    endLoopInstruction: 's');

final BrainfkDerivatives BRAINFKDERIVATIVE_REVERSEFK = BrainfkDerivatives(
    pointerShiftRightInstruction: '<',
    pointerShiftLeftInstruction: '>',
    increaseValueInstruction: '-',
    decreaseValueInstruction: '+',
    outputInstruction: ',',
    inputInstruction: '.',
    startLoopInstruction: ']',
    endLoopInstruction: '[');

final BrainfkDerivatives BRAINFKDERIVATIVE_BTJZXGQUARTFRQIFJLV = BrainfkDerivatives(
    pointerShiftRightInstruction: 'f',
    pointerShiftLeftInstruction: 'rqi',
    increaseValueInstruction: 'qua',
    decreaseValueInstruction: 'rtf',
    outputInstruction: 'lv',
    inputInstruction: 'j',
    startLoopInstruction: 'btj',
    endLoopInstruction: 'zxg',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_BINARYFK = BrainfkDerivatives(
    pointerShiftRightInstruction: '010',
    pointerShiftLeftInstruction: '011',
    increaseValueInstruction: '000',
    decreaseValueInstruction: '001',
    outputInstruction: '100',
    inputInstruction: '101',
    startLoopInstruction: '110',
    endLoopInstruction: '111',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_TERNARY = BrainfkDerivatives(
    pointerShiftRightInstruction: '01',
    pointerShiftLeftInstruction: '00',
    increaseValueInstruction: '11',
    decreaseValueInstruction: '10',
    outputInstruction: '20',
    inputInstruction: '21',
    startLoopInstruction: '02',
    endLoopInstruction: '12',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_KENNYSPEAK = BrainfkDerivatives(
    pointerShiftRightInstruction: 'mmp',
    pointerShiftLeftInstruction: 'mmm',
    increaseValueInstruction: 'mpp',
    decreaseValueInstruction: 'pmm',
    outputInstruction: 'fmm',
    inputInstruction: 'fpm',
    startLoopInstruction: 'mmf',
    endLoopInstruction: 'mpf',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_MORSEFK = BrainfkDerivatives(
    pointerShiftRightInstruction: '.--',
    pointerShiftLeftInstruction: '--.',
    increaseValueInstruction: '..-',
    decreaseValueInstruction: '-..',
    outputInstruction: '-.-',
    inputInstruction: '.-.',
    startLoopInstruction: '---',
    endLoopInstruction: '...',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_AAA = BrainfkDerivatives(
    pointerShiftRightInstruction: 'aAaA',
    pointerShiftLeftInstruction: 'AAaa',
    increaseValueInstruction: 'AAAA',
    decreaseValueInstruction: 'AaAa',
    outputInstruction: 'aaaa',
    inputInstruction: 'aAaa',
    startLoopInstruction: 'aaAA',
    endLoopInstruction: 'aaaA',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_BLUB = BrainfkDerivatives(
    pointerShiftRightInstruction: 'Blub. Blub?',
    pointerShiftLeftInstruction: 'Blub? Blub.',
    increaseValueInstruction: 'Blub. Blub.',
    decreaseValueInstruction: 'Blub! Blub!',
    outputInstruction: 'Blub! Blub.',
    inputInstruction: 'Blub. Blub!',
    startLoopInstruction: 'Blub! Blub?',
    endLoopInstruction: 'Blub? Blub!',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_OOK = BrainfkDerivatives(
    pointerShiftRightInstruction: 'Ook. Ook?',
    pointerShiftLeftInstruction: 'Ook? Ook.',
    increaseValueInstruction: 'Ook. Ook.',
    decreaseValueInstruction: 'Ook! Ook!',
    outputInstruction: 'Ook! Ook.',
    inputInstruction: 'Ook. Ook!',
    startLoopInstruction: 'Ook! Ook?',
    endLoopInstruction: 'Ook? Ook!',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_SHORTOOK = BrainfkDerivatives(
    pointerShiftRightInstruction: '.?',
    pointerShiftLeftInstruction: '?.',
    increaseValueInstruction: '..',
    decreaseValueInstruction: '!!',
    outputInstruction: '!.',
    inputInstruction: '.!',
    startLoopInstruction: '!?',
    endLoopInstruction: '?!',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_NAK = BrainfkDerivatives(
    pointerShiftRightInstruction: 'Nak. Nak?',
    pointerShiftLeftInstruction: 'Nak? Nak.',
    increaseValueInstruction: 'Nak. Nak.',
    decreaseValueInstruction: 'Nak! Nak!',
    outputInstruction: 'Nak! Nak.',
    inputInstruction: 'Nak. Nak!',
    startLoopInstruction: 'Nak! Nak?',
    endLoopInstruction: 'Nak? Nak!',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_PIKALANG = BrainfkDerivatives(
    pointerShiftRightInstruction: 'pipi',
    pointerShiftLeftInstruction: 'pichu',
    increaseValueInstruction: 'pi',
    decreaseValueInstruction: 'ka',
    outputInstruction: 'pikachu',
    inputInstruction: 'pikapi',
    startLoopInstruction: 'pika',
    endLoopInstruction: 'chu',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_PEWLANG = BrainfkDerivatives(
    pointerShiftRightInstruction: 'pew',
    pointerShiftLeftInstruction: 'Pew',
    increaseValueInstruction: 'pEw',
    decreaseValueInstruction: 'peW',
    outputInstruction: 'PEw',
    inputInstruction: 'pEW',
    startLoopInstruction: 'PeW',
    endLoopInstruction: 'PEW',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_ROADRUNNER = BrainfkDerivatives(
    pointerShiftRightInstruction: 'meeP',
    pointerShiftLeftInstruction: 'Meep',
    increaseValueInstruction: 'mEEp',
    decreaseValueInstruction: 'MeeP',
    outputInstruction: 'MEEP',
    inputInstruction: 'meep',
    startLoopInstruction: 'mEEP',
    endLoopInstruction: 'MEEp',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_ZZZ = BrainfkDerivatives(
    pointerShiftRightInstruction: 'zz',
    pointerShiftLeftInstruction: '-zz',
    increaseValueInstruction: 'z',
    decreaseValueInstruction: '-z',
    outputInstruction: 'zzz',
    inputInstruction: '-zzz',
    startLoopInstruction: 'z+z',
    endLoopInstruction: 'z-z',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_SCREAMCODE = BrainfkDerivatives(
    pointerShiftRightInstruction: 'AAAH',
    pointerShiftLeftInstruction: 'AAAAGH',
    increaseValueInstruction: 'F*CK',
    decreaseValueInstruction: 'SHIT',
    outputInstruction: '!!!!!!',
    inputInstruction: 'WHAT?',
    startLoopInstruction: 'OW',
    endLoopInstruction: 'OWIE',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_FLUFFLEPUFF = BrainfkDerivatives(
    pointerShiftRightInstruction: 'b',
    pointerShiftLeftInstruction: 't',
    increaseValueInstruction: 'pf',
    decreaseValueInstruction: 'bl',
    outputInstruction: '!',
    inputInstruction: '?',
    startLoopInstruction: '*gasp*',
    endLoopInstruction: '*pomf*',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_TRIPLET = BrainfkDerivatives(
    pointerShiftRightInstruction: '001',
    pointerShiftLeftInstruction: '100',
    increaseValueInstruction: '111',
    decreaseValueInstruction: '000',
    outputInstruction: '010',
    inputInstruction: '101',
    startLoopInstruction: '110',
    endLoopInstruction: '011',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_UWU = BrainfkDerivatives(
    pointerShiftRightInstruction: 'OwO',
    pointerShiftLeftInstruction: '°w°',
    increaseValueInstruction: 'UwU',
    decreaseValueInstruction: 'QwQ',
    outputInstruction: '@w@',
    inputInstruction: '>w<',
    startLoopInstruction: '~w~',
    endLoopInstruction: '-w-',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE___FK = BrainfkDerivatives(
    pointerShiftRightInstruction: '!!!!!#',
    pointerShiftLeftInstruction: '!!!!!!#',
    increaseValueInstruction: '!!!!!!!#',
    decreaseValueInstruction: '!!!!!!!!#',
    outputInstruction: '!!!!!!!!!!#',
    inputInstruction: '!!!!!!!!!#',
    startLoopInstruction: '!!!!!!!!!!!#',
    endLoopInstruction: '!!!!!!!!!!!!#',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_WEPMLRIO = BrainfkDerivatives(
    pointerShiftRightInstruction: 'r',
    pointerShiftLeftInstruction: 'l',
    increaseValueInstruction: 'p',
    decreaseValueInstruction: 'm',
    outputInstruction: 'o',
    inputInstruction: 'I',
    startLoopInstruction: 'w',
    endLoopInstruction: 'e',
    commandDelimiter: '');

final BrainfkDerivatives BRAINFKDERIVATIVE_HTPF = BrainfkDerivatives(
    pointerShiftRightInstruction: '>',
    pointerShiftLeftInstruction: '<',
    increaseValueInstruction: '=',
    decreaseValueInstruction: '/',
    outputInstruction: '"',
    inputInstruction: '#',
    startLoopInstruction: '&',
    endLoopInstruction: ';',
    commandDelimiter: '');

final BrainfkDerivatives BRAINFKDERIVATIVE_GIBMEROL = BrainfkDerivatives(
    pointerShiftRightInstruction: 'G',
    pointerShiftLeftInstruction: 'i',
    increaseValueInstruction: 'b',
    decreaseValueInstruction: 'M',
    outputInstruction: 'e',
    inputInstruction: 'R',
    startLoopInstruction: 'o',
    endLoopInstruction: 'l',
    commandDelimiter: '');

final BrainfkDerivatives BRAINFKDERIVATIVE_NAGAWOOSKI = BrainfkDerivatives(
    pointerShiftRightInstruction: 'na',
    pointerShiftLeftInstruction: 'ga',
    increaseValueInstruction: 'woo',
    decreaseValueInstruction: 'ski',
    outputInstruction: 'an',
    inputInstruction: 'ag',
    startLoopInstruction: 'oow',
    endLoopInstruction: 'iks',
    commandDelimiter: '');

final BrainfkDerivatives BRAINFKDERIVATIVE_MIERDA = BrainfkDerivatives(
    pointerShiftRightInstruction: 'Derecha',
    pointerShiftLeftInstruction: 'Izquierda',
    increaseValueInstruction: 'Mas',
    decreaseValueInstruction: 'Menos',
    outputInstruction: 'Decir',
    inputInstruction: 'Leer',
    startLoopInstruction: 'Iniciar Bucle',
    endLoopInstruction: 'Terminar Bucle',
    commandDelimiter: ' ');

final BrainfkDerivatives BRAINFKDERIVATIVE_CUSTOM = BrainfkDerivatives(
    pointerShiftRightInstruction: '',
    pointerShiftLeftInstruction: '',
    increaseValueInstruction: '',
    decreaseValueInstruction: '',
    outputInstruction: '',
    inputInstruction: '',
    startLoopInstruction: '',
    endLoopInstruction: '',
    commandDelimiter: ' ');

// NEVER EVER CHANGE THE NAMES! (the value strings of the map);
// They are used as keys in the multi decoder
final Map<BrainfkDerivatives, String> BRAINFK_DERIVATIVES = {
  BRAINFKDERIVATIVE___FK: '!!F**k',
  BRAINFKDERIVATIVE_AAA: 'AAA',
  BRAINFKDERIVATIVE_ALPHK: 'Alph**k',
  BRAINFKDERIVATIVE_BINARYFK: 'BinaryFuck',
  BRAINFKDERIVATIVE_BLUB: 'Blub',
  BRAINFKDERIVATIVE_BTJZXGQUARTFRQIFJLV: 'Btjzxgquartfrqifjlv',
  BRAINFKDERIVATIVE_COLONOSCOPY: 'Colonoscopy',
  BRAINFKDERIVATIVE_DETAILEDFK: 'DetailedF**k',
  BRAINFKDERIVATIVE_FLUFFLEPUFF: 'Fluffle Puff',
  BRAINFKDERIVATIVE_FKBEES: 'f**kbeEs',
  BRAINFKDERIVATIVE_GERMAN: 'GERMAN',
  BRAINFKDERIVATIVE_KENNYSPEAK: 'Kenny Speak',
  BRAINFKDERIVATIVE_KONFK: 'K-on F**k',
  BRAINFKDERIVATIVE_MORSEFK: 'MorseF**k',
  BRAINFKDERIVATIVE_NAK: 'Nak',
  BRAINFKDERIVATIVE_OMAM: 'Omam',
  BRAINFKDERIVATIVE_OOK: 'Ook',
  BRAINFKDERIVATIVE_PSSCRIPT: 'P***sScript',
  BRAINFKDERIVATIVE_PEWLANG: 'PewLang',
  BRAINFKDERIVATIVE_PIKALANG: 'PikaLang',
  BRAINFKDERIVATIVE_REVERSEFK: 'ReverseF**k',
  BRAINFKDERIVATIVE_REVOLUTION9: 'Revolution 9',
  BRAINFKDERIVATIVE_ROADRUNNER: 'Roadrunner',
  BRAINFKDERIVATIVE_SCREAMCODE: 'ScreamCode',
  BRAINFKDERIVATIVE_SHORTOOK: 'Short Ook',
  BRAINFKDERIVATIVE_TERNARY: 'Ternary',
  BRAINFKDERIVATIVE_TRIPLET: 'Triplet',
  BRAINFKDERIVATIVE_UWU: 'UwU',
  BRAINFKDERIVATIVE_ZZZ: 'ZZZ',
  BRAINFKDERIVATIVE_WEPMLRIO: 'wepmlrIo',
  BRAINFKDERIVATIVE_HTPF: 'HTPF',
  BRAINFKDERIVATIVE_MIERDA: 'Mierda',
  BRAINFKDERIVATIVE_GIBMEROL: 'GibMeRol',
  BRAINFKDERIVATIVE_NAGAWOOSKI: 'Nagawooski',
  BRAINFKDERIVATIVE_CUSTOM: 'Custom',
};
