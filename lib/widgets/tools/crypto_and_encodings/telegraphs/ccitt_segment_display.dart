import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{'1': false, '2': false, '3': false, '4': false, '5': false};

const _CCITT_RELATIVE_DISPLAY_WIDTH = 180;
const _CCITT_RELATIVE_DISPLAY_HEIGHT = 60;
const _CCITT_RADIUS = 20.0;

class CCITTSegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;
  final bool tapeStyle;

  CCITTSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged, this.tapeStyle: false})
      : super(
            key: key,
            initialSegments: _INITIAL_SEGMENTS,
            segments: segments,
            readOnly: readOnly,
            onChanged: onChanged,
            type: SegmentDisplayType.CUSTOM,
            customPaint: (GCWTouchCanvas canvas, Size size, Map<String, bool> currentSegments, Function setSegmentState,
                Color segment_color_on, Color segment_color_off) {
              var paint = defaultSegmentPaint();
              var SEGMENTS_COLOR_ON = segment_color_on;
              var SEGMENTS_COLOR_OFF = segment_color_off;

              var circles = {
                '1': [10, 30],
                '2': [40, 30],
                '3': [100, 30],
                '4': [130, 30],
                '5': [160, 30]
              };
              var pointSize = size.height / _CCITT_RELATIVE_DISPLAY_HEIGHT * _CCITT_RADIUS;

              circles.forEach((key, value) {
                paint.color = Colors.black;
                canvas.touchCanvas.drawCircle(
                    Offset(size.width / _CCITT_RELATIVE_DISPLAY_WIDTH * (value[0]),
                        size.height / _CCITT_RELATIVE_DISPLAY_HEIGHT * (value[1])),
                    pointSize + 2,
                    paint);

                if (size.height < 50) return;
              });

              circles.forEach((key, value) {
                paint.color = currentSegments[key] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
                canvas.touchCanvas.drawCircle(
                    Offset(size.width / _CCITT_RELATIVE_DISPLAY_WIDTH * value[0],
                        size.height / _CCITT_RELATIVE_DISPLAY_HEIGHT * value[1]),
                    pointSize,
                    paint, onTapDown: (tapDetail) {
                  setSegmentState(key, !currentSegments[key]);
                });

                if (size.height < 50) return;
              });

              paint.color = Colors.grey;
              canvas.touchCanvas.drawCircle(
                  Offset(size.width / _CCITT_RELATIVE_DISPLAY_WIDTH * 70.0,
                      size.height / _CCITT_RELATIVE_DISPLAY_HEIGHT * 30.0),
                  pointSize / 2.0,
                  paint);
            });
}