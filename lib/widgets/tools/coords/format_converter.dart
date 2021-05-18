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

class FormatConverter extends StatefulWidget {
  @override
  FormatConverterState createState() => FormatConverterState();
}

class FormatConverterState extends State<FormatConverter> {
<<<<<<< HEAD
  var _currentCoords = defaultCoordinate;
=======
  BaseCoordinates _currentCoords = DEC(defaultCoordinate.latitude, defaultCoordinate.longitude);

>>>>>>> 4b47786f48b4656027a8fb2552bbe93caca85bb9
  var _currentCoordsFormat = defaultCoordFormat();
  var _APIKeymissing = false;

  Map<String, String> _currentOutputFormat = {'format': keyCoordsDEC};
  List<String> _currentOutput = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              _calculateOutput(context);
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
<<<<<<< HEAD
        (_APIKeymissing)
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
=======
        GCWCoordsOutput(
          outputs: _currentOutput,
          points: [
            GCWMapPoint(point: _currentCoords.toLatLng(), coordinateFormat: _currentOutputFormat),
          ],
        ),
>>>>>>> 4b47786f48b4656027a8fb2552bbe93caca85bb9
      ],
    );
  }

  _calculateOutput(BuildContext context) {
<<<<<<< HEAD
    _currentOutput = [formatCoordOutput(_currentCoords, _currentOutputFormat, defaultEllipsoid())];
    _APIKeymissing = (_currentOutput == ['ERROR']);
=======
    _currentOutput = [formatCoordOutput(_currentCoords.toLatLng(), _currentOutputFormat, defaultEllipsoid())];
>>>>>>> 4b47786f48b4656027a8fb2552bbe93caca85bb9
  }
}
