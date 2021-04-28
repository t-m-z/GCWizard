import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:prefs/prefs.dart';

class FormatConverter extends StatefulWidget {
  @override
  FormatConverterState createState() => FormatConverterState();
}

class FormatConverterState extends State<FormatConverter> {
  var _currentCoords = defaultCoordinate;
  var _currentCoordsFormat = defaultCoordFormat();
  bool _APIKeymissing = false;
  bool _W3W = false;

  Map<String, String> _currentOutputFormat = {'format': keyCoordsDEC};
  List<String> _currentOutput = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _APIKey = Prefs.getString('coord_default_w3w_apikey');
    if (_APIKey == null || _APIKey == '')
      _APIKeymissing = true;
    else
      _APIKeymissing = false;
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'coords_formatconverter_coord'),
          coordsFormat: _currentCoordsFormat,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];
            });
          },
        ),
        GCWCoordsOutputFormat(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentOutputFormat = value;
              _W3W = (value['format'] == 'coords_what3words');
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
        (_APIKeymissing && _W3W)
            ? GCWOutput(
                title: i18n(context, 'coords_formatconverter_w3w_error'),
                child: i18n(context, 'coords_formatconverter_w3w_no_apikey'),
                suppressCopyButton: true)
            : GCWCoordsOutput(
                outputs: _currentOutput,
                points: [
                  GCWMapPoint(point: _currentCoords, coordinateFormat: _currentOutputFormat),
                ],
              ),
      ],
    );
  }

  _calculateOutput(BuildContext context) {
    _currentOutput = [formatCoordOutput(_currentCoords, _currentOutputFormat, defaultEllipsoid())];
    print('widget '+_currentOutput.toString());
    _APIKeymissing = (_currentOutput.join('') == 'ERROR');
  }
}
