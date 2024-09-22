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

Future<MorseData> PCMamplitudes2Image(
    {required double duration,
    required List<double> RMSperPoint,
    required double maxAmplitude,
    required double minAmplitude,
    }) async {

  const BOUNDS = 10.0;

  var vScaleFactor = 1.0;

  while(maxAmplitude < 260) {
    vScaleFactor = vScaleFactor * 10;
    maxAmplitude = maxAmplitude * 10;
  }
  minAmplitude = minAmplitude * vScaleFactor;

  double threshhold = maxAmplitude - (maxAmplitude - minAmplitude) / 2;

  var width = BOUNDS + RMSperPoint.length + BOUNDS;
  var height = BOUNDS + maxAmplitude + BOUNDS;

  List<bool> morseCode = [];

  final canvasRecorderPolygon = ui.PictureRecorder();
  final canvasPolygon =
      ui.Canvas(canvasRecorderPolygon, ui.Rect.fromLTWH(0, 0, width, height));

  final canvasRecorderRectangle = ui.PictureRecorder();
  final canvasRectangle =
  ui.Canvas(canvasRecorderRectangle, ui.Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  canvasPolygon.drawRect(Rect.fromLTWH(0, 0, width, height), paint);
  canvasRectangle.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

  paint.color = Colors.white;
  paint.strokeWidth = 2.0;
  canvasPolygon.drawLine(Offset(0, 0), Offset(width, 0), paint);
  canvasPolygon.drawLine(Offset(0, minAmplitude), Offset(width, minAmplitude), paint);
  canvasPolygon.drawLine(Offset(0, threshhold), Offset(width, threshhold), paint);
  canvasPolygon.drawLine(Offset(0, maxAmplitude), Offset(width, maxAmplitude), paint);

  paint.color = Colors.orangeAccent;
  paint.strokeWidth = 2.0;

  final path = Path();

  int countHigh = 0;
  int countLow = 0;

  path.moveTo(BOUNDS, 0);
  for (var i = 0; i < RMSperPoint.length; i++) {
    RMSperPoint[i] = RMSperPoint[i] * vScaleFactor;

    if (RMSperPoint[i] > threshhold) {
      countHigh++;
    } else {
      countLow ++;
    }
    path.lineTo(BOUNDS + i, BOUNDS + maxAmplitude - RMSperPoint[i]);
    canvasRectangle.drawLine(Offset(BOUNDS + i, BOUNDS + maxAmplitude), Offset(BOUNDS + i, BOUNDS + maxAmplitude - RMSperPoint[i]), paint);
  }
  canvasPolygon.drawPath(path, paint);

  paint.color = Colors.red;
  canvasRectangle.drawLine(Offset(BOUNDS, BOUNDS + 10), Offset(BOUNDS + RMSperPoint.length, BOUNDS + 10), paint);

  bool highBand = countHigh > countLow;
print('Highband : '+highBand.toString());

  for (var i = 0; i < RMSperPoint.length; i++) {
    if (highBand) {
      if (RMSperPoint[i] > threshhold) {
        morseCode.add(true);
      } else {
        morseCode.add(false);
      }
    } else {
      if (RMSperPoint[i] > threshhold) {
        morseCode.add(false);
      } else {
        morseCode.add(true);
      }
    }
  }

  final imgPolygon = await canvasRecorderPolygon
      .endRecording()
      .toImage(width.floor(), height.floor());
  final dataPolygon = await imgPolygon.toByteData(format: ui.ImageByteFormat.png);

  final imgRectangle = await canvasRecorderRectangle
      .endRecording()
      .toImage(width.floor(), height.floor());
  final dataRectangle = await imgRectangle.toByteData(format: ui.ImageByteFormat.png);

  // get pixel info and build morse code
  morseCode = [];
  final byteData = await imgRectangle.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (byteData != null) {
    final buffer = byteData.buffer.asUint8List();
    // Calculate the index for the pixel at (x, y)
    for (int i = 0; i < RMSperPoint.length; i++) {
      int x = (BOUNDS + i).toInt();
      int y = (BOUNDS + 8).toInt();
      final pixelIndex = (y * imgRectangle.width + x) * 4;
      final r = buffer[pixelIndex];
      final g = buffer[pixelIndex + 1];
      final b = buffer[pixelIndex + 2];
      final a = buffer[pixelIndex + 3];
      //print('Pixel at ($x, $y): R=$r, G=$g, B=$b, A=$a'); //print(x.toString() + ' '+_isBlack(r, g, b).toString());
      morseCode.add(_isBlack(r, g, b));
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

