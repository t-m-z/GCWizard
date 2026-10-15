import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/sqrt5/widget/sqrt5.dart';

class SQRT5Selection extends GCWSelection {
  const SQRT5Selection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        SQRT5NthDecimal,
        SQRT5DecimalRange,
        SQRT5Search
      });

    return GCWToolList(toolList: _toolList);
  }
}
