import 'dart:io' as io;
import 'dart:typed_data';

import "package:flutter_test/flutter_test.dart";
import 'package:path/path.dart' as path;

import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

String testDirPath = 'test/tools/wherigo/unluac/resources/';

Uint8List _getFileDataUin8List(String name) {
  io.File file = io.File(path.join(testDirPath, name));
  return file.readAsBytesSync();
}

String _getFileDataString(String name) {
  io.File file = io.File(path.join(testDirPath, name));
  return String.fromCharCodes(file.readAsBytesSync());
}

void main() {
  group("Cartridges", () {
    // Cachesleuth
    //      054,
    // WherigoKit
    //      005, 009, 017, 055, 056, 057, 058, 059, 060, 061,
    // WWB Earwigo
    //      012, 018, 034, 035, 038, 053, 062, 063, 064,
    // Urwigo
    //      001, 002, 003, 004, 006, 007, 010, 011, 013, 014,
    //      015, 016, 019, 020, 021, 022, 023, 024, 025, 026,
    //      027, 028, 029, 030, 031, 032, 033, 036, 037, 039,
    //      040, 041, 042, 043, 044, 045, 046, 047, 048, 049,
    //      050, 051, 052,
    //
    int numberOfCartridges = 64;
    List<Map<String, Object?>> _inputsToExpected = [];
    for (int i = 1; i <= numberOfCartridges; i++) {
      String filename = i.toString().padLeft(3, '0');
      Map<String, Object> map = {};
      map['input'] = filename + '.luac';
      map['expectedOutput'] = filename + '.lua';
      _inputsToExpected.add(map);
    }

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = decompileLua(_getFileDataUin8List(elem['input'] as String), );
        expect(_actual, _getFileDataString(elem['expectedOutput'] as String).replaceAll('\r\n', '\n'));
      });
    }
  });

}