import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/utils/datetime_utils.dart';

class Weekday extends StatefulWidget {
  const Weekday({Key? key}) : super(key: key);

  @override
 _WeekdayState createState() => _WeekdayState();
}

class _WeekdayState extends State<Weekday> {
  late DateTime _currentDate;

  @override
  void initState() {
    DateTime now = DateTime.now();
    _currentDate = DateTime(now.year, now.month, now.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(text: i18n(context, 'dates_weekday_date')),
        GCWDateTimePicker(
          config: const {DateTimePickerConfig.DATE},
          datetime: _currentDate,
          onChanged: (value) {
            setState(() {
              _currentDate = value.datetime;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var weekday = _currentDate.weekday;
    var output = i18n(context, WEEKDAY[weekday] ?? '');

    return GCWDefaultOutput(child: output);
  }
}
