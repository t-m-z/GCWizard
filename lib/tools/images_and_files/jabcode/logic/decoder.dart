part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

double _dist(double x1, double y1, double x2, double y2) => sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));

void _copyAndInterpolateSubblockFrom16To32(Uint8List palette, int dstOffset, int srcOffset) {
  palette.setRange(dstOffset + 84, dstOffset + 84 + 12, palette, srcOffset + 36);
  palette.setRange(dstOffset + 60, dstOffset + 60 + 12, palette, srcOffset + 24);
  palette.setRange(dstOffset + 24, dstOffset + 24 + 12, palette, srcOffset + 12);
  palette.setRange(dstOffset + 0, dstOffset + 0 + 12, palette, srcOffset + 0);

  for (int j = 0; j < 12; j++) {
    final sum = palette[dstOffset + 0 + j] + palette[dstOffset + 24 + j];
    palette[dstOffset + 12 + j] = sum ~/ 2;
  }
  for (int j = 0; j < 12; j++) {
    int sum = palette[dstOffset + 24 + j] * 2 + palette[dstOffset + 60 + j];
    palette[dstOffset + 36 + j] = sum ~/ 3;
    sum = palette[dstOffset + j] + palette[dstOffset + 60 + j] * 2;
    palette[dstOffset + 48 + j] = sum ~/ 3;
  }
  for (int j = 0; j < 12; j++) {
    final sum = palette[dstOffset + 60 + j] + palette[dstOffset + 84 + j];
    palette[dstOffset + 72 + j] = sum ~/ 2;
  }
}

void _interpolatePalette(Uint8List palette, int colorNumber) {
  for (int i = 0; i < _colorPaletteNumber; i++) {
    final offset = colorNumber * 3 * i;
    if (colorNumber == 128) {
      palette.setRange(offset + 336, offset + 336 + 48, palette, offset + 144);
      palette.setRange(offset + 240, offset + 240 + 48, palette, offset + 96);
      palette.setRange(offset + 96, offset + 96 + 48, palette, offset + 48);

      for (int j = 0; j < 48; j++) {
        final sum = palette[offset + 0 + j] + palette[offset + 96 + j];
        palette[offset + 48 + j] = sum ~/ 2;
      }
      for (int j = 0; j < 48; j++) {
        int sum = palette[offset + 96 + j] * 2 + palette[offset + 240 + j];
        palette[offset + 144 + j] = sum ~/ 3;
        sum = palette[offset + 96 + j] + palette[offset + 240 + j] * 2;
        palette[offset + 192 + j] = sum ~/ 3;
      }
      for (int j = 0; j < 48; j++) {
        final sum = palette[offset + 240 + j] + palette[offset + 336 + j];
        palette[offset + 288 + j] = sum ~/ 2;
      }
    } else if (colorNumber == 256) {
      _copyAndInterpolateSubblockFrom16To32(palette, offset + 672, offset + 144);
      _copyAndInterpolateSubblockFrom16To32(palette, offset + 480, offset + 96);
      _copyAndInterpolateSubblockFrom16To32(palette, offset + 192, offset + 48);
      _copyAndInterpolateSubblockFrom16To32(palette, offset + 0, offset + 0);

      for (int j = 0; j < 96; j++) {
        final sum = palette[offset + 0 + j] + palette[offset + 192 + j];
        palette[offset + 96 + j] = sum ~/ 2;
      }
      for (int j = 0; j < 96; j++) {
        int sum = palette[offset + 192 + j] * 2 + palette[offset + 480 + j];
        palette[offset + 288 + j] = sum ~/ 3;
        sum = palette[offset + 192 + j] + palette[offset + 480 + j] * 2;
        palette[offset + 384 + j] = sum ~/ 3;
      }
      for (int j = 0; j < 96; j++) {
        final sum = palette[offset + 480 + j] + palette[offset + 672 + j];
        palette[offset + 576 + j] = sum ~/ 2;
      }
    } else {
      return;
    }
  }
}

void _writeColorPalette(_JabBitmap matrix, _JabDecodedSymbol symbol, int pIndex, int colorIndex, int x, int y) {
  final colorNumber = pow(2, symbol.metadata.nc + 1).toInt();
  final mtxBytesPerPixel = matrix.bitsPerPixel ~/ 8;
  final mtxBytesPerRow = matrix.width * mtxBytesPerPixel;

  final paletteOffset = colorNumber * 3 * pIndex;
  final mtxOffset = y * mtxBytesPerRow + x * mtxBytesPerPixel;
  symbol.palette![paletteOffset + colorIndex * 3 + 0] = matrix.pixel[mtxOffset + 0];
  symbol.palette![paletteOffset + colorIndex * 3 + 1] = matrix.pixel[mtxOffset + 1];
  symbol.palette![paletteOffset + colorIndex * 3 + 2] = matrix.pixel[mtxOffset + 2];
}

List<_JabVector2d> getColorPalettePosInFP(int pIndex, int matrixWidth, int matrixHeight) {
  late _JabVector2d p1, p2;
  switch (pIndex) {
    case 0:
      p1 = _JabVector2d(_distanceToBorder - 1, _distanceToBorder - 1);
      p2 = _JabVector2d(p1.x + 1, p1.y);
      break;
    case 1:
      p1 = _JabVector2d(matrixWidth - _distanceToBorder, _distanceToBorder - 1);
      p2 = _JabVector2d(p1.x - 1, p1.y);
      break;
    case 2:
      p1 = _JabVector2d(matrixWidth - _distanceToBorder, matrixHeight - _distanceToBorder);
      p2 = _JabVector2d(p1.x - 1, p1.y);
      break;
    case 3:
    default:
      p1 = _JabVector2d(_distanceToBorder - 1, matrixHeight - _distanceToBorder);
      p2 = _JabVector2d(p1.x + 1, p1.y);
      break;
  }
  return [p1, p2];
}

void _readColorPaletteInMaster(
    _JabBitmap matrix, _JabDecodedSymbol symbol, Uint8List dataMap, _MasterMetadataCursor cursor) {
  final colorNumber = pow(2, symbol.metadata.nc + 1).toInt();
  symbol.palette = Uint8List(colorNumber * 3 * _colorPaletteNumber);

  for (int i = 0; i < _colorPaletteNumber; i++) {
    final p = getColorPalettePosInFP(i, matrix.width, matrix.height);
    for (int k = 0; k < 2; k++) {
      _writeColorPalette(
          matrix, symbol, i, _masterPalettePlacementIndex[i][k] % colorNumber, p[k].x, p[k].y);
    }
  }

  for (int colorCounter = 2; colorCounter < min(colorNumber, 64); colorCounter++) {
    for (int i = 0; i < _colorPaletteNumber; i++) {
      _writeColorPalette(matrix, symbol, i, _masterPalettePlacementIndex[i][colorCounter] % colorNumber,
          cursor.x, cursor.y);
      dataMap[cursor.index] = 1;
      cursor.advance();
    }
  }

  if (colorNumber > 64) {
    _interpolatePalette(symbol.palette!, colorNumber);
  }
}

void _readColorPaletteInSlave(_JabBitmap matrix, _JabDecodedSymbol symbol, Uint8List dataMap) {
  final colorNumber = pow(2, symbol.metadata.nc + 1).toInt();
  symbol.palette = Uint8List(colorNumber * 3 * _colorPaletteNumber);

  for (int i = 0; i < _colorPaletteNumber; i++) {
    final p = getColorPalettePosInFP(i, matrix.width, matrix.height);
    for (int k = 0; k < 2; k++) {
      _writeColorPalette(matrix, symbol, i, _slavePalettePlacementIndex[k] % colorNumber, p[k].x, p[k].y);
    }
  }

  for (int colorCounter = 2; colorCounter < min(colorNumber, 64); colorCounter++) {
    final pos = _slavePalettePosition[colorCounter - 2];
    final colorIndex = _slavePalettePlacementIndex[colorCounter] % colorNumber;
    // Die vier Paletten gehen durch 90°-Drehungen auseinander hervor.
    final positions = [
      (pos.x, pos.y),
      (matrix.width - 1 - pos.y, pos.x),
      (matrix.width - 1 - pos.x, matrix.height - 1 - pos.y),
      (pos.y, matrix.height - 1 - pos.x),
    ];
    for (int i = 0; i < _colorPaletteNumber; i++) {
      final (px, py) = positions[i];
      _writeColorPalette(matrix, symbol, i, colorIndex, px, py);
      dataMap[py * matrix.width + px] = 1;
    }
  }

  if (colorNumber > 64) {
    _interpolatePalette(symbol.palette!, colorNumber);
  }
}

int _getNearestPalette(_JabBitmap matrix, int x, int y) {
  final px = List<int>.filled(_colorPaletteNumber, 0);
  final py = List<int>.filled(_colorPaletteNumber, 0);
  px[0] = _distanceToBorder - 1 + 3;
  py[0] = _distanceToBorder - 1;
  px[1] = matrix.width - _distanceToBorder - 3;
  py[1] = _distanceToBorder - 1;
  px[2] = matrix.width - _distanceToBorder - 3;
  py[2] = matrix.height - _distanceToBorder;
  px[3] = _distanceToBorder - 1 + 3;
  py[3] = matrix.height - _distanceToBorder;

  double min = _dist(0, 0, matrix.width.toDouble(), matrix.height.toDouble());
  int pIndex = 0;
  for (int i = 0; i < _colorPaletteNumber; i++) {
    final dist = _dist(x.toDouble(), y.toDouble(), px[i].toDouble(), py[i].toDouble());
    if (dist < min) {
      min = dist;
      pIndex = i;
    }
  }
  return pIndex;
}

int _decodeModuleHD(_JabBitmap matrix, Uint8List? palette, int colorNumber,
    Float64List? normPalette, List<double> palThs, int x, int y) {
  final pIndex = _getNearestPalette(matrix, x, y);

  final mtxBytesPerPixel = matrix.bitsPerPixel ~/ 8;
  final mtxBytesPerRow = matrix.width * mtxBytesPerPixel;
  final mtxOffset = y * mtxBytesPerRow + x * mtxBytesPerPixel;
  final rgb = [
    matrix.pixel[mtxOffset + 0],
    matrix.pixel[mtxOffset + 1],
    matrix.pixel[mtxOffset + 2],
  ];

  int index1 = 0;

  if (rgb[0] < palThs[pIndex * 3 + 0] &&
      rgb[1] < palThs[pIndex * 3 + 1] &&
      rgb[2] < palThs[pIndex * 3 + 2]) {
    return 0;
  }

  if (palette != null) {
    final rgbMax = max(rgb[0], max(rgb[1], rgb[2])).toDouble();
    final r = rgb[0] / rgbMax;
    final g = rgb[1] / rgbMax;
    final b = rgb[2] / rgbMax;

    double min1 = 255 * 255 * 3, min2 = 255 * 255 * 3;
    for (int i = 0; i < colorNumber; i++) {
      final pr = normPalette![colorNumber * 4 * pIndex + i * 4 + 0];
      final pg = normPalette[colorNumber * 4 * pIndex + i * 4 + 1];
      final pb = normPalette[colorNumber * 4 * pIndex + i * 4 + 2];

      final diff = (pr - r) * (pr - r) + (pg - g) * (pg - g) + (pb - b) * (pb - b);

      if (diff < min1) {
        min2 = min1;
        min1 = diff;
        index1 = i;
      } else if (diff < min2) {
        min2 = diff;
      }
    }

    if (index1 == 0 || index1 == 7) {
      final rgbSum = rgb[0] + rgb[1] + rgb[2];
      final p0Sum = palette[colorNumber * 3 * pIndex + 0 * 3 + 0] +
          palette[colorNumber * 3 * pIndex + 0 * 3 + 1] +
          palette[colorNumber * 3 * pIndex + 0 * 3 + 2];
      final p7Sum = palette[colorNumber * 3 * pIndex + 7 * 3 + 0] +
          palette[colorNumber * 3 * pIndex + 7 * 3 + 1] +
          palette[colorNumber * 3 * pIndex + 7 * 3 + 2];

      index1 = rgbSum < ((p0Sum + p7Sum) / 2) ? 0 : 7;
    }
  } else {
    index1 = ((rgb[0] > 100 ? 1 : 0) + (rgb[1] > 100 ? 1 : 0) + (rgb[2] > 100 ? 1 : 0)) > 1
        ? 1
        : 0;
  }
  return index1;
}

int _decodeModuleNc(List<int> rgb) {
  const thsBlack = 80;
  const thsStd = 0.08;
  if (rgb[0] < thsBlack && rgb[1] < thsBlack && rgb[2] < thsBlack) {
    return 0;
  }
  final aveVar = _getAveVar(rgb);
  final minMidMax = _getMinMax(rgb);
  final indexMin = minMidMax.IndexMin, indexMid = minMidMax.IndexMiddle, indexMax = minMidMax.IndexMax;
  final std = sqrt(aveVar.Var) / minMidMax.Max;

  final bits = List<int>.filled(3, 0);
  if (std > thsStd) {
    bits[indexMax] = 1;
    bits[indexMin] = 0;
    final r1 = rgb[indexMid] / rgb[indexMin];
    final r2 = rgb[indexMax] / rgb[indexMid];
    bits[indexMid] = r1 > r2 ? 1 : 0;
  } else {
    return 7;
  }
  return (bits[0] << 2) + (bits[1] << 1) + bits[2];
}

List<double> _getPaletteThreshold(Uint8List palette, int paletteOffset, int colorNumber) {
  final ths = [0.0, 0.0, 0.0];
  int p(int i) => palette[paletteOffset + i];
  if (colorNumber == 4) {
    final cpr0 = max(p(0), p(3));
    final cpr1 = min(p(6), p(9));
    final cpg0 = max(p(1), p(7));
    final cpg1 = min(p(4), p(10));
    final cpb0 = max(p(8), p(11));
    final cpb1 = min(p(2), p(5));
    ths[0] = (cpr0 + cpr1) / 2.0;
    ths[1] = (cpg0 + cpg1) / 2.0;
    ths[2] = (cpb0 + cpb1) / 2.0;
  } else if (colorNumber == 8) {
    final cpr0 = max(max(max(p(0), p(3)), p(6)), p(9));
    final cpr1 = min(min(min(p(12), p(15)), p(18)), p(21));
    final cpg0 = max(max(max(p(1), p(4)), p(13)), p(16));
    final cpg1 = min(min(min(p(7), p(10)), p(19)), p(22));
    final cpb0 = max(max(max(p(2), p(8)), p(14)), p(20));
    final cpb1 = min(min(min(p(5), p(11)), p(17)), p(23));
    ths[0] = (cpr0 + cpr1) / 2.0;
    ths[1] = (cpg0 + cpg1) / 2.0;
    ths[2] = (cpb0 + cpb1) / 2.0;
  }
  return ths;
}

({bool Success, int ReadBitLength}) _decodeSlaveMetadata(
    _JabDecodedSymbol hostSymbol, int dockedPosition, Uint8List data, int offset) {
  hostSymbol.slaveMetadata[dockedPosition].nc = hostSymbol.metadata.nc;
  hostSymbol.slaveMetadata[dockedPosition].maskType = hostSymbol.metadata.maskType;
  hostSymbol.slaveMetadata[dockedPosition].dockedPosition = 0;

  int index = offset;
  int ss, se;

  if (index < 0) return (Success: false, ReadBitLength: 0);
  ss = data[index--];
  if (ss == 0) {
    hostSymbol.slaveMetadata[dockedPosition].sideVersion =
        _JabVector2d(hostSymbol.metadata.sideVersion.x, hostSymbol.metadata.sideVersion.y);
  }
  if (index < 0) return (Success: false, ReadBitLength: 0);
  se = data[index--];
  if (se == 0) {
    hostSymbol.slaveMetadata[dockedPosition].ecl = _JabVector2d(hostSymbol.metadata.ecl.x, hostSymbol.metadata.ecl.y);
  }

  if (ss == 1) {
    if ((index - 4) < 0) return (Success: false, ReadBitLength: 0);
    int v = 0;
    for (int i = 0; i < 5; i++) {
      v += data[index--] << (4 - i);
    }
    final sideVersion = v + 1;
    if (dockedPosition == 2 || dockedPosition == 3) {
      hostSymbol.slaveMetadata[dockedPosition].sideVersion = _JabVector2d(sideVersion, hostSymbol.metadata.sideVersion.y);
    } else {
      hostSymbol.slaveMetadata[dockedPosition].sideVersion = _JabVector2d(hostSymbol.metadata.sideVersion.x, sideVersion);
    }
  }
  if (se == 1) {
    if ((index - 5) < 0) return (Success: false, ReadBitLength: 0);
    int e = 0;
    for (int i = 0; i < 3; i++) {
      e += data[index--] << (2 - i);
    }
    final wc = e + 3;
    e = 0;
    for (int i = 0; i < 3; i++) {
      e += data[index--] << (2 - i);
    }
    final wr = e + 4;
    hostSymbol.slaveMetadata[dockedPosition].ecl = _JabVector2d(wc, wr);

    if (wc >= wr) {
      return (Success: false, ReadBitLength: 0); // "Incorrect error correction parameter in slave metadata"
    }
  }
  return (Success: offset - index > 0, ReadBitLength: offset - index);
}

int _decodeNcModuleColor(int module1Color, int module2Color) {
  for (int i = 0; i < 8; i++) {
    if (module1Color == _ncColorEncodeTable[i][0] && module2Color == _ncColorEncodeTable[i][1]) {
      return i;
    }
  }
  return 8;
}

_Status _decodeMasterMetadataPartI(
    _JabBitmap matrix, _JabDecodedSymbol symbol, Uint8List dataMap, _MasterMetadataCursor cursor) {
  final moduleColor = List<int>.filled(_masterMetadataPart1ModuleNumber, 0);
  final mtxBytesPerPixel = matrix.bitsPerPixel ~/ 8;
  final mtxBytesPerRow = matrix.width * mtxBytesPerPixel;

  while (cursor.moduleCount < _masterMetadataPart1ModuleNumber) {
    final mtxOffset = cursor.y * mtxBytesPerRow + cursor.x * mtxBytesPerPixel;
    final rgb = _decodeModuleNc([
      matrix.pixel[mtxOffset + 0],
      matrix.pixel[mtxOffset + 1],
      matrix.pixel[mtxOffset + 2],
    ]);
    if (rgb != 0 && rgb != 3 && rgb != 6) {
      return _Status.DecodeMetadataFailed;
    }
    moduleColor[cursor.moduleCount] = rgb;
    dataMap[cursor.index] = 1;
    cursor.advance();
  }

  final bits = [
    _decodeNcModuleColor(moduleColor[0], moduleColor[1]),
    _decodeNcModuleColor(moduleColor[2], moduleColor[3]),
  ];
  if (bits[0] > 7 || bits[1] > 7) {
    return _Status.DecodeMetadataFailed;
  }

  final rawPart1 = Uint8List(_masterMetadataPart1Length);
  int bitCount = 0;
  for (int n = 0; n < 2; n++) {
    for (int i = 0; i < 3; i++) {
      final bit = (bits[n] >> (2 - i)) & 0x01;
      rawPart1[bitCount] = bit;
      bitCount++;
    }
  }

  final part1 = _decodeLDPChd(rawPart1, _masterMetadataPart1Length, _masterMetadataPart1Length > 36 ? 4 : 3, 0);
  if (part1 == null) {
    return _Status.Failure;
  }
  symbol.metadata.nc = (part1[0] << 2) + (part1[1] << 1) + part1[2];

  return _Status.Success;
}

_Status _decodeMasterMetadataPartII(
    _JabBitmap matrix,
    _JabDecodedSymbol symbol,
    Uint8List dataMap,
    Float64List normPalette,
    List<double> palThs,
    _MasterMetadataCursor cursor) {
  final rawPart2 = Uint8List(_masterMetadataPart2Length);
  int part2BitCount = 0;
  const vLength = 10, eLength = 6;

  final colorNumber = pow(2, symbol.metadata.nc + 1).toInt();
  final bitsPerModule = (log(colorNumber) / log(2)).toInt();

  while (part2BitCount < _masterMetadataPart2Length) {
    final bits =
        _decodeModuleHD(matrix, symbol.palette, colorNumber, normPalette, palThs, cursor.x, cursor.y);
    for (int i = 0; i < bitsPerModule; i++) {
      final bit = (bits >> (bitsPerModule - 1 - i)) & 0x01;
      if (part2BitCount < _masterMetadataPart2Length) {
        rawPart2[part2BitCount] = bit;
        part2BitCount++;
      } else {
        break;
      }
    }
    dataMap[cursor.index] = 1;
    cursor.advance();
  }

  final part2 = _decodeLDPChd(rawPart2, _masterMetadataPart2Length, _masterMetadataPart2Length > 36 ? 4 : 3, 0);
  if (part2 == null) {
    return _Status.DecodeMetadataFailed;
  }

  int v = 0;
  for (int i = 0; i < vLength ~/ 2; i++) {
    v += part2[i] << (vLength ~/ 2 - 1 - i);
  }
  final sideVersionX = v + 1;
  v = 0;
  for (int i = 0; i < vLength ~/ 2; i++) {
    v += part2[i + vLength ~/ 2] << (vLength ~/ 2 - 1 - i);
  }
  final sideVersionY = v + 1;
  symbol.metadata.sideVersion = _JabVector2d(sideVersionX, sideVersionY);

  int bitIndex = vLength;
  int e = 0;
  for (int i = bitIndex; i < (bitIndex + eLength ~/ 2); i++) {
    e += part2[i] << (eLength ~/ 2 - 1 - (i - bitIndex));
  }
  final wc = e + 3;
  e = 0;
  for (int i = bitIndex; i < (bitIndex + eLength ~/ 2); i++) {
    e += part2[i + eLength ~/ 2] << (eLength ~/ 2 - 1 - (i - bitIndex));
  }
  final wr = e + 4;
  symbol.metadata.ecl = _JabVector2d(wc, wr);

  bitIndex = vLength + eLength;
  symbol.metadata.maskType = (part2[bitIndex + 0] << 2) + (part2[bitIndex + 1] << 1) + part2[bitIndex + 2];
  symbol.metadata.dockedPosition = 0;

  symbol.sideSize = _JabVector2d(
      _version2size(symbol.metadata.sideVersion.x), _version2size(symbol.metadata.sideVersion.y));
  if (matrix.width != symbol.sideSize.x || matrix.height != symbol.sideSize.y) {
    return _Status.Failure; // "Primary symbol matrix size does not match the metadata"
  }
  if (wc >= wr) {
    return _Status.DecodeMetadataFailed; // "Incorrect error correction parameter in primary symbol metadata"
  }
  return _Status.Success;
}

_JabData _readRawModuleData(_JabBitmap matrix, _JabDecodedSymbol symbol, Uint8List dataMap,
    Float64List normPalette, List<double> palThs) {
  final colorNumber = pow(2, symbol.metadata.nc + 1).toInt();
  int moduleCount = 0;
  final data = Uint8List(matrix.width * matrix.height);

  for (int j = 0; j < matrix.width; j++) {
    for (int i = 0; i < matrix.height; i++) {
      if (dataMap[i * matrix.width + j] == 0) {
        final bits =
            _decodeModuleHD(matrix, symbol.palette, colorNumber, normPalette, palThs, j, i);
        data[moduleCount] = bits;
        moduleCount++;
      }
    }
  }
  return _JabData(moduleCount, data);
}

_JabData _rawModuleData2RawData(_JabData rawModuleData, int bitsPerModule) {
  final rawData = Uint8List(rawModuleData.length * bitsPerModule);
  for (int i = 0; i < rawModuleData.length; i++) {
    for (int j = 0; j < bitsPerModule; j++) {
      rawData[i * bitsPerModule + j] =
          (rawModuleData.data[i] >> (bitsPerModule - 1 - j)) & 0x01;
    }
  }
  return _JabData(rawModuleData.length * bitsPerModule, rawData);
}

void _fillDataMap(Uint8List dataMap, int width, int height, int type) {
  final sideVerXIndex = _size2version(width) - 1;
  final sideVerYIndex = _size2version(height) - 1;
  final numberOfApX = _jabApNum[sideVerXIndex];
  final numberOfApY = _jabApNum[sideVerYIndex];

  void setm(int y, int x) => dataMap[y * width + x] = 1;

  for (int i = 0; i < numberOfApY; i++) {
    for (int j = 0; j < numberOfApX; j++) {
      final xOffset = _jabApPos[sideVerXIndex][j] - 1;
      final yOffset = _jabApPos[sideVerYIndex][i] - 1;

      setm(yOffset, xOffset);
      setm(yOffset, xOffset - 1);
      setm(yOffset, xOffset + 1);
      setm(yOffset - 1, xOffset);
      setm(yOffset + 1, xOffset);

      if (i == 0 && (j == 0 || j == numberOfApX - 1)) {
        setm(yOffset - 1, xOffset - 1);
        setm(yOffset + 1, xOffset + 1);
        if (type == 0) {
          setm(yOffset - 2, xOffset - 2);
          setm(yOffset - 2, xOffset - 1);
          setm(yOffset - 2, xOffset);
          setm(yOffset - 1, xOffset - 2);
          setm(yOffset, xOffset - 2);

          setm(yOffset + 2, xOffset + 2);
          setm(yOffset + 2, xOffset + 1);
          setm(yOffset + 2, xOffset);
          setm(yOffset + 1, xOffset + 2);
          setm(yOffset, xOffset + 2);
        }
      } else if (i == numberOfApY - 1 && (j == 0 || j == numberOfApX - 1)) {
        setm(yOffset - 1, xOffset + 1);
        setm(yOffset + 1, xOffset - 1);
        if (type == 0) {
          setm(yOffset - 2, xOffset + 2);
          setm(yOffset - 2, xOffset + 1);
          setm(yOffset - 2, xOffset);
          setm(yOffset - 1, xOffset + 2);
          setm(yOffset, xOffset + 2);

          setm(yOffset + 2, xOffset - 2);
          setm(yOffset + 2, xOffset - 1);
          setm(yOffset + 2, xOffset);
          setm(yOffset + 1, xOffset - 2);
          setm(yOffset, xOffset - 2);
        }
      } else {
        if ((i % 2 == 0 && j % 2 == 0) || (i % 2 == 1 && j % 2 == 1)) {
          setm(yOffset - 1, xOffset - 1);
          setm(yOffset + 1, xOffset + 1);
        } else {
          setm(yOffset - 1, xOffset + 1);
          setm(yOffset + 1, xOffset - 1);
        }
      }
    }
  }
}

void _loadDefaultMasterMetadata(_JabBitmap matrix, _JabDecodedSymbol symbol) {
  symbol.metadata.defaultMode = true;
  symbol.metadata.nc = _defaultModuleColorMode;
  symbol.metadata.ecl = _JabVector2d(_ecclevel2wcwr[_defaultEccLevel][0], _ecclevel2wcwr[_defaultEccLevel][1]);
  symbol.metadata.maskType = _defaultMaskingReference;
  symbol.metadata.dockedPosition = 0;
  symbol.metadata.sideVersion = _JabVector2d(_size2version(matrix.width), _size2version(matrix.height));
}

Float64List _normalizeColorPalette(_JabDecodedSymbol symbol, int colorNumber) {
  final normPalette = Float64List(colorNumber * 4 * _colorPaletteNumber);
  for (int i = 0; i < colorNumber * _colorPaletteNumber; i++) {
    final rgbMax = max(symbol.palette![i * 3 + 0],
        max(symbol.palette![i * 3 + 1], symbol.palette![i * 3 + 2])).toDouble();
    normPalette[i * 4 + 0] = symbol.palette![i * 3 + 0] / rgbMax;
    normPalette[i * 4 + 1] = symbol.palette![i * 3 + 1] / rgbMax;
    normPalette[i * 4 + 2] = symbol.palette![i * 3 + 2] / rgbMax;
    normPalette[i * 4 + 3] =
        ((symbol.palette![i * 3 + 0] + symbol.palette![i * 3 + 1] + symbol.palette![i * 3 + 2]) / 3.0) / 255.0;
  }
  return normPalette;
}

_Status _decodeSymbol(_JabBitmap matrix, _JabDecodedSymbol symbol, Uint8List dataMap,
    Float64List normPalette, List<double> palThs, int type) {
  _fillDataMap(dataMap, matrix.width, matrix.height, type);

  final rawModuleData = _readRawModuleData(matrix, symbol, dataMap, normPalette, palThs);

  _demaskSymbol(rawModuleData, dataMap, symbol.sideSize, symbol.metadata.maskType,
      pow(2, symbol.metadata.nc + 1).toInt());

  final rawData = _rawModuleData2RawData(rawModuleData, symbol.metadata.nc + 1);

  final wc = symbol.metadata.ecl.x;
  final wr = symbol.metadata.ecl.y;
  final pg = (rawData.length ~/ wr) * wr;
  final pn = pg * (wr - wc) ~/ wr;

  rawData.length = pg;
  _deinterleaveData(rawData);

  final decoded = _decodeLDPChd(rawData.data, pg, wc, wr);
  if (decoded == null || decoded.length != pn) {
    return _Status.Failure; // "LDPC decoding for data in symbol failed"
  }

  int metadataOffset = pn - 1;
  while (decoded[metadataOffset] == 0) {
    metadataOffset--;
  }
  metadataOffset--;

  symbol.metadata.dockedPosition = 0;
  for (int i = 0; i < 4; i++) {
    if (type == 1) {
      if (i == symbol.hostPosition) continue;
    }
    symbol.metadata.dockedPosition += decoded[metadataOffset--] << (3 - i);
  }

  for (int i = 0; i < 4; i++) {
    if (symbol.metadata.dockedPosition & (0x08 >> i) != 0) {
      final r = _decodeSlaveMetadata(symbol, i, decoded, metadataOffset);
      if (!r.Success) {
        return _Status.DecodeMetadataFailed;
      }
      metadataOffset -= r.ReadBitLength;
    }
  }

  final netDataLength = metadataOffset + 1;
  symbol.data = _JabData(netDataLength, Uint8List.sublistView(decoded, 0, netDataLength));

  return _Status.Success;
}

_Status _decodeMaster(_JabBitmap matrix, _JabDecodedSymbol symbol) {
  final dataMap = Uint8List(matrix.width * matrix.height);

  final cursor = _MasterMetadataCursor(matrix.width, matrix.height);

  final decodePartIRet = _decodeMasterMetadataPartI(matrix, symbol, dataMap, cursor);
  bool defaultLoaded = false;
  if (decodePartIRet == _Status.Failure) {
    return _Status.Failure;
  }
  if (decodePartIRet == _Status.DecodeMetadataFailed) {
    cursor.reset();
    dataMap.fillRange(0, dataMap.length, 0);
    _loadDefaultMasterMetadata(matrix, symbol);
    defaultLoaded = true;
  }

  _readColorPaletteInMaster(matrix, symbol, dataMap, cursor);

  final colorNumber = pow(2, symbol.metadata.nc + 1).toInt();
  final normPalette = _normalizeColorPalette(symbol, colorNumber);

  final palThs = List<double>.filled(3 * _colorPaletteNumber, 0);
  for (int i = 0; i < _colorPaletteNumber; i++) {
    final t = _getPaletteThreshold(symbol.palette!, (colorNumber * 3) * i, colorNumber);
    palThs[i * 3 + 0] = t[0];
    palThs[i * 3 + 1] = t[1];
    palThs[i * 3 + 2] = t[2];
  }

  if (!defaultLoaded) {
    if (_decodeMasterMetadataPartII(matrix, symbol, dataMap, normPalette, palThs, cursor) != _Status.Success) {
      return _Status.Failure;
    }
  }

  return _decodeSymbol(matrix, symbol, dataMap, normPalette, palThs, 0);
}

_Status _decodeSlave(_JabBitmap matrix, _JabDecodedSymbol symbol) {
  final dataMap = Uint8List(matrix.width * matrix.height);

  _readColorPaletteInSlave(matrix, symbol, dataMap);

  final colorNumber = pow(2, symbol.metadata.nc + 1).toInt();
  final normPalette = _normalizeColorPalette(symbol, colorNumber);

  final palThs = List<double>.filled(3 * _colorPaletteNumber, 0);
  for (int i = 0; i < _colorPaletteNumber; i++) {
    final t = _getPaletteThreshold(symbol.palette!, i * 3, colorNumber);
    palThs[i * 3 + 0] = t[0];
    palThs[i * 3 + 1] = t[1];
    palThs[i * 3 + 2] = t[2];
  }

  return _decodeSymbol(matrix, symbol, dataMap, normPalette, palThs, 1);
}

({int Length, int Value}) _readData(_JabData data, int start, int length) {
  int i;
  int val = 0;
  for (i = start; i < (start + length) && i < data.length; i++) {
    val += data.data[i] << (length - 1 - (i - start));
  }
  return (Length: i - start, Value: val);
}

_JabData? _decodeData(_JabData bits) {
  final decodedBytes = Uint8List(bits.length);

  int mode = _JabEncodeMode.upper;
  int preMode = _JabEncodeMode.none;
  int index = 0;
  int count = 0;

  while (index < bits.length) {
    bool flag = false;
    int value = 0;
    int n;
    if (mode != _JabEncodeMode.byte) {
      final r = _readData(bits, index, _characterSize[mode]);
      n = r.Length;
      value = r.Value;
      if (n < _characterSize[mode]) break;
      index += _characterSize[mode];
    }

    switch (mode) {
      case _JabEncodeMode.upper:
        if (value <= 26) {
          decodedBytes[count++] = _jabDecodingTableUpper[value];
          if (preMode != _JabEncodeMode.none) mode = preMode;
        } else {
          switch (value) {
            case 27:
              mode = _JabEncodeMode.punct;
              preMode = _JabEncodeMode.upper;
              break;
            case 28:
              mode = _JabEncodeMode.lower;
              preMode = _JabEncodeMode.none;
              break;
            case 29:
              mode = _JabEncodeMode.numeric;
              preMode = _JabEncodeMode.none;
              break;
            case 30:
              mode = _JabEncodeMode.alphanumeric;
              preMode = _JabEncodeMode.none;
              break;
            case 31:
              final r = _readData(bits, index, 2);
              if (r.Length < 2) {
                flag = true;
                break;
              }
              index += 2;
              value = r.Value;
              switch (value) {
                case 0:
                  mode = _JabEncodeMode.byte;
                  preMode = _JabEncodeMode.upper;
                  break;
                case 1:
                  mode = _JabEncodeMode.mixed;
                  preMode = _JabEncodeMode.upper;
                  break;
                case 2:
                  mode = _JabEncodeMode.eci;
                  preMode = _JabEncodeMode.none;
                  break;
                case 3:
                  flag = true;
                  break;
              }
              break;
            default:
              return null; // "Invalid value decoded"
          }
        }
        break;

      case _JabEncodeMode.lower:
        if (value <= 26) {
          decodedBytes[count++] = _jabDecodingTableLower[value];
          if (preMode != _JabEncodeMode.none) mode = preMode;
        } else {
          switch (value) {
            case 27:
              mode = _JabEncodeMode.punct;
              preMode = _JabEncodeMode.lower;
              break;
            case 28:
              mode = _JabEncodeMode.upper;
              preMode = _JabEncodeMode.lower;
              break;
            case 29:
              mode = _JabEncodeMode.numeric;
              preMode = _JabEncodeMode.none;
              break;
            case 30:
              mode = _JabEncodeMode.alphanumeric;
              preMode = _JabEncodeMode.none;
              break;
            case 31:
              final r = _readData(bits, index, 2);
              if (r.Length < 2) {
                flag = true;
                break;
              }
              index += 2;
              value = r.Value;
              switch (value) {
                case 0:
                  mode = _JabEncodeMode.byte;
                  preMode = _JabEncodeMode.lower;
                  break;
                case 1:
                  mode = _JabEncodeMode.mixed;
                  preMode = _JabEncodeMode.lower;
                  break;
                case 2:
                  mode = _JabEncodeMode.upper;
                  preMode = _JabEncodeMode.none;
                  break;
                case 3:
                  mode = _JabEncodeMode.fnc1;
                  preMode = _JabEncodeMode.none;
                  break;
              }
              break;
            default:
              return null;
          }
        }
        break;

      case _JabEncodeMode.numeric:
        if (value <= 12) {
          decodedBytes[count++] = _jabDecodingTableNumeric[value];
          if (preMode != _JabEncodeMode.none) mode = preMode;
        } else {
          switch (value) {
            case 13:
              mode = _JabEncodeMode.punct;
              preMode = _JabEncodeMode.numeric;
              break;
            case 14:
              mode = _JabEncodeMode.upper;
              preMode = _JabEncodeMode.none;
              break;
            case 15:
              final r = _readData(bits, index, 2);
              if (r.Length < 2) {
                flag = true;
                break;
              }
              index += 2;
              value = r.Value;
              switch (value) {
                case 0:
                  mode = _JabEncodeMode.byte;
                  preMode = _JabEncodeMode.numeric;
                  break;
                case 1:
                  mode = _JabEncodeMode.mixed;
                  preMode = _JabEncodeMode.numeric;
                  break;
                case 2:
                  mode = _JabEncodeMode.upper;
                  preMode = _JabEncodeMode.numeric;
                  break;
                case 3:
                  mode = _JabEncodeMode.lower;
                  preMode = _JabEncodeMode.none;
                  break;
              }
              break;
            default:
              return null;
          }
        }
        break;

      case _JabEncodeMode.punct:
        if (value >= 0 && value <= 15) {
          decodedBytes[count++] = _jabDecodingTablePunct[value];
          mode = preMode;
        } else {
          return null;
        }
        break;

      case _JabEncodeMode.mixed:
        if (value >= 0 && value <= 31) {
          if (value == 19) {
            decodedBytes[count++] = 10;
            decodedBytes[count++] = 13;
          } else if (value == 20) {
            decodedBytes[count++] = 44;
            decodedBytes[count++] = 32;
          } else if (value == 21) {
            decodedBytes[count++] = 46;
            decodedBytes[count++] = 32;
          } else if (value == 22) {
            decodedBytes[count++] = 58;
            decodedBytes[count++] = 32;
          } else {
            decodedBytes[count++] = _jabDecodingTableMixed[value];
          }
          mode = preMode;
        } else {
          return null;
        }
        break;

      case _JabEncodeMode.alphanumeric:
        if (value <= 62) {
          decodedBytes[count++] = _jabDecodingTableAlphanumeric[value];
          if (preMode != _JabEncodeMode.none) mode = preMode;
        } else if (value == 63) {
          final r = _readData(bits, index, 2);
          if (r.Length < 2) {
            flag = true;
            break;
          }
          index += 2;
          value = r.Value;
          switch (value) {
            case 0:
              mode = _JabEncodeMode.byte;
              preMode = _JabEncodeMode.alphanumeric;
              break;
            case 1:
              mode = _JabEncodeMode.mixed;
              preMode = _JabEncodeMode.alphanumeric;
              break;
            case 2:
              mode = _JabEncodeMode.punct;
              preMode = _JabEncodeMode.alphanumeric;
              break;
            case 3:
              mode = _JabEncodeMode.upper;
              preMode = _JabEncodeMode.none;
              break;
          }
        } else {
          return null;
        }
        break;

      case _JabEncodeMode.byte:
        {
          var r = _readData(bits, index, 4);
          if (r.Length < 4) {
            return null; // "Not enough bits to decode"
          }
          index += 4;
          value = r.Value;
          if (value == 0) {
            r = _readData(bits, index, 13);
            if (r.Length < 13) {
              return null;
            }
            value = r.Value + 15 + 1;
            index += 13;
          }
          for (int i = 0; i < value; i++) {
            r = _readData(bits, index, 8);
            if (r.Length < 8) {
              return null;
            }
            index += 8;
            decodedBytes[count++] = r.Value;
          }
          mode = preMode;
          break;
        }

      case _JabEncodeMode.eci:
        index += bits.length;
        break;
      case _JabEncodeMode.fnc1:
        index += bits.length;
        break;
      case _JabEncodeMode.none:
      default:
        index += bits.length;
        break;
    }
    if (flag) break;
  }

  return _JabData(count, Uint8List.sublistView(decodedBytes, 0, count));
}
