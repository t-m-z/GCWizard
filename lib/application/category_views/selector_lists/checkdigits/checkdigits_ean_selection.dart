import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_ean.dart';

class CheckDigitsEANSelection extends GCWSelection {
  const CheckDigitsEANSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        CheckDigitsEANCheckNumber,
        CheckDigitsEANCalculateCheckDigit,
        CheckDigitsEANCalculateMissingDigit
      });

    return GCWToolList(toolList: _toolList);
  }
}
