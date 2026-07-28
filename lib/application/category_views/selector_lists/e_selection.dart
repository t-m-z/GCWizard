import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/e/widget/e.dart';

class ESelection extends GCWSelection {
  const ESelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        ENthDecimal,
        EDecimalRange,
        ESearch
      });

    return GCWToolList(toolList: _toolList);
  }
}