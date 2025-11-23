import 'dart:math';

import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';

enum NUMBER_TYPE { DECIMAL, BINARY, HEXADECIMAL }

String numberToImage(String numberString, NUMBER_TYPE type) {
  switch (type) {
    case NUMBER_TYPE.DECIMAL:
      return convertBase(numberString, 10, 2).padLeft(160, '0');
    case NUMBER_TYPE.BINARY:
      return numberString.padLeft(160, '0');
    case NUMBER_TYPE.HEXADECIMAL:
      return convertBase(numberString, 16, 2).padLeft(160, '0');
  }
}

class Image2BinaryData {
  List<List<bool>> currentBoard = [];
  late int width;
  late int height;

  Image2BinaryData(
      {List<List<bool>>? content, required int width, required int height}) {
    _generateBoard(content, width, height);
  }

  void _generateBoard(List<List<bool>>? content, int width, int height) {
    var _newBoard = List<List<bool>>.generate(
        height, (index) => List<bool>.generate(width, (index) => false));

    if (content != null && content.isNotEmpty) {
      for (int i = 0; i < min(height, content.length); i++) {
        for (int j = 0; j < min(width, content[i].length); j++) {
          _newBoard[i][j] = content[i][j];
        }
      }
    }
    currentBoard = List.from(_newBoard);
  }

  void reset({List<List<bool>>? board}) {
    if (board == null) {
      currentBoard = List.from(List<List<bool>>.generate(
          height, (index) => List<bool>.generate(width, (index) => false)));
    } else {
      currentBoard = board;
    }
  }

  BigInt getNumber() {
    BigInt number = BigInt.zero;

    List<String> boardBinary = [];
    String line = '';
    for (List<bool> row in currentBoard) {
      line = '';
      for (bool column in row) {
        if (column) {
          line = line + '1';
        } else {
          line = line + '0';
        }
      }
      boardBinary.add(line);
    }

    String binary = boardBinary.join('');
    String decimal = convertBase(binary, 2, 10);

    number = BigInt.parse(decimal);

    return number;
  }
}
