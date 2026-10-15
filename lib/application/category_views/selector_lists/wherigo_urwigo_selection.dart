import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/wherigo/earwigo_text_deobfuscation/widget/earwigo_text_deobfuscation.dart';
import 'package:gc_wizard/tools/wherigo/urwigo_hashbreaker/widget/urwigo_hashbreaker.dart';
import 'package:gc_wizard/tools/wherigo/urwigo_text_deobfuscation/widget/urwigo_text_deobfuscation.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/widget/wherigo_analyze.dart';

class WherigoSelection extends GCWSelection {
  const WherigoSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        UrwigoHashBreaker,
        UrwigoTextDeobfuscation,
        EarwigoTextDeobfuscation,
        WherigoAnalyze
      });

    return GCWToolList(toolList: _toolList);
  }
}
