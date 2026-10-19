part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

_JabBitmap _filterBinary(_JabBitmap binary) {
  final width = binary.width;
  final height = binary.height;
  const filterSize = 5;
  const halfSize = (filterSize - 1) ~/ 2;

  var tmp = Uint8List.fromList(binary.pixel);
  for (int i = halfSize; i < height - halfSize; i++) {
    for (int j = halfSize; j < width - halfSize; j++) {
      int sum = tmp[i * width + j] > 0 ? 1 : 0;
      for (int k = 1; k <= halfSize; k++) {
        sum += tmp[i * width + (j - k)] > 0 ? 1 : 0;
        sum += tmp[i * width + (j + k)] > 0 ? 1 : 0;
      }
      binary.pixel[i * width + j] = sum > halfSize ? 255 : 0;
    }
  }

  tmp = Uint8List.fromList(binary.pixel);
  for (int i = halfSize; i < height - halfSize; i++) {
    for (int j = halfSize; j < width - halfSize; j++) {
      int sum = tmp[i * width + j] > 0 ? 1 : 0;
      for (int k = 1; k <= halfSize; k++) {
        sum += tmp[(i - k) * width + j] > 0 ? 1 : 0;
        sum += tmp[(i + k) * width + j] > 0 ? 1 : 0;
      }
      binary.pixel[i * width + j] = sum > halfSize ? 255 : 0;
    }
  }
  return binary;
}

List<int> _getHistogram(_JabBitmap bitmap, int channel) {
  final hist = List<int>.filled(256, 0);
  final bytesPerPixel = bitmap.bitsPerPixel ~/ 8;
  for (int i = 0; i < bitmap.width * bitmap.height; i++) {
    hist[bitmap.pixel[i * bytesPerPixel + channel]]++;
  }
  return hist;
}

({int Max, int Min}) _getHistMaxMin(List<int> hist, int ths) {
  int min = 0;
  for (int i = 0; i < 256; i++) {
    if (hist[i] > ths) {
      min = i;
      break;
    }
  }
  int max = 255;
  for (int i = 255; i >= 0; i--) {
    if (hist[i] > ths) {
      max = i;
      break;
    }
  }

  return (Max: max, Min: min);
}

void _balanceRGB(_JabBitmap bitmap) {
  final bytesPerPixel = bitmap.bitsPerPixel ~/ 8;

  const countThs = 20;
  final ranges = List.generate(3, (channel) => _getHistMaxMin(_getHistogram(bitmap, channel), countThs));

  for (int offset = 0; offset < bitmap.width * bitmap.height * bytesPerPixel; offset += bytesPerPixel) {
    for (int channel = 0; channel < 3; channel++) {
      final value = bitmap.pixel[offset + channel];
      final range = ranges[channel];
      bitmap.pixel[offset + channel] = value < range.Min
          ? 0
          : value > range.Max
              ? 255
              : ((value - range.Min) / (range.Max - range.Min) * 255.0).toInt() & 0xFF;
    }
  }
}

({double Ave, double Var}) _getAveVar(List<int> rgb) {
  final ave = (rgb[0] + rgb[1] + rgb[2]) / 3;
  double sum = 0.0;
  for (int i = 0; i < 3; i++) {
    sum += (rgb[i] - ave) * (rgb[i] - ave);
  }
  return (Ave: ave, Var: sum / 3);
}

({int Min, int Middle, int Max, int IndexMin, int IndexMiddle, int IndexMax}) _getMinMax(List<int> rgb) {
  int indexMin = 0, indexMid = 1, indexMax = 2;
  if (rgb[indexMin] > rgb[indexMax]) {
    final t = indexMin;
    indexMin = indexMax;
    indexMax = t;
  }
  if (rgb[indexMin] > rgb[indexMid]) {
    final t = indexMin;
    indexMin = indexMid;
    indexMid = t;
  }
  if (rgb[indexMid] > rgb[indexMax]) {
    final t = indexMid;
    indexMid = indexMax;
    indexMax = t;
  }
  return (Min: rgb[indexMin], Middle: rgb[indexMid], Max:rgb[indexMax],
    IndexMin: indexMin, IndexMiddle: indexMid, IndexMax: indexMax);
}

List<List<double>> _calculateBlockAverages(
    _JabBitmap bitmap, int blockNumX, int blockNumY, int blockSizeX, int blockSizeY) {
  final bytesPerPixel = bitmap.bitsPerPixel ~/ 8;
  final bytesPerRow = bitmap.width * bytesPerPixel;
  final averages = List.generate(blockNumX * blockNumY, (_) => List<double>.filled(3, 0));

  for (int i = 0; i < blockNumY; i++) {
    for (int j = 0; j < blockNumX; j++) {
      final average = averages[i * blockNumX + j];
      final sx = j * blockSizeX;
      final ex = (j == blockNumX - 1) ? bitmap.width : (sx + blockSizeX);
      final sy = i * blockSizeY;
      final ey = (i == blockNumY - 1) ? bitmap.height : (sy + blockSizeY);
      for (int y = sy; y < ey; y++) {
        for (int x = sx; x < ex; x++) {
          for (int channel = 0; channel < 3; channel++) {
            average[channel] += bitmap.pixel[y * bytesPerRow + x * bytesPerPixel + channel];
          }
        }
      }
      final counter = (ey - sy) * (ex - sx);
      for (int channel = 0; channel < 3; channel++) {
        average[channel] /= counter;
      }
    }
  }
  return averages;
}

List<_JabBitmap> _binarizerRGB(_JabBitmap bitmap, List<double>? blkThs) {
  final rgb = List.generate(3, (_) => _JabBitmap.gray(bitmap.width, bitmap.height));

  final bytesPerPixel = bitmap.bitsPerPixel ~/ 8;
  final bytesPerRow = bitmap.width * bytesPerPixel;

  final maxBlockSize = max(bitmap.width, bitmap.height) ~/ 2;
  final blockNumX = _ceilDiv(bitmap.width, maxBlockSize);
  final blockNumY = _ceilDiv(bitmap.height, maxBlockSize);
  final blockSizeX = bitmap.width ~/ blockNumX;
  final blockSizeY = bitmap.height ~/ blockNumY;

  final pixelAve =
      blkThs == null ? _calculateBlockAverages(bitmap, blockNumX, blockNumY, blockSizeX, blockSizeY) : null;

  const thsStd = 0.08;
  for (int i = 0; i < bitmap.height; i++) {
    for (int j = 0; j < bitmap.width; j++) {
      final offset = i * bytesPerRow + j * bytesPerPixel;
      final rgbThs = blkThs ??
          pixelAve![min(i ~/ blockSizeY, blockNumY - 1) * blockNumX + min(j ~/ blockSizeX, blockNumX - 1)];

      final pix = [bitmap.pixel[offset], bitmap.pixel[offset + 1], bitmap.pixel[offset + 2]];
      final pixelIndex = i * bitmap.width + j;

      if (pix[0] < rgbThs[0] && pix[1] < rgbThs[1] && pix[2] < rgbThs[2]) {
        for (final channel in rgb) {
          channel.pixel[pixelIndex] = 0;
        }
        continue;
      }

      final minMidMax = _getMinMax(pix);
      final stdNorm = sqrt(_getAveVar(pix).Var) / minMidMax.Max;

      if (stdNorm < thsStd && pix[0] > rgbThs[0] && pix[1] > rgbThs[1] && pix[2] > rgbThs[2]) {
        for (final channel in rgb) {
          channel.pixel[pixelIndex] = 255;
        }
      } else {
        rgb[minMidMax.IndexMax].pixel[pixelIndex] = 255;
        rgb[minMidMax.IndexMin].pixel[pixelIndex] = 0;
        final r1 = pix[minMidMax.IndexMiddle] / pix[minMidMax.IndexMin];
        final r2 = pix[minMidMax.IndexMax] / pix[minMidMax.IndexMiddle];
        rgb[minMidMax.IndexMiddle].pixel[pixelIndex] = r1 > r2 ? 255 : 0;
      }
    }
  }

  return rgb.map(_filterBinary).toList();
}
