import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_dropdown.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_input.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/utci/logic/utci.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/humidity.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/temperature.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_category.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/velocity.dart';

class UTCI extends StatefulWidget {
  const UTCI({Key? key}) : super(key: key);

  @override
  UTCIState createState() => UTCIState();
}

class UTCIState extends State<UTCI> {
  double _currentTemperature = 0.0;
  double _currentHumidity = 0.0;
  double _currentWindSpeed = 0.5;

  Temperature _currentOutputUnit = TEMPERATURE_CELSIUS;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWUnitInput(
          value: _currentTemperature,
          title: i18n(context, 'common_measure_temperature'),
          initialUnit: TEMPERATURE_CELSIUS,
          min: 0.0,
          unitList: temperatures,
          onChanged: (value) {
            setState(() {
              _currentTemperature = TEMPERATURE_CELSIUS.fromKelvin(value);
            });
          },
        ),
        GCWUnitInput(
          value: _currentHumidity,
          title: i18n(context, 'common_measure_humidity'),
          initialUnit: HUMIDITY,
          min: 0.0,
          max: 100.0,
          unitList: humidity,
          onChanged: (value) {
            setState(() {
              _currentHumidity = value;
            });
          },
        ),
        GCWUnitInput(
          value: _currentWindSpeed,
          title: i18n(context, 'common_measure_windspeed'),
          initialUnit: VELOCITY_MS,
          min: 0.0,
          max: 100.0,
          unitList: velocities,
          onChanged: (value) {
            setState(() {
              _currentWindSpeed = value;
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'common_outputunit')),
        GCWUnitDropDown<Temperature>(
          value: _currentOutputUnit,
          onlyShowSymbols: false,
          unitList: temperatures,
          unitCategory: UNITCATEGORY_TEMPERATURE,
          onChanged: (Temperature value) {
            setState(() {
              _currentOutputUnit = value;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String unit = '';
    String hintUTCI = '';

    double output_c = calculateUTCI(_currentTemperature, _currentHumidity, _currentWindSpeed);
    double output = TEMPERATURE_CELSIUS.toKelvin(output_c);
    output = _currentOutputUnit.fromReference(output);

    unit = _currentOutputUnit.symbol;
    hintUTCI = _calculateHintUTCI(output_c);

    return Column(
      children: [
        GCWDefaultOutput(child: output.toStringAsFixed(2) + ' ' + unit, copyText: output.toString()),
        Row(
          children: [
            Container(
              width: 50,
              padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
              child: GCWIconButton(
                icon: Icons.wb_sunny,
                iconColor: _colorUTCI(output),
                backgroundColor: const Color(0xFF4d4d4d),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: GCWOutput(
                child: i18n(context, hintUTCI),
              ),
            )
          ],
        )
      ],
    );
  }

  String _calculateHintUTCI(double UTCI) {
    if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.BLUE_ACCENT]!) {
      if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.BLUE]!) {
        if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.LIGHT_BLUE]!) {
          if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.LIGHT_BLUE_ACCENT]!) {
            if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.GREEN]!) {
              if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.ORANGE]!) {
                if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.RED]!) {
                  if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.RED_ACCENT]!) {
                    if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.DARK_RED]!) {
                      return 'utci_index_dark_red';
                    } else {
                      return 'utci_index_red_accent';
                    }
                  } else {
                    return 'utci_index_red';
                  }
                } else {
                  return 'utci_index_orange';
                }
              } else {
                return 'utci_index_green';
              }
            } else {
              return 'utci_index_light_blue_accent';
            }
          } else {
            return 'utci_index_light_blue';
          }
        } else {
          return 'utci_index_blue';
        }
      } else {
        return 'utci_index_blue_accent';
      }
    } else {
      return 'utci_index_dark_blue';
    }
  }

  Color _colorUTCI(double UTCI) {
    if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.BLUE_ACCENT]!) {
      if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.BLUE]!) {
        if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.LIGHT_BLUE]!) {
          if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.LIGHT_BLUE_ACCENT]!) {
            if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.GREEN]!) {
              if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.ORANGE]!) {
                if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.RED]!) {
                  if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.RED_ACCENT]!) {
                    if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.DARK_RED]!) {
                      return Colors.red.shade900;
                    } else {
                      return Colors.red.shade600;
                    }
                  } else {
                    return Colors.red;
                  }
                } else {
                  return Colors.orange;
                }
              } else {
                return Colors.green;
              }
            } else {
              return Colors.lightBlue.shade200;
            }
          } else {
            return Colors.lightBlue.shade400;
          }
        } else {
          return Colors.blue;
        }
      } else {
        return Colors.blue.shade700;
      }
    } else {
      return Colors.blue.shade900;
    }
  }
}
