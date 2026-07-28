import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/sphenic_numbers/widget/spenic_numbers.dart';

class NumberSequenceSphenicNumbersSelection extends GCWSelection {
  const NumberSequenceSphenicNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceSphenicNumbersNthNumber,
        NumberSequenceSphenicNumbersRange,
        NumberSequenceSphenicNumbersDigits,
        NumberSequenceSphenicNumbersCheckNumber,
        NumberSequenceSphenicNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
