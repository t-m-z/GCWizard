import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/toki_pona/widget/toki_pona.dart';

class TokiPonaSelection extends GCWSelection {
  const TokiPonaSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {
          'toki_pona_letters_names',
          'toki_pona_letters_symbols',
          'toki_pona_numbers',
          'toki_pona_numbers_sitelen_pona',
          'toki_pona_numbers_sitelen_telo',
          'toki_pona_numbers_sitelen_sitelen'
        }, const {TokiPona});

    return GCWToolList(toolList: _toolList);
  }
}
