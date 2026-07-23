import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/external_libs/cosinekitty.astronomy/astronomy.dart' as astronomy;
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/rise_set.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/widget/astronomy_i18n.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:intl/intl.dart';

class SunRiseSet extends StatefulWidget {
  const SunRiseSet({super.key});

  @override
  _SunRiseSetState createState() => _SunRiseSetState();
}

class _SunRiseSetState extends State<SunRiseSet> {
  var _currentDateTimeUTCWithTZ = DateTimeUTCwithTZ.now();
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
    var coords = _currentCoords.toLatLng() ?? defaultCoordinate;
    var sunRiseCulSetsUTC = astronomy.sunRiseSetUTC(coords, _currentDateTimeUTCWithTZ.dateTimeUtc);
    var riseSets = getRiseSetsAtDay(sunRiseCulSetsUTC, _currentDateTimeUTCWithTZ, strict: true);
    var twilights = astronomy.TwilightsUTC(coords, _currentDateTimeUTCWithTZ.dateTimeUtc);

    var rise = riseSets.firstWhereOrNull((e) => e.$1 == RiseSetType.RISE);
    var culmination = riseSets.firstWhereOrNull((e) => e.$1 == RiseSetType.CULMINATION);
    var set = riseSets.firstWhereOrNull((e) => e.$1 == RiseSetType.SET);

    var dateFormat = DateFormat.jms(Localizations.localeOf(context).toString());

    var outputs = [
      [
        i18n(context, 'astronomy_riseset_astronomicalmorning'),
        twilights.astronomicalMorning == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatTimeUTCWithTZ(context, twilights.astronomicalMorning!, _currentDateTimeUTCWithTZ.timezoneOffset)
      ],
      [
        i18n(context, 'astronomy_riseset_nauticalmorning'),
        twilights.nauticalMorning == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatTimeUTCWithTZ(context, twilights.nauticalMorning!, _currentDateTimeUTCWithTZ.timezoneOffset)
      ],
      [
        i18n(context, 'astronomy_riseset_civilmorning'),
        twilights.civilMorning == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatTimeUTCWithTZ(context, twilights.civilMorning!, _currentDateTimeUTCWithTZ.timezoneOffset)
      ],
      [
        i18n(context, 'astronomy_riseset_sunrise'),
        rise == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : dateFormat.format(rise.$2)
      ],
      [
        i18n(context, 'astronomy_riseset_transit'),
        culmination == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : dateFormat.format(culmination.$2)
      ],
      [
        i18n(context, 'astronomy_riseset_sunset'),
        set == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : dateFormat.format(set.$2)
      ],
      [
        i18n(context, 'astronomy_riseset_civilevening'),
        twilights.civilEvening == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatTimeUTCWithTZ(context, twilights.civilEvening!, _currentDateTimeUTCWithTZ.timezoneOffset)
      ],
      [
        i18n(context, 'astronomy_riseset_nauticalevening'),
        twilights.nauticalEvening == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatTimeUTCWithTZ(context, twilights.nauticalEvening!, _currentDateTimeUTCWithTZ.timezoneOffset)
      ],
      [
        i18n(context, 'astronomy_riseset_astronomicalevening'),
        twilights.astronomicalEvening == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatTimeUTCWithTZ(context, twilights.astronomicalEvening!, _currentDateTimeUTCWithTZ.timezoneOffset)
      ],
    ];

    return GCWColumnedMultilineOutput(firstRows: [GCWTextDivider(text: i18n(context, 'common_output'))], data: outputs);
  }
}
