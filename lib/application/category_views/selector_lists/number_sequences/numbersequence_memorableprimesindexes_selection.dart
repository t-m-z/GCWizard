import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/memorable_primes/widget/memorable_primes_indexes.dart';

class NumberSequenceMemorablePrimesIndexesSelection extends GCWSelection {
  const NumberSequenceMemorablePrimesIndexesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceMemorablePrimesIndexesNthNumber,
        NumberSequenceMemorablePrimesIndexesRange,
        NumberSequenceMemorablePrimesIndexesDigits,
        NumberSequenceMemorablePrimesIndexesCheckNumber,
        NumberSequenceMemorablePrimesIndexesContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
