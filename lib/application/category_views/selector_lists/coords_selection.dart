import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';

class CoordsSelection extends GCWSelection {
  const CoordsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterCategory(ToolCategory.COORDINATES);

    return GCWToolList(toolList: _toolList);
  }
}
