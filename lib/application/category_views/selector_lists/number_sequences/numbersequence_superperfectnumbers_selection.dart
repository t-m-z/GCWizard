import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/superperfect_numbers/widget/superperfect_numbers.dart';

class NumberSequenceSuperPerfectNumbersSelection extends GCWSelection {
  const NumberSequenceSuperPerfectNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceSuperPerfectNumbersNthNumber,
        NumberSequenceSuperPerfectNumbersRange,
        NumberSequenceSuperPerfectNumbersDigits,
        NumberSequenceSuperPerfectNumbersCheckNumber,
        NumberSequenceSuperPerfectNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
