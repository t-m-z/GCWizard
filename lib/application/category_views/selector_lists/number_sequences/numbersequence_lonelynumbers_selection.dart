import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/lonely_numbers/widget/lonely_numbers.dart';

class NumberSequenceLonelyNumbersSelection extends GCWSelection {
  const NumberSequenceLonelyNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceLonelyNumbersNthNumber,
        NumberSequenceLonelyNumbersRange,
        NumberSequenceLonelyNumbersDigits,
        NumberSequenceLonelyNumbersCheckNumber,
        NumberSequenceLonelyNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
