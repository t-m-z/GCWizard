import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/resistor/resistor_colorcodecalculator/widget/resistor_colorcodecalculator.dart';
import 'package:gc_wizard/tools/science_and_technology/resistor/resistor_eia96/widget/resistor_eia96.dart';

class ResistorSelection extends GCWSelection {
  const ResistorSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'resistor'},
        const {ResistorColorCodeCalculator, ResistorEIA96});

    return GCWToolList(toolList: _toolList);
  }
}
