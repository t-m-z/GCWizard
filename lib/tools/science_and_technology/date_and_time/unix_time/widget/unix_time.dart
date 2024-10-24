import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/unix_time/logic/unix_time.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:intl/intl.dart';

class UnixTime extends StatefulWidget {
  const UnixTime({Key? key}) : super(key: key);

  @override
  _UnixTimeState createState() => _UnixTimeState();
}

class _UnixTimeState extends State<UnixTime> {
  int _currentTimeStamp = 0;
  var _currentDateTimeEncrypt = DateTimeTZ.now();
  var _currentDateTimeDecrypt = DateTimeTZ.now();
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
              if (_currentMode == GCWSwitchPosition.left) {
                _currentDateTimeEncrypt = DateTimeTZ.now();
              } else {
                _currentDateTimeDecrypt = DateTimeTZ.now();
              }
            });
          },
        ),
        (_currentMode == GCWSwitchPosition.right) ?
          Column(
            children: [
              GCWIntegerSpinner(
                  value: _currentTimeStamp,
                  min: 0,
                  onChanged: (value) {
                    setState(() {
                      _currentTimeStamp = value;
                    });
                  }),
              GCWDateTimePicker(
                datetime: _currentDateTimeDecrypt,
                config: const {
                  DateTimePickerConfig.TIMEZONES
                },
                onChanged: (datetime) {
                  setState(() {
                    _currentDateTimeDecrypt = datetime;
                  });
                },
              ),
            ],
          ) : GCWDateTimePicker(
            datetime: _currentDateTimeEncrypt,
            config: const {
              DateTimePickerConfig.DATE,
              DateTimePickerConfig.TIME,
              DateTimePickerConfig.SECOND_AS_INT,
              DateTimePickerConfig.TIMEZONES
            },
            onChanged: (datetime) {
              setState(() {
                _currentDateTimeEncrypt = datetime;
              });
            },
          ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    UnixTimeOutput output;
    if (_currentMode == GCWSwitchPosition.left) {
      //Date to Unix
      output = DateTimeToUnixTime(_currentDateTimeEncrypt.dateTimeUtc);
    } else {
      //UNIX to Date
      output = UnixTimeToDateTime(_currentTimeStamp);
    }
    return GCWDefaultOutput(
      child: output.Error.startsWith('dates_')
          ? i18n(context, output.Error)
          : _currentMode == GCWSwitchPosition.left
              ? output.UnixTimeStamp
              : _formatDate(context, DateTimeTZ(dateTimeUtc: output.GregorianDateTimeUTC, timezone: _currentDateTimeDecrypt.timezone).toLocalTime()),
    );
  }

  String _formatDate(BuildContext context, DateTime datetime) {
    String loc = Localizations.localeOf(context).toString();
    return DateFormat.yMd(loc).add_jms().format(datetime).toString();
  }
}
