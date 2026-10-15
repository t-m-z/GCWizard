import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/taxicab/widget/taxicab_numbers.dart';

class NumberSequenceTaxicabNumbersSelection extends GCWSelection {
  const NumberSequenceTaxicabNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceTaxicabNumbersNthNumber,
        NumberSequenceTaxicabNumbersRange,
        NumberSequenceTaxicabNumbersDigits,
        NumberSequenceTaxicabNumbersCheckNumber,
        NumberSequenceTaxicabNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
