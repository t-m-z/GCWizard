import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_de_persid.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class CheckDigitsDEPersIDSelection extends GCWSelection {
  const CheckDigitsDEPersIDSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(const CheckDigitsDEPersIDCheckNumber()),
        className(const CheckDigitsDEPersIDCalculateCheckDigit()),
        className(const CheckDigitsDEPersIDCalculateMissingDigit()),
      ].contains(className(element.tool));
    }).toList();

    return GCWToolList(toolList: _toolList);
  }
}
