import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_dropdown.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_input.dart';
import 'package:gc_wizard/tools/science_and_technology/beaufort/logic/beaufort.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_category.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/velocity.dart' as logic;
import 'package:intl/intl.dart';

class Beaufort extends StatefulWidget {
  const Beaufort({Key? key}) : super(key: key);

  @override
 _BeaufortState createState() => _BeaufortState();
}

class _BeaufortState extends State<Beaufort> {
  var _currentMode = GCWSwitchPosition.left;

  var _currentVelocity = 0.0;
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
                  GCWUnitDropDown<logic.Velocity>(
                    value: _currentOutputUnit,
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

  String? _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return meterPerSecondToBeaufort(_currentVelocity).toString();
    } else {
      var format = NumberFormat('0');
      if (_currentOutputUnit == logic.VELOCITY_MS) format = NumberFormat('0.0');

      var range = beaufortToMeterPerSecond(_currentBeaufortInput);
      if (range == null || range.length < 2) return null;
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
