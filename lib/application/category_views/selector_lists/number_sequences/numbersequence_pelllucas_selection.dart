import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/pell_lucas/widget/pell_lucas.dart';

class NumberSequencePellLucasSelection extends GCWSelection {
  const NumberSequencePellLucasSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequencePellLucasNthNumber,
        NumberSequencePellLucasRange,
        NumberSequencePellLucasDigits,
        NumberSequencePellLucasCheckNumber,
        NumberSequencePellLucasContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
