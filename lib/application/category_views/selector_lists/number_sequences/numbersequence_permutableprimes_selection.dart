import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/permutable_primes/widget/permutable_primes.dart';

class NumberSequencePermutablePrimesSelection extends GCWSelection {
  const NumberSequencePermutablePrimesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequencePermutablePrimesNthNumber,
        NumberSequencePermutablePrimesRange,
        NumberSequencePermutablePrimesDigits,
        NumberSequencePermutablePrimesCheckNumber,
        NumberSequencePermutablePrimesContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
