import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/countries.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class Countries extends StatefulWidget {
  final List<String> fields;

  Countries({Key key, this.fields}) : super(key: key);

  @override
  CountriesState createState() => CountriesState();
}

class CountriesState extends State<Countries> {
  var _currentSwitchSort = GCWSwitchPosition.left;
  var _currentSort = 0;
  List<String> _currentSortList;

  @override
  void initState() {
    super.initState();

    _currentSortList = ['common_countries'];
    _currentSortList.addAll(widget.fields.map((e) => 'countries_${e}_sort'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (widget.fields.length == 1)
          GCWTwoOptionsSwitch(
            value: _currentSwitchSort,
            title: i18n(context, 'common_sortby'),
            leftValue: i18n(context, _currentSortList[0]),
            rightValue: i18n(context, _currentSortList[1]),
            onChanged: (value) {
              setState(() {
                _currentSwitchSort = value;
                _currentSort = value == GCWSwitchPosition.left ? 0 : 1;
              });
            },
          ),
        if (widget.fields.length > 1)
          GCWDropDownButton(
            title: i18n(context, 'common_sortby'),
            value: _currentSort,
            onChanged: (value) {
              setState(() {
                _currentSort = value;
              });
            },
            items: _currentSortList
                .asMap()
                .map((index, field) {
                  return MapEntry(index, GCWDropDownMenuItem(value: index, child: i18n(context, field)));
                })
                .values
                .toList(),
          ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    var output;

    var field = _currentSort == 0 ? widget.fields[0] : widget.fields[_currentSort - 1];
    var flexValues = List<int>.generate(widget.fields.length, (index) => 1);

    var data = COUNTRIES.values.where((e) => e[field] != null && e[field].length > 0).map((e) {
      if (_currentSort == 0) {
        var dataList = [i18n(context, e['name'])];
        dataList.addAll(widget.fields.map((field) => e[field]));

        return dataList;
      } else {
        var dataList = [e[field], i18n(context, e['name'])];
        dataList.addAll(widget.fields.where((f) => f != field).map((f) => e[f]));

        return dataList;
      }
    }).toList();

    if (_currentSort == 0) {
      flexValues.insert(0, widget.fields.length + 1);
    } else {
      flexValues.insert(1, widget.fields.length + 1);
    }

    data.sort((a, b) {
      var result = a[0].compareTo(b[0]);
      if (result != 0) return result;

      return a[1].compareTo(b[1]);
    });

    output = columnedMultiLineOutput(context, data, flexValues: flexValues, copyColumn: 1);

    return Column(
      children: output,
    );
  }
}
