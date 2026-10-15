import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bacon/widget/bacon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bacon/widget/bacon_analyze.dart';

class BaconSelection extends GCWSelection {
  const BaconSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        Bacon,
        BaconAnalyze
      });

    return GCWToolList(toolList: _toolList);
  }
}
