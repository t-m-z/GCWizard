import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/jacobsthal_lucas/widget/jacobsthal_lucas.dart';

class NumberSequenceJacobsthalLucasSelection extends GCWSelection {
  const NumberSequenceJacobsthalLucasSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceJacobsthalLucasNthNumber,
        NumberSequenceJacobsthalLucasRange,
        NumberSequenceJacobsthalLucasDigits,
        NumberSequenceJacobsthalLucasCheckNumber,
        NumberSequenceJacobsthalLucasContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
