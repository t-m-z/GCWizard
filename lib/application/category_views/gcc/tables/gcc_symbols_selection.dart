import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_ascii_set.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_morse.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_numeralbases.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_resistor_4.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_resistor_5.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class GCCSymbolsSelection extends GCWSelection {
  const GCCSymbolsSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(const TableASCIISet()),
        className(const TableMorse()),
        className(const TableNumeralBasesNames()),
        className(const TableResistor4()),
        className(const TableResistor5()),
      ].contains(className(element.tool));
    }).toList();

    return GCWToolList(toolList: _toolList);
  }
}