import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/beaufort/widget/beaufort.dart';

class BeaufortSelection extends GCWSelection {
  const BeaufortSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'windforce_beaufort', 'windforce_knots'},
        {Beaufort});

    return GCWToolList(toolList: _toolList);
  }
}
