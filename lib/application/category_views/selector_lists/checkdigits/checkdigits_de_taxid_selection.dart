import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_de_taxid.dart';

class CheckDigitsDETaxIDSelection extends GCWSelection {
  const CheckDigitsDETaxIDSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        CheckDigitsDETaxIDCheckNumber,
        CheckDigitsDETaxIDCalculateCheckDigit,
        CheckDigitsDETaxIDCalculateMissingDigit
      });

    return GCWToolList(toolList: _toolList);
  }
}
