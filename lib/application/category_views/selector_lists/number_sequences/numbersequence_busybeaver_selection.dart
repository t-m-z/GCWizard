import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/busybeaver/widget/busybeaver.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class NumberSequenceBusyBeaverSelection extends GCWSelection {
  const NumberSequenceBusyBeaverSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(const NumberSequenceBusyBeaverNthNumber()),
        className(const NumberSequenceBusyBeaverRange()),
        className(const NumberSequenceBusyBeaverDigits()),
        className(const NumberSequenceBusyBeaverCheckNumber()),
        className(const NumberSequenceBusyBeaverContainsDigits()),
      ].contains(className(element.tool));
    }).toList();

    return GCWToolList(toolList: _toolList);
  }
}