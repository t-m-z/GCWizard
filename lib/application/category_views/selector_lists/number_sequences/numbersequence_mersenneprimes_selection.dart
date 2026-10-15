import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersenne_primes/widget/mersenne_primes.dart';

class NumberSequenceMersennePrimesSelection extends GCWSelection {
  const NumberSequenceMersennePrimesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceMersennePrimesNthNumber,
        NumberSequenceMersennePrimesRange,
        NumberSequenceMersennePrimesDigits,
        NumberSequenceMersennePrimesCheckNumber,
        NumberSequenceMersennePrimesContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
