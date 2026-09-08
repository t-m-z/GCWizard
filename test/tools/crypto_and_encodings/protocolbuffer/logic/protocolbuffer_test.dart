import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer.dart';

void main() {

  // https://www.protobufpal.com/

  group("Protocolbuffer.decrypt", () {

    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : '''Message {
}'''},

      {'input' : '0a180a0a0a014e10251815209703120a0a0157107a180320c704122248616e6765722c20757020686967682c206e6f7420696e2076656765746174696f6e',
        'expectedOutput' : '''Message {
  1: Message {
    1: Message {
      1: "N"
      2: 37
      3: 21
      4: 407
    }
    2: Message {
      1: "W"
      2: 122
      3: 3
      4: 583
    }
  }
  2: "Hanger, up high, not in vegetation"
}'''},

      {'input' : '0a1e0a036c617412014e1834201b28a60532036c6f6e3a0145400d480c50d902120465756c65',
        'expectedOutput' : '''Message {
  1: Message {
    1: "lat"
    2: "N"
    3: 52
    4: 27
    5: 678
    6: "lon"
    7: "E"
    8: 13
    9: 12
    10: 345
  }
  2: "eule"
}'''},

    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = decryptProtocolBuffer(elem['input'] as String);
        expect(_actual['json'], elem['expectedOutput'] as String);
      });
    }
  });


}