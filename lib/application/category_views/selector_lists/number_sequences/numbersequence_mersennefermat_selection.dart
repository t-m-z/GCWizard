import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersennefermat/widget/mersennefermat.dart';

class NumberSequenceMersenneFermatSelection extends GCWSelection {
  const NumberSequenceMersenneFermatSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceMersenneFermatNthNumber,
        NumberSequenceMersenneFermatRange,
        NumberSequenceMersenneFermatDigits,
        NumberSequenceMersenneFermatCheckNumber,
        NumberSequenceMersenneFermatContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
