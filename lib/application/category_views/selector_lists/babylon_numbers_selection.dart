import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/babylon_numbers/widget/babylon_numbers.dart';

class BabylonNumbersSelection extends GCWSelection {
  const BabylonNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'babylonian_numerals'},
        {BabylonNumbers});

    return GCWToolList(toolList: _toolList);
  }
}
