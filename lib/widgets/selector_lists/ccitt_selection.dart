import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/ccitt1.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/ccitt2.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/ccitt3.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/ccitt4.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/ccitt5.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/ccitt_ccir476.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/punchtape.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class CCITTSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      if (className(element.tool) == className(SymbolTable())) if ((element.tool as SymbolTable).symbolKey ==
              'ita1_1926' ||
          (element.tool as SymbolTable).symbolKey == 'ita1_1929' ||
          (element.tool as SymbolTable).symbolKey == 'ita2_1929' ||
          (element.tool as SymbolTable).symbolKey == 'ita3_1931') return true;

      return [
        className(CCITT1()),
        className(CCITT2()),
        className(CCITT3()),
        className(CCITT4()),
        className(CCITT5()),
        className(CCIR476()),
        className(TeletypewriterPunchTape()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
