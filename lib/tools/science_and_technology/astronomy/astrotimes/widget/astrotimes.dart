import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/external_libs/cosinekitty.astronomy/astronomy.dart' as astronomy;
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/widget/astronomy_i18n.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/utils/datetime_utils.dart';
import 'package:intl/intl.dart';

class AstroTimes extends StatefulWidget {
  const AstroTimes({super.key});

  @override
  _AstroTimesState createState() => _AstroTimesState();
}

class _AstroTimesState extends State<AstroTimes> {
  var _currentDateTimeUTCWithTZ = DateTimeUTCwithTZ.nowTimestamp();
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
          text: i18n(context, 'astronomy_postion_datetime'),
        ),
        GCWDateTimePicker(
          config: const {DateTimePickerConfig.DATE, DateTimePickerConfig.TIME, DateTimePickerConfig.TIMEZONES},
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
    var format = NumberFormat('0.000000');
    var astrotimes = astronomy.AstroTime(_currentCoords.toLatLng() ?? defaultCoordinate, _currentDateTimeUTCWithTZ.dateTimeUtc);

    var outputsTimes = [
      [i18n(context, 'astronomy_astrotimestimes_utc') + ' (UTC)', formatDateTimeUTCWithTZ(context, _currentDateTimeUTCWithTZ.dateTimeUtc, Duration.zero)],
      [i18n(context, 'astronomy_astrotimes_universaltime') + ' (UT)', format.format(astrotimes.universalTime)],
      [i18n(context, 'astronomy_astrotimes_terrestrialtime') + ' (TT)', format.format(astrotimes.terrestrialTime)],
      [i18n(context, 'astronomy_astrotimes_gmst'), formatHoursToHHmmss(astrotimes.greenwichApparentSiderealTime)],
      [i18n(context, 'astronomy_astrotimes_lmst'), formatHoursToHHmmss(astrotimes.localApparentSiderealTime)],
      [i18n(context, 'astronomy_position_juliandate') + ' (UT)', format.format(astrotimes.julianDateUT)],
      [i18n(context, 'astronomy_position_juliandate') + ' (TT)', format.format(astrotimes.julianDateTT)],
      [i18n(context, 'DeltaT'), format.format(astrotimes.deltaT)],
      [i18n(context, 'astronomy_position_juliandate') + ' Reduced (RJD)', format.format(astrotimes.julianDateReduced)],
      [i18n(context, 'astronomy_position_juliandate') + ' Modified (MJD)', format.format(astrotimes.julianDateModified)],
      [i18n(context, 'astronomy_position_juliandate') + ' Truncated (TJD)', format.format(astrotimes.julianDateTruncated)],
      [i18n(context, 'astronomy_position_juliandate') + ' Dublin', format.format(astrotimes.julianDateDublin)],
      [i18n(context, 'astronomy_position_juliandate') + ' CNES', format.format(astrotimes.julianDateCNES)],
      [i18n(context, 'astronomy_position_juliandate') + ' CCSDS', format.format(astrotimes.julianDateCCSDS)],
      [i18n(context, 'astronomy_position_juliandate') + ' (JD2000)', format.format(astrotimes.julianDateJD2000)],
      [i18n(context, 'astronomy_position_juliandate') + ' Modified JD2000 (MJD2000)', format.format(astrotimes.julianDateModifiedJD2000)],
      [i18n(context, 'astronomy_astrotimes_juliancenturies'), format.format(astrotimes.julianCenturies)],
      [i18n(context, 'astronomy_astrotimes_julianmillennia'), format.format(astrotimes.julianMillennia)],
    ];

    var rowsData = GCWColumnedMultilineOutput(
        firstRows: [GCWTextDivider(text: i18n(context, 'common_output'))], data: outputsTimes);

    return Column(children: [rowsData]);
  }
}
