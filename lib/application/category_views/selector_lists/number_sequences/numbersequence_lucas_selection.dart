import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/lucas/widget/lucas.dart';

class NumberSequenceLucasSelection extends GCWSelection {
  const NumberSequenceLucasSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceLucasNthNumber,
        NumberSequenceLucasRange,
        NumberSequenceLucasDigits,
        NumberSequenceLucasCheckNumber,
        NumberSequenceLucasContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
