import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersenne_exponents/widget/mersenne_exponents.dart';

class NumberSequenceMersenneExponentsSelection extends GCWSelection {
  const NumberSequenceMersenneExponentsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        NumberSequenceMersenneExponentsNthNumber,
        NumberSequenceMersenneExponentsRange,
        NumberSequenceMersenneExponentsDigits,
        NumberSequenceMersenneExponentsCheckNumber,
        NumberSequenceMersenneExponentsContainsDigits
      });

    return GCWToolList(toolList: _toolList);
  }
}
