import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/uncategorized/zodiac/widget/zodiac.dart';

class ZodiacSelection extends GCWSelection {
  const ZodiacSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {'zodiac_signs', 'zodiac_signs_latin'},
        const {Zodiac});

    return GCWToolList(toolList: _toolList);
  }
}
