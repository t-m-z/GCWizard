import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/sqrt3/widget/sqrt3.dart';

class SQRT3Selection extends GCWSelection {
  const SQRT3Selection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        SQRT3NthDecimal,
        SQRT3DecimalRange,
        SQRT3Search
      });

    return GCWToolList(toolList: _toolList);
  }
}
