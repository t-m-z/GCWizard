import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/phi/widget/phi.dart';

class PhiSelection extends GCWSelection {
  const PhiSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        PhiNthDecimal,
        PhiDecimalRange,
        PhiSearch
      });

    return GCWToolList(toolList: _toolList);
  }
}
