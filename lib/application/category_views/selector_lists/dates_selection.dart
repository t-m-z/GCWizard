import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/selector_lists/maya_calendar_selection.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/calendar/widget/calendar.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/day_calculator/widget/day_calculator.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/day_of_the_year/widget/day_of_the_year.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/epoch_time/excel_time/widget/excel_time.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/epoch_time/unix_time/widget/unix_time.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/time_calculator/widget/time_calculator.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/weekday/widget/weekday.dart';
import 'package:gc_wizard/tools/science_and_technology/time_converter/widget/time_converter.dart';

class DatesSelection extends GCWSelection {
  const DatesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        DayCalculator,
        TimeCalculator,
        Weekday,
        DayOfTheYear,
        TimeConverter,
        Calendar,
        UnixTime,
        ExcelTime,
        MayaCalendarSelection
      });

    return GCWToolList(toolList: _toolList);
  }
}
