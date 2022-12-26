import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/humidity.dart';
import 'package:gc_wizard/logic/common/units/temperature.dart';
import 'package:gc_wizard/logic/common/units/unit.dart';
import 'package:gc_wizard/logic/common/units/unit_category.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/apparent_temperature/wet_bulb_temperature.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_input.dart';

class WetBulbTemperature extends StatefulWidget {
  @override
  WetBulbTemperatureState createState() => WetBulbTemperatureState();
}

class WetBulbTemperatureState extends State<WetBulbTemperature> {
  double _currentTemperature = 1.0;
  double _currentHumidity = 0.0;

  //Map<String, dynamic> _currentOutputUnit = {'unit': TEMPERATURE_CELSIUS, 'prefix': UNITPREFIX_NONE};
  Unit _currentOutputUnit = TEMPERATURE_CELSIUS;

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
        GCWTextDivider(text: i18n(context, 'common_outputunit')),
        GCWUnitDropDownButton(
          value: _currentOutputUnit,
          onlyShowSymbols: false,
          unitList: temperatures,
          unitCategory: UNITCATEGORY_TEMPERATURE,
          onChanged: (value) {
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
    String hintWBT = '';
    double WBT_C = 0.0;
    double WBT = 0.0;

    WBT_C = calculateWetBulbTemperature(_currentTemperature, _currentHumidity);
    hintWBT = _calculateHintWBT(WBT_C);

    WBT = TEMPERATURE_CELSIUS.toKelvin(WBT_C);
    WBT = _currentOutputUnit.fromReference(WBT);

    unit = _currentOutputUnit.symbol;

    return Column(
      children: [
        GCWDefaultOutput(child: WBT.toStringAsFixed(2) + ' ' + unit, copyText: WBT.toString()),
        Row(
          children: [
            Container(
                width: 50,
                child: GCWIconButton(
                    icon: Icons.wb_sunny, iconColor: _colorWBT(WBT_C), backgroundColor: Color(0xFF4d4d4d)),
                padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN)),
            Expanded(
              child: GCWOutput(
                child: i18n(context, hintWBT),
              ),
            )
          ],
        )
      ],
    );
  }

  String _calculateHintWBT(double WBT) {
    if (WBT > WBT_HEAT_STRESS[WBT_HEATSTRESS_CONDITION.PURPLE]) if (WBT >
        WBT_HEAT_STRESS[
            WBT_HEATSTRESS_CONDITION.BLUE]) if (WBT > WBT_HEAT_STRESS[WBT_HEATSTRESS_CONDITION.LIGHT_BLUE]) if (WBT >
        WBT_HEAT_STRESS[
            WBT_HEATSTRESS_CONDITION.GREEN]) if (WBT > WBT_HEAT_STRESS[WBT_HEATSTRESS_CONDITION.ORANGE]) if (WBT >
        WBT_HEAT_STRESS[WBT_HEATSTRESS_CONDITION.RED]) if (WBT > WBT_HEAT_STRESS[WBT_HEATSTRESS_CONDITION.RED])
      return 'wet_bulb_temperature_index_wbt_dark_red';
    else
      return 'wet_bulb_temperature_index_wbt_red';
    else
      return 'wet_bulb_temperature_index_wbt_orange';
    else
      return 'wet_bulb_temperature_index_wbt_green';
    else
      return 'wet_bulb_temperature_index_wbt_light_blue';
    else
      return 'wet_bulb_temperature_index_wbt_blue';
    else
      return 'wet_bulb_temperature_index_wbt_purple';
    else
      return 'wet_bulb_temperature_index_wbt_black';
  }

  Color _colorWBT(double WBT) {
    if (WBT > WBT_HEAT_STRESS[WBT_HEATSTRESS_CONDITION.PURPLE]) if (WBT >
        WBT_HEAT_STRESS[
            WBT_HEATSTRESS_CONDITION.BLUE]) if (WBT > WBT_HEAT_STRESS[WBT_HEATSTRESS_CONDITION.LIGHT_BLUE]) if (WBT >
        WBT_HEAT_STRESS[
            WBT_HEATSTRESS_CONDITION.GREEN]) if (WBT > WBT_HEAT_STRESS[WBT_HEATSTRESS_CONDITION.ORANGE]) if (WBT >
        WBT_HEAT_STRESS[WBT_HEATSTRESS_CONDITION.RED]) if (WBT > WBT_HEAT_STRESS[WBT_HEATSTRESS_CONDITION.DARK_RED])
      return Colors.red[900];
    else
      return Colors.red;
    else
      return Colors.orange;
    else
      return Colors.green;
    else
      return Colors.lightBlue[200];
    else
      return Colors.blue;
    else
      return Colors.purple;
    else
      return Colors.white;
  }
}
