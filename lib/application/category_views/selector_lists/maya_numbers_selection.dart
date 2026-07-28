import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/maya_numbers/widget/maya_numbers.dart';

class MayaNumbersSelection extends GCWSelection {
  const MayaNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'maya_numerals'},
        const {MayaNumbers});

    return GCWToolList(toolList: _toolList);
  }
}
