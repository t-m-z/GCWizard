import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/perfect_numbers/widget/perfect_numbers.dart';

class NumberSequencePerfectNumbersSelection extends GCWSelection {
  const NumberSequencePerfectNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequencePerfectNumbersNthNumber,
        NumberSequencePerfectNumbersRange,
        NumberSequencePerfectNumbersDigits,
        NumberSequencePerfectNumbersCheckNumber,
        NumberSequencePerfectNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
