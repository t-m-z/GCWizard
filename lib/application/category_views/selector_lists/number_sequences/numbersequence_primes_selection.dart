import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/primes/widget/primes.dart';

class NumberSequencePrimesSelection extends GCWSelection {
  const NumberSequencePrimesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequencePrimesNthNumber,
        NumberSequencePrimesRange,
        NumberSequencePrimesDigits,
        NumberSequencePrimesCheckNumber,
        NumberSequencePrimesContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
