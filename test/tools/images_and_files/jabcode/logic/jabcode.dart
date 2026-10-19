import 'dart:io' as io;
import 'dart:typed_data';
import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';
import 'package:path/path.dart' as path;

var testDirPath = 'test/tools/images_and_files/jabcode/resources/';

Uint8List _getFileData(String name) {
  io.File file = io.File(path.join(testDirPath, name));
  return file.readAsBytesSync();
}

void main() {

  group("jabcode.scanBytes:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': 'GC Wizard4.png', 'expectedOutput': (Data: 'GC Wizard', DecodeStatus: '')},
      {'input': 'GC Wizard8.png', 'expectedOutput': (Data: 'GC Wizard', DecodeStatus: '')},
      {'input': '2.png', 'expectedOutput': (Data: 'Welcome to Wikipedia, the free encyclopedia that anyone can edit.', DecodeStatus: '')},
      {'input': '3.png', 'expectedOutput': (Data: 'Welcome to Wikipedia, the free encyclopedia that anyone can edit.', DecodeStatus: '')},
      {'input': '4.png', 'expectedOutput': (Data: 'Welcome to Wikipedia, the free encyclopedia that anyone can edit.', DecodeStatus: '')},
      {'input': '4.jpg', 'expectedOutput': (Data: null, DecodeStatus: DecodeResult.NotDetectable.toString())},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () async {
        Uint8List content = _getFileData(elem['input'] as String);
        var _actual = await scanBytes(content);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("jabcode.generateJabCode:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': 'GC Wizard', 'colors': 4, 'expectedOutput': _getFileData('GC Wizard4.png')},
      {'input': 'GC Wizard', 'colors': 8, 'expectedOutput': _getFileData('GC Wizard8.png')},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']} ${elem['colors']}', () async {
        var _actual = await generateJabCode(elem['input'] as String, colorCount:elem['colors'] as int, border:0);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}
