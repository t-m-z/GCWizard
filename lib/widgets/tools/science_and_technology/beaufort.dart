import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/unit_category.dart';
import 'package:gc_wizard/logic/common/units/velocity.dart' as logic;
import 'package:gc_wizard/logic/tools/science_and_technology/beaufort.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_input.dart';
import 'package:intl/intl.dart';

class Beaufort extends StatefulWidget {
  @override
  BeaufortState createState() => BeaufortState();
}

class BeaufortState extends State<Beaufort> {
  var _currentMode = GCWSwitchPosition.left;

  var _currentVelocity = 0.0;
  logic.Velocity _currentVelocityUnit = UNITCATEGORY_VELOCITY.defaultUnit;

  var _currentBeaufortInput = 0;
  logic.Velocity _currentOutputUnit = UNITCATEGORY_VELOCITY.defaultUnit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'beaufort_mode_left'),
          rightValue: i18n(context, 'beaufort_mode_right'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
            ? GCWUnitInput(
                unitCategory: UNITCATEGORY_VELOCITY,
                onChanged: (value) {
                  setState(() {
                    _currentVelocity = value;
                  });
                },
              )
            : Column(
                children: [
                  GCWIntegerSpinner(
                    min: 0,
                    max: 17,
                    value: _currentBeaufortInput,
                    onChanged: (value) {
                      setState(() {
                        _currentBeaufortInput = value;
                      });
                    },
                  ),
                  GCWTextDivider(text: i18n(context, 'common_outputunit')),
                  GCWUnitDropDownButton(
                    unitCategory: UNITCATEGORY_VELOCITY,
                    onChanged: (value) {
                      setState(() {
                        _currentOutputUnit = value;
                      });
                    },
                  )
                ],
              ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return meterPerSecondToBeaufort(_currentVelocity).toString();
    } else {
      var format = NumberFormat('0');
      if (_currentOutputUnit == logic.VELOCITY_MS) format = NumberFormat('0.0');

      var range = beaufortToMeterPerSecond(_currentBeaufortInput);
      var lower = _currentOutputUnit.fromMS(range[0]);

      var out = format.format(lower);

      var upper = range[1];
      if (upper.isInfinite) {
        return '\u2265 ' + out;
      } else {
        upper = _currentOutputUnit.fromMS(upper);
        return out + ' - ' + format.format(upper);
      }
    }
  }
}
