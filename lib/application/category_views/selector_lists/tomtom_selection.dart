import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tomtom/widget/tomtom.dart';

class TomTomSelection extends GCWSelection {
  const TomTomSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'tomtom'},
        const {TomTom});

    return GCWToolList(toolList: _toolList);
  }
}
