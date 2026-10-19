part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

const int _w1 = 100;
const int _w2 = 3;
const int _w3 = 3;

int _applyRule1(List<int> matrix, int width, int height, int colorNumber) {
  final List<(int, int)> fpColors = switch (colorNumber) {
    2 => const [(0, 1), (1, 0), (1, 0), (1, 0)],
    4 => const [(0, 3), (1, 2), (2, 1), (3, 0)],
    _ => [
        for (final core in [_fp0CoreColor, _fp1CoreColor, _fp2CoreColor, _fp3CoreColor]) (core, 7 - core)
      ],
  };

  int score = 0;
  for (int i = 2; i <= height - 3; i++) {
    for (int j = 2; j <= width - 3; j++) {
      final center = i * width + j;
      final isFinderLike = fpColors.any((colors) {
        final (c1, c2) = colors;
        return matrix[center - 2] == c1 &&
            matrix[center - 1] == c2 &&
            matrix[center] == c1 &&
            matrix[center + 1] == c2 &&
            matrix[center + 2] == c1 &&
            matrix[center - 2 * width] == c1 &&
            matrix[center - width] == c2 &&
            matrix[center + width] == c2 &&
            matrix[center + 2 * width] == c1;
      });
      if (isFinderLike) score++;
    }
  }
  return _w1 * score;
}

int _applyRule2(List<int> matrix, int width, int height) {
  int score = 0;
  for (int i = 0; i < height - 1; i++) {
    for (int j = 0; j < width - 1; j++) {
      final color = matrix[i * width + j];
      if (color != -1 &&
          color == matrix[i * width + j + 1] &&
          color == matrix[(i + 1) * width + j] &&
          color == matrix[(i + 1) * width + j + 1]) {
        score++;
      }
    }
  }
  return _w2 * score;
}

int _applyRule3(List<int> matrix, int width, int height) {
  int runScore(int length) => length >= 5 ? _w3 + (length - 5) : 0;

  int score = 0;
  for (int k = 0; k < 2; k++) {
    final lines = k == 0 ? height : width;
    final cells = k == 0 ? width : height;
    for (int i = 0; i < lines; i++) {
      int sameColorCount = 0;
      int preColor = -1;
      for (int j = 0; j < cells; j++) {
        final curColor = k == 0 ? matrix[i * width + j] : matrix[j * width + i];
        if (curColor == -1) {
          score += runScore(sameColorCount);
          sameColorCount = 0;
          preColor = -1;
        } else if (curColor == preColor) {
          sameColorCount++;
        } else {
          score += runScore(sameColorCount);
          sameColorCount = 1;
          preColor = curColor;
        }
      }
      score += runScore(sameColorCount);
    }
  }
  return score;
}

int _evaluateMask(List<int> matrix, int width, int height, int colorNumber) {
  return _applyRule1(matrix, width, height, colorNumber) +
      _applyRule2(matrix, width, height) +
      _applyRule3(matrix, width, height);
}

int _applyMaskFormula(int index, int maskType, int x, int y, int colorNumber) {
  switch (maskType) {
    case 0:
      return index ^ ((x + y) % colorNumber);
    case 1:
      return index ^ (x % colorNumber);
    case 2:
      return index ^ (y % colorNumber);
    case 3:
      return index ^ ((x ~/ 2 + y ~/ 3) % colorNumber);
    case 4:
      return index ^ ((x ~/ 3 + y ~/ 2) % colorNumber);
    case 5:
      return index ^ (((x + y) ~/ 2 + (x + y) ~/ 3) % colorNumber);
    case 6:
      return index ^ (((x * x * y) % 7 + (2 * x * x + 2 * y) % 19) % colorNumber);
    case 7:
      return index ^ (((x * y * y) % 5 + (2 * x + y * y) % 13) % colorNumber);
    default:
      return index;
  }
}

void _maskSymbols(_JabEncode enc, int maskType) {
  for (int k = 0; k < enc.symbolNumber; k++) {
    final symbol = enc.symbols[k];
    final symbolWidth = symbol.sideSize.x;

    for (int y = 0; y < symbol.sideSize.y; y++) {
      for (int x = 0; x < symbolWidth; x++) {
        final i = y * symbolWidth + x;
        if (symbol.dataMap![i] != 0) {
          symbol.matrix![i] = _applyMaskFormula(symbol.matrix![i], maskType, x, y, enc.colorNumber) & 0xFF;
        }
      }
    }
  }
}

List<int> _maskedCodeMatrix(_JabEncode enc, int maskType, _JabCode cp) {
  final masked = List<int>.filled(cp.codeSize.x * cp.codeSize.y, -1);

  for (int k = 0; k < enc.symbolNumber; k++) {
    final offset = _symbolOffsetInCode(enc, cp, k);

    final symbol = enc.symbols[k];
    final symbolWidth = symbol.sideSize.x;

    for (int y = 0; y < symbol.sideSize.y; y++) {
      for (int x = 0; x < symbolWidth; x++) {
        final i = y * symbolWidth + x;
        masked[(y + offset.Y) * cp.codeSize.x + (x + offset.X)] = symbol.dataMap![i] != 0
            ? _applyMaskFormula(symbol.matrix![i], maskType, x, y, enc.colorNumber)
            : symbol.matrix![i];
      }
    }
  }
  return masked;
}

int _maskCode(_JabEncode enc, _JabCode cp) {
  int maskType = 0;
  int minPenaltyScore = 10000;

  for (int t = 0; t < _numberOfMaskPatterns; t++) {
    final penaltyScore = _evaluateMask(_maskedCodeMatrix(enc, t, cp), cp.codeSize.x, cp.codeSize.y, enc.colorNumber);
    if (penaltyScore < minPenaltyScore) {
      maskType = t;
      minPenaltyScore = penaltyScore;
    }
  }

  _maskSymbols(enc, maskType);
  return maskType;
}

void _demaskSymbol(_JabData data, Uint8List dataMap, _JabVector2d symbolSize,
    int maskType, int colorNumber) {
  final symbolWidth = symbolSize.x;
  final symbolHeight = symbolSize.y;
  int count = 0;
  for (int x = 0; x < symbolWidth; x++) {
    for (int y = 0; y < symbolHeight; y++) {
      if (dataMap[y * symbolWidth + x] == 0) {
        if (count > data.length - 1) return;
        int index = data.data[count];
        index = _applyMaskFormula(index, maskType, x, y, colorNumber);
        data.data[count] = index & 0xFF;
        count++;
      }
    }
  }
}
