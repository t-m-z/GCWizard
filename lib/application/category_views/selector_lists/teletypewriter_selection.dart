import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ancient_teletypewriter/widget/ancient_teletypewriter.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt_teletypewriter/widget/ccitt_teletypewriter.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/other_teletypewriter/widget/other_teletypewriter.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/punchtape/widget/punchtape.dart';

class TeletypewriterSelection extends GCWSelection {
  const TeletypewriterSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {
          'baudot_1888',
          'baudot_54123',
          'murraybaudot',
          'siemens',
          'westernunion',
          'ita1_1926',
          'ita1_1929',
          'ita2_1929',
          'ita3_1931'
        }, const {
          AncientTeletypewriter,
          OtherTeletypewriter,
          CCITTTeletypewriter,
          TeletypewriterPunchTape
        });

    return GCWToolList(toolList: _toolList);
  }
}
