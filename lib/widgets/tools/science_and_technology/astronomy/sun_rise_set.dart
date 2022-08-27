import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/julian_date.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/sun_rise_set.dart' as logic;
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class SunRiseSet extends StatefulWidget {
  @override
  SunRiseSetState createState() => SunRiseSetState();
}

class SunRiseSetState extends State<SunRiseSet> {
  var _currentDateTime = {'datetime': DateTime.now(), 'timezone': DateTime.now().timeZoneOffset};
  var _currentCoords = defaultCoordinate;
  var _currentCoordsFormat = defaultCoordFormat();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'common_location'),
          coordsFormat: _currentCoordsFormat,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'astronomy_riseset_date'),
        ),
        GCWDateTimePicker(
          type: DateTimePickerType.DATE_ONLY,
          withTimezones: true,
          onChanged: (datetime) {
            setState(() {
              _currentDateTime = datetime;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    var sunRise = logic.SunRiseSet(
        _currentCoords,
        JulianDate(_currentDateTime['datetime'], _currentDateTime['timezone']),
        _currentDateTime['timezone'],
        defaultEllipsoid());

    var outputs = [
      [
        i18n(context, 'astronomy_riseset_astronomicalmorning'),
        sunRise.astronomicalMorning.isNaN
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatHoursToHHmmss(sunRise.astronomicalMorning)
      ],
      [
        i18n(context, 'astronomy_riseset_nauticalmorning'),
        sunRise.nauticalMorning.isNaN
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatHoursToHHmmss(sunRise.nauticalMorning)
      ],
      [
        i18n(context, 'astronomy_riseset_civilmorning'),
        sunRise.civilMorning.isNaN
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatHoursToHHmmss(sunRise.civilMorning)
      ],
      [
        i18n(context, 'astronomy_riseset_sunrise'),
        sunRise.rise.isNaN ? i18n(context, 'astronomy_riseset_notavailable') : formatHoursToHHmmss(sunRise.rise)
      ],
      [
        i18n(context, 'astronomy_riseset_transit'),
        sunRise.transit.isNaN ? i18n(context, 'astronomy_riseset_notavailable') : formatHoursToHHmmss(sunRise.transit)
      ],
      [
        i18n(context, 'astronomy_riseset_sunset'),
        sunRise.set.isNaN ? i18n(context, 'astronomy_riseset_notavailable') : formatHoursToHHmmss(sunRise.set)
      ],
      [
        i18n(context, 'astronomy_riseset_civilevening'),
        sunRise.civilEvening.isNaN
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatHoursToHHmmss(sunRise.civilEvening)
      ],
      [
        i18n(context, 'astronomy_riseset_nauticalevening'),
        sunRise.nauticalEvening.isNaN
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatHoursToHHmmss(sunRise.nauticalEvening)
      ],
      [
        i18n(context, 'astronomy_riseset_astronomicalevening'),
        sunRise.astronomicalEvening.isNaN
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatHoursToHHmmss(sunRise.astronomicalEvening)
      ],
    ];

    var rows = columnedMultiLineOutput(context, outputs);

    rows.insert(0, GCWTextDivider(text: i18n(context, 'common_output')));

    return Column(children: rows);
  }
}
