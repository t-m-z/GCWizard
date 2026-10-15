import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/14_segment_display/widget/fourteen_segments.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/16_segment_display/widget/sixteen_segments.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/7_segment_display/widget/seven_segments.dart';

class SegmentDisplaySelection extends GCWSelection {
  const SegmentDisplaySelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        SevenSegments,
        FourteenSegments,
        SixteenSegments
      });

    return GCWToolList(toolList: _toolList);
  }
}
