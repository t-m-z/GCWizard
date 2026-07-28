import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/recaman/widget/recaman.dart';

class NumberSequenceRecamanSelection extends GCWSelection {
  const NumberSequenceRecamanSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceRecamanNthNumber,
        NumberSequenceRecamanRange,
        NumberSequenceRecamanDigits,
        NumberSequenceRecamanCheckNumber,
        NumberSequenceRecamanContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
