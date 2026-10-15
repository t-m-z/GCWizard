import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/weird_numbers/widget/weird_numbers.dart';

class NumberSequenceWeirdNumbersSelection extends GCWSelection {
  const NumberSequenceWeirdNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceWeirdNumbersNthNumber,
        NumberSequenceWeirdNumbersRange,
        NumberSequenceWeirdNumbersDigits,
        NumberSequenceWeirdNumbersCheckNumber,
        NumberSequenceWeirdNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
