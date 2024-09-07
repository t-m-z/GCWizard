import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/images_and_files/animated_image_morse_code/logic/animated_image_morse_code.dart';
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

  final canvasRecorder = ui.PictureRecorder();
  final canvas =
      ui.Canvas(canvasRecorder, ui.Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

  paint.color = Colors.white;
  paint.strokeWidth = 2.0;
  canvas.drawLine(Offset(0, 0), Offset(width, 0), paint);
  canvas.drawLine(Offset(0, minAmplitude), Offset(width, minAmplitude), paint);
  canvas.drawLine(Offset(0, threshhold), Offset(width, threshhold), paint);
  canvas.drawLine(Offset(0, maxAmplitude), Offset(width, maxAmplitude), paint);

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
  }

  canvas.drawPath(path, paint);

  bool highBand = countHigh > countLow;

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

  final img = await canvasRecorder
      .endRecording()
      .toImage(width.floor(), height.floor());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);

  return MorseData(
      MorseImage: trimNullBytes(data!.buffer.asUint8List()),
      MorseCode: morseCode);
}

