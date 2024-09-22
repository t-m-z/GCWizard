import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';

part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_datatypes.dart';
part 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform_data.dart';

SoundfileData getSoundfileData(Uint8List bytes) {
  switch (getFileType(bytes)) {
    case FileType.WAV:
    case FileType.WMV:
      return WAVContent(bytes);
    default:
      return SoundfileData(
          structure: [],
          PCMformat: 0,
          bits: 0,
          channels: 0,
          sampleRate: 0,
          duration: 0.0,
          amplitudesData: Uint8List.fromList([]));
  }
}

Future<MorseData> PCMamplitudes2Image({
  required double duration,
  required List<double> RMSperPoint,
  required double maxAmplitude,
  required double minAmplitude,
}) async {
  const BOUNDS = 10.0;

  var vScaleFactor = 1.0;

  while (maxAmplitude * vScaleFactor < 260) {
    vScaleFactor = vScaleFactor + 1;
  }
  maxAmplitude = maxAmplitude * vScaleFactor;
  minAmplitude = minAmplitude * vScaleFactor;

  var width = BOUNDS + RMSperPoint.length + BOUNDS;
  var height = BOUNDS + maxAmplitude + BOUNDS;

  double analyseBar = maxAmplitude - (maxAmplitude - minAmplitude) / 2;

  final canvasRecorderPolygon = ui.PictureRecorder();
  final canvasPolygon = ui.Canvas(canvasRecorderPolygon, ui.Rect.fromLTWH(0, 0, width, height));

  final canvasRecorderRectangle = ui.PictureRecorder();
  final canvasRectangle = ui.Canvas(canvasRecorderRectangle, ui.Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Colors.black87
    ..style = PaintingStyle.fill;

  canvasPolygon.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
  canvasRectangle.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

  paint.color = Colors.black;
  canvasPolygon.drawRect(Rect.fromLTWH(BOUNDS, BOUNDS, RMSperPoint.length.toDouble(), maxAmplitude), paint);
  canvasRectangle.drawRect(Rect.fromLTWH(BOUNDS, BOUNDS, RMSperPoint.length.toDouble(), maxAmplitude), paint);

  paint.strokeWidth = 2.0;
  paint.style = PaintingStyle.stroke;
  // paint.color = Colors.white;
  // canvasPolygon.drawLine(
  //     Offset(BOUNDS, _transform(height, BOUNDS, 0)),
  //     Offset(width - BOUNDS, _transform(height, BOUNDS, 0)), paint);
  // canvasRectangle.drawLine(
  //     Offset(BOUNDS, _transform(height, BOUNDS, 0)),
  //     Offset(width, _transform(height, BOUNDS, 0)), paint);
  // paint.color = Colors.green;
  // canvasPolygon.drawLine(
  //     Offset(BOUNDS, _transform(height, BOUNDS, minAmplitude)),
  //     Offset(width - BOUNDS, _transform(height, BOUNDS, minAmplitude)), paint);
  // canvasRectangle.drawLine(
  //     Offset(BOUNDS, _transform(height, BOUNDS, minAmplitude)),
  //     Offset(width - BOUNDS, _transform(height, BOUNDS, minAmplitude)), paint);
  // paint.color = Colors.red;
  // canvasPolygon.drawLine(
  //     Offset(BOUNDS, _transform(height, BOUNDS, maxAmplitude)),
  //     Offset(width - BOUNDS, _transform(height, BOUNDS, maxAmplitude)), paint);
  // canvasRectangle.drawLine(
  //     Offset(BOUNDS, _transform(height, BOUNDS, maxAmplitude)),
  //     Offset(width - BOUNDS, _transform(height, BOUNDS, maxAmplitude)), paint);

  paint.color = Colors.orangeAccent;

  final path = Path();

  path.moveTo(BOUNDS, _transform(height, BOUNDS, 0));
  for (var i = 0; i < RMSperPoint.length; i++) {
    RMSperPoint[i] = RMSperPoint[i] * vScaleFactor;
    path.lineTo(BOUNDS + i, _transform(height, BOUNDS, RMSperPoint[i]));
  }
  path.lineTo(BOUNDS + RMSperPoint.length, _transform(height, BOUNDS, 0));

  canvasPolygon.drawPath(path, paint);

  paint.style = PaintingStyle.fill;
  canvasRectangle.drawPath(path, paint);

  // paint.color = Colors.blue;
  // paint.strokeWidth = 1.0;
  // canvasPolygon.drawLine(
  //     Offset(BOUNDS, _transform(height, BOUNDS, analyseBar - 2)),
  //     Offset(width - BOUNDS, _transform(height, BOUNDS, analyseBar - 2)), paint);
  // canvasPolygon.drawLine(
  //     Offset(BOUNDS, _transform(height, BOUNDS, analyseBar + 2)),
  //     Offset(width - BOUNDS, _transform(height, BOUNDS, analyseBar + 2)), paint);
  // canvasRectangle.drawLine(
  //     Offset(BOUNDS, _transform(height, BOUNDS, analyseBar - 2)),
  //     Offset(width - BOUNDS, _transform(height, BOUNDS, analyseBar - 2)), paint);
  // canvasRectangle.drawLine(
  //     Offset(BOUNDS, _transform(height, BOUNDS, analyseBar + 2)),
  //     Offset(width - BOUNDS, _transform(height, BOUNDS, analyseBar + 2)), paint);

  final imgPolygon = await canvasRecorderPolygon.endRecording().toImage(width.floor(), height.floor());
  final dataPolygon = await imgPolygon.toByteData(format: ui.ImageByteFormat.png);

  final imgRectangle = await canvasRecorderRectangle.endRecording().toImage(width.floor(), height.floor());
  final dataRectangle = await imgRectangle.toByteData(format: ui.ImageByteFormat.png);

  // get pixel info and build morse code
  List<bool> morseCode = [];
  final byteData = await imgRectangle.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (byteData != null) {
    final buffer = byteData.buffer.asUint8List();
    // Calculate the index for the pixel at (x, y)
    int x = 0;
    int y = _transform(height, BOUNDS, analyseBar).toInt();

    for (int i = 0; i < RMSperPoint.length; i++) {
      x = (BOUNDS + i).toInt();
      final pixelIndex = (y * imgRectangle.width + x) * 4;

      final r = buffer[pixelIndex];
      final g = buffer[pixelIndex + 1];
      final b = buffer[pixelIndex + 2];
      //final a = buffer[pixelIndex + 3];
      morseCode.add(!_isBlack(r, g, b));

    }
  }

  return MorseData(
      MorseImagePolygon: trimNullBytes(dataPolygon!.buffer.asUint8List()),
      MorseImageRectangle: trimNullBytes(dataRectangle!.buffer.asUint8List()),
      MorseCode: morseCode);
}

bool _isBlack(int r, int g, int b) {
  return (r == 0 && g == 0 && b == 0);
}

double _transform(double height, double bounds, double y) {
  return height - bounds - y;
}
