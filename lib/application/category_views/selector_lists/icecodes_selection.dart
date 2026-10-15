import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/icecodes/widget/icecodes.dart';

class IceCodesSelection extends GCWSelection {
  const IceCodesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'icecodes'},
        const {IceCodes});

    return GCWToolList(toolList: _toolList);
  }
}
