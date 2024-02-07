import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/symbol_table.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class GCCSymbolsSelection extends GCWSelection {
  const GCCSymbolsSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(const SymbolTable()),
      ].contains(className(element.tool));
    }).toList();

 /*   _toolList = registeredTools.where((element) {
      return [
        // 8Bit Braille
        'symboltables_alchemy',
        'symboltables_egiptiorum',
        'symboltables_cirth',
        'symboltables_antiker',
        'symboltables_arcadian',
        // ascii
        // astronomy
        // atbash
        'symboltables_ath',
        'symboltables_babylonian_numerals',
        // bacon
        'symboltables_barbier',
        'symboltables_baudot_54123',
        // binärcode
        // bluebox
        'symboltables_blox',
        'symboltables_brahmi',
        'symboltables_braille_de',
        // buchstabenwert
        'symboltables_chappe_1794',
        'symboltables_chappe_1809',
        'symboltables_chappe_v1',
        'symboltables_cherokee',
        // code sonne mRNA
        'symboltables_color_honey',
        'symboltables_color_tokki',
        'symboltables_daedric',
        'symboltables_dagger',
        'symboltables_dancing_men',
        'symboltables_deafblind',
        // decabit
        'symboltables_dragon_language',
        'symboltables_fakoo',
        // faur farbcodes
        'symboltables_finger',
        'symboltables_fonic',
        'symboltables_flags',
        'symboltables_freemason',
        'symboltables_freemasaon_v2',
        'symboltables_futurama',
        'symboltables_gargish',
        'symboltables_gernreich',
        'symboltables_glagolitic',
        // gebärden
        // glückszahl
        'symboltables_gnommish',
        // griechische buchstaben
        'symboltables_greek_numerals',
        // hennoch
        'symboltables_hexahue',
        'symboltables_hieratic',
        'symboltables_hobbit_runes',
        'symboltables_hvd',
        'symboltables_hylian_64',
        'symboltables_hymnos',
      ].contains(element.id);
    }).toList();*/

    _toolList.sort((a, b) => sortToolList(a, b));

    return GCWToolList(toolList: _toolList);
  }
}