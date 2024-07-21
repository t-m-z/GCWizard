// https://www.reservistenverband.de/wp-content/uploads/2019/08/taschenkarte_fernmeldedienst_aller_truppen_nr.9_3.pdf
// https://www.rk-ubstadt.de/?p=2079
// https://www.geocaching.com/geocache/GC7DF7R_garnisonsgeschichte-6?guid=27ba9b97-31ab-473e-b35f-6d657e5d60b4
// https://fschjgbtl251.de/technik/fernmeldetechnik/
// http://scherfel.de/shared-files/388/FmDst-SchleiernUndSchluesseln.pdf
//
// 08 41 75 51 36 30 99 28 65 10 66 46 55 20 79 16 82 02 93 45 97 19 88 81 63 01 38 72 29 87 98 54 50 04 49 44 27 31 77 17 18 64 15 56 32 86 73 26 67 95 35 14 96 39 06 80 25 68 85 43 12 48 07 24 74
// cjosmhlquweby
// dainrtxfkpvzg
//
// 54 15 25 31 02 85 35 26 14 33 05 58 47 32 39 49 88 10 23 78 82 08 92 91 73 56 09 43 80 81 69 74 35 52 53 67 34 71 62 76 42 29 63 27 16 30 17 12 06 99 37 97 46 84 68 90 89 59 48 21 65 44 86 07 20
// ixsyukfqdgevc
// ozjrpwmatlbnh

import 'dart:typed_data';

enum BundeswehrTalkingBoardAuthentificationTableType {AUTHENTIFICATIONTABLE, NUMERALCODE}
enum TABLE_SOURCE {NONE, CUSTOM, RANDOM, FILE}

class BundeswehrTalkingBoard {
  final List<String> xAxisNumeralCode;
  final List<String> yAxisNumeralCode;
  final List<String> AuthentificationCode;

  BundeswehrTalkingBoard({
    required this.xAxisNumeralCode,
    required this.yAxisNumeralCode,
    required this.AuthentificationCode,
  });

  @override
  toString() {
    return "{\n" +
        '  "xAxisNumeralCode" : "' + xAxisNumeralCode.join('') + '",\n' +
        '  "yAxisNumeralCode" : "' + yAxisNumeralCode.join('') + '",\n' +
        '  "AuthentificationCode" : "' + AuthentificationCode.join(' ') + '"\n' +
        "}";
  }

  Uint8List toByteList() {
    return Uint8List.fromList(toString().codeUnits);
  }

  Map<String, dynamic> toJson() =>
      {'xAxis': xAxisNumeralCode, 'yAxis': yAxisNumeralCode, 'AuthentificationCode': AuthentificationCode};

  BundeswehrTalkingBoard.fromJson(Map<String, dynamic> json)
      //: xAxisNumeralCode = json['xAxisNumeralCode']!.split(''),
      //  yAxisNumeralCode = json['yAxisNumeralCode']!.split(''),
      //  AuthentificationCode = json['AuthentificationCode']!.split(' ');
      : xAxisNumeralCode = (json['xAxisNumeralCode']! as String).split(''),
  yAxisNumeralCode = (json['yAxisNumeralCode']! as String).split(''),
  AuthentificationCode = (json['AuthentificationCode']! as String).split(' ');
}

class BundeswehrTalkingBoardAuthentificationTable {
  final List<String> xAxis;
  final List<String> yAxis;
  final List<String> Content;
  final Map<String, List<String>>? Encoding;

  BundeswehrTalkingBoardAuthentificationTable(
      {required this.xAxis, required this.yAxis, required this.Content, this.Encoding});
}

class BundeswehrTalkingBoardAuthentificationOutput {
  // TODO Thomas: Why is ResponseCode a List, not a simple String?
  // because there are a couple of errors which can be returned to the user
  final List<String> ResponseCode;
  final List<String>? Tupel1;
  final List<String>? Tupel2;
  final List<String>? Tupel3;
  final String? Number;
  final String? Details;

  BundeswehrTalkingBoardAuthentificationOutput(
      {required this.ResponseCode, this.Tupel1, this.Tupel2, this.Tupel3, this.Number, this.Details});
}

const BUNDESWEHR_TALKINGBOARD_AUTH_TABLE_Y_AXIS = [
  'A',
  'D',
  'E',
  'G',
  'H',
  'I',
  'L',
  'N',
  'O',
  'R',
  'S',
  'T',
  'U',
];

const BUNDESWEHR_TALKINGBOARD_AUTH_TABLE_X_AXIS = [
  'V',
  'W',
  'X',
  'Y',
  'Z',
];

const BUNDESWEHR_TALKINGBOARD_NUMERALCODE = [
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'A',
  'B',
  'C',
  'D',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'E',
  'F',
  'G',
  'H',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'I',
  'J',
  'K',
  'L',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '9',
  'M',
  'N',
  'O',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '8',
  '9',
  'P',
  'Q',
  'R',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '7',
  '8',
  '9',
  'S',
  'T',
  'U',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '6',
  '7',
  '8',
  '9',
  'V',
  'W',
  'X',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '5',
  '6',
  '7',
  '8',
  '9',
  'Y',
  'Z',
  'A',
  '0',
  '1',
  '2',
  '3',
  '4',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'D',
  'E',
  'G',
  '0',
  '1',
  '2',
  '3',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'H',
  'I',
  'L',
  '0',
  '1',
  '2',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'N',
  'O',
  'R',
  '0',
  '1',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'S',
  'T',
  'U',
  '0',
];

const _LETTERS = [
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
];

const _DIGITS = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];

const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_OK = 'bundeswehr_talkingboard_auth_response_ok';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK = 'bundeswehr_talkingboard_auth_response_not_ok';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_AUTH = 'bundeswehr_talkingboard_auth_response_invalid_auth';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_MISSING_CALLSIGN =
    'bundeswehr_talkingboard_auth_response_invalid_missing_callsign';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_CALLSIGN_LETTER =
    'bundeswehr_talkingboard_auth_response_invalid_callsign_letter';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_AUTHENTIFICATION_LETTER =
    'bundeswehr_talkingboard_auth_response_invalid_authentification_letter';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_AUTHENTIFICATION_CODE =
    'bundeswehr_talkingboard_auth_response_invalid_autentification_code';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_NUMERAL_TABLE =
    'bundeswehr_talkingboard_auth_response_invalid_custom_table_numeral';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_X_AXIS_NUMERAL_TABLE =
    'bundeswehr_talkingboard_auth_response_invalid_x_axis_numeral_code';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_Y_AXIS_NUMERAL_TABLE =
    'bundeswehr_talkingboard_auth_response_invalid_y_axis_numeral_code';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_AUTH_TABLE =
    'bundeswehr_talkingboard_auth_response_invalid_custom_table_auth';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CUSTOM_NUMERAL_TABLE =
    'bundeswehr_talkingboard_auth_response_empty_custom_table_numeral';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CUSTOM_AUTH_TABLE =
    'bundeswehr_talkingboard_auth_response_empty_custom_table_auth';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CALLSIGN = 'bundeswehr_talkingboard_auth_response_empty_callsign';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CALLSIGN_LETTER =
    'bundeswehr_talkingboard_auth_response_empty_callsign_letter';
const BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_AUTHCODE = 'bundeswehr_talkingboard_auth_response_empty_authcode';

BundeswehrTalkingBoardAuthentificationOutput buildAuthBundeswehr(
    String currentCallSign,
    String currentLetterAuth,
    String currentLetterCallSign,
    BundeswehrTalkingBoardAuthentificationTable tableNumeralCode,
    BundeswehrTalkingBoardAuthentificationTable tableAuthentificationCode) {
  List<String> responseCodes = [];

  if (currentCallSign.isEmpty) {
    responseCodes.add(BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CALLSIGN);
  }

  if (currentLetterCallSign.isEmpty) {
    responseCodes.add(BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CALLSIGN_LETTER);
  }

  if (_tableIsInvalid(tableNumeralCode, BundeswehrTalkingBoardAuthentificationTableType.NUMERALCODE)) {
    responseCodes.add(BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CUSTOM_NUMERAL_TABLE);
  }

  if (_tableIsInvalid(
      tableAuthentificationCode, BundeswehrTalkingBoardAuthentificationTableType.AUTHENTIFICATIONTABLE)) {
    responseCodes.add(BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CUSTOM_AUTH_TABLE);
  }

  if (responseCodes.isNotEmpty) {
    return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: responseCodes);
  }

  if (currentCallSign.split('').contains(currentLetterCallSign)) {
    if (BUNDESWEHR_TALKINGBOARD_AUTH_TABLE_Y_AXIS.contains(currentLetterCallSign)) {
      List<String> tupel1 = [];
      for (int i = 0; i < tableNumeralCode.Content.length; i++) {
        if (tableNumeralCode.Content[i] == currentLetterCallSign) {
          String t1 = tableNumeralCode.xAxis[i % 13];
          String t2 = tableNumeralCode.yAxis[i ~/ 13];
          tupel1.add(t1 + t2);
          tupel1.add(t2 + t1);
        }
      }

      String authCode = tableAuthentificationCode.Content[
          tableAuthentificationCode.yAxis.indexOf(currentLetterCallSign) * 5 +
              tableAuthentificationCode.xAxis.indexOf(currentLetterAuth)];
      List<String> tupel2 = [];
      for (int i = 0; i < tableNumeralCode.Content.length; i++) {
        if (tableNumeralCode.Content[i] == authCode.split('')[0]) {
          String t1 = tableNumeralCode.xAxis[i % 13];
          String t2 = tableNumeralCode.yAxis[i ~/ 13];
          tupel2.add(t1 + t2);
          tupel2.add(t2 + t1);
        }
      }

      List<String> tupel3 = [];
      for (int i = 0; i < tableNumeralCode.Content.length; i++) {
        if (tableNumeralCode.Content[i] == authCode.split('')[1]) {
          String t1 = tableNumeralCode.xAxis[i % 13];
          String t2 = tableNumeralCode.yAxis[i ~/ 13];
          tupel3.add(t1 + t2);
          tupel3.add(t2 + t1);
        }
      }

      return BundeswehrTalkingBoardAuthentificationOutput(
          ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_OK],
          Tupel1: tupel1,
          Tupel2: tupel2,
          Tupel3: tupel3,
          Number: authCode);
    }
    return BundeswehrTalkingBoardAuthentificationOutput(
        ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_AUTHENTIFICATION_LETTER]);
  }
  return BundeswehrTalkingBoardAuthentificationOutput(
      ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_CALLSIGN_LETTER]);
}

BundeswehrTalkingBoardAuthentificationOutput checkAuthBundeswehr(
    String currentCallSign,
    String currentAuth,
    String currentLetterAuth,
    BundeswehrTalkingBoardAuthentificationTable tableNumeralCode,
    BundeswehrTalkingBoardAuthentificationTable tableAuthentificationCode) {
  List<String> responseCodes = [];

  if (currentCallSign.isEmpty) {
    responseCodes.add(BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CALLSIGN);
  }

  if (currentAuth.isEmpty) {
    responseCodes.add(BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_AUTHCODE);
  }

  if (!BUNDESWEHR_TALKINGBOARD_AUTH_TABLE_X_AXIS.contains(currentLetterAuth)) {
    responseCodes.add(BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_AUTHENTIFICATION_LETTER);
  }

  if (_tableIsInvalid(tableNumeralCode, BundeswehrTalkingBoardAuthentificationTableType.NUMERALCODE)) {
    responseCodes.add(BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CUSTOM_NUMERAL_TABLE);
  }

  if (_tableIsInvalid(
      tableAuthentificationCode, BundeswehrTalkingBoardAuthentificationTableType.AUTHENTIFICATIONTABLE)) {
    responseCodes.add(BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_EMPTY_CUSTOM_AUTH_TABLE);
  }

  if (responseCodes.isNotEmpty) {
    return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: responseCodes);
  }

  currentAuth = _normalizeAuthCode(currentAuth);
  if (currentAuth.isNotEmpty) {
    String details = 'Numeral Code:\n';
    List<String> authCode = currentAuth.split(' ');
    if (authCode.length != 3) {
      return BundeswehrTalkingBoardAuthentificationOutput(
          ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_AUTH]);
    }

    List<String> tupel = authCode[0].split('');
    if (tableNumeralCode.xAxis.contains(tupel[0]) && tableNumeralCode.xAxis.contains(tupel[1])) {
      return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK]);
    }
    if (tableNumeralCode.yAxis.contains(tupel[0]) && tableNumeralCode.yAxis.contains(tupel[1])) {
      return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK]);
    }

    int index_x = 0;
    int index_y = 0;

    String char = '';
    if (tableNumeralCode.xAxis.contains(tupel[0])) {
      index_x = tableNumeralCode.xAxis.indexOf(tupel[0]);
      index_y = tableNumeralCode.yAxis.indexOf(tupel[1]);
    } else {
      index_x = tableNumeralCode.xAxis.indexOf(tupel[1]);
      index_y = tableNumeralCode.yAxis.indexOf(tupel[0]);
    }
    char = tableNumeralCode.Content[index_x + index_y * 13];

    if (!_LETTERS.contains(char)) {
      return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK]);
    }

    details = details + authCode[0] + ' ⇒ ' + char + '\n';

    tupel = authCode[1].split('');
    if (tableNumeralCode.xAxis.contains(tupel[0]) && tableNumeralCode.xAxis.contains(tupel[1])) {
      return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK]);
    }
    if (tableNumeralCode.yAxis.contains(tupel[0]) && tableNumeralCode.yAxis.contains(tupel[1])) {
      return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK]);
    }

    int index = 0;
    String digit1 = '';
    if (tableNumeralCode.xAxis.contains(tupel[0])) {
      index = tableNumeralCode.xAxis.indexOf(tupel[0]) + tableNumeralCode.yAxis.indexOf(tupel[1]) * 13;
    } else {
      index = tableNumeralCode.xAxis.indexOf(tupel[1]) + tableNumeralCode.yAxis.indexOf(tupel[0]) * 13;
    }
    digit1 = tableNumeralCode.Content[index];
    if (!_DIGITS.contains(digit1)) {
      return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK]);
    }
    details = details + authCode[1] + ' ⇒ ' + digit1 + '\n';

    tupel = authCode[2].split('');
    if (tableNumeralCode.xAxis.contains(tupel[0]) && tableNumeralCode.xAxis.contains(tupel[1])) {
      return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK]);
    }
    if (tableNumeralCode.yAxis.contains(tupel[0]) && tableNumeralCode.yAxis.contains(tupel[1])) {
      return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK]);
    }

    String digit2 = '';
    if (tableNumeralCode.xAxis.contains(tupel[0])) {
      index = tableNumeralCode.xAxis.indexOf(tupel[0]) + tableNumeralCode.yAxis.indexOf(tupel[1]) * 13;
    } else {
      index = tableNumeralCode.xAxis.indexOf(tupel[1]) + tableNumeralCode.yAxis.indexOf(tupel[0]) * 13;
    }
    digit2 = tableNumeralCode.Content[index];
    if (!_DIGITS.contains(digit2)) {
      return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK]);
    }
    details = details + authCode[2] + ' ⇒ ' + digit2 + '\n';

    String digit = '';
    index_x = tableAuthentificationCode.xAxis.indexOf(currentLetterAuth);
    index_y = tableAuthentificationCode.yAxis.indexOf(char);
    digit = tableAuthentificationCode.Content[index_x + index_y * 5];
    details = details + '\nAuthent. Code\n';
    details = details + char + currentLetterAuth + ' ⇒ ' + digit + '\n';

    if (currentCallSign.split('').contains(char) && (digit == digit1 + digit2 || digit == digit2 + digit1)) {
      return BundeswehrTalkingBoardAuthentificationOutput(
          ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_OK], Details: details);
    } else {
      return BundeswehrTalkingBoardAuthentificationOutput(ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_NOT_OK]);
    }
  }
  return BundeswehrTalkingBoardAuthentificationOutput(
      ResponseCode: [BUNDESWEHR_TALKINGBOARD_AUTH_RESPONSE_INVALID_AUTHENTIFICATION_CODE]);
}

String _normalizeAuthCode(String currentAuth) {
  currentAuth = currentAuth.replaceAll('.', ' ').replaceAll(',', ' ').replaceAll(' ', '');
  if (currentAuth.length == 6) {
    return currentAuth.substring(0, 2) + ' ' + currentAuth.substring(2, 4) + ' ' + currentAuth.substring(4);
  } else {
    return '';
  }
}

bool _tableIsInvalid(
    BundeswehrTalkingBoardAuthentificationTable? table, BundeswehrTalkingBoardAuthentificationTableType type) {
  if (table == null) {
    return true;
  }
  switch (type) {
    case BundeswehrTalkingBoardAuthentificationTableType.AUTHENTIFICATIONTABLE:
      return (table.xAxis.length != 5 || table.yAxis.length != 13 || table.Content.length < 65);
    case BundeswehrTalkingBoardAuthentificationTableType.NUMERALCODE:
      return (table.xAxis.length != 13 || table.yAxis.length != 13 || table.Content.length < 169);
  }
}

String BundeswehrTalkingBoardCreateAuthTableString(List<String> authCode){
  Map<String, Map<String, String>> _authTable = {};

  int i = 0;
  for (var row in BUNDESWEHR_TALKINGBOARD_AUTH_TABLE_Y_AXIS) {
    Map<String, String> authTableRow = {};
    for (var col in BUNDESWEHR_TALKINGBOARD_AUTH_TABLE_X_AXIS) {
      authTableRow[col] = authCode[i];
      i++;
    }
    _authTable[row] = authTableRow;
  }

  i = 0;
  String _authTableString = '     V   W   X   Y   Z \n-----------------------\n';
  for (String element in BUNDESWEHR_TALKINGBOARD_AUTH_TABLE_Y_AXIS) {
    _authTableString = _authTableString +
        ' ' +
        element +
        '   ' +
        authCode[i].toString().padLeft(2, '0') +
        '  ' +
        authCode[i + 1].toString().padLeft(2, '0') +
        '  ' +
        authCode[i + 2].toString().padLeft(2, '0') +
        '  ' +
        authCode[i + 3].toString().padLeft(2, '0') +
        '  ' +
        authCode[i + 4].toString().padLeft(2, '0') +
        '\n';
    i = i + 5;
  }
  return _authTableString;
}

String BundeswehrTalkingBoardCreateNumeralCodeTableString(List<String> _xAxisTitle, List<String> _yAxisTitle){
  int i = 0;
  String _numeralCodeString = '   ' + _xAxisTitle.join(' ') + '\n----------------------------\n ';
  for (var row in _yAxisTitle) {
    _numeralCodeString = _numeralCodeString + row + ' ';
    for (int j = 0; j < 13; j++) {
      _numeralCodeString = _numeralCodeString + BUNDESWEHR_TALKINGBOARD_NUMERALCODE[i * 13 + j] + ' ';
    }
    i++;
    _numeralCodeString = _numeralCodeString + '\n ';
  }
  return _numeralCodeString;
}