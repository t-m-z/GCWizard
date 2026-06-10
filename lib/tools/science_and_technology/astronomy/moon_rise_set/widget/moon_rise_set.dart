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

class MoonRiseSet extends StatefulWidget {
  const MoonRiseSet({super.key});

  @override
  _MoonRiseSetState createState() => _MoonRiseSetState();
}

class _MoonRiseSetState extends State<MoonRiseSet> {
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
    var moonRise = astronomy.moonRiseSetUTC(_currentCoords.toLatLng() ?? defaultCoordinate, _currentDateTimeUTCWithTZ.dateTimeUtc);

    var outputs = [
      [
        i18n(context, 'astronomy_riseset_moonrise'),
        moonRise.rise == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatTimeUTCWithTZ(context, moonRise.rise!, _currentDateTimeUTCWithTZ.timezoneOffset)
      ],
      [
        i18n(context, 'astronomy_riseset_transit'),
        moonRise.culmination == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatTimeUTCWithTZ(context, moonRise.culmination!, _currentDateTimeUTCWithTZ.timezoneOffset)
      ],
      [
        i18n(context, 'astronomy_riseset_moonset'),
        moonRise.set == null
            ? i18n(context, 'astronomy_riseset_notavailable')
            : formatTimeUTCWithTZ(context, moonRise.set!, _currentDateTimeUTCWithTZ.timezoneOffset)
      ],
    ];

    return GCWColumnedMultilineOutput(firstRows: [GCWTextDivider(text: i18n(context, 'common_output'))], data: outputs);
  }
}
