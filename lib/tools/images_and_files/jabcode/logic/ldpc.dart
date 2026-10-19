part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

const int _lpdcMetadataSeed = 38545;
const int _lpdcMessageSeed = 785465;

int _ceilDiv(int a, int b) => (a + b - 1) ~/ b;

int _getBit(Int32List words, int wordOffset, int bit) => (words[wordOffset + bit ~/ 32] >> (31 - bit % 32)) & 1;

void _setBit(Int32List words, int wordOffset, int bit, int value) {
  final index = wordOffset + bit ~/ 32;
  final mask = 1 << (31 - bit % 32);
  words[index] = value != 0 ? words[index] | mask : words[index] & ~mask;
}

void _swap(List<int> list, int i, int j) {
  final tmp = list[i];
  list[i] = list[j];
  list[j] = tmp;
}

int _subBlockCount(int pg) {
  for (int i = 1; i < 10000; i++) {
    if (pg ~/ i < 2700) return i;
  }
  return 0;
}

Int32List _createParityMatrix(int wc, int wr, int capacity) =>
    wr > 0 ? _createMatrixA(wc, wr, capacity) : _createMetadataMatrixA(wc, capacity);

Int32List _createMatrixA(int wc, int wr, int capacity) {
  final int nbPcb = wr < 4 ? capacity ~/ 2 : capacity ~/ wr * wc;
  final int offset = _ceilDiv(capacity, 32);
  final int effwidth = offset * 32;

  final matrixA = Int32List(offset * nbPcb);
  final permutation = List<int>.generate(capacity, (i) => i);

  for (int i = 0; i < capacity ~/ wr; i++) {
    for (int j = 0; j < wr; j++) {
      _setBit(matrixA, 0, i * (effwidth + wr) + j, 1);
    }
  }

  _setSeed(_lpdcMessageSeed);
  for (int i = 1; i < wc; i++) {
    final offIndex = i * (capacity ~/ wr);
    for (int j = 0; j < capacity; j++) {
      final pos = (_lcg64Temper() / _uint32Max * (capacity - j)).toInt();
      for (int k = 0; k < capacity ~/ wr; k++) {
        _setBit(matrixA, (offIndex + k) * offset, j, _getBit(matrixA, k * offset, permutation[pos]));
      }
      _swap(permutation, capacity - 1 - j, pos);
    }
  }
  return matrixA;
}

Int32List _createMetadataMatrixA(int wc, int capacity) {
  final int nbPcb = capacity ~/ 2;
  final int offset = _ceilDiv(capacity, 32);
  final matrixA = Int32List(offset * nbPcb);
  final permutation = List<int>.generate(capacity, (i) => i);

  _setSeed(_lpdcMetadataSeed);
  final nbOnce = (capacity * nbPcb / wc + 3).toInt() ~/ nbPcb;

  for (int i = 0; i < nbPcb; i++) {
    for (int j = 0; j < nbOnce; j++) {
      final pos = (_lcg64Temper() / _uint32Max * (capacity - j)).toInt();
      _setBit(matrixA, i * offset, permutation[pos], 1);
      _swap(permutation, capacity - 1 - j, pos);
    }
  }
  return matrixA;
}

int _gaussJordan(Int32List matrixA, int wc, int wr, int capacity, bool encode) {
  final int nbPcb = wr < 4 ? capacity ~/ 2 : capacity ~/ wr * wc;
  final int offset = _ceilDiv(capacity, 32);

  final matrixH = Int32List.fromList(matrixA);
  final columnArrangement = Int32List(capacity);
  final processedColumn = Uint8List(capacity);
  final zeroLinesNb = Int32List(nbPcb);
  final swapCol = Int32List(2 * capacity);

  int zeroLines = 0;
  int loop = 0;

  for (int i = 0; i < nbPcb; i++) {
    int pivotColumn = capacity + 1;
    for (int j = 0; j < capacity; j++) {
      if (_getBit(matrixH, offset * i, j) == 1) {
        pivotColumn = j;
        break;
      }
    }
    if (pivotColumn < capacity) {
      processedColumn[pivotColumn] = 1;
      columnArrangement[pivotColumn] = i;
      if (pivotColumn >= nbPcb) {
        swapCol[2 * loop] = pivotColumn;
        loop++;
      }

      for (int j = 0; j < nbPcb; j++) {
        if (j != i && _getBit(matrixH, j * offset, pivotColumn) == 1) {
          for (int k = 0; k < offset; k++) {
            matrixH[k + offset * j] ^= matrixH[k + offset * i];
          }
        }
      }
    } else {
      zeroLinesNb[zeroLines] = i;
      zeroLines++;
    }
  }

  final matrixRank = nbPcb - zeroLines;
  int loop2 = 0;
  for (int i = matrixRank; i < nbPcb; i++) {
    if (columnArrangement[i] > 0) {
      for (int j = 0; j < nbPcb; j++) {
        if (processedColumn[j] == 0) {
          columnArrangement[j] = columnArrangement[i];
          processedColumn[j] = 1;
          processedColumn[i] = 0;
          swapCol[2 * loop] = i;
          swapCol[2 * loop + 1] = j;
          columnArrangement[i] = j;
          loop++;
          loop2++;
          break;
        }
      }
    }
  }

  int loop1 = 0;
  for (int kl = 0; kl < nbPcb; kl++) {
    if (processedColumn[kl] == 0 && loop1 < loop - loop2) {
      columnArrangement[kl] = columnArrangement[swapCol[2 * loop1]];
      processedColumn[kl] = 1;
      swapCol[2 * loop1 + 1] = kl;
      loop1++;
    }
  }

  loop1 = 0;
  for (int kl = 0; kl < nbPcb; kl++) {
    if (processedColumn[kl] == 0) {
      columnArrangement[kl] = zeroLinesNb[loop1];
      loop1++;
    }
  }

  if (encode) {
    for (int i = 0; i < nbPcb; i++) {
      matrixA.setRange(i * offset, i * offset + offset, matrixH, columnArrangement[i] * offset);
    }
    _swapColumns(matrixA, swapCol, loop, nbPcb, offset);
  } else {
    for (int i = 0; i < nbPcb; i++) {
      matrixH.setRange(i * offset, i * offset + offset, matrixA, columnArrangement[i] * offset);
    }
    _swapColumns(matrixH, swapCol, loop, nbPcb, offset);
    matrixA.setRange(0, offset * nbPcb, matrixH);
  }

  return matrixRank;
}

void _swapColumns(Int32List m, Int32List swapCol, int loop, int nbPcb, int offset) {
  for (int i = 0; i < loop; i++) {
    final colA = swapCol[2 * i];
    final colB = swapCol[2 * i + 1];
    for (int j = 0; j < nbPcb; j++) {
      final rowOffset = j * offset;
      final bitA = _getBit(m, rowOffset, colA);
      _setBit(m, rowOffset, colA, _getBit(m, rowOffset, colB));
      _setBit(m, rowOffset, colB, bitA);
    }
  }
}

Int32List _createGeneratorMatrix(Int32List matrixA, int capacity, int Pn) {
  final int offset = _ceilDiv(Pn, 32);
  final int effwidth = offset * 32;
  final int offsetCap = _ceilDiv(capacity, 32);

  final g = Int32List(offset * capacity);

  for (int i = 0; i < Pn; i++) {
    _setBit(g, (capacity - Pn + i) * offset, i, 1);
  }

  int matrixIndex = capacity - Pn;
  int loop = 0;

  for (int i = 0; i < (capacity - Pn) * effwidth; i++) {
    if (matrixIndex >= capacity) {
      loop++;
      matrixIndex = capacity - Pn;
    }
    if (i % effwidth < Pn) {
      _setBit(g, 0, i, _getBit(matrixA, offsetCap * loop, matrixIndex));
      matrixIndex++;
    }
  }
  return g;
}

void _encodeSubBlock(Uint8List eccData, int eccStart, Int32List g, int gWordsPerRow, int pgSubBlock,
    Uint8List data, int dataStart, int dataEnd) {
  for (int i = 0; i < pgSubBlock; i++) {
    int parity = 0;
    for (int j = dataStart; j < dataEnd; j++) {
      parity ^= _getBit(g, gWordsPerRow * i, j - dataStart) & (data[j] & 1);
    }
    eccData[eccStart + i] = parity & 1;
  }
}

_JabData _encodeLDPC(_JabData data, List<int> coderateParams) {
  final wc = coderateParams[0];
  final wr = coderateParams[1];
  final pn0 = data.length;
  final int Pg = wr > 0 ? wr * ((pn0 * wr / (wr - wc)).ceil() / wr).ceil() : pn0 * 2;

  final nbSubBlocks = _subBlockCount(Pg);
  int pgSubBlock = wr > 0 ? (Pg ~/ nbSubBlocks) ~/ wr * wr : Pg;
  int pnSubBlock = wr > 0 ? pgSubBlock * (wr - wc) ~/ wr : pn0;

  final fullBlocks = Pg ~/ pgSubBlock;
  final encodingIterations = pnSubBlock * fullBlocks < pn0 ? fullBlocks - 1 : fullBlocks;

  final matrixA = _createParityMatrix(wc, wr, pgSubBlock);
  int matrixRank = _gaussJordan(matrixA, wc, wr, pgSubBlock, true);
  final g = _createGeneratorMatrix(matrixA, pgSubBlock, pgSubBlock - matrixRank);

  final eccData = Uint8List(Pg);

  final offset = _ceilDiv(pgSubBlock - matrixRank, 32);
  for (int iter = 0; iter < encodingIterations; iter++) {
    _encodeSubBlock(eccData, iter * pgSubBlock, g, offset, pgSubBlock, data.data, iter * pnSubBlock,
    (iter + 1) * pnSubBlock);
  }

  if (encodingIterations != fullBlocks) {
    final start = encodingIterations * pnSubBlock;
    final lastIndex = encodingIterations * pgSubBlock;
    pgSubBlock = Pg - encodingIterations * pgSubBlock;
    pnSubBlock = pgSubBlock * (wr - wc) ~/ wr;
    final matrixA2 = _createMatrixA(wc, wr, pgSubBlock);
    matrixRank = _gaussJordan(matrixA2, wc, wr, pgSubBlock, true);
    final g2 = _createGeneratorMatrix(matrixA2, pgSubBlock, pgSubBlock - matrixRank);
    _encodeSubBlock(eccData, lastIndex, g2, _ceilDiv(pgSubBlock - matrixRank, 32), pgSubBlock, data.data, start,
        data.length);
  }

  return _JabData(Pg, eccData);
}

void _decodeMessage(Uint8List data, Int32List matrix, int length, int height, int maxIter, int startPos) {
  final maxVal = Int32List(length);
  final equalMax = Int32List(length);
  final prevIndex = Int32List(length);
  final rnd = Random();

  int prevCount = 0;
  final offset = _ceilDiv(length, 32);

  void flip(int index) => data[index] = (data[index] + 1) % 2;

  for (int kl = 0; kl < maxIter; kl++) {
    int max = 0;
    for (int j = 0; j < height; j++) {
      int check = 0;
      for (int i = 0; i < length; i++) {
        check += _getBit(matrix, j * offset, i) & (data[startPos + i] & 1);
      }
      if (check % 2 != 0) {
        for (int k = 0; k < length; k++) {
          if (_getBit(matrix, j * offset, k) == 1) maxVal[k]++;
        }
      }
    }

    int counter = 0;
    for (int j = 0; j < length; j++) {
      bool isUsed = false;
      for (int i = 0; i < prevCount; i++) {
        if (prevIndex[i] == j) {
          isUsed = true;
          break;
        }
      }
      if (maxVal[j] >= max && !isUsed) {
        if (maxVal[j] != max) counter = 0;
        max = maxVal[j];
        equalMax[counter] = j;
        counter++;
      }
      maxVal[j] = 0;
    }

    if (max == 0) break;

    if (length < 36) {
      final randTmp = (rnd.nextDouble() * counter).toInt().clamp(0, counter - 1);
      prevIndex[0] = startPos + equalMax[randTmp];
      flip(prevIndex[0]);
      prevCount = 1;
    } else {
      for (int j = 0; j < counter; j++) {
        prevIndex[j] = startPos + equalMax[j];
        flip(prevIndex[j]);
      }
      prevCount = counter;
    }
  }
}

bool _isParityValid(Int32List matrix, int rank, int length, Uint8List data, int startPos) {
  final offset = _ceilDiv(length, 32);
  for (int i = 0; i < rank; i++) {
    int parity = 0;
    for (int j = 0; j < length; j++) {
      parity ^= _getBit(matrix, i * offset, j) & (data[startPos + j] & 1);
    }
    if (parity != 0) return false;
  }
  return true;
}

Uint8List? _decodeLDPChd(Uint8List data, int length, int wcIn, int wr) {
  const maxIter = 25;
  int wc = wcIn;
  final int pn, pg;
  if (wr > 3) {
    pg = wr * (length ~/ wr);
    pn = pg * (wr - wc) ~/ wr; //decodedDataLen
  } else {
    pg = length;
    pn = length ~/ 2; //decodedDataLen
    wc = pn > 36 ? 3 : 2;
  }

  final int pgSubBlock = wr > 3 ? (pg ~/ _subBlockCount(pg)) ~/ wr * wr : pg;
  int pnSubBlock = wr > 3 ? pgSubBlock * (wr - wc) ~/ wr : pn;
  final int blockPnSub = pnSubBlock;
  final int nbSubBlocks = pg ~/ pgSubBlock;
  final int decodingIterations = pnSubBlock * nbSubBlocks < pn ? nbSubBlocks - 1 : nbSubBlocks;

  final matrixA = _createParityMatrix(wc, wr, pgSubBlock);
  final matrixRank = _gaussJordan(matrixA, wc, wr, pgSubBlock, false);

  for (int iter = 0; iter < nbSubBlocks; iter++) {
    Int32List curMatrix = matrixA;
    int curRank = matrixRank;
    int curPgSub = pgSubBlock;

    if (decodingIterations != nbSubBlocks && iter == decodingIterations) {
      curPgSub = pg - decodingIterations * pgSubBlock;
      pnSubBlock = curPgSub * (wr - wc) ~/ wr;
      curMatrix = _createMatrixA(wc, wr, curPgSub);
      curRank = _gaussJordan(curMatrix, wc, wr, curPgSub, false);
    }

    final startPos = iter * pgSubBlock;
    if (!_isParityValid(curMatrix, curRank, curPgSub, data, startPos)) {
      _decodeMessage(data, curMatrix, curPgSub, curRank, maxIter, startPos);
      if (!_isParityValid(curMatrix, curRank, curPgSub, data, startPos)) return null;
    }

    for (int i = 0; i < pnSubBlock; i++) {
      data[iter * blockPnSub + i] = data[startPos + i + curRank];
    }
  }
  return Uint8List.sublistView(data, 0, pn);
}