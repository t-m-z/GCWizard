import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/harshad/widget/harshad_numbers.dart';

class NumberSequenceHarshadNumbersSelection extends GCWSelection {
  const NumberSequenceHarshadNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceHarshadNumbersNthNumber,
        NumberSequenceHarshadNumbersRange,
        NumberSequenceHarshadNumbersDigits,
        NumberSequenceHarshadNumbersCheckNumber,
        NumberSequenceHarshadNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
