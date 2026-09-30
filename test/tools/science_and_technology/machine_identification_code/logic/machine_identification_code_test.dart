import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/machine_identification_code/logic/machine_identification_code.dart';

void main() {
  group("calculate", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input:' : '',
        'expectedOutput' : outputMIC(statusOK: true, mic: [], parityColumn: [], parityRow: [], ),
      },
      {
        'input:' : '010101102103104105106107',
        'expectedOutput' : outputMIC(
          statusOK: false,
          mic: [],
          parityColumn: [2,3,4,5,6,7,8,9,11,12,13,14,15],
          parityRow: [], ),
      },
      {
        'input:' : '011101102103104105106107',
        'expectedOutput' : outputMIC(
          statusOK: false,
          mic: [],
          parityColumn: [2,3,4,5,6,7,8,9,11,12,13,14,15],
          parityRow: [1], ),
      },
      {
        'input' : '020030040050060070080090101102103104105106107110120130140150',
        'expectedOutput' : outputMIC(
          statusOK: true,
          mic: ['0','0','0','0','0','0','0','0','0','127','0','0','0','0'],
          parityColumn: [],
          parityRow: [],
        ),
      },
      {// archived GC5NTMR west
        'input' : '011012013020022024030040054056057067070076077080084085086087090101102103104105106107110114117120124127130134136140151153155',
        'expectedOutput' : outputMIC(
          statusOK: true,
          mic: ['112','40','0','0','11','1','3','15','0','127','9','9','10','0', '84'],
          parityColumn: [],
          parityRow: [],
        ),
      },
      {// archived GC5NTMR north
        'input' : '010011013014017020023024025026030040054056057067070076077080084085086087090101102103104105106107110115116120122123125126130132137145151153155',
        'expectedOutput' : outputMIC(
          statusOK: true,
          mic: ['217','30','0','0','11','1','3','15','0','127','6','54','33','4', '84'],
          parityColumn: [],
          parityRow: [],
        ),
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = decodeMIC(elem['input'] as List<String>);
        expect(_actual.statusOK, (elem['expectedOutput'] as outputMIC).statusOK);
        if (_actual.statusOK) {
          expect(_actual.mic, (elem['expectedOutput'] as outputMIC).mic);
        } else {
          expect(_actual.parityColumn, (elem['expectedOutput'] as outputMIC).parityColumn);
          expect(_actual.parityRow, (elem['expectedOutput'] as outputMIC).parityRow);
        }
      });
    }
  });

}