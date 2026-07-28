import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/carmichael/widget/carmichael_numbers.dart';

class NumberSequenceCarmichaelNumbersSelection extends GCWSelection {
  const NumberSequenceCarmichaelNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceCarmichaelNumbersNthNumber,
        NumberSequenceCarmichaelNumbersRange,
        NumberSequenceCarmichaelNumbersDigits,
        NumberSequenceCarmichaelNumbersCheckNumber,
        NumberSequenceCarmichaelNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
