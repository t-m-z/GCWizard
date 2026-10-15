import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/sqrt2/widget/sqrt2.dart';

class SQRT2Selection extends GCWSelection {
  const SQRT2Selection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        SQRT2NthDecimal,
        SQRT2DecimalRange,
        SQRT2Search
      });

    return GCWToolList(toolList: _toolList);
  }
}
