import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/mass.dart';
import 'package:gc_wizard/logic/common/units/unit_category.dart';
import 'package:gc_wizard/logic/common/units/unit_prefix.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_input.dart';
import 'package:gc_wizard/widgets/common/units/gcw_units.dart';
import 'package:intl/intl.dart';

class Projectiles extends StatefulWidget {
  @override
  ProjectilesState createState() => ProjectilesState();
}

class ProjectilesState extends State<Projectiles> {
  UnitCategory _currentMode = UNITCATEGORY_ENERGY;

  Map<String, dynamic> _currentOutputUnit = {'unit': UNITCATEGORY_ENERGY.defaultUnit, 'prefix': UNITPREFIX_NONE};

  double _currentInputMass = 0.0;
  double _currentInputVelocity = 0.0;
  double _currentInputEnergy = 0.0;

  Map<UnitCategory, String> _calculateProjectilesModeItems;

  @override
  void initState() {
    super.initState();

    _calculateProjectilesModeItems = {
      UNITCATEGORY_ENERGY: 'projectiles_energy',
      UNITCATEGORY_MASS: 'projectiles_mass',
      UNITCATEGORY_VELOCITY: 'projectiles_velocity',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;

              if (_currentMode == UNITCATEGORY_ENERGY) {
                _currentOutputUnit = {'unit': UNITCATEGORY_ENERGY.defaultUnit};
              } else if (_currentMode == UNITCATEGORY_MASS) {
                _currentOutputUnit = {'unit': UNITCATEGORY_MASS.defaultUnit};
              } else if (_currentMode == UNITCATEGORY_VELOCITY) {
                _currentOutputUnit = {'unit': UNITCATEGORY_VELOCITY.defaultUnit};
              }

              _currentOutputUnit.putIfAbsent('prefix', () => UNITPREFIX_NONE);
            });
          },
          items: _calculateProjectilesModeItems.entries.map((mode) {
            return GCWDropDownMenuItem(value: mode.key, child: i18n(context, mode.value));
          }).toList(),
        ),
        _currentMode != UNITCATEGORY_MASS
            ? GCWUnitInput(
                value: _currentInputMass,
                title: i18n(context, 'projectiles_mass'),
                unitList: allMasses(),
                onChanged: (value) {
                  setState(() {
                    _currentInputMass = value;
                  });
                },
              )
            : Container(),
        _currentMode != UNITCATEGORY_ENERGY
            ? GCWUnitInput(
                value: _currentInputEnergy,
                title: i18n(context, 'projectiles_energy'),
                unitCategory: UNITCATEGORY_ENERGY,
                onChanged: (value) {
                  setState(() {
                    _currentInputEnergy = value;
                  });
                },
              )
            : Container(),
        _currentMode != UNITCATEGORY_VELOCITY
            ? GCWUnitInput(
                value: _currentInputVelocity,
                title: i18n(context, 'projectiles_velocity'),
                unitCategory: UNITCATEGORY_VELOCITY,
                onChanged: (value) {
                  setState(() {
                    _currentInputVelocity = value;
                  });
                },
              )
            : Container(),
        GCWTextDivider(text: i18n(context, 'common_outputunit')),
        GCWUnits(
          value: _currentOutputUnit,
          unitCategory: _currentMode,
          onlyShowPrefixSymbols: false,
          onChanged: (value) {
            setState(() {
              _currentOutputUnit = value;
            });
          },
        ),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  _calculateOutput() {
    double outputValue;

    if (_currentMode == UNITCATEGORY_ENERGY) {
      outputValue = calculateEnergy(_currentInputMass, _currentInputVelocity);
    } else if (_currentMode == UNITCATEGORY_MASS) {
      outputValue = calculateMass(_currentInputEnergy, _currentInputVelocity);
    } else if (_currentMode == UNITCATEGORY_VELOCITY) {
      outputValue = calculateVelocity(_currentInputEnergy, _currentInputMass);
    }

    if (outputValue == null) return '';

    outputValue = _currentOutputUnit['unit'].fromReference(outputValue) / _currentOutputUnit['prefix'].value;
    return NumberFormat('0.0' + '#' * 6).format(outputValue) +
        ' ' +
        (_currentOutputUnit['prefix'].symbol ?? '') +
        _currentOutputUnit['unit'].symbol;
  }
}
