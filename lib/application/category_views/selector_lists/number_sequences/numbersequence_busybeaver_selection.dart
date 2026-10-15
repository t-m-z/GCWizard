import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/busybeaver/widget/busybeaver.dart';

class NumberSequenceBusyBeaverSelection extends GCWSelection {
  const NumberSequenceBusyBeaverSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceBusyBeaverNthNumber,
        NumberSequenceBusyBeaverRange,
        NumberSequenceBusyBeaverDigits,
        NumberSequenceBusyBeaverCheckNumber,
        NumberSequenceBusyBeaverContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
