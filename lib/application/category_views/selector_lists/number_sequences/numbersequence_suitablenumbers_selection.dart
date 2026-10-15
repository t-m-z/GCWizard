import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/suitable_numbers/widget/suitable_numbers.dart';

class NumberSequenceSuitableNumbersSelection extends GCWSelection {
  const NumberSequenceSuitableNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceSuitableNumbersNthNumber,
        NumberSequenceSuitableNumbersRange,
        NumberSequenceSuitableNumbersDigits,
        NumberSequenceSuitableNumbersCheckNumber,
        NumberSequenceSuitableNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
