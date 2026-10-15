import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt1/widget/ccitt1.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt2/widget/ccitt2.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt3/widget/ccitt3.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt4/widget/ccitt4.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt5/widget/ccitt5.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt_ccir476/widget/ccitt_ccir476.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/punchtape/widget/punchtape.dart';

class CCITTSelection extends GCWSelection {
  const CCITTSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {
          'ita1_1926',
          'ita1_1929',
          'ita2_1929',
          'ita3_1931'
        },const {
          CCITT1,
          CCITT2,
          CCITT3,
          CCITT4,
          CCITT5,
          CCIR476,
          TeletypewriterPunchTape
        });

    return GCWToolList(toolList: _toolList);
  }
}
