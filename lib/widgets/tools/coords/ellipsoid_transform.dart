import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/ellipsoid_transform.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';

class EllipsoidTransform extends StatefulWidget {
  @override
  EllipsoidTransformState createState() => EllipsoidTransformState();
}

class EllipsoidTransformState extends State<EllipsoidTransform> {
  var _currentCoords = defaultCoordinate;
  var _currentCoordsFormat = defaultCoordFormat();

  var _currentOutputFormat = defaultCoordFormat();
  List<String> _currentOutput = [];

  var _currentFromDate = transformableDates[0];
  var _currentToDate = transformableDates[1];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'coords_ellipsoidtransform_coord'),
          coordsFormat: _currentCoordsFormat,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'coords_ellipsoidtransform_fromellipsoiddate'),
        ),
        GCWDropDownButton(
          value: _currentFromDate,
          onChanged: (newValue) {
            setState(() {
              _currentFromDate = newValue;
            });
          },
          items: transformableDates.map((date) {
            return GCWDropDownMenuItem(
              value: date,
              child: date['name'],
            );
          }).toList(),
        ),
        GCWTextDivider(
          text: i18n(context, 'coords_ellipsoidtransform_toellipsoiddate'),
        ),
        GCWDropDownButton(
          value: _currentToDate,
          onChanged: (newValue) {
            setState(() {
              _currentToDate = newValue;
            });
          },
          items: transformableDates.map((date) {
            return GCWDropDownMenuItem(
              value: date,
              child: date['name'],
            );
          }).toList(),
        ),
        GCWCoordsOutputFormat(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentOutputFormat = value;
            });
          },
        ),
        GCWSubmitButton(
          onPressed: () {
            setState(() {
              _calculateOutput(context);
            });
          },
        ),
        GCWCoordsOutput(
          outputs: _currentOutput,
          points: [
            GCWMapPoint(
              point: _currentCoords,
            ),
          ],
        ),
      ],
    );
  }

  _calculateOutput(BuildContext context) {
    var newCoords = _currentCoords;

    if (_currentFromDate['transformationIndex'] != null) {
      newCoords = ellipsoidTransformLatLng(newCoords, _currentFromDate['transformationIndex'], false, false);
    }

    if (_currentToDate['transformationIndex'] != null) {
      newCoords = ellipsoidTransformLatLng(newCoords, _currentToDate['transformationIndex'], true, false);
    }

    _currentOutput = [formatCoordOutput(newCoords, _currentOutputFormat, _currentToDate['ellipsoid'])];
  }
}
