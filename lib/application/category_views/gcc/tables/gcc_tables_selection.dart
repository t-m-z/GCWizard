import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_ascii_set.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_morse.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_numeralbases.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_resistor_4.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_resistor_5.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_roman.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class GCCTableSelection extends GCWSelection {
  const GCCTableSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(const GCCTableASCIISet()),
        className(const GCCTableMorse()),
        className(const GCCTableNumeralBasesNames()),
        className(const GCCTableResistor4()),
        className(const GCCTableResistor5()),
        className(const GCCTableRoman()),
      ].contains(className(element.tool));
    }).toList();

    return GCWToolList(toolList: _toolList);
  }
}