import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/_common/logic/gpx_kml_gpx_import.dart';
import 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';
import 'package:gc_wizard/tools/coords/distance_and_bearing/logic/distance_and_bearing.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/map_view/persistence/model.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/gcw_mapview.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/color_utils.dart';
import 'package:latlong2/latlong.dart';

class RescuePointsMapView extends StatefulWidget {
  RescuePointsMapView({super.key}) : super();

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<RescuePointsMapView> {
  var points = <GCWMapPoint>[];
  var polyGeodetics = <GCWMapPolyline>[];
  var isEditable = true;

  var _currentCoords = defaultBaseCoordinate;
  int _currentRange = 1000;

  final String _ASSET_PATH =
      'lib/tools/coords/rescue_points/assets/GPX_KWF_RP.gpx';

  bool _inRange(LatLng coord1, LatLng coord2, int distance) {
    return (distanceBearing(coord1, coord2, Ellipsoid.WGS84).distance <=
        distance);
  }

  void _loadCoordinatesFile() async {
    // Read the Zip file from disk.
    final bytes = await DefaultAssetBundle.of(context).load(_ASSET_PATH);

    GCWFile file =
        GCWFile(name: _ASSET_PATH, bytes: bytes.buffer.asUint8List());

    await importCoordinatesFile(file).then((viewData) {
      if (viewData != null) {
        int i = 0;
        for (MapPointDAO point in viewData.points) {
          if (_inRange(LatLng(point.latitude, point.longitude),
              _currentCoords.toLatLng()!, _currentRange)) {
            points.add(GCWMapPoint(
                uuid: point.uuid,
                markerText: point.name,
                point: LatLng(point.latitude, point.longitude),
                coordinateFormat:
                    CoordinateFormat.fromPersistenceKey(point.coordinateFormat),
                isVisible: point.isVisible,
                color: hexStringToColor(point.color),
                circle: point.radius != null
                    ? GCWMapCircle(
                        centerPoint: LatLng(point.latitude, point.longitude),
                        radius: point.radius!,
                        color:
                            hexStringToColor(point.circleColor ?? point.color))
                    : null,
                circleColorSameAsPointColor: point.circleColorSameAsColor,
                isEditable: point.isEditable ?? false));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GCWCoords(
          title: i18n(context, 'coords_antipodes_coorda'),
          coordsFormat: _currentCoords.format,
          onChanged: (ret) {
            setState(() {
              if (ret != null) {
                _currentCoords = ret;
              }
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'common_radius'),
          min: 0,
          max: 2000,
          value: _currentRange,
          onChanged: (value) {
            setState(() {
              _currentRange = value;
            });
          },
        ),
        GCWSubmitButton(
          onPressed: () {
            setState(() {
              _loadCoordinatesFile();
            });
          },
        ),
        _buildOutput(),
      ],
    );
  }

  List<List<String>> _pointsToList() {
    List<List<String>> result = [];
    for (var point in points) {
      result.add([
        point.markerText.toString(),
        point.point.latitude.toString().padRight(10, '0').substring(0, 10),
        point.point.longitude.toString().padRight(10, '0').substring(0, 10),
      ]);
    }
    return result;
  }

  Widget _buildOutput() {
    return GCWDefaultOutput(
        child: Column(children: [
      GCWColumnedMultilineOutput(
        data: _pointsToList(),
        flexValues: [2, 3, 3],
      ),
      GCWButton(
        text: i18n(context, 'coords_show_on_map'),
        onPressed: () {
          openInMap(context, List<GCWMapPoint>.from(points), isCommonMap: true);
        },
      ),
    ]));
  }
}
