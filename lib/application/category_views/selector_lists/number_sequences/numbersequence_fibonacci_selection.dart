import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/fibonacci/widget/fibonacci.dart';

class NumberSequenceFibonacciSelection extends GCWSelection {
  const NumberSequenceFibonacciSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceFibonacciNthNumber,
        NumberSequenceFibonacciRange,
        NumberSequenceFibonacciDigits,
        NumberSequenceFibonacciCheckNumber,
        NumberSequenceFibonacciContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
