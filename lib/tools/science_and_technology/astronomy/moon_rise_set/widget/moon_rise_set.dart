import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/external_libs/cosinekitty.astronomy/astronomy.dart' as astronomy;
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/rise_set.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:intl/intl.dart';

class MoonRiseSet extends StatefulWidget {
  const MoonRiseSet({super.key});

  @override
  _MoonRiseSetState createState() => _MoonRiseSetState();
}

class _MoonRiseSetState extends State<MoonRiseSet> {
  var _currentDateTimeUTCWithTZ = DateTimeUTCwithTZ.nowDate();
  var _currentCoords = defaultBaseCoordinate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'common_location'),
          coordsFormat: _currentCoords.format,
          onChanged: (ret) {
            setState(() {
              if (ret != null) {
                _currentCoords = ret;
              }
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'astronomy_riseset_date'),
        ),
        GCWDateTimePicker(
          config: const {DateTimePickerConfig.DATE, DateTimePickerConfig.TIMEZONES},
          onChanged: (datetime) {
            setState(() {
              _currentDateTimeUTCWithTZ = datetime;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    var moonRiseCulSets = astronomy.moonRiseSetUTC(
      _currentCoords.toLatLng() ?? defaultCoordinate, 
      _currentDateTimeUTCWithTZ.dateTimeUtc
    );

    var riseSets = getRiseSetsAtDay(moonRiseCulSets, _currentDateTimeUTCWithTZ);

    var outputs = <List<String>>[];
    var currentDay = _currentDateTimeUTCWithTZ.toLocalTime();
    for (var riseSet in riseSets) {
      var dateTime = riseSet.$2;
      DateFormat hourFormat = DateFormat.jms(Localizations.localeOf(context).toString());
      var output = hourFormat.format(dateTime);
      if (dateTime.isBefore(currentDay) || dateTime.isAfter(currentDay.add(Duration(days: 1)))) {
        DateFormat dayFormat = DateFormat.yMd(Localizations.localeOf(context).toString());
        output = dayFormat.format(dateTime) + ' ' + output;
      }

      var label = '';
      switch (riseSet.$1) {
        case RiseSetType.RISE: label = 'astronomy_riseset_moonrise'; break;
        case RiseSetType.CULMINATION: label = 'astronomy_riseset_transit'; break;
        case RiseSetType.SET: label = 'astronomy_riseset_moonset'; break;
      }
      outputs.add([
        i18n(context, label),
        output
      ]);
    }

    return GCWColumnedMultilineOutput(firstRows: [GCWTextDivider(text: i18n(context, 'common_output'))], data: outputs);
  }
}
