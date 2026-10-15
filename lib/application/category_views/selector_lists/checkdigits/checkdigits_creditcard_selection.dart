import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_creditcard.dart';

class CheckDigitsCreditCardSelection extends GCWSelection {
  const CheckDigitsCreditCardSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        CheckDigitsCreditCardCheckNumber,
        CheckDigitsCreditCardCalculateCheckDigit,
        CheckDigitsCreditCardCalculateMissingDigit
      });

    return GCWToolList(toolList: _toolList);
  }
}
