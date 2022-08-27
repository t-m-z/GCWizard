import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/angle.dart';
import 'package:gc_wizard/logic/common/units/area.dart';
import 'package:gc_wizard/logic/common/units/density.dart';
import 'package:gc_wizard/logic/common/units/energy.dart';
import 'package:gc_wizard/logic/common/units/force.dart';
import 'package:gc_wizard/logic/common/units/length.dart';
import 'package:gc_wizard/logic/common/units/mass.dart';
import 'package:gc_wizard/logic/common/units/power.dart';
import 'package:gc_wizard/logic/common/units/pressure.dart';
import 'package:gc_wizard/logic/common/units/temperature.dart';
import 'package:gc_wizard/logic/common/units/time.dart';
import 'package:gc_wizard/logic/common/units/typography.dart';
import 'package:gc_wizard/logic/common/units/unit.dart';
import 'package:gc_wizard/logic/common/units/unit_category.dart';
import 'package:gc_wizard/logic/common/units/unit_prefix.dart';
import 'package:gc_wizard/logic/common/units/velocity.dart';
import 'package:gc_wizard/logic/common/units/volume.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/units/gcw_units.dart';
import 'package:intl/intl.dart';

final List<Map<String, dynamic>> _categories = [
  {'category': UNITCATEGORY_ANGLE, 'default_from_unit': ANGLE_DEGREE, 'default_to_unit': ANGLE_RADIAN},
  {'category': UNITCATEGORY_AREA, 'default_from_unit': AREA_SQUAREMETER, 'default_to_unit': AREA_SQUAREKILOMETER},
  {
    'category': UNITCATEGORY_DENSITY,
    'default_from_unit': DENSITY_KILOGRAMPERCUBICMETER,
    'default_to_unit': DENSITY_GRAMPERLITER
  },
  {'category': UNITCATEGORY_ENERGY, 'default_from_unit': ENERGY_JOULE, 'default_to_unit': ENERGY_CALORIE},
  {'category': UNITCATEGORY_FORCE, 'default_from_unit': FORCE_POUND, 'default_to_unit': FORCE_NEWTON},
  {'category': UNITCATEGORY_LENGTH, 'default_from_unit': LENGTH_FOOT, 'default_to_unit': LENGTH_METER},
  {'category': UNITCATEGORY_MASS, 'default_from_unit': MASS_POUND, 'default_to_unit': MASS_GRAM},
  {'category': UNITCATEGORY_POWER, 'default_from_unit': POWER_WATT, 'default_to_unit': POWER_METRICHORSEPOWER},
  {'category': UNITCATEGORY_PRESSURE, 'default_from_unit': PRESSURE_PASCAL, 'default_to_unit': PRESSURE_BAR},
  {
    'category': UNITCATEGORY_TEMPERATURE,
    'default_from_unit': TEMPERATURE_CELSIUS,
    'default_to_unit': TEMPERATURE_FAHRENHEIT
  },
  {'category': UNITCATEGORY_TIME, 'default_from_unit': TIME_HOUR, 'default_to_unit': TIME_MINUTE},
  {
    'category': UNITCATEGORY_TYPOGRAPHY,
    'default_from_unit': TYPOGRAPHY_DTPPOINT,
    'default_to_unit': TYPOGRAPHY_CENTIMETER
  },
  {'category': UNITCATEGORY_VELOCITY, 'default_from_unit': VELOCITY_KMH, 'default_to_unit': VELOCITY_MS},
  {'category': UNITCATEGORY_VOLUME, 'default_from_unit': VOLUME_CUBICMETER, 'default_to_unit': VOLUME_LITER},
];

class UnitConverter extends StatefulWidget {
  @override
  UnitConverterState createState() => UnitConverterState();
}

class UnitConverterState extends State<UnitConverter> {
  var _currentValue = 1.0;
  Map<String, dynamic> _currentFromUnit;
  Map<String, dynamic> _currentToUnit;

  var _currentCategory;

  @override
  void initState() {
    super.initState();

    _currentCategory = _categories.firstWhere((category) => category['category'].key == UNITCATEGORY_LENGTH.key);
    _currentFromUnit = {'unit': _currentCategory['default_from_unit'], 'prefix': UNITPREFIX_NONE};
    _currentToUnit = {'unit': _currentCategory['default_to_unit'], 'prefix': UNITPREFIX_NONE};
  }

  @override
  Widget build(BuildContext context) {
    _categories.sort((a, b) {
      return i18n(context, a['category'].key).compareTo(i18n(context, b['category'].key));
    });

    return Column(
      children: <Widget>[
        GCWDoubleSpinner(
            value: _currentValue,
            numberDecimalDigits: 5,
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
            }),
        GCWTextDivider(
          text: i18n(context, 'unitconverter_unit'),
        ),
        GCWDropDownButton(
          value: _currentCategory,
          items: _categories.map((category) {
            return GCWDropDownMenuItem(value: category, child: i18n(context, category['category'].key));
          }).toList(),
          onChanged: (value) {
            setState(() {
              if (value['category'].key != _currentCategory['category'].key) {
                _currentCategory = value;

                _currentFromUnit = {'unit': _currentCategory['default_from_unit'], 'prefix': UNITPREFIX_NONE};
                _currentToUnit = {'unit': _currentCategory['default_to_unit'], 'prefix': UNITPREFIX_NONE};
              }
            });
          },
        ),
        Row(
          children: [
            Expanded(child: GCWText(text: i18n(context, 'unitconverter_from')), flex: 1),
            Expanded(
                child: GCWUnits(
                  value: _currentFromUnit,
                  unitCategory: _currentCategory['category'],
                  onChanged: (value) {
                    setState(() {
                      _currentFromUnit = value;
                    });
                  },
                ),
                flex: 4)
          ],
        ),
        Row(
          children: [
            Expanded(child: GCWText(text: i18n(context, 'unitconverter_to')), flex: 1),
            Expanded(
                child: GCWUnits(
                  value: _currentToUnit,
                  unitCategory: _currentCategory['category'],
                  onChanged: (value) {
                    setState(() {
                      _currentToUnit = value;
                    });
                  },
                ),
                flex: 4)
          ],
        ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    var fromPrefix = _currentFromUnit['prefix'].value;
    var fromUnit = _currentFromUnit['unit'];
    var toPrefix = _currentToUnit['prefix'].value;
    var toUnit = _currentToUnit['unit'];

    return NumberFormat('0.' + '#' * 8).format(convert(_currentValue * fromPrefix, fromUnit, toUnit) / toPrefix);
  }
}
