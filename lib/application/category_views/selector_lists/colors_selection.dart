import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/color_tool/widget/color_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/pantone_color_codes/widget/pantone_color_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/ral_color_codes/widget/ral_color_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/xkcd_color_codes/widget/xkcd_color_codes.dart';

class ColorsSelection extends GCWSelection {
  const ColorsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'color_code'},
        {ColorTool, PantoneColorCodes, RALColorCodes, XKCDColorCodes},
        startsWith: true);

    return GCWToolList(toolList: _toolList);
  }
}
