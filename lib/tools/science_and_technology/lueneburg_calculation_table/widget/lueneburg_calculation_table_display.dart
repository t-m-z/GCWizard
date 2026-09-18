import 'package:flutter/material.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/gcw_touchcanvas.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/n_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/segmentdisplay_painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'ML1' : false,
  'ML2' : false,
  'ML3' : false,
  'ML4' : false,
  'ML5' : false,
  'MR1' : false,
  'MR2' : false,
  'MR3' : false,
  'MR4' : false,
  'MR5' : false,
  'DL1' : false,
  'DL2' : false,
  'DL3' : false,
  'DL4' : false,
  'DL5' : false,
  'DR1' : false,
  'DR2' : false,
  'DR3' : false,
  'DR4' : false,
  'DR5' : false,
};

const _LCT_RELATIVE_DISPLAY_WIDTH = 250;
const _LCT_RELATIVE_DISPLAY_HEIGHT = 150;
const _LCT_RADIUS = 5.0;

class MICSegmentDisplay extends NSegmentDisplay {
  MICSegmentDisplay(
      {super.key,
        required super.segments,
        super.readOnly,
        super.onChanged})
      : super(
      initialSegments: _INITIAL_SEGMENTS,
      type: SegmentDisplayType.CUSTOM,
      customPaint: (GCWTouchCanvas canvas, Size size, Map<String, bool> currentSegments, Function setSegmentState,
          Color segment_color_on, Color segment_color_off) {
        var paint = defaultSegmentPaint();
        var SEGMENTS_COLOR_ON = segment_color_on;
        var SEGMENTS_COLOR_OFF = segment_color_off;

        const circles = {
          'ML1' : [10,20], 'ML2' : [25, 20], 'ML3': [40, 20], 'ML4': [55, 20], 'ML5': [70, 20],
          'MR1' : [100,20], 'MR2' : [115, 20], 'MR3': [130, 20], 'MR4': [145, 20], 'MR5': [160, 20],
          'DL1' : [10,40], 'DL2' : [25, 40], 'DL3': [40, 40], 'DL4': [55, 40], 'DL5': [70, 40],
          'DR1' : [100,40], 'DR2' : [115, 40], 'DR3': [130, 40], 'DR4': [145, 40], 'DR5': [160, 40],
        };

        circles.forEach((key, value) {
          paint.color = segmentActive(currentSegments, key) ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;

          var pointSize = size.height / _LCT_RELATIVE_DISPLAY_HEIGHT * _LCT_RADIUS;

          canvas.touchCanvas.drawCircle(
              Offset(size.width / _LCT_RELATIVE_DISPLAY_WIDTH * value[0],
                  size.height / _LCT_RELATIVE_DISPLAY_HEIGHT * value[1]),
              pointSize,
              paint, onTapDown: (tapDetail) {
            setSegmentState(key, !segmentActive(currentSegments, key));
          });

          if (size.height < NSegmentDisplay.MIN_HEIGHT) return;

        });

        const letters = {
          'M' : 20,
          'D' : 40,
          'C' : 60,
          'L' : 80,
          'X' : 100,
          'V' : 120,
          'I' : 140,
        };
        letters.forEach((key, value) {
          TextSpan span =
          TextSpan(style: gcwTextStyle().copyWith(color: SEGMENTS_COLOR_ON, fontSize: 16 * 1.3), text: key);
          TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
          textPainter.layout();

          textPainter.paint(
              canvas.canvas,
              Offset(size.width / _LCT_RELATIVE_DISPLAY_WIDTH * 85 - textPainter.width * 0.5,
                  size.height / _LCT_RELATIVE_DISPLAY_HEIGHT * value - textPainter.height * 0.5));
        });

        const lines = {20, 60, 100, 140};
                paint.color = SEGMENTS_COLOR_OFF;
        paint.strokeWidth = 2.0;
        for (var height in lines) {
          canvas.touchCanvas.drawLine(
              Offset(size.width / _LCT_RELATIVE_DISPLAY_WIDTH * 10,
                  size.height / _LCT_RELATIVE_DISPLAY_HEIGHT * height),
              Offset(size.width / _LCT_RELATIVE_DISPLAY_WIDTH * 70,
                  size.height / _LCT_RELATIVE_DISPLAY_HEIGHT * height), paint);
          canvas.touchCanvas.drawLine(
              Offset(size.width / _LCT_RELATIVE_DISPLAY_WIDTH * 100,
                  size.height / _LCT_RELATIVE_DISPLAY_HEIGHT * height),
              Offset(size.width / _LCT_RELATIVE_DISPLAY_WIDTH * 160,
                  size.height / _LCT_RELATIVE_DISPLAY_HEIGHT * height), paint);
        }
      });
}