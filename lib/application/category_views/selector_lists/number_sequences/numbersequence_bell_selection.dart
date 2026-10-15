import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/bell/widget/bell.dart';

class NumberSequenceBellSelection extends GCWSelection {
  const NumberSequenceBellSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceBellNthNumber,
        NumberSequenceBellRange,
        NumberSequenceBellDigits,
        NumberSequenceBellCheckNumber,
        NumberSequenceBellContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
