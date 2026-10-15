import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/memorable_primes/widget/memorable_primes.dart';

class NumberSequenceMemorablePrimesSelection extends GCWSelection {
  const NumberSequenceMemorablePrimesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceMemorablePrimesNthNumber,
        NumberSequenceMemorablePrimesRange,
        NumberSequenceMemorablePrimesDigits,
        NumberSequenceMemorablePrimesCheckNumber,
        NumberSequenceMemorablePrimesContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
