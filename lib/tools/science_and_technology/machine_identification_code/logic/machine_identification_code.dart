import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';

class outputMIC {
  bool statusOK;
  List<String> mic;
  List<int> parityColumn;
  List<int> parityRow;

  outputMIC({required this.mic, required this.parityColumn, required this.parityRow, required this.statusOK});
}

outputMIC decodeMIC(List<String> inputs) {
  if (inputs.isEmpty)  {
    return outputMIC(statusOK: true, mic: [], parityColumn: [], parityRow: [],);
  }

  var parityCheck = _parityCheck(inputs);

  if (!(parityCheck['parityCheckOk'] as bool)) {
    return outputMIC(
        mic: [],
        parityColumn: parityCheck['parityErrorColumns'] as List<int>,
        parityRow: parityCheck['parityErrorRows'] as List<int>,
        statusOK: false);
  }

  var tripel = buildMICTripel(inputs);
  var codes = {
    '01': '00000000',
    '02': '00000000',
    '03': '00000000',
    '04': '00000000',
    '05': '00000000',
    '06': '00000000',
    '07': '00000000',
    '08': '00000000',
    '09': '00000000',
    '10': '00000000',
    '11': '00000000',
    '12': '00000000',
    '13': '00000000',
    '14': '00000000',
    '15': '00000000',
  };
  List<String> decodedMICData = [];

  for (var element in tripel) {
    String code = codes[element.substring(0, 2)]!;
    int pos = int.parse(element.substring(2));
    codes[element.substring(0, 2)] = _replaceCharAt(code, pos, '1');
  }

  bool parityColumn = false;
  codes.forEach((key, value) {
    if (!parityColumn) {
      decodedMICData.add(convertBase(value, 2, 10));
      parityColumn = true;
    } else {
      decodedMICData.add(convertBase(value.substring(1), 2, 10));
    }
  });

  return outputMIC(mic: decodedMICData, parityColumn: [], parityRow: [], statusOK: true);
}

List<String> buildMICTripel(List<String> input) {
  List<String> result = [];
  for (var element in input) {
    for (int i = 0; i < element.length / 3; i++) {
      result.add(input[0].substring(i * 3, i * 3 + 3));
    }
  }
  return result;
}

String _replaceCharAt(String oldString, int index, String newChar) {
  return oldString.substring(0, index) +
      newChar +
      oldString.substring(index + 1);
}

Map<String, dynamic> _parityCheck(List<String> data){
  List<int> parityErrorColumn = [];
  List<int> parityErrorRow = [];

  List<String> tripel = buildMICTripel(data);
  List<int> columns = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> columnsParity = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> rows = [0, 0, 0, 0, 0, 0, 0, 0];
  List<int> rowsParity = [0, 0, 0, 0, 0, 0, 0, 0];
  String column = '';
  String row = '';
  bool result = true;
  for (String element in tripel){
    column = element.substring(0,2);
    row = element.substring(2);

    if (column == '01') {
      rowsParity[int.parse(row)] = 1;
    } else {
      if (row != '0') {
        columns[int.parse(column) - 1]++;
      }
    }

    if (row == '0') {
      columnsParity[int.parse(column) - 1] = 1;
    } else {
      if (column != '01') {
        rows[int.parse(row)]++;
      }
    }
  }

  for (int i = 1; i <= 14; i++){
    if ((columns[i] % 2 == 0 && columnsParity[i] == 0) ||
        (columns[i] % 2 == 1 && columnsParity[i] == 1)) {
      result = false;
      parityErrorColumn.add(i + 1);
    }
  }
  for (int i = 1; i <= 7; i++) {
    if ((rows[i] % 2 == 0 && rowsParity[i] != 1) ||
        (rows[i] % 2 == 1 && rowsParity[i] != 0)) {
      result = false;
      parityErrorRow.add(i);
    }
  }

  return {
    'parityCheckOk': result,
    'parityErrorRows': parityErrorRow,
    'parityErrorColumns': parityErrorColumn
  };
}
