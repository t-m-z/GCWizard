import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/maya_calendar/widget/maya_calendar.dart';

class MayaCalendarSelection extends GCWSelection {
  const MayaCalendarSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterSymbolTableTools(
        const {
          'maya_calendar_longcount',
          'maya_calendar_haab_codices',
          'maya_calendar_haab_inscripts',
          'maya_calendar_tzolkin_codices',
          'maya_calendar_tzolkin_inscripts'
        }, const {MayaCalendar});

    return GCWToolList(toolList: _toolList);
  }
}
