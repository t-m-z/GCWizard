import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/widget/vigenere_breaker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gronsfeld/widget/gronsfeld.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/larrabee/widget/larrabee.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/porta/widget/porta.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/trithemius/widget/trithemius.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/vigenere/widget/vigenere.dart';

class VigenereSelection extends GCWSelection {
  const VigenereSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        Vigenere,
        VigenereBreaker,
        Trithemius,
        Gronsfeld,
        Porta,
        Larrabee
      });

    return GCWToolList(toolList: _toolList);
  }
}
