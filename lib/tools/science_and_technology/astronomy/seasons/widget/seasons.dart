import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/external_libs/cosinekitty.astronomy/astronomy.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/widget/astronomy_i18n.dart';
import 'package:intl/intl.dart';

class Seasons extends StatefulWidget {
  const Seasons({super.key});

  @override
  _SeasonsState createState() => _SeasonsState();
}

class _SeasonsState extends State<Seasons> {
  int _currentYear = DateTime.now().year;
  var _currentTimeZoneOffset = DateTime.now().timeZoneOffset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'common_year'),
        ),
        GCWIntegerSpinner(
          value: _currentYear,
          min: -1000,
          max: 3000,
          onChanged: (value) {
            setState(() {
              _currentYear = value;
            });
          },
        ),
        GCWDateTimePicker(
          config: const {DateTimePickerConfig.TIMEZONES},
          onChanged: (datetime) {
            setState(() {
              _currentTimeZoneOffset = datetime.timezoneOffset;
            });
          }
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var seasons = SeasonsUTC(_currentYear);
    var spring = seasons.spring;
    var summer = seasons.summer;
    var fall = seasons.fall;
    var winter = seasons.winter;
    var aphelion = seasons.aphelion;
    var perihelion = seasons.perihelion;

    var outputs = [
      [
        i18n(context, 'astronomy_seasons_spring'),
        formatDateTimeUTCWithTZ(context, spring!, _currentTimeZoneOffset)
      ],
      [
        i18n(context, 'astronomy_seasons_summer'),
        formatDateTimeUTCWithTZ(context, summer!, _currentTimeZoneOffset)
      ],
      [
        i18n(context, 'astronomy_seasons_autumn'),
        formatDateTimeUTCWithTZ(context, fall!, _currentTimeZoneOffset)
      ],
      [
        i18n(context, 'astronomy_seasons_winter'),
        formatDateTimeUTCWithTZ(context, winter!, _currentTimeZoneOffset)
      ],
      [
        i18n(context, 'astronomy_seasons_perihelion'),
        formatDateTimeUTCWithTZ(context, perihelion.date, _currentTimeZoneOffset) +
            '\n\n' +
            i18n(context, 'astronomy_seasons_distance') +
            ' =\n' +
            NumberFormat('0.0000000').format(perihelion.distanceKm) +
            ' km\n=\n' +
            NumberFormat('0.0000000').format(perihelion.distanceAu) +
            ' AU'
      ],
      [
        i18n(context, 'astronomy_seasons_aphelion'),
        formatDateTimeUTCWithTZ(context, aphelion.date, _currentTimeZoneOffset) +
            '\n\n' +
            i18n(context, 'astronomy_seasons_distance') +
            ' =\n' +
            NumberFormat('0.0000000').format(aphelion.distanceKm) +
            ' km\n=\n' +
            NumberFormat('0.0000000').format(aphelion.distanceAu) +
            ' AU'
      ],
    ];

    return GCWColumnedMultilineOutput(
        firstRows: [GCWTextDivider(text: i18n(context, 'common_output'))], data: outputs, flexValues: const [1, 2]);
  }
}
