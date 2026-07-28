import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum/widget/cross_sum.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum_range/widget/cross_sum_range.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum_range_frequency/widget/cross_sum_range_frequency.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/iterated_cross_sum_range/widget/iterated_cross_sum_range.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/iterated_cross_sum_range_frequency/widget/iterated_cross_sum_range_frequency.dart';

class CrossSumSelection extends GCWSelection {
  const CrossSumSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        CrossSum,
        CrossSumRange,
        IteratedCrossSumRange,
        CrossSumRangeFrequency,
        IteratedCrossSumRangeFrequency
      });

    return GCWToolList(toolList: _toolList);
  }
}
