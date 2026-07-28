import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/easter/easter_date/widget/easter_date.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/easter/easter_years/widget/easter_years.dart';

class EasterSelection extends GCWSelection {
  const EasterSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {EasterDate, EasterYears});

    return GCWToolList(toolList: _toolList);
  }
}
