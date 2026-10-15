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

class MoonPosition extends StatefulWidget {
  const MoonPosition({super.key});

  @override
  _MoonPositionState createState() => _MoonPositionState();
}

class _MoonPositionState extends State<MoonPosition> {
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
    var format = NumberFormat('0.00');

    var moonPosition = astronomy.MoonPosition(_currentCoords.toLatLng() ?? defaultCoordinate, _currentDateTimeUTCWithTZ.dateTimeUtc);

    var outputsMoon = [
      [i18n(context, 'astronomy_position_azimuth'), format.format(moonPosition.azimuthDeg) + '°'],
      [i18n(context, 'astronomy_position_altitude'), format.format(moonPosition.altitudeDeg) + '°'],
      [i18n(context, 'astronomy_position_eclipticlongitude'), format.format(moonPosition.eclipticLongitudeDeg) + '°'],
      [i18n(context, 'astronomy_position_eclipticlatitude'), format.format(moonPosition.eclipticLatitudeDeg) + '°'],
      [i18n(context, 'astronomy_position_rightascension'), formatHoursToHHmmss(moonPosition.rightAscensionDeg)],
      [i18n(context, 'astronomy_position_declination'), format.format(moonPosition.declinationDeg) + '°'],
      [i18n(context, 'astronomy_position_diameter'), format.format(moonPosition.apparentDiameterDeg) + '\''],
      [i18n(context, 'astronomy_position_distancetoearthcenter'), format.format(moonPosition.distanceCenterToEarthCenterKm) + ' km'],
      [i18n(context, 'astronomy_position_distancetoobserver'), format.format(moonPosition.distanceCenterToObserverKm) + ' km'],
      [i18n(context, 'astronomy_position_distancesurfacetoobserver'), format.format(moonPosition.distanceSurfaceToObserverKm) + ' km'],
      [i18n(context, 'astronomy_position_moonage'), format.format(moonPosition.age) + ' d'],
      [i18n(context, 'astronomy_position_illumination'), format.format(moonPosition.illuminationPercent) + '%'],
      [i18n(context, 'astronomy_position_moonphase_number'), '${moonPosition.phaseNumber}'],
      [i18n(context, 'astronomy_position_moonphase'), i18n(context, getMoonPhase(moonPosition.phaseName) ?? '')],
    ];

    var rowsData = GCWColumnedMultilineOutput(
        firstRows: [GCWTextDivider(text: i18n(context, 'common_output'))], data: outputsMoon);

    return Column(children: [rowsData]);
  }
}
