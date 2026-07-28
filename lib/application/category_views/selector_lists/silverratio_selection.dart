import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/silver_ratio/widget/silver_ratio.dart';

class SilverRatioSelection extends GCWSelection {
  const SilverRatioSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        SilverRatioNthDecimal,
        SilverRatioDecimalRange,
        SilverRatioSearch,
      }).toList();

    return GCWToolList(toolList: _toolList);
  }
}
