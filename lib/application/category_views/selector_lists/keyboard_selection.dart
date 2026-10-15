import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard/keyboard_layout/widget/keyboard_layout.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard/keyboard_numbers/widget/keyboard_numbers.dart';

class KeyboardSelection extends GCWSelection {
  const KeyboardSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        KeyboardLayout,
        KeyboardNumbers
      });

    return GCWToolList(toolList: _toolList);
  }
}
