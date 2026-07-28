import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/primarypseudoperfect_numbers/widget/primarypseudoperfect_numbers.dart';

class NumberSequencePrimaryPseudoPerfectNumbersSelection extends GCWSelection {
  const NumberSequencePrimaryPseudoPerfectNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequencePrimaryPseudoPerfectNumbersNthNumber,
        NumberSequencePrimaryPseudoPerfectNumbersRange,
        NumberSequencePrimaryPseudoPerfectNumbersDigits,
        NumberSequencePrimaryPseudoPerfectNumbersCheckNumber,
        NumberSequencePrimaryPseudoPerfectNumbersContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
