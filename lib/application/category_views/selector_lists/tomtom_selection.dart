import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tomtom/widget/tomtom.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/symbol_table.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class TomTomSelection extends GCWSelection {
  const TomTomSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      if (className(element.tool) == className(const SymbolTable()) &&
          (element.tool as SymbolTable).symbolKey == 'tomtom') {
        return true;
      }

      return [
        className(const TomTom()),
      ].contains(className(element.tool));
    }).toList();

    return GCWToolList(toolList: _toolList);
  }
}
