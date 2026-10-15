import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/look_and_say/widget/look_and_say.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/look_and_say/widget/look_and_say_text.dart';

class NumberSequenceLookAndSaySelection extends GCWSelection {
  const NumberSequenceLookAndSaySelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceLookAndSayNthNumber,
        NumberSequenceLookAndSayRange,
        NumberSequenceLookAndSayDigits,
        NumberSequenceLookAndSayCheckNumber,
        NumberSequenceLookAndSayContainsDigits,
        LookAndSayText
      });

    return GCWToolList(toolList: _toolList);
  }
}
