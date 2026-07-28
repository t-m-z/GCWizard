import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/braille/braille/widget/braille.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/braille/braille_dot_numbers/widget/braille_dot_numbers.dart';

class BrailleSelection extends GCWSelection {
  const BrailleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools2(
        const {'braille_'},
        const {Braille, BrailleDotNumbers},
        startsWith: true,
        symbolTables2: const {'fakoo'});

    return GCWToolList(toolList: _toolList);
  }
}
