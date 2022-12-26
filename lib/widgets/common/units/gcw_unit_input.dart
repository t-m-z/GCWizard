import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/common/units/unit.dart';
import 'package:gc_wizard/logic/common/units/unit_category.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';

class GCWUnitInput extends StatefulWidget {
  final min;
  final max;
  final numberDecimalDigits;
  final double value;
  final List<Unit> unitList;
  final UnitCategory unitCategory;
  final title;
  final Unit initialUnit;
  final suppressOverflow;

  final Function onChanged;

  GCWUnitInput(
      {Key key,
      this.title,
      this.min,
      this.max,
      this.numberDecimalDigits: 5,
      this.value: 0.0,
      this.unitCategory,
      this.unitList,
      this.initialUnit,
      this.onChanged,
      this.suppressOverflow: false})
      : super(key: key);

  @override
  _GCWUnitInputState createState() => _GCWUnitInputState();
}

class _GCWUnitInputState extends State<GCWUnitInput> {
  var _currentUnit;
  var _currentValue;

  @override
  void initState() {
    super.initState();

    _currentValue = widget.value;
    _currentUnit = widget.initialUnit ?? getReferenceUnit(widget.unitList ?? widget.unitCategory.units);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
            child: GCWDoubleSpinner(
              title: widget.title,
              min: widget.min,
              max: widget.max,
              numberDecimalDigits: widget.numberDecimalDigits,
              value: _currentValue,
              suppressOverflow: widget.suppressOverflow,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                  _convertToReferenceAndEmitOnChange();
                });
              },
            ),
            padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
          ),
          flex: 3),
      Expanded(
          child: GCWUnitDropDownButton(
            value: _currentUnit,
            unitList: widget.unitList ?? widget.unitCategory.units,
            onChanged: (value) {
              setState(() {
                _currentUnit = value;
                _convertToReferenceAndEmitOnChange();
              });
            },
          ),
          flex: 1)
    ]);
  }

  _convertToReferenceAndEmitOnChange() {
    var referenceValue = _currentUnit.toReference(_currentValue);
    widget.onChanged(referenceValue);
  }
}
