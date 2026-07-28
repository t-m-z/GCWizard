import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/jacobsthal/widget/jacobsthal.dart';

class NumberSequenceJacobsthalSelection extends GCWSelection {
  const NumberSequenceJacobsthalSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceJacobsthalNthNumber,
        NumberSequenceJacobsthalRange,
        NumberSequenceJacobsthalDigits,
        NumberSequenceJacobsthalCheckNumber,
        NumberSequenceJacobsthalContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
