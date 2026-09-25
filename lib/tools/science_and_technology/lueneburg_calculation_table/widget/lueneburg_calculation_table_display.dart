import 'package:flutter/material.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/gcw_touchcanvas.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/n_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/segmentdisplay_painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'ML1' : false,  'ML2' : false,  'ML3' : false,  'ML4' : false,
  'MR1' : false,  'MR2' : false,  'MR3' : false,  'MR4' : false,
  'DL1' : false,
  'DR1' : false,
  'CL1' : false,  'CL2' : false,  'CL3' : false,  'CL4' : false,
  'CR1' : false,  'CR2' : false,  'CR3' : false,  'CR4' : false,
  'LL1' : false,
  'LR1' : false,
  'XL1' : false,  'XL2' : false,  'XL3' : false,  'XL4' : false,
  'XR1' : false,  'XR2' : false,  'XR3' : false,  'XR4' : false,
  'VL1' : false,
  'VR1' : false,
  'IL1' : false,  'IL2' : false,  'IL3' : false,  'IL4' : false,
  'IR1' : false,  'IR2' : false,  'IR3' : false,  'IR4' : false,
};

class LCTSegmentDisplay extends NSegmentDisplay {
  LCTSegmentDisplay(
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

        var distX = size.width / 23;
        var distY = size.height / 15;

        const lines = {0, 2, 4, 6};
        paint.color = Colors.brown;
        paint.strokeWidth = 2.0;
        for (var height in lines) {
          canvas.touchCanvas.drawLine(
              Offset(distX, distY * (height * 2 + 1) + distY / 2),
              Offset(distX * 10, distY * (height * 2 + 1) + distY / 2), paint);
          canvas.touchCanvas.drawLine(
              Offset(distX * 13, distY * (height * 2 + 1) + distY / 2),
              Offset(distX * 22, distY * (height * 2 + 1) + distY / 2), paint);
        }

        const circles = {
          'ML1' : [0,0], 'ML2' : [1, 0], 'ML3': [2, 0], 'ML4': [3, 0],
          'MR1' : [6,0], 'MR2' : [7, 0], 'MR3': [8, 0], 'MR4': [9, 0],
          'DL1' : [2,1],
          'DR1' : [7,1],
          'CL1' : [0,2], 'CL2' : [1, 2], 'CL3': [2, 2], 'CL4': [3, 2],
          'CR1' : [6,2], 'CR2' : [7, 2], 'CR3': [8, 2], 'CR4': [9, 2],
          'LL1' : [2,3],
          'LR1' : [7,3],
          'XL1' : [0,4], 'XL2' : [1, 4], 'XL3': [2, 4], 'XL4': [3, 4],
          'XR1' : [6,4], 'XR2' : [7, 4], 'XR3': [8, 4], 'XR4': [9, 4],
          'VL1' : [2,5],
          'VR1' : [7,5],
          'IL1' : [0,6], 'IL2' : [1, 6], 'IL3': [2, 6], 'IL4': [3, 6],
          'IR1' : [6,6], 'IR2' : [7, 6], 'IR3': [8, 6], 'IR4': [9, 6],
        };

        circles.forEach((key, value) {
          paint.color = segmentActive(currentSegments, key) ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;

          canvas.touchCanvas.drawCircle(
              Offset(distX + distX * (value[0] * 2 + 1) + distX / 2,
                  distY * (value[1] * 2 + 1) + distY / 2),
              distX / 2,
              paint, onTapDown: (tapDetail) {
            setSegmentState(key, !segmentActive(currentSegments, key));
          });

          if (size.height < NSegmentDisplay.MIN_HEIGHT) return;

        });

        const letters = {
          'M' : 0,
          'D' : 1,
          'C' : 2,
          'L' : 3,
          'X' : 4,
          'V' : 5,
          'I' : 6,
        };
        letters.forEach((key, value) {
          TextSpan span =
          TextSpan(style: gcwTextStyle().copyWith(color: Colors.brown, fontSize: distX * 1.5), text: key);
          TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
          textPainter.layout();

          textPainter.paint(
              canvas.canvas,
              Offset(distX * 12 - textPainter.width,
                  distY * (value * 2 + 1) + distY / 2 - textPainter.height * 0.5));
        });

      });
}