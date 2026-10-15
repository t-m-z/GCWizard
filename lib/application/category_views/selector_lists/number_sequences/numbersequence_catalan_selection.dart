import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/catalan/widget/catalan.dart';

class NumberSequenceCatalanSelection extends GCWSelection {
  const NumberSequenceCatalanSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceCatalanNthNumber,
        NumberSequenceCatalanRange,
        NumberSequenceCatalanDigits,
        NumberSequenceCatalanCheckNumber,
        NumberSequenceCatalanContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
