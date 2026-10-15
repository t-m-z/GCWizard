import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/shadoks_numbers/widget/shadoks_numbers.dart';

class ShadoksSelection extends GCWSelection {
  const ShadoksSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'shadoks'},
        const {ShadoksNumbers});

    return GCWToolList(toolList: _toolList);
  }
}
