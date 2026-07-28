import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/cistercian_numbers/widget/cistercian_numbers.dart';

class CistercianNumbersSelection extends GCWSelection {
  const CistercianNumbersSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'cistercian'},
        const {CistercianNumbers});

    return GCWToolList(toolList: _toolList);
  }
}
