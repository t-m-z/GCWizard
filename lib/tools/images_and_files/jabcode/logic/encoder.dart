part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

void _genColorPalette(int colorNumber, Uint8List palette) {
  if (colorNumber < 8) return;

  int vr, vg, vb;
  switch (colorNumber) {
    case 16:
      vr = 4; vg = 2; vb = 2;
      break;
    case 32:
      vr = 4; vg = 4; vb = 2;
      break;
    case 64:
      vr = 4; vg = 4; vb = 4;
      break;
    case 128:
      vr = 8; vg = 4; vb = 4;
      break;
    case 256:
      vr = 8; vg = 8; vb = 4;
      break;
    default:
      return;
  }

  final double dr = (vr - 1) == 3 ? 85 : 256 / (vr - 1);
  final double dg = (vg - 1) == 3 ? 85 : 256 / (vg - 1);
  final double db = (vb - 1) == 3 ? 85 : 256 / (vb - 1);

  int index = 0;
  for (int i = 0; i < vr; i++) {
    final r = (dr * i).toInt().clamp(0, 255);
    for (int j = 0; j < vg; j++) {
      final g = (dg * j).toInt().clamp(0, 255);
      for (int k = 0; k < vb; k++) {
        final b = (db * k).toInt().clamp(0, 255);
        palette[index++] = r;
        palette[index++] = g;
        palette[index++] = b;
      }
    }
  }
}

void _setDefaultPalette(int colorNumber, Uint8List palette) {
  if (colorNumber == 4) {
    // black 000 für 00
    palette.setRange(0, 3, _jabDefaultPalette, _fp0CoreColor * 3);
    // magenta 101 für 01
    palette.setRange(3, 6, _jabDefaultPalette, 5 * 3);
    // yellow 110 für 10
    palette.setRange(6, 9, _jabDefaultPalette, _fp2CoreColor * 3);
    // cyan 011 für 11
    palette.setRange(9, 12, _jabDefaultPalette, _fp3CoreColor * 3);
  } else if (colorNumber == 8) {
    for (int i = 0; i < colorNumber * 3; i++) {
      palette[i] = _jabDefaultPalette[i];
    }
  } else {
    _genColorPalette(colorNumber, palette);
  }
}

void _convertDecToBin(int decIn, Uint8List bin, int startPosition, int length) {
  int dec = decIn;
  if (dec < 0) dec += 256;
  for (int j = 0; j < length; j++) {
    bin[startPosition + length - 1 - j] = dec % 2;
    dec ~/= 2;
  }
}

_JabEncode _createEncode(int moduleSize, int colorNumberIn, int symbolNumberIn, int eccLevelIn) {
  final colorNumber = const [4, 8, 16, 32, 64, 128, 256].contains(colorNumberIn) ? colorNumberIn : _defaultColorNumber;
  final symbolNumber = symbolNumberIn < 1 || symbolNumberIn > _maxSymbolNumber ? _defaultSymbolNumber : symbolNumberIn;
  final eccLevel = eccLevelIn < 0 || eccLevelIn > 10 ? _defaultEccLevel : eccLevelIn;
  final enc = _JabEncode(moduleSize: moduleSize, colorNumber: colorNumber, symbolNumber: symbolNumber);

  enc.palette = Uint8List(colorNumber * 3);
  _setDefaultPalette(enc.colorNumber, enc.palette!);

  enc.symbolVersions = List.generate(symbolNumber, (_) => _JabVector2d(0, 0));
  enc.symbolEccLevels = List<int>.filled(symbolNumber, eccLevel);
  enc.symbolPositions = List.filled(symbolNumber, 0);
  enc.symbols = List.generate(symbolNumber, (_) => _JabSymbol());

  return enc;
}

int _byteModeOverhead(int counter, int modeswitch) {
  int overhead = 13;
  if (counter > 8207) {
    final remainInByteMode = counter ~/ 8207;
    final remainInByteModeResidual = counter % 8207;
    overhead += remainInByteMode * modeswitch;
    overhead += remainInByteModeResidual < 16 ? (remainInByteMode - 1) * 13 : remainInByteMode * 13;
    if (remainInByteModeResidual == 0) overhead -= modeswitch;
  }
  return overhead;
}

({List<int> Sequence, int Length})? _analyzeInputData(_JabData input) {
  int encodeSeqLength = _encMax;

  final currSeqLen = Int32List((input.length + 2) * 14);
  final prevMode = Int32List((2 * input.length + 2) * 14)..fillRange(0, (2 * input.length + 2) * 14, _encMax ~/ 2);
  final switchMode = Int32List(28)..fillRange(0, 28, _encMax ~/ 2);
  final tempSwitchMode = Int32List(28)..fillRange(0, 28, _encMax ~/ 2);

  for (int k = 0; k < 7; k++) {
    currSeqLen[k] = currSeqLen[k + 7] = _encMax;
    prevMode[k] = prevMode[k + 7] = _encMax;
  }

  currSeqLen[0] = 0;
  int jpToNxtChar = 0, confirm = 0;
  int currSeqCounter = 0;
  bool isShift = false;
  int nbChar = 0;
  int endOfLoop = input.length;
  int prevModeIndex = 0;

  for (int i = 0; i < endOfLoop; i++) {
    final tmp = input.data[nbChar];
    final tmp1 = nbChar + 1 < input.length ? input.data[nbChar + 1] : 0;

    currSeqCounter++;
    final curRow = i * 14;
    final nextRow = (i + 1) * 14;
    final seqRow = currSeqCounter * 14;
    for (int j = 0; j < _jabEncodingModes; j++) {
      if (_jabEncodingTable[tmp][j] > -1 && _jabEncodingTable[tmp][j] < 64) {
        currSeqLen[nextRow + j] = currSeqLen[nextRow + j + 7] = _characterSize[j];
      } else if ((_jabEncodingTable[tmp][j] == -18 && tmp1 == 10) ||
          (_jabEncodingTable[tmp][j] < -18 && tmp1 == 32)) {
        currSeqLen[nextRow + j] = currSeqLen[nextRow + j + 7] = _characterSize[j];
        jpToNxtChar = 1;
      } else {
        currSeqLen[nextRow + j] = currSeqLen[nextRow + j + 7] = _encMax;
      }
    }
    currSeqLen[nextRow + 6] = currSeqLen[nextRow + 13] = _characterSize[6];
    isShift = false;

    for (int j = 0; j < 14; j++) {
      int prev = -1;
      int len = currSeqLen[nextRow + j] + currSeqLen[curRow + j] + _latchShiftTo[j][j];
      prevMode[seqRow + j] = j;
      for (int k = 0; k < 14; k++) {
        final candidate = currSeqLen[nextRow + j] + currSeqLen[curRow + k] + _latchShiftTo[k][j];
        if ((len >= candidate && k < 13) || (k == 13 && prev == j)) {
          len = candidate;
          prevMode[seqRow + j] = tempSwitchMode[2 * k] == k ? tempSwitchMode[2 * k + 1] : k;
          if (k == 13 && prev == j) prev = -1;
        }
      }
      currSeqLen[nextRow + j] = len;

      if (j > 6) {
        final prevOfJ = prevMode[seqRow + j];
        final needsSwitch = currSeqLen[nextRow + prevOfJ] > len ||
            (jpToNxtChar == 1 && currSeqLen[nextRow + prevOfJ] + _characterSize[prevOfJ % 7] > len);

        if (needsSwitch && j != 13) {
          int index = prevOfJ;
          int loop = 1;
          while (index > 6 && currSeqCounter - loop >= 0) {
            index = prevMode[(currSeqCounter - loop) * 14 + index];
            loop++;
          }
          currSeqLen[nextRow + index] = len;
          prevMode[(currSeqCounter + 1) * 14 + index] = j;
          switchMode[2 * index] = index;
          switchMode[2 * index + 1] = j;
          isShift = true;
          if (jpToNxtChar == 1 && j == 11) {
            confirm = 1;
            prevModeIndex = index;
          }
        } else if (needsSwitch && j == 13) {
          currSeqLen[nextRow + prevOfJ] = len;
          prevMode[(currSeqCounter + 1) * 14 + prevOfJ] = j;
          switchMode[2 * prevOfJ] = prevOfJ;
          switchMode[2 * prevOfJ + 1] = j;
          isShift = true;
        }
        if (j != 13) {
          currSeqLen[nextRow + j] = _encMax;
        } else {
          prev = prevOfJ;
        }
      }
    }

    tempSwitchMode.setAll(0, switchMode);
    switchMode.fillRange(0, 28, _encMax ~/ 2);

    if (jpToNxtChar == 1 && confirm == 1) {
      for (int j = 0; j <= 2 * _jabEncodingModes + 1; j++) {
        if (j != prevModeIndex) currSeqLen[nextRow + j] = _encMax;
      }
      nbChar++;
      endOfLoop--;
    }
    jpToNxtChar = 0;
    confirm = 0;
    nbChar++;
  }

  int currentMode = 0;
  final lastRow = (nbChar - (input.length - endOfLoop)) * 14;
  for (int j = 0; j <= 2 * _jabEncodingModes + 1; j++) {
    if (encodeSeqLength > currSeqLen[lastRow + j]) {
      encodeSeqLength = currSeqLen[lastRow + j];
      currentMode = j;
    }
  }
  if (currentMode > 6) isShift = true;
  if (isShift && tempSwitchMode[2 * currentMode + 1] < 14) {
    currentMode = tempSwitchMode[2 * currentMode + 1];
  }

  final encodeSeq = Int32List(currSeqCounter + 1 + (isShift ? 1 : 0));

  int counter = 0;
  int modeswitch = 0;
  encodeSeq[currSeqCounter] = currentMode;

  for (int i = currSeqCounter; i > 0; i--) {
    if (encodeSeq[i] == 13 || encodeSeq[i] == 6) {
      counter++;
    } else if (counter > 15) {
      if (counter > 8207) {
        switch (encodeSeq[i]) {
          case 0:
          case 1:
          case 7:
          case 8:
            modeswitch = 11;
            break;
          case 2:
          case 9:
            modeswitch = 10;
            break;
          case 5:
          case 12:
            modeswitch = 12;
            break;
        }
      }
      encodeSeqLength += _byteModeOverhead(counter, modeswitch);
      counter = 0;
    }

    if (encodeSeq[i] < 14 && i - 1 != 0) {
      encodeSeq[i - 1] = prevMode[i * 14 + encodeSeq[i]];
    } else if (i - 1 == 0) {
      encodeSeq[i - 1] = 0;
      if (counter > 15) {
        modeswitch = 11;
        encodeSeqLength += _byteModeOverhead(counter, modeswitch);
        counter = 0;
      }
    } else {
      return null;
    }
  }

  return (Sequence: encodeSeq.toList(), Length: encodeSeqLength);
}

bool _isDefaultMode(_JabEncode enc) {
  if (enc.colorNumber == 8 &&
      (enc.symbolEccLevels[0] == 0 || enc.symbolEccLevels[0] == _defaultEccLevel)) {
    return true;
  }
  return false;
}

const int _masterMetadataPart1Length = 6;
const int _masterMetadataPart2Length = 38;
const int _masterMetadataPart1ModuleNumber = 4;

int _getMetadataLength(_JabEncode enc, int index) {
  int length = 0;
  if (index == 0) {
    if (_isDefaultMode(enc)) {
      length = 0;
    } else {
      length += _masterMetadataPart1Length;
      length += _masterMetadataPart2Length;
    }
  } else {
    length += 2;
    final hostIndex = enc.symbols[index].host;
    if (enc.symbolVersions[index].x != enc.symbolVersions[hostIndex].x ||
        enc.symbolVersions[index].y != enc.symbolVersions[hostIndex].y) {
      length += 5;
    }
    if (enc.symbolEccLevels[index] != enc.symbolEccLevels[hostIndex]) {
      length += 6;
    }
  }
  return length;
}

int _getSymbolCapacity(_JabEncode enc, int index) {
  final int nbModulesFp = index == 0 ? 4 * 17 : 4 * 7;
  final int nbModulesPalette = enc.colorNumber > 64
      ? (64 - 2) * _colorPaletteNumber
      : (enc.colorNumber - 2) * _colorPaletteNumber;
  final int sideSizeX = _version2size(enc.symbolVersions[index].x);
  final int sideSizeY = _version2size(enc.symbolVersions[index].y);
  final int numberOfApsX = _jabApNum[enc.symbolVersions[index].x - 1];
  final int numberOfApsY = _jabApNum[enc.symbolVersions[index].y - 1];
  final int nbModulesAp = (numberOfApsX * numberOfApsY - 4) * 7;
  final int nbOfBpm = (log(enc.colorNumber) / log(2)).round();
  int nbModulesMetadata = 0;
  if (index == 0) {
    final nbMetadataBits = _getMetadataLength(enc, index);
    if (nbMetadataBits > 0) {
      nbModulesMetadata = (nbMetadataBits - _masterMetadataPart1Length) ~/ nbOfBpm;
      if ((nbMetadataBits - _masterMetadataPart1Length) % nbOfBpm != 0) {
        nbModulesMetadata++;
      }
      nbModulesMetadata += _masterMetadataPart1ModuleNumber;
    }
  }
  final capacity = (sideSizeX * sideSizeY -
          nbModulesFp -
          nbModulesAp -
          nbModulesPalette -
          nbModulesMetadata) *
      nbOfBpm;
  return capacity;
}

int _netCapacity(int capacity, int wc, int wr) => (capacity ~/ wr) * wr - (capacity ~/ wr) * wc;

({int Wc, int Wr})? _getOptimalECC(int capacity, int netDataLength) {
  ({int Wc, int Wr})? best;
  int minDist = capacity;
  for (int k = 3; k <= 6 + 2; k++) {
    for (int j = k + 1; j <= 6 + 3; j++) {
      final dist = _netCapacity(capacity, k, j) - netDataLength;
      if (dist < minDist && dist >= 0) {
        best = (Wc: k, Wr: j);
        minDist = dist;
      }
    }
  }
  return best;
}

int _applyOptimalEcc(_JabSymbol symbol, int capacity, int netDataLength) {
  final best = _getOptimalECC(capacity, netDataLength);
  if (best != null) {
    symbol.wcwr[0] = best.Wc;
    symbol.wcwr[1] = best.Wr;
  }
  return _netCapacity(capacity, symbol.wcwr[0], symbol.wcwr[1]);
}

_JabData? _encodeData(_JabData data, int encodedLength, List<int> encodeSeq) {
  final encodedData = Uint8List(encodedLength);

  int counter = 0;
  bool shiftBack = false;
  int position = 0;
  int currentEncodedLength = 0;
  int endOfLoop = data.length;
  int byteOffset = 0;
  int byteCounter = 0;
  int factor = 1;

  void writeByteCount() {
    _convertDecToBin(byteCounter > 15 ? 0 : byteCounter, encodedData, position, 4);
    position += 4;
    if (byteCounter > 15) {
      _convertDecToBin(byteCounter <= 8207 ? byteCounter - 15 - 1 : 8191, encodedData, position, 13);
      position += 13;
    }
  }

  for (int i = 0; i < endOfLoop; i++) {
    final tmp = data.data[currentEncodedLength];
    if (position < encodedLength) {
      if (encodeSeq[counter] != encodeSeq[counter + 1]) {
        int length = _latchShiftTo[encodeSeq[counter]][encodeSeq[counter + 1]];
        if (encodeSeq[counter + 1] == 6 || encodeSeq[counter + 1] == 13) {
          length -= 4;
        }
        if (length < _encMax) {
          _convertDecToBin(_modeSwitch[encodeSeq[counter]][encodeSeq[counter + 1]], encodedData, position, length);
        } else {
          return null; // "Encoding data failed"
        }
        position += _latchShiftTo[encodeSeq[counter]][encodeSeq[counter + 1]];
        if (encodeSeq[counter + 1] == 6 || encodeSeq[counter + 1] == 13) {
          position -= 4;
        }
        if ((encodeSeq[counter + 1] > 6 && encodeSeq[counter + 1] <= 13) ||
            (encodeSeq[counter + 1] == 13 && encodeSeq[counter + 2] != 13)) {
          shiftBack = true;
        }
      }

      if (encodeSeq[counter + 1] % 7 != 6) {
        final mode = encodeSeq[counter + 1] % 7;
        if (_jabEncodingTable[tmp][mode] > -1 && _characterSize[mode] < _encMax) {
          _convertDecToBin(_jabEncodingTable[tmp][mode], encodedData, position, _characterSize[mode]);
          position += _characterSize[mode];
          counter++;
        } else if (_jabEncodingTable[tmp][mode] < -1) {
          final tmp1 = data.data[currentEncodedLength + 1];
          final int decimalValue;
          if (((tmp == 44 || tmp == 46 || tmp == 58) && tmp1 == 32) || (tmp == 13 && tmp1 == 10)) {
            decimalValue = _jabEncodingTable[tmp][mode].abs();
          } else if (tmp == 13) {
            decimalValue = 18;
          } else {
            return null; // "Encoding data failed"
          }
          if (_characterSize[mode] < _encMax) {
            _convertDecToBin(decimalValue, encodedData, position, _characterSize[mode]);
          }
          position += _characterSize[mode];
          counter++;
          endOfLoop--;
          currentEncodedLength++;
        } else {
          return null; // "Encoding data failed"
        }
      } else {
        // byte mode
        if (encodeSeq[counter] != encodeSeq[counter + 1]) {
          byteCounter = 0;
          for (int byteLoop = counter + 1; byteLoop <= endOfLoop; byteLoop++) {
            if (byteLoop < encodeSeq.length &&
                (encodeSeq[byteLoop] == 6 || encodeSeq[byteLoop] == 13)) {
              byteCounter++;
            } else {
              break;
            }
          }
          writeByteCount();
          byteOffset = byteCounter;
        }
        if (byteOffset - byteCounter == factor * 8207) {
          final refMode = encodeSeq[counter - (byteOffset - byteCounter)];
          switch (refMode) {
            case 0:
            case 1:
            case 7:
            case 8:
              _convertDecToBin(124, encodedData, position, 7);
              position += 7;
              break;
            case 2:
            case 9:
              _convertDecToBin(60, encodedData, position, 5);
              position += 5;
              break;
            case 5:
            case 12:
              _convertDecToBin(252, encodedData, position, 8);
              position += 8;
              break;
          }
          writeByteCount();
          factor++;
        }
        final mode = encodeSeq[counter + 1] % 7;
        if (_characterSize[mode] < _encMax) {
          _convertDecToBin(tmp, encodedData, position, _characterSize[mode]);
        } else {
          return null; // "Encoding data failed"
        }
        position += _characterSize[mode];
        counter++;
        byteCounter--;
      }

      if (shiftBack && byteCounter == 0) {
        if (byteOffset == 0) {
          encodeSeq[counter] = encodeSeq[counter - 1];
        } else {
          encodeSeq[counter] = encodeSeq[counter - byteOffset];
        }
        shiftBack = false;
        byteOffset = 0;
      }
    } else {
      return null; // "Encoding data failed"
    }
    currentEncodedLength++;
  }
  return _JabData(encodedLength, encodedData);
}

bool _encodeMasterMetadata(_JabEncode enc) {
  const partILength = _masterMetadataPart1Length ~/ 2;
  const partIILength = _masterMetadataPart2Length ~/ 2;
  const vLength = 10;
  const eLength = 6;
  const mskLength = 3;

  final nc = (log(enc.colorNumber) / log(2.0)).round() - 1;
  final v = ((enc.symbolVersions[0].x - 1) << 5) + (enc.symbolVersions[0].y - 1);
  final e1 = enc.symbols[0].wcwr[0] - 3;
  final e2 = enc.symbols[0].wcwr[1] - 4;
  const msk = _defaultMaskingReference;

  final partI = Uint8List(partILength);
  _convertDecToBin(nc, partI, 0, partILength);

  final partII = Uint8List(partIILength);
  _convertDecToBin(v, partII, 0, vLength);
  _convertDecToBin(e1, partII, vLength, 3);
  _convertDecToBin(e2, partII, vLength + 3, 3);
  _convertDecToBin(msk, partII, vLength + eLength, mskLength);

  final wcwr = [2, -1];
  final encodedPartI = _encodeLDPC(_JabData(partILength, partI), wcwr);
  final encodedPartII = _encodeLDPC(_JabData(partIILength, partII), wcwr);

  final encodedMetadataLength = encodedPartI.length + encodedPartII.length;
  final metadata = Uint8List(encodedMetadataLength);
  metadata.setRange(0, encodedPartI.length, encodedPartI.data);
  metadata.setRange(encodedPartI.length, encodedMetadataLength, encodedPartII.data);
  enc.symbols[0].metadata = _JabData(encodedMetadataLength, metadata);

  return true;
}

bool _updateMasterMetadataPartII(_JabEncode enc, int maskRef) {
  const partIILength = _masterMetadataPart2Length ~/ 2;
  final partII = Uint8List(partIILength);

  const vLength = 10;
  const eLength = 6;
  const mskLength = 3;
  final v = ((enc.symbolVersions[0].x - 1) << 5) + (enc.symbolVersions[0].y - 1);
  final e1 = enc.symbols[0].wcwr[0] - 3;
  final e2 = enc.symbols[0].wcwr[1] - 4;
  _convertDecToBin(v, partII, 0, vLength);
  _convertDecToBin(e1, partII, vLength, 3);
  _convertDecToBin(e2, partII, vLength + 3, 3);
  _convertDecToBin(maskRef, partII, vLength + eLength, mskLength);

  final wcwr = [2, -1];
  final encodedPartII = _encodeLDPC(_JabData(partIILength, partII), wcwr);

  final metadata = enc.symbols[0].metadata!;
  metadata.data.setRange(_masterMetadataPart1Length,
      _masterMetadataPart1Length + encodedPartII.length, encodedPartII.data);

  return true;
}

class _MasterMetadataCursor {
  _MasterMetadataCursor(this.width, this.height);

  final int width, height;
  int x = _masterMetadataX;
  int y = _masterMetadataY;

  int moduleCount = 0;
  int get index => y * width + x;

  void reset() {
    x = _masterMetadataX;
    y = _masterMetadataY;
    moduleCount = 0;
  }

  void advance() {
    moduleCount++;
    final n = moduleCount;
    if (n % 4 == 0 || n % 4 == 2) {
      y = height - 1 - y;
    }
    if (n % 4 == 1 || n % 4 == 3) {
      x = width - 1 - x;
    }
    if (n % 4 == 0) {
      if (n <= 20 || (n >= 44 && n <= 68) || (n >= 96 && n <= 124) || (n >= 156 && n <= 172)) {
        y += 1;
      } else if ((n > 20 && n < 44) || (n > 68 && n < 96) || (n > 124 && n < 156)) {
        x -= 1;
      }
    }
    if (n == 44 || n == 96 || n == 156) {
      final tmp = x;
      x = y;
      y = tmp;
    }
  }
}

void _placeMasterMetadataPartII(_JabEncode enc) {
  final nbOfBitsPerMod = (log(enc.colorNumber) / log(2)).round();
  final symbol = enc.symbols[0];
  final cursor = _MasterMetadataCursor(symbol.sideSize.x, symbol.sideSize.y);

  final colorPaletteSize = min(enc.colorNumber - 2, 64 - 2);
  final moduleOffset = _masterMetadataPart1ModuleNumber + colorPaletteSize * _colorPaletteNumber;
  for (int i = 0; i < moduleOffset; i++) {
    cursor.advance();
  }

  final partIIBitEnd = _masterMetadataPart1Length + _masterMetadataPart2Length;
  int metadataIndex = _masterMetadataPart1Length;
  final matrix = symbol.matrix!;
  while (metadataIndex < partIIBitEnd) {
    int colorIndex = matrix[cursor.index];
    for (int j = 0; j < nbOfBitsPerMod && metadataIndex < partIIBitEnd; j++) {
      final bitMask = 1 << (nbOfBitsPerMod - 1 - j);
      if (symbol.metadata!.data[metadataIndex] == 0) {
        colorIndex &= ~bitMask;
      } else {
        colorIndex |= bitMask;
      }
      metadataIndex++;
    }
    matrix[cursor.index] = colorIndex & 0xFF;
    cursor.advance();
  }
}

Uint8List _getColorPaletteIndex(int indexSize, int colorNumber) {
  final index = Uint8List(indexSize);
  for (int i = 0; i < indexSize; i++) {
    index[i] = i;
  }
  if (colorNumber < 128) return index;

  final tmp = Uint8List(colorNumber);
  for (int i = 0; i < colorNumber; i++) {
    tmp[i] = i;
  }

  if (colorNumber == 128) {
    index.setRange(0, 16, tmp, 0);
    index.setRange(16, 32, tmp, 32);
    index.setRange(32, 48, tmp, 80);
    index.setRange(48, 64, tmp, 112);
  } else if (colorNumber == 256) {
    index.setRange(0, 4, tmp, 0);
    index.setRange(4, 8, tmp, 8);
    index.setRange(8, 12, tmp, 20);
    index.setRange(12, 16, tmp, 28);

    index.setRange(16, 20, tmp, 64);
    index.setRange(20, 24, tmp, 72);
    index.setRange(24, 28, tmp, 84);
    index.setRange(28, 32, tmp, 92);

    index.setRange(32, 36, tmp, 160);
    index.setRange(36, 40, tmp, 168);
    index.setRange(40, 44, tmp, 180);
    index.setRange(44, 48, tmp, 188);

    index.setRange(48, 52, tmp, 224);
    index.setRange(52, 56, tmp, 232);
    index.setRange(56, 60, tmp, 244);
    index.setRange(60, 64, tmp, 252);
  }
  return index;
}

void _createMatrix(_JabEncode enc, int index, _JabData eccEncodedData) {
  final symbol = enc.symbols[index];
  final width = symbol.sideSize.x;
  final height = symbol.sideSize.y;

  symbol.matrix = Uint8List(width * height);
  symbol.dataMap = Uint8List(width * height)..fillRange(0, width * height, 1);

  final matrix = symbol.matrix!;
  final dataMap = symbol.dataMap!;

  void setModule(int x, int y, int colorIndex) {
    matrix[y * width + x] = colorIndex;
    dataMap[y * width + x] = 0;
  }

  final nc = (log(enc.colorNumber) / log(2.0)).round() - 1;
  final sideVerXIndex = _size2version(width) - 1;
  final sideVerYIndex = _size2version(height) - 1;

  final apCountX = _jabApNum[sideVerXIndex];
  final apCountY = _jabApNum[sideVerYIndex];
  for (int x = 0; x < apCountX; x++) {
    for (int y = 0; y < apCountY; y++) {
      if ((x == 0 || x == apCountX - 1) && (y == 0 || y == apCountY - 1)) continue;

      final centerX = _jabApPos[sideVerXIndex][x] - 1;
      final centerY = _jabApPos[sideVerYIndex][y] - 1;
      final diagonal = (x + y) % 2 == 0 ? 1 : -1;
      for (final (dx, dy) in [(0, -1), (-1, 0), (1, 0), (0, 1), (-diagonal, -1), (diagonal, 1)]) {
        setModule(centerX + dx, centerY + dy, _apnCoreColorIndex[nc]);
      }
      setModule(centerX, centerY, _apxCoreColorIndex[nc]);
    }
  }

  void setCornerModules(int i, int j, List<int> colors) {
    final leftX = _distanceToBorder - j - 1;
    final leftX2 = _distanceToBorder + j - 1;
    final rightX = width - (_distanceToBorder - 1) - j - 1;
    final rightX2 = width - (_distanceToBorder - 1) + j - 1;
    final topY = _distanceToBorder - (i + 1);
    final topY2 = _distanceToBorder + (i - 1);
    final bottomY = height - _distanceToBorder + i;
    final bottomY2 = height - _distanceToBorder - i;

    setModule(leftX, topY, colors[0]);
    setModule(leftX2, topY2, colors[0]);
    setModule(rightX, topY, colors[1]);
    setModule(rightX2, topY2, colors[1]);
    setModule(rightX, bottomY, colors[2]);
    setModule(rightX2, bottomY2, colors[2]);
    setModule(leftX, bottomY, colors[3]);
    setModule(leftX2, bottomY2, colors[3]);
  }

  final cornerRings = index == 0 ? 3 : 2;
  for (int k = 0; k < cornerRings; k++) {
    final List<int> colors;
    if (index == 0) {
      final fp = [_fp0CoreColorIndex[nc], _fp1CoreColorIndex[nc], _fp2CoreColorIndex[nc], _fp3CoreColorIndex[nc]];
      colors = k % 2 != 0 ? fp.reversed.toList() : fp;
    } else {
      final apColorIndex = k % 2 != 0 ? _apxCoreColorIndex[nc] : _apnCoreColorIndex[nc];
      colors = [apColorIndex, apColorIndex, apColorIndex, apColorIndex];
    }
    for (int i = 0; i < k + 1; i++) {
      for (int j = 0; j < k + 1; j++) {
        if (i == k || j == k) setCornerModules(i, j, colors);
      }
    }
  }

  final nbOfBitsPerMod = (log(enc.colorNumber) / log(2)).toInt();
  final paletteIndexSize = enc.colorNumber > 64 ? 64 : enc.colorNumber;
  final paletteIndex = _getColorPaletteIndex(paletteIndexSize, enc.colorNumber);

  if (index == 0) {
    final cursor = _MasterMetadataCursor(width, height);
    void placeNext(int colorIndex) {
      setModule(cursor.x, cursor.y, colorIndex);
      cursor.advance();
    }

    int metadataIndex = 0;

    if (!_isDefaultMode(enc)) {
      final metadata = symbol.metadata!;
      while (metadataIndex < metadata.length && metadataIndex < _masterMetadataPart1Length) {
        final val = (metadata.data[metadataIndex] << 2) +
            (metadata.data[metadataIndex + 1] << 1) +
            metadata.data[metadataIndex + 2];
        for (int i = 0; i < 2; i++) {
          placeNext(_ncColorEncodeTable[val][i] % enc.colorNumber);
        }
        metadataIndex += 3;
      }
    }

    for (int i = 2; i < min(enc.colorNumber, 64); i++) {
      for (int palette = 0; palette < _colorPaletteNumber; palette++) {
        placeNext(paletteIndex[_masterPalettePlacementIndex[palette][i] % enc.colorNumber]);
      }
    }

    if (!_isDefaultMode(enc)) {
      final metadata = symbol.metadata!;
      while (metadataIndex < metadata.length) {
        int colorIndex = 0;
        for (int j = 0; j < nbOfBitsPerMod && metadataIndex < metadata.length; j++) {
          colorIndex += metadata.data[metadataIndex] << (nbOfBitsPerMod - 1 - j);
          metadataIndex++;
        }
        placeNext(colorIndex);
      }
    }
  } else {
    for (int i = 2; i < min(enc.colorNumber, 64); i++) {
      final pos = _slavePalettePosition[i - 2];
      final val = paletteIndex[_slavePalettePlacementIndex[i] % enc.colorNumber];
      setModule(pos.x, pos.y, val); // left
      setModule(width - 1 - pos.y, pos.x, val); // top
      setModule(width - 1 - pos.x, height - 1 - pos.y, val); // right
      setModule(pos.y, height - 1 - pos.x, val); // bottom
    }
  }

  int writtenMessPart = 0;
  int padding = 0;
  for (int startI = 0; startI < width; startI++) {
    for (int i = startI; i < width * height; i += width) {
      if (dataMap[i] == 0) continue;

      int colorIndex = 0;
      for (int j = 0; j < nbOfBitsPerMod; j++) {
        final int bit;
        if (writtenMessPart < eccEncodedData.length) {
          bit = eccEncodedData.data[writtenMessPart];
        } else {
          bit = padding;
          padding = 1 - padding;
        }
        writtenMessPart++;
        colorIndex += bit << (nbOfBitsPerMod - 1 - j);
      }
      matrix[i] = colorIndex & 0xFF;
    }
  }
}

void _swapSymbols(_JabEncode enc, int index1, int index2) {
  final tmpPos = enc.symbolPositions[index1];
  enc.symbolPositions[index1] = enc.symbolPositions[index2];
  enc.symbolPositions[index2] = tmpPos;

  final tmpVerX = enc.symbolVersions[index1].x;
  enc.symbolVersions[index1].x = enc.symbolVersions[index2].x;
  enc.symbolVersions[index2].x = tmpVerX;
  final tmpVerY = enc.symbolVersions[index1].y;
  enc.symbolVersions[index1].y = enc.symbolVersions[index2].y;
  enc.symbolVersions[index2].y = tmpVerY;

  final tmpEcc = enc.symbolEccLevels[index1];
  enc.symbolEccLevels[index1] = enc.symbolEccLevels[index2];
  enc.symbolEccLevels[index2] = tmpEcc;

  final s = enc.symbols[index1];
  enc.symbols[index1] = enc.symbols[index2];
  enc.symbols[index2] = s;
}

bool _assignDockedSymbols(_JabEncode enc) {
  for (int i = 0; i < enc.symbolNumber; i++) {
    enc.symbols[i].host = -1;
    for (int j = 0; j < 4; j++) {
      enc.symbols[i].slaves[j] = 0;
    }
  }

  int assignedSlaveIndex = 1;
  for (int i = 0;
      i < enc.symbolNumber - 1 && assignedSlaveIndex < enc.symbolNumber;
      i++) {
    for (int j = 0; j < 4 && assignedSlaveIndex < enc.symbolNumber; j++) {
      for (int k = i + 1;
          k < enc.symbolNumber && assignedSlaveIndex < enc.symbolNumber;
          k++) {
        if (enc.symbols[k].host == -1) {
          final hpos = enc.symbolPositions[i];
          final spos = enc.symbolPositions[k];
          bool slaveFound = false;
          switch (j) {
            case 0: // top
              if (_jabSymbolPos[hpos].x == _jabSymbolPos[spos].x &&
                  _jabSymbolPos[hpos].y - 1 == _jabSymbolPos[spos].y) {
                enc.symbols[i].slaves[0] = assignedSlaveIndex;
                enc.symbols[k].slaves[1] = -1;
                slaveFound = true;
              }
              break;
            case 1: // bottom
              if (_jabSymbolPos[hpos].x == _jabSymbolPos[spos].x &&
                  _jabSymbolPos[hpos].y + 1 == _jabSymbolPos[spos].y) {
                enc.symbols[i].slaves[1] = assignedSlaveIndex;
                enc.symbols[k].slaves[0] = -1;
                slaveFound = true;
              }
              break;
            case 2: // left
              if (_jabSymbolPos[hpos].y == _jabSymbolPos[spos].y &&
                  _jabSymbolPos[hpos].x - 1 == _jabSymbolPos[spos].x) {
                enc.symbols[i].slaves[2] = assignedSlaveIndex;
                enc.symbols[k].slaves[3] = -1;
                slaveFound = true;
              }
              break;
            case 3: // right
              if (_jabSymbolPos[hpos].y == _jabSymbolPos[spos].y &&
                  _jabSymbolPos[hpos].x + 1 == _jabSymbolPos[spos].x) {
                enc.symbols[i].slaves[3] = assignedSlaveIndex;
                enc.symbols[k].slaves[2] = -1;
                slaveFound = true;
              }
              break;
          }
          if (slaveFound) {
            _swapSymbols(enc, k, assignedSlaveIndex);
            enc.symbols[assignedSlaveIndex].host = i;
            assignedSlaveIndex++;
          }
        }
      }
    }
  }

  for (int i = 1; i < enc.symbolNumber; i++) {
    if (enc.symbols[i].host == -1) {
      return false; // "Slave symbol at position ... has no host"
    }
  }
  return true;
}

_JabCode _getCodePara(_JabEncode enc) {
  final cp = _JabCode();

  if (enc.masterSymbolWidth != 0 || enc.masterSymbolHeight != 0) {
    final dimensionX = enc.masterSymbolWidth ~/ enc.symbols[0].sideSize.x;
    final dimensionY = enc.masterSymbolHeight ~/ enc.symbols[0].sideSize.y;
    cp.dimension = max(max(dimensionX, dimensionY), 1);
  } else {
    cp.dimension = enc.moduleSize;
  }

  final positions = List.generate(enc.symbolNumber, (i) => _jabSymbolPos[enc.symbolPositions[i]]);
  cp.minX = 0;
  cp.minY = 0;
  int maxX = 0, maxY = 0;
  for (final pos in positions) {
    cp.minX = min(cp.minX, pos.x);
    cp.minY = min(cp.minY, pos.y);
    maxX = max(maxX, pos.x);
    maxY = max(maxY, pos.y);
  }

  cp.rows = maxY - cp.minY + 1;
  cp.cols = maxX - cp.minX + 1;
  cp.colWidth = List<int>.filled(cp.cols, 0);
  cp.rowHeight = List<int>.filled(cp.rows, 0);

  cp.codeSize = _JabVector2d(0, 0);
  for (int x = cp.minX; x <= maxX; x++) {
    final first = positions.indexWhere((pos) => pos.x == x);
    if (first < 0) continue;
    cp.colWidth[x - cp.minX] = enc.symbols[first].sideSize.x;
    cp.codeSize.x += cp.colWidth[x - cp.minX];
  }
  for (int y = cp.minY; y <= maxY; y++) {
    final first = positions.indexWhere((pos) => pos.y == y);
    if (first < 0) continue;
    cp.rowHeight[y - cp.minY] = enc.symbols[first].sideSize.y;
    cp.codeSize.y += cp.rowHeight[y - cp.minY];
  }
  return cp;
}

({int X, int Y}) _symbolOffsetInCode(_JabEncode enc, _JabCode cp, int k) {
  final pos = _jabSymbolPos[enc.symbolPositions[k]];
  return (
    X: cp.colWidth.take(pos.x - cp.minX).fold<int>(0, (sum, width) => sum + width),
    Y: cp.rowHeight.take(pos.y - cp.minY).fold<int>(0, (sum, height) => sum + height),
  );
}

void _createBitmap(_JabEncode enc, _JabCode cp) {
  final width = cp.dimension * cp.codeSize.x;
  final height = cp.dimension * cp.codeSize.y;
  const bytesPerPixel = _bitmapBitsPerPixel ~/ 8;
  final bytesPerRow = width * bytesPerPixel;

  final bitmap = _JabBitmap(
    width: width,
    height: height,
    bitsPerPixel: _bitmapBitsPerPixel,
    bitsPerChannel: _bitmapBitsPerChannel,
    channelCount: _bitmapChannelCount,
  );
  enc.bitmap = bitmap;

  for (int k = 0; k < enc.symbolNumber; k++) {
    final symbol = enc.symbols[k];
    final offset = _symbolOffsetInCode(enc, cp, k);

    for (int y = 0; y < symbol.sideSize.y; y++) {
      for (int x = 0; x < symbol.sideSize.x; x++) {
        final paletteOffset = symbol.matrix![y * symbol.sideSize.x + x] * 3;

        for (int i = (offset.Y + y) * cp.dimension; i < (offset.Y + y + 1) * cp.dimension; i++) {
          for (int j = (offset.X + x) * cp.dimension; j < (offset.X + x + 1) * cp.dimension; j++) {
            final pixelOffset = i * bytesPerRow + j * bytesPerPixel;
            bitmap.pixel[pixelOffset] = enc.palette![paletteOffset];
            bitmap.pixel[pixelOffset + 1] = enc.palette![paletteOffset + 1];
            bitmap.pixel[pixelOffset + 2] = enc.palette![paletteOffset + 2];
            bitmap.pixel[pixelOffset + 3] = 255;
          }
        }
      }
    }
  }
}

bool _checkDockedSymbolSize(_JabEncode enc) {
  for (int i = 0; i < enc.symbolNumber; i++) {
    for (int j = 0; j < 4; j++) {
      final slaveIndex = enc.symbols[i].slaves[j];
      if (slaveIndex > 0) {
        final hpos = enc.symbolPositions[i];
        final spos = enc.symbolPositions[slaveIndex];
        final xDiff = _jabSymbolPos[hpos].x - _jabSymbolPos[spos].x;
        final yDiff = _jabSymbolPos[hpos].y - _jabSymbolPos[spos].y;

        if (xDiff == 0 &&
            enc.symbolVersions[i].x != enc.symbolVersions[slaveIndex].x) {
          return false;
        }
        if (yDiff == 0 &&
            enc.symbolVersions[i].y != enc.symbolVersions[slaveIndex].y) {
          return false;
        }
      }
    }
  }
  return true;
}

bool _setMasterSymbolVersion(_JabEncode enc, _JabData encodedData) {
  final payloadLength = encodedData.length + 5;
  final master = enc.symbols[0];
  if (enc.symbolEccLevels[0] == 0) enc.symbolEccLevels[0] = _defaultEccLevel;
  master.wcwr[0] = _ecclevel2wcwr[enc.symbolEccLevels[0]][0];
  master.wcwr[1] = _ecclevel2wcwr[enc.symbolEccLevels[0]][1];

  for (int i = 1; i <= 32; i++) {
    enc.symbolVersions[0].x = i;
    enc.symbolVersions[0].y = i;
    if (_netCapacity(_getSymbolCapacity(enc, 0), master.wcwr[0], master.wcwr[1]) >= payloadLength) {
      master.sideSize.x = _version2size(i);
      master.sideSize.y = _version2size(i);
      return true;
    }
  }
  return false;
}

bool _addE2SlaveMetadata(_JabSymbol slave) {
  final oldMetadataLength = slave.metadata!.length;
  final newMetadataLength = oldMetadataLength + 6;
  final oldMetadata = slave.metadata!;
  final newData = Uint8List(newMetadataLength);
  newData.setRange(0, oldMetadataLength, oldMetadata.data);
  slave.metadata = _JabData(newMetadataLength, newData);

  slave.metadata!.data[1] = 1; // SE = 1
  final e1 = slave.wcwr[0] - 3;
  final e2 = slave.wcwr[1] - 4;
  _convertDecToBin(e1, slave.metadata!.data, oldMetadataLength, 3);
  _convertDecToBin(e2, slave.metadata!.data, oldMetadataLength + 3, 3);
  return true;
}

void _updateSlaveMetadataE(_JabEncode enc, int hostIndex, int slaveIndex) {
  final host = enc.symbols[hostIndex];
  final slave = enc.symbols[slaveIndex];

  int offset = host.data!.length - 1;
  while (host.data!.data[offset] == 0) {
    offset--;
  }
  offset--; // skip flag bit
  if (hostIndex == 0) {
    offset -= 4;
  } else {
    offset -= 3;
  }
  for (int i = 0; i < 4; i++) {
    if (host.slaves[i] == slaveIndex) {
      break;
    } else if (host.slaves[i] <= 0) {
      continue;
    } else {
      offset -= enc.symbols[host.slaves[i]].metadata!.length;
    }
  }
  if (slave.metadata!.data[0] == 1) {
    offset -= 7;
  } else {
    offset -= 2;
  }

  final e = Uint8List(6);
  final e1 = slave.wcwr[0] - 3;
  final e2 = slave.wcwr[1] - 4;
  _convertDecToBin(e1, e, 0, 3);
  _convertDecToBin(e2, e, 3, 3);
  for (int i = 0; i < 6; i++) {
    host.data!.data[offset--] = e[i];
  }
}

bool _fitDataIntoSymbols(_JabEncode enc, _JabData encodedData) {
  final capacity = List<int>.filled(enc.symbolNumber, 0);
  final netCapacity = List<int>.filled(enc.symbolNumber, 0);
  int totalNetCapacity = 0;
  for (int i = 0; i < enc.symbolNumber; i++) {
    capacity[i] = _getSymbolCapacity(enc, i);
    enc.symbols[i].wcwr[0] = _ecclevel2wcwr[enc.symbolEccLevels[i]][0];
    enc.symbols[i].wcwr[1] = _ecclevel2wcwr[enc.symbolEccLevels[i]][1];
    netCapacity[i] = _netCapacity(capacity[i], enc.symbols[i].wcwr[0], enc.symbols[i].wcwr[1]);
    totalNetCapacity += netCapacity[i];
  }

  int assignedDataLength = 0;
  for (int i = 0; i < enc.symbolNumber; i++) {
    int sDataLength;
    if (i == enc.symbolNumber - 1) {
      sDataLength = encodedData.length - assignedDataLength;
    } else {
      final prop = netCapacity[i] / totalNetCapacity;
      sDataLength = (prop * encodedData.length).toInt();
    }
    int sPayloadLength = sDataLength + 1 + (i == 0 ? 4 : 3);
    for (int j = 0; j < 4; j++) {
      if (enc.symbols[i].slaves[j] > 0) {
        sPayloadLength += enc.symbols[enc.symbols[i].slaves[j]].metadata!.length;
      }
    }

    if (sPayloadLength > netCapacity[i]) {
      return false; // "Message does not fit into the specified code."
    }

    int j = 0;
    while (netCapacity[i] - sPayloadLength >= 6 && j < 4) {
      if (enc.symbols[i].slaves[j] > 0) {
        final slaveSym = enc.symbols[enc.symbols[i].slaves[j]];
        if (slaveSym.metadata!.data[1] == 0) {
          if (!_addE2SlaveMetadata(slaveSym)) return false;
          sPayloadLength += 6;
        }
      }
      j++;
    }

    final int pnLength;
    if (i == 0) {
      pnLength = _isDefaultMode(enc)
          ? netCapacity[i]
          : _applyOptimalEcc(enc.symbols[i], capacity[i], sPayloadLength);
    } else if (enc.symbols[i].metadata!.data[1] == 1) {
      pnLength = _applyOptimalEcc(enc.symbols[i], capacity[i], sPayloadLength);
      _updateSlaveMetadataE(enc, enc.symbols[i].host, i);
    } else {
      pnLength = netCapacity[i];
    }

    final payload = Uint8List(pnLength);
    payload.setRange(0, sDataLength, encodedData.data, assignedDataLength);
    assignedDataLength += sDataLength;

    int setPos = sPayloadLength - 1;
    payload[setPos--] = 1; // flag bit

    for (int k = 0; k < 4; k++) {
      if (enc.symbols[i].slaves[k] > 0) {
        payload[setPos--] = 1;
      } else if (enc.symbols[i].slaves[k] == 0) {
        payload[setPos--] = 0;
      }
    }
    for (int k = 0; k < 4; k++) {
      if (enc.symbols[i].slaves[k] > 0) {
        final slaveMeta = enc.symbols[enc.symbols[i].slaves[k]].metadata!;
        for (int m = 0; m < slaveMeta.length; m++) {
          payload[setPos--] = slaveMeta.data[m];
        }
      }
    }

    enc.symbols[i].data = _JabData(pnLength, payload);
  }
  return true;
}

bool _initSymbols(_JabEncode enc) {
  if (enc.symbolNumber > 1) {
    for (int i = 0; i < enc.symbolNumber; i++) {
      if (enc.symbolVersions[i].x < 1 ||
          enc.symbolVersions[i].x > 32 ||
          enc.symbolVersions[i].y < 1 ||
          enc.symbolVersions[i].y > 32) {
        return false;
      }
      if (enc.symbolPositions[i] < 0 || enc.symbolPositions[i] > _maxSymbolNumber) {
        return false;
      }
    }
  }

  if (enc.symbolNumber > 1 && enc.symbolPositions[0] != 0) {
    for (int i = 0; i < enc.symbolNumber; i++) {
      if (enc.symbolPositions[i] == 0) {
        final tmpPos = enc.symbolPositions[i];
        enc.symbolPositions[i] = enc.symbolPositions[0];
        enc.symbolPositions[0] = tmpPos;
        final tmpVx = enc.symbolVersions[i].x;
        enc.symbolVersions[i].x = enc.symbolVersions[0].x;
        enc.symbolVersions[0].x = tmpVx;
        final tmpVy = enc.symbolVersions[i].y;
        enc.symbolVersions[i].y = enc.symbolVersions[0].y;
        enc.symbolVersions[0].y = tmpVy;
        final tmpEcc = enc.symbolEccLevels[i];
        enc.symbolEccLevels[i] = enc.symbolEccLevels[0];
        enc.symbolEccLevels[0] = tmpEcc;
        break;
      }
    }
  }

  if (enc.symbolNumber > 1 && enc.symbolPositions[0] != 0) {
    return false; // "Master symbol missing"
  }
  if (enc.symbolNumber == 1 && enc.symbolPositions[0] != 0) {
    enc.symbolPositions[0] = 0;
  }

  for (int i = 0; i < enc.symbolNumber - 1; i++) {
    for (int j = i + 1; j < enc.symbolNumber; j++) {
      if (enc.symbolPositions[i] == enc.symbolPositions[j]) {
        return false; // "Duplicate symbol position"
      }
    }
  }

  if (!_assignDockedSymbols(enc)) return false;
  if (!_checkDockedSymbolSize(enc)) return false;

  for (int i = 0; i < enc.symbolNumber; i++) {
    enc.symbols[i].index = i;
    enc.symbols[i].sideSize.x = _version2size(enc.symbolVersions[i].x);
    enc.symbols[i].sideSize.y = _version2size(enc.symbolVersions[i].y);
  }
  return true;
}

bool _setSlaveMetadata(_JabEncode enc) {
  for (int i = 1; i < enc.symbolNumber; i++) {
    int ss, se, v = 0, e1 = 0, e2 = 0;
    int metadataLength = 2;

    if (enc.symbolVersions[i].x != enc.symbolVersions[enc.symbols[i].host].x) {
      ss = 1;
      v = enc.symbolVersions[i].x - 1;
      metadataLength += 5;
    } else if (enc.symbolVersions[i].y != enc.symbolVersions[enc.symbols[i].host].y) {
      ss = 1;
      v = enc.symbolVersions[i].y - 1;
      metadataLength += 5;
    } else {
      ss = 0;
    }

    if (enc.symbolEccLevels[i] == 0 ||
        enc.symbolEccLevels[i] == enc.symbolEccLevels[enc.symbols[i].host]) {
      se = 0;
    } else {
      se = 1;
      e1 = _ecclevel2wcwr[enc.symbolEccLevels[i]][0] - 3;
      e2 = _ecclevel2wcwr[enc.symbolEccLevels[i]][1] - 4;
      metadataLength += 6;
    }

    final metadata = Uint8List(metadataLength);
    metadata[0] = ss;
    metadata[1] = se;
    if (ss == 1) {
      _convertDecToBin(v, metadata, 2, 5);
    }
    if (se == 1) {
      final startPos = (ss == 1) ? 7 : 2;
      _convertDecToBin(e1, metadata, startPos, 3);
      _convertDecToBin(e2, metadata, startPos + 3, 3);
    }
    enc.symbols[i].metadata = _JabData(metadataLength, metadata);
  }
  return true;
}

_EncodeResult generateJABCode(_JabEncode enc, _JabData data) {
  if (data.length == 0) {
    return _EncodeResult.NoInputData; // "No input data specified!"
  }

  if (!_initSymbols(enc)) return _EncodeResult.InvalidSymbolVersion;

  final analysis = _analyzeInputData(data);
  if (analysis == null) {
    return _EncodeResult.Failure; // "Analyzing input data failed"
  }
  final encodedData = _encodeData(data, analysis.Length, analysis.Sequence);
  if (encodedData == null) {
    return _EncodeResult.Failure;
  }

  if (enc.symbolNumber == 1 && (enc.symbolVersions[0].x == 0 || enc.symbolVersions[0].y == 0)) {
    if (!_setMasterSymbolVersion(enc, encodedData)) {
      return _EncodeResult.InputDataToLong;
    }
  }

  if (!_setSlaveMetadata(enc)) {
    return _EncodeResult.Failure;
  }

  if (!_fitDataIntoSymbols(enc, encodedData)) {
    return _EncodeResult.InputDataToLong;
  }

  if (!_isDefaultMode(enc) && !_encodeMasterMetadata(enc)) {
      return _EncodeResult.Failure;
  }

  for (int i = 0; i < enc.symbolNumber; i++) {
    final eccEncodedData = _encodeLDPC(enc.symbols[i].data!, enc.symbols[i].wcwr);
    _interleaveData(eccEncodedData);
    _createMatrix(enc, i, eccEncodedData);
  }

  final cp = _getCodePara(enc);
  if (_isDefaultMode(enc)) {
    _maskSymbols(enc, _defaultMaskingReference);
  } else {
    final maskReference = _maskCode(enc, cp);
    if (maskReference != _defaultMaskingReference) {
      _updateMasterMetadataPartII(enc, maskReference);
      _placeMasterMetadataPartII(enc);
    }
  }

  _createBitmap(enc, cp);
  return _EncodeResult.Success;
}