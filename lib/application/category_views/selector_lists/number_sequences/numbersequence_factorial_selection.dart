import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/factorial/widget/factorial.dart';

class NumberSequenceFactorialSelection extends GCWSelection {
  const NumberSequenceFactorialSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceFactorialNthNumber,
        NumberSequenceFactorialRange,
        NumberSequenceFactorialDigits,
        NumberSequenceFactorialCheckNumber,
        NumberSequenceFactorialContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
