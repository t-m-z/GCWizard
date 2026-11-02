import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/utils/math_utils.dart';

void main() {
  group("gcd:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : [], 'expectedOutput' : ''},
      {'input' : [0], 'expectedOutput' : '0'},
      {'input' : [0, 0], 'expectedOutput' : '0'},
      {'input' : [0, 34], 'expectedOutput' : '34'},
      {'input' : [-1], 'expectedOutput' : '-1'},
      {'input' : [3], 'expectedOutput' : '3'},
      {'input' : [-6, 3], 'expectedOutput' : '3'},
      {'input' : [24, 36, 144], 'expectedOutput' : '12'},
      {'input' : [-24, -360, -144], 'expectedOutput' : '24'},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = gcdList(elem['input'] as List<int>);

        expect(_actual, (elem['expectedOutput']as String));

      });
    }
  });

}