import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/predator/widget/predator.dart';

class PredatorSelection extends GCWSelection {
  const PredatorSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'predator'},
        const {Predator});

    return GCWToolList(toolList: _toolList);
  }
}
