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
  'CL1' : false,
  'CL2' : false,
  'CL3' : false,
  'CL4' : false,
  'CL5' : false,
  'CR1' : false,
  'CR2' : false,
  'CR3' : false,
  'CR4' : false,
  'CR5' : false,
  'LL1' : false,
  'LL2' : false,
  'LL3' : false,
  'LL4' : false,
  'LL5' : false,
  'LR1' : false,
  'LR2' : false,
  'LR3' : false,
  'LR4' : false,
  'LR5' : false,
  'XL1' : false,
  'XL2' : false,
  'XL3' : false,
  'XL4' : false,
  'XL5' : false,
  'XR1' : false,
  'XR2' : false,
  'XR3' : false,
  'XR4' : false,
  'XR5' : false,
  'VL1' : false,
  'VL2' : false,
  'VL3' : false,
  'VL4' : false,
  'VL5' : false,
  'VR1' : false,
  'VR2' : false,
  'VR3' : false,
  'VR4' : false,
  'VR5' : false,
  'IL1' : false,
  'IL2' : false,
  'IL3' : false,
  'IL4' : false,
  'IL5' : false,
  'IR1' : false,
  'IR2' : false,
  'IR3' : false,
  'IR4' : false,
  'IR5' : false,
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

        const circles = {
          'ML1' : [10,20], 'ML2' : [25, 20], 'ML3': [40, 20], 'ML4': [55, 20], 'ML5': [70, 20],
          'MR1' : [100,20], 'MR2' : [115, 20], 'MR3': [130, 20], 'MR4': [145, 20], 'MR5': [160, 20],
          'DL1' : [10,40], 'DL2' : [25, 40], 'DL3': [40, 40], 'DL4': [55, 40], 'DL5': [70, 40],
          'DR1' : [100,40], 'DR2' : [115, 40], 'DR3': [130, 40], 'DR4': [145, 40], 'DR5': [160, 40],
          'CL1' : [10,60], 'CL2' : [25, 60], 'CL3': [40, 60], 'CL4': [55, 60], 'CL5': [70, 60],
          'CR1' : [100,60], 'CR2' : [115, 60], 'CR3': [130, 60], 'CR4': [145, 60], 'CR5': [160, 60],
          'LL1' : [10,80], 'LL2' : [25, 80], 'LL3': [40, 80], 'LL4': [55, 80], 'LL5': [70, 80],
          'LR1' : [100,80], 'LR2' : [115, 80], 'LR3': [130, 80], 'LR4': [145, 80], 'LR5': [160, 80],
          'XL1' : [10,100], 'XL2' : [25, 100], 'XL3': [40, 100], 'XL4': [55, 100], 'XL5': [70, 100],
          'XR1' : [100,100], 'XR2' : [115, 100], 'XR3': [130, 100], 'XR4': [145, 100], 'XR5': [160, 100],
          'VL1' : [10,120], 'VL2' : [25, 120], 'VL3': [40, 120], 'VL4': [55, 120], 'VL5': [70, 120],
          'VR1' : [100,120], 'VR2' : [115, 120], 'VR3': [130, 120], 'VR4': [145, 120], 'VR5': [160, 120],
          'IL1' : [10,140], 'IL2' : [25, 140], 'IL3': [40, 140], 'IL4': [55, 140], 'IL5': [70, 140],
          'IR1' : [100,140], 'IR2' : [115, 140], 'IR3': [130, 140], 'IR4': [145, 140], 'IR5': [160, 140],
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
          TextSpan(style: gcwTextStyle().copyWith(color: Colors.brown, fontSize: 16 * 1.3), text: key);
          TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
          textPainter.layout();

          textPainter.paint(
              canvas.canvas,
              Offset(size.width / _LCT_RELATIVE_DISPLAY_WIDTH * 85 - textPainter.width * 0.5,
                  size.height / _LCT_RELATIVE_DISPLAY_HEIGHT * value - textPainter.height * 0.5));
        });

      });
}