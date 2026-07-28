import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/sublime_numbers/widget/sublime_numbers.dart';

class NumberSequenceSublimeNumbersSelection extends GCWSelection {
  const NumberSequenceSublimeNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceSublimeNumbersNthNumber,
        NumberSequenceSublimeNumbersRange,
        NumberSequenceSublimeNumbersDigits,
        NumberSequenceSublimeNumbersCheckNumber,
        NumberSequenceSublimeNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
