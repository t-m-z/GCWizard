import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/utils/math_utils.dart';

void main() {
  group("lcm:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : [], 'expectedOutput' : ''},
      {'input' : [0], 'expectedOutput' : '0'},
      {'input' : [0, 0], 'expectedOutput' : '0'},
      {'input' : [0, 34, 5], 'expectedOutput' : '0'},
      {'input' : [-1], 'expectedOutput' : '-1'},
      {'input' : [3], 'expectedOutput' : '3'},
      {'input' : [-2, 3], 'expectedOutput' : '-6'},
      {'input' : [-2, -3], 'expectedOutput' : '6'},
      {'input' : [-2, -3, 4], 'expectedOutput' : '-12'},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = lcmList(elem['input'] as List<int>);

          expect(_actual, (elem['expectedOutput']as String));

      });
    }
  });

}