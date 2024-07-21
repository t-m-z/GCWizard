import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/jacobsthal_lucas/widget/jacobsthal_lucas.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class NumberSequenceJacobsthalLucasSelection extends GCWSelection {
  const NumberSequenceJacobsthalLucasSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(const NumberSequenceJacobsthalLucasNthNumber()),
        className(const NumberSequenceJacobsthalLucasRange()),
        className(const NumberSequenceJacobsthalLucasDigits()),
        className(const NumberSequenceJacobsthalLucasCheckNumber()),
        className(const NumberSequenceJacobsthalLucasContainsDigits()),
      ].contains(className(element.tool));
    }).toList();

    return GCWToolList(toolList: _toolList);
  }
}
