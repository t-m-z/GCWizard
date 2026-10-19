part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

int? _clampSamplePosition(int position, int size) {
  if (position >= 0 && position < size) return position;
  if (position == -1) return 0;
  if (position == size) return size - 1;
  return null;
}

_JabBitmap? _sampleSymbol(_JabBitmap bitmap, _JabPerspectiveTransform pt, _JabVector2d sideSize) {
  final matrix = _JabBitmap(
    width: sideSize.x,
    height: sideSize.y,
    channelCount: bitmap.channelCount,
    bitsPerChannel: bitmap.bitsPerChannel,
    bitsPerPixel: bitmap.bitsPerChannel * bitmap.channelCount,
  );

  final bytesPerPixel = bitmap.bitsPerPixel ~/ 8;
  final bitmapBytesPerRow = bitmap.width * bytesPerPixel;
  final matrixBytesPerRow = sideSize.x * bytesPerPixel;

  final points = List<_JabPoint>.generate(sideSize.x, (_) => _JabPoint(0, 0));
  for (int i = 0; i < sideSize.y; i++) {
    for (int j = 0; j < sideSize.x; j++) {
      points[j].x = j + 0.5;
      points[j].y = i + 0.5;
    }
    _warpPoints(pt, points);

    for (int j = 0; j < sideSize.x; j++) {
      final mappedX = _clampSamplePosition(points[j].x.toInt(), bitmap.width);
      final mappedY = _clampSamplePosition(points[j].y.toInt(), bitmap.height);
      if (mappedX == null || mappedY == null) return null;

      for (int c = 0; c < matrix.channelCount; c++) {
        int sum = 0;
        for (int dx = -1; dx <= 1; dx++) {
          for (int dy = -1; dy <= 1; dy++) {
            int px = mappedX + dx;
            int py = mappedY + dy;
            if (px < 0 || px > bitmap.width - 1) px = mappedX;
            if (py < 0 || py > bitmap.height - 1) py = mappedY;
            sum += bitmap.pixel[py * bitmapBytesPerRow + px * bytesPerPixel + c];
          }
        }
        matrix.pixel[i * matrixBytesPerRow + j * bytesPerPixel + c] = (sum / 9.0 + 0.5).toInt() & 0xFF;
      }
    }
  }
  return matrix;
}