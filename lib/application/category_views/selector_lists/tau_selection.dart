import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/tau/widget/tau.dart';

class TauSelection extends GCWSelection {
  const TauSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        TauNthDecimal,
        TauDecimalRange,
        TauSearch
      });

    return GCWToolList(toolList: _toolList);
  }
}
