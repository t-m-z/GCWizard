// https://www.geocaching.com/geocache/GC8PJEQ
//
// ASSDWW.DSAWSSDW.WWDSSA.WWA.WDSASDW   => 08078
//
// SDWSS.AWDSSA.SAWDWAS.ASSDWA.DWWASS   => 49860
//
// ss dsasd dsadsa sdwawd asdsa ssdwwa ww sswaw dwawd asdsa sdwss wwa wasdsaw wwsaw ww awdwa awdwa ss sdsww asdsa dwadwass ss sawwds
// wdddsaasasdsdwwdss wdwaaaaaaaaaaaaaaaasssa

// https://www.geocaching.com/geocache/GC5QNK6_random-walk
// N: ESSNESWSENSSSENSSNESWSENESSWNNWSENSS
// E: ESSWNNSSWSESWESWESWESWSESSENWESSESSWNN
// ESS NESWSEN SS SENSS NESWSEN ESSWNN WSENSS SS WSESW ESWESW ESWSE SSENW ESS ESSWNN
// ESS NESWSEN SS SENSS NESWSEN ESSWNN WSENSS  => 7824809
// SS WSESW ESWESW ESWSE SSENW ESS ESSWNN      => 01532670
//
// https://www.geocaching.com/geocache/GC9K0X7_weihnachten-2021
// ↗↑↑↑↑↑→↓↓↓↓↓→↑↑↗↑↑↑↗↑↑↗↑↑↗↑↑↑↑↑↑→↓↓↓↓↗↑↗↗↗↗↑↑↑↑↑→↓↓↓↓↓↗↗→↗→↗→→↗↑↑↑↑↑→↓↓↓↓↓→↗→→→→→→↘→↑↑↑↑↑→↓↓↓↓↓↘→→↘→↘→↘↘↑↑↑↑↑→↓↓↓↓↓↘↘↘↘↓↘↑↑↑↑→↓↓↓↓↓↓↘↓↓↘↓↓↘↓↓↓↘↓↓→↑↑↑↑↑→↓↓↓↓↓↘←←←←←←←←←←←←←←←↑→→↑↑↑←←↑→→↑←←←↓↓↓→→↓←←↓↓←←←↑→→↑↑↑↑←←↓→↑→↑←←←↓↓↓→→↓←←↓↓←↑↑↑↑↑↑←↓↓↓↓↓↓←←←↑→→↑←←↑→↑←↑→→↑←←←↓↓↓↓↓↓←←↑↑↑↑↑↑↑↑→→→→→→→↖↖→↖↖→↖↖→↖↖→↖↖→↖↖→↖↖↙↙→↙↙→↙↙→↙↙→↙↙→↙↙→↙↙→→→→→→→↓↓↓↓↓↓↓↓←←←←↑→→↑←←↑→→↑↑↑←←←↓→→↓←←↓↓↓↓←←←↑→→↑↑↑↑↑←←←↓→→↓←↓→↓←←↓↓←←←↑→→↑↑↑↑↑←←←↓→→↓←↓→↓←←↓↓←←←←←←↑↑↑↑↑↘↘↘↘→↑↑↑↑↑←↓↓↓↓↖↖↖↖←↓↓↓↓↓↓←←←←←←←←
//

import 'dart:math';

import 'package:gc_wizard/tools/crypto_and_encodings/substitution/logic/substitution.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

class Offset {
  final int xOffset;
  final int yOffset;
  final int leftBorder;
  Offset(this.xOffset, this.yOffset, this.leftBorder);
}

enum WASD_TYPE { CURSORS, WASD, IJMK, ESDF, ULDR, OLUR, VLZR, WQSE, ARROWS, NWSE, NWSO, NUMERIC, CUSTOM }

enum WASD_DIRECTION { UP, DOWN, LEFT, RIGHT, START, UPLEFT, UPRIGHT, DOWNLEFT, DOWNRIGHT }

const _SEGMENT_LENGTH = 5;

const Map<WASD_TYPE, String> KEYBOARD_CONTROLS = {
  WASD_TYPE.CURSORS: '↑←↓→↖↗↙↘',
  WASD_TYPE.NWSE: 'NWSE    ',
  WASD_TYPE.NWSO: 'NWSO    ',
  WASD_TYPE.ARROWS: '^<v>    ',
  WASD_TYPE.WASD: 'WASDQEYX',
  WASD_TYPE.ULDR: 'ULDR    ',
  WASD_TYPE.OLUR: 'OLUR    ',
  WASD_TYPE.ESDF: 'ESDFWRXC',
  WASD_TYPE.WQSE: 'WQSE    ',
  WASD_TYPE.IJMK: 'IJMKUON;',
  WASD_TYPE.VLZR: 'VLZR',
  WASD_TYPE.NUMERIC: 'wasd_keyboard_keypad',
  WASD_TYPE.CUSTOM: 'wasd_keyboard_custom',
};

const Map<String, List<String>> _WASD_ENCODE = {
  '0': [
    '←↓↓→↑↑',
    '↓↓→↑↑←',
    '↓→↑↑←↓',
    '→↑↑←↓↓',
    '↑↑←↓↓→',
    '↑←↓↓→↑',
    '↑↑→↓↓←',
    '↑→↓↓←↑',
    '→↓↓←↑↑',
    '↓↓←↑↑→',
    '↓←↑↑→↓',
    '←↑↑→↓↓'
  ],
  '1': ['↑↑', '↓↓'],
  '2': ['→↓←↓→', '←↑→↑←'],
  '3': ['→↓←→↓←', '→↑←→↑←'],
  '4': ['↓→↑↓↓', '↓→↓↑↑', '↑↑↓←↑', '↓↓↑←↑'],
  '5': ['→↑←↑→', '←↓→↓←'],
  '6': ['←↓↓→↑←', '↓↓→↑←', '→↓←↑↑→', '→↓←↑↑', '←↓→↓←↑', '↓→↑←↑→', '↓→↑←↑', '↓→↓←↑'],
  '7': ['↑↑←', '→↓↓'],
  '8': [
    '↓→↓←↑→↑←',
    '→↓←↓→↑←↑',
    '↑→↓←↓→↑',
    '↓←↑→↑←↓',
    '↑←↓→↓←↑',
    '↓→↑←↑→↓',
    '←↓→↓←↑→↑',
    '↓←↓→↑←↑→',
    '↑→↑←↓→↓←',
    '→↑←↑→↓←↓',
    '←↑→↑←↓→↓',
    '↑←↑→↓←↓→',
    '↑↑→↓←→↓←',
    '→↑←→↑←↓↓',
    '↑↑←↓→←↓→',
    '←↑→←↑→↓↓',
    '↓↓→↑←→↑←',
    '→↓←→↓←↑↑',
    '↓↓←↑→←↑→',
    '←↓→←↓→↑↑',
    '→↓←↑↓↓→↑'
  ],
  '9': [
    '←↓→↓↑↑',
    '←↑→↓↓',
    '↑←↓→↓',
    '←↑→↓↓←',
    '↑←↓→↓←',
    '←↓→↓←→↑↑',
    '↑↑←↓→',
    '↑←↑→↓',
    '→↑↑←↓→',
    '→↑←↑→↓',
    '↓↓←→↑←↑→',
    '←↓→↑↓↓',
    '←↓→↑↓↓←'
  ],
  ' ': [' '],
  '.': ['.']
};

final Map<List<String>, String> _WASD_DECODE = switchMapKeyValue(_WASD_ENCODE);

String encodeWASD(String input, List<String> controlSet) {
  if (input.isEmpty) return '';

  controlSet = _normalizeControlSet(controlSet);

  input = input.toUpperCase();
  Random rnd = Random();
  List<String> result = [];
  input.split('').forEach((element) {
    if (_WASD_ENCODE[element] == null) {
      result.add('');
    } else {
      result.add(_WASD_ENCODE[element]![rnd.nextInt(_WASD_ENCODE[element]!.length)].toString());
    }
  });

  return substitution(result.join(' '), {
    '↑': controlSet[0],
    '←': controlSet[1],
    '↓': controlSet[2],
    '→': controlSet[3],
    '↖': controlSet[4],
    '↗': controlSet[5],
    '↙': controlSet[6],
    '↘': controlSet[7],
  });
}

String _normalizeDecodingInput(String input, List<String> controlSet) {
  var pattern = '[^' + controlSet.join().toUpperCase() + ']';

  input = input.toUpperCase().replaceAll(RegExp(pattern), ' ');

  return substitution(input, {
    controlSet[0]: '↑',
    controlSet[1]: '←',
    controlSet[2]: '↓',
    controlSet[3]: '→',
    controlSet[4]: '↖',
    controlSet[5]: '↗',
    controlSet[6]: '↙',
    controlSet[7]: '↘',
  });
}

String decodeWASD(String input, List<String> controlSet) {
  if (input.isEmpty) return '';
  controlSet = _normalizeControlSet(controlSet);

  List<String> resultDecode = [];
  bool found = false;
  String result = '';

  _normalizeDecodingInput(input, controlSet).split(' ').forEach((element) {
    if (element.isNotEmpty) {
      _WASD_DECODE.forEach((key, value) {
        if (key.contains(element)) {
          found = true;
          result = value;
        }
      });
      if (found) {
        resultDecode.add(result);
        found = false;
      } else {
        resultDecode.add(UNKNOWN_ELEMENT);
      }
    }
  });
  return resultDecode.join('');
}

List<String> _normalizeControlSet(List<String> controlSet) {
  var normalized = List<String?>.from(controlSet);
  while (normalized.length < 4) {
    normalized.add(null);
  }

  if (normalized[0] == null || normalized[0]!.isEmpty) normalized[0] = '↑';
  if (normalized[1] == null || normalized[1]!.isEmpty) normalized[1] = '←';
  if (normalized[2] == null || normalized[2]!.isEmpty) normalized[2] = '↓';
  if (normalized[3] == null || normalized[3]!.isEmpty) normalized[3] = '→';
  if (normalized[4] == null || normalized[4]!.isEmpty) normalized[3] = '↖';
  if (normalized[5] == null || normalized[5]!.isEmpty) normalized[3] = '↗';
  if (normalized[6] == null || normalized[6]!.isEmpty) normalized[3] = '↙';
  if (normalized[7] == null || normalized[7]!.isEmpty) normalized[3] = '↘';

  return normalized.map((e) => (e ?? '').toUpperCase()).toList();
}

String decodeWASDGraphic(String input, List<String> controlSet) {
  if (input.isEmpty) return '';

  controlSet = _normalizeControlSet(controlSet);

  int x = 0;
  int y = 0;
  int maxLetterX = 0;
  int maxLetterY = 0;
  int minLetterX = 0;
  int minLetterY = 0;
  int xOffset = 0;
  int yOffset = 0;
  int maxSentenceX = 0;
  int maxSentenceY = 0;
  int minSentenceX = 0;
  int minSentenceY = 0;

  Map<String, String> sentence = {};

  var comingFrom = WASD_DIRECTION.START;

  _setXYDirection() {
    switch (comingFrom) {
      case WASD_DIRECTION.UP:
        y++;
        break;
      case WASD_DIRECTION.DOWN:
        y--;
        break;
      case WASD_DIRECTION.LEFT:
        x--;
        break;
      case WASD_DIRECTION.RIGHT:
        x++;
        break;
      case WASD_DIRECTION.UPLEFT:
        x--;
        y--;
        break;
      case WASD_DIRECTION.UPRIGHT:
        x++;
        y--;
        break;
      case WASD_DIRECTION.DOWNLEFT:
        x--;
        y++;
        break;
      case WASD_DIRECTION.DOWNRIGHT:
        x++;
        y++;
        break;
      default:
    }
  }

  _normalizeDecodingInput(input, controlSet).split(' ').forEach((word) {
    // draw picture per letter
    // transform/normalize picture
    // align picture in world

    y = 0;
    x = 0;
    maxLetterX = 0;
    maxLetterY = 0;
    minLetterX = 0;
    minLetterY = 0;

    comingFrom = WASD_DIRECTION.START;

    Map<String, String> letter = {};

    word.split('').forEach((newDirection) {
      switch (newDirection) {
        case '↓': // back, down
          _setXYDirection();
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            y++;
            letter[x.toString() + '|' + (y).toString()] = '1';
          }
          comingFrom = WASD_DIRECTION.UP;
          break;

        case '↑': // forward, up
          _setXYDirection();
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            y--;
            letter[x.toString() + '|' + (y).toString()] = '1';
          }
          comingFrom = WASD_DIRECTION.DOWN;
          break;

        case '←': // left
          _setXYDirection();
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            x--;
            letter[x.toString() + '|' + (y).toString()] = '1';
          }
          comingFrom = WASD_DIRECTION.LEFT;
          break;

        case '→': // right
          _setXYDirection();
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            x++;
            letter[x.toString() + '|' + (y).toString()] = '1';
          }
          comingFrom = WASD_DIRECTION.RIGHT;
          break;

        case '↖':
          _setXYDirection();
          comingFrom = WASD_DIRECTION.UPLEFT;
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            x--;
            y--;
            letter[x.toString() + '|' + (y).toString()] = '1';
          }
          break;

        case '↗':
          _setXYDirection();
          comingFrom = WASD_DIRECTION.UPRIGHT;
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            x++;
            y--;
            letter[x.toString() + '|' + (y).toString()] = '1';
          }
          break;

        case '↙':
          _setXYDirection();
          comingFrom = WASD_DIRECTION.DOWNLEFT;
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            x--;
            y++;
            letter[x.toString() + '|' + (y).toString()] = '1';
          }
          break;

        case '↘':
          _setXYDirection();
          comingFrom = WASD_DIRECTION.DOWNRIGHT;
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            x++;
            y++;
            letter[x.toString() + '|' + (y).toString()] = '1';
          }
          break;
      }
      if (y < minLetterY) minLetterY = y - 1;
      if (x < minLetterX) minLetterX = x - 1;
      if (y > maxLetterY) maxLetterY = y + 1;
      if (x > maxLetterX) maxLetterX = x + 1;

      if (maxLetterY > maxSentenceY) maxSentenceY = maxLetterY;
      if (minLetterY < minSentenceY) minSentenceY = minLetterY;
    }); // for Each newDirection

    // transform/normalize letter
    xOffset = 0;
    yOffset = 0;
    if (minLetterY == -5) minLetterY = -6;
    if (minLetterY == -11) minLetterY = -12;
    if (minLetterY < 0) yOffset = -1 * minLetterY;

    if (minLetterX < 0) xOffset = -1 * minLetterX;

    Map<String, String> transformedLetter = {};
    letter.forEach((key, value) {
      transformedLetter[(int.parse(key.split('|')[0]) + xOffset).toString() +
          '|' +
          (int.parse(key.split('|')[1]) + yOffset).toString()] = value;
    });

    // add letter to sentence
    transformedLetter.forEach((key, value) {
      sentence[(int.parse(key.split('|')[0]) + maxSentenceX).toString() +
          '|' +
          (int.parse(key.split('|')[1])).toString()] = value;
    });

    maxSentenceX = maxSentenceX + (maxLetterX - minLetterX) + 4;
  }); // forEach word

  // build bitmap
  List<List<String?>> binaryWorld =
      List.generate(maxSentenceX + 3, (y) => []..length = maxSentenceY - minSentenceY + 3, growable: false);
  sentence.forEach((key, value) {
    x = int.parse(key.split('|')[0]);
    y = int.parse(key.split('|')[1]);
    binaryWorld[x][y] = value;
  });

  // build output
  String outputLine = '##';
  List<String> output = <String>[];
  output.add(outputLine.padRight(maxSentenceX + 1, '#'));
  for (y = 0; y < maxSentenceY - minSentenceY + 1; y++) {
    outputLine = '##';
    for (x = 0; x < maxSentenceX - minSentenceX + 1; x++) {
      if (binaryWorld[x][y] == null) {
        outputLine = outputLine + '#';
      } else {
        outputLine = outputLine + binaryWorld[x][y]!;
      }
    }
    output.add(outputLine);
  }

  return output.join('\n');
}
