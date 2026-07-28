import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/fermat/widget/fermat.dart';

class NumberSequenceFermatSelection extends GCWSelection {
  const NumberSequenceFermatSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceFermatNthNumber,
        NumberSequenceFermatRange,
        NumberSequenceFermatDigits,
        NumberSequenceFermatCheckNumber,
        NumberSequenceFermatContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
