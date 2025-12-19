import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/gpx_kml_gpx_import.dart';
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

  final String _ASSET_PATH =
      'lib/tools/coords/rescue_points/assets/GPX_KWF_RP.gpx';

  void _loadCoordinatesFile() async {
    // Read the Zip file from disk.
    final bytes = await DefaultAssetBundle.of(context).load(_ASSET_PATH);

    GCWFile file = GCWFile(
        name: _ASSET_PATH,
        bytes: bytes.buffer.asUint8List());

    await importCoordinatesFile(file).then((viewData) {
      if (viewData != null) {
        int i = 0;
        for (MapPointDAO point in viewData.points) {
          points.add(GCWMapPoint(
              uuid: point.uuid,
              markerText: point.name,
              point: LatLng(point.latitude, point.longitude),
              coordinateFormat: CoordinateFormat.fromPersistenceKey(point.coordinateFormat),
              isVisible: point.isVisible,
              color: hexStringToColor(point.color),
              circle: point.radius != null
                  ? GCWMapCircle(
                  centerPoint: LatLng(point.latitude, point.longitude),
                  radius: point.radius!,
                  color: hexStringToColor(point.circleColor ?? point.color))
                  : null,
              circleColorSameAsPointColor: point.circleColorSameAsColor,
              isEditable: point.isEditable ?? false));
        }
      }
      openInMap(
           context,
           points,
           mapPolylines: []
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadCoordinatesFile();
    return Container();
  }
}
