import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/happy_numbers/widget/happy_numbers.dart';

class NumberSequenceHappyNumbersSelection extends GCWSelection {
  const NumberSequenceHappyNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceHappyNumbersNthNumber,
        NumberSequenceHappyNumbersRange,
        NumberSequenceHappyNumbersDigits,
        NumberSequenceHappyNumbersCheckNumber,
        NumberSequenceHappyNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
