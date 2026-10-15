import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/lychrel/widget/lychrel.dart';

class NumberSequenceLychrelSelection extends GCWSelection {
  const NumberSequenceLychrelSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceLychrelNthNumber,
        NumberSequenceLychrelRange,
        NumberSequenceLychrelDigits,
        NumberSequenceLychrelCheckNumber,
        NumberSequenceLychrelContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
