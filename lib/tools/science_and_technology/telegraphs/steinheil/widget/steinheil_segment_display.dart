part of 'package:gc_wizard/tools/science_and_technology/telegraphs/steinheil/widget/steinheil.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'a': false,
  'b': false,
  'c': false,
  'd': false,
  'e': false,
  'f': false,
  'g': false,
  'h': false
};

const _STEINHEIL_RELATIVE_DISPLAY_WIDTH = 100;
const _STEINHEIL_RELATIVE_DISPLAY_HEIGHT = 100;
const _STEINHEIL_RADIUS = 12;


class _SteinheilSegmentDisplay extends NSegmentDisplay {

  _SteinheilSegmentDisplay({
    Key? key,
    required Map<String, bool> segments,
    bool readOnly = false,
    void Function(Map<String, bool>)? onChanged})
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
          'a': [15, 20],
          'b': [40, 20],
          'c': [65, 20],
          'd': [90, 20],
          'e': [15, 60],
          'f': [40, 60],
          'g': [65, 60],
          'h': [90, 60]
        };

        circles.forEach((key, value) {
          paint.color = segmentActive(currentSegments, key) ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;

          canvas.touchCanvas.drawCircle(
              Offset(size.width / _STEINHEIL_RELATIVE_DISPLAY_WIDTH * value[0],
                  size.height / _STEINHEIL_RELATIVE_DISPLAY_HEIGHT * value[1]),
              size.height / _STEINHEIL_RELATIVE_DISPLAY_HEIGHT * _STEINHEIL_RADIUS,
              paint, onTapDown: (tapDetail) {
            setSegmentState(key, !segmentActive(currentSegments, key));
          });

          if (size.height < 50) return;

        });
      });
}
