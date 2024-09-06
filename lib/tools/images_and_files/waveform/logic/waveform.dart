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

  var threshhold = maxAmplitude - (maxAmplitude - minAmplitude) / 3;

  var width = BOUNDS + RMSperPoint.length + BOUNDS;
  var height = BOUNDS + maxAmplitude + BOUNDS;

  List<bool> morseCode = [];

  //int durationScaleH = RMSperPoint.length ~/ duration;
  //int durationScaleV = maxAmplitude ~/ 100 ;

  final canvasRecorder = ui.PictureRecorder();
  final canvas =
      ui.Canvas(canvasRecorder, ui.Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

  //paint.color = Colors.white;
  //paint.strokeWidth = 2.0;
  //canvas.drawLine(Offset(BOUNDS, height / 4 * 3),
  //    Offset(BOUNDS + width, height / 4 * 3), paint);

  paint.color = Colors.orangeAccent;
  paint.strokeWidth = 2.0;

  final path = Path();

  path.moveTo(BOUNDS, 0);
  path.lineTo(BOUNDS, BOUNDS + maxAmplitude);
  for (var i = 0; i < RMSperPoint.length; i++) {
    RMSperPoint[i] = RMSperPoint[i] * vScaleFactor;
    path.lineTo(BOUNDS + i, BOUNDS + maxAmplitude - RMSperPoint[i]);

    // if (i % durationScaleH == 0) {
    //   paint.color = Colors.red;
    //   paint.strokeWidth = 2.0;
    //   canvas.drawLine(
    //       Offset(
    //           BOUNDS + 1 + i, height / 4 * 3 - durationScaleV),
    //       Offset(
    //           BOUNDS + 1 + i, height / 4 * 3 + durationScaleV),
    //       paint);
    //   paint.color = Colors.orangeAccent;
    //   paint.strokeWidth = 2.0;
    // }

    if (_highPitch(RMSperPoint[i])) {
    //if (RMSperPoint[i] > threshhold) {
      morseCode.add(false);
    } else {
      morseCode.add(true);
    }
  }
  path.lineTo(BOUNDS + RMSperPoint.length - 1, 0);

  canvas.drawPath(path, paint);

  final img = await canvasRecorder
      .endRecording()
      .toImage(width.floor(), height.floor());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
/*  final pixel = await img.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (pixel != null) {
    final buffer = pixel.buffer.asUint8List();
// Calculate the index for the pixel at (x, y)
    final pixelIndex = (y * img.width + x) * 4;
    final r = buffer[pixelIndex];
    final g = buffer[pixelIndex + 1];
    final b = buffer[pixelIndex + 2];
    final a = buffer[pixelIndex + 3];
    //print('Pixel at ($x, $y): R=$r, G=$g, B=$b, A=$a');  }
  }*/

  return MorseData(
      MorseImage: trimNullBytes(data!.buffer.asUint8List()),
      MorseCode: morseCode);
}
