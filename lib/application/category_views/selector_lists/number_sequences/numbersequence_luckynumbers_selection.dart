import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/lucky_numbers/widget/lucky_numbers.dart';

class NumberSequenceLuckyNumbersSelection extends GCWSelection {
  const NumberSequenceLuckyNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceLuckyNumbersNthNumber,
        NumberSequenceLuckyNumbersRange,
        NumberSequenceLuckyNumbersDigits,
        NumberSequenceLuckyNumbersCheckNumber,
        NumberSequenceLuckyNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
