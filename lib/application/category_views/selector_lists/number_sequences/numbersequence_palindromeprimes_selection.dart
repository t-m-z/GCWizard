import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/palindrome_primes/widget/palindrome_primes.dart';

class NumberSequencePalindromePrimesSelection extends GCWSelection {
  const NumberSequencePalindromePrimesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequencePalindromePrimesNthNumber,
        NumberSequencePalindromePrimesRange,
        NumberSequencePalindromePrimesDigits,
        NumberSequencePalindromePrimesCheckNumber,
        NumberSequencePalindromePrimesContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
