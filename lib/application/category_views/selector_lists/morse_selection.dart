import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/morse/widget/morse.dart';

class MorseSelection extends GCWSelection {
  const MorseSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {
          'morse',
          'morse_1838_patent',
          'morse_1844_vail',
          'morse_gerke',
          'morse_steinheil'
        }, const {Morse});

    return GCWToolList(toolList: _toolList);
  }
}
