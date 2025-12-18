import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/gcw_mapview.dart';

class RescuePointsMapView extends StatefulWidget {
  RescuePointsMapView({super.key}) : super();

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<RescuePointsMapView> {
  var points = <GCWMapPoint>[];
  var polyGeodetics = <GCWMapPolyline>[];
  var isEditable = false;

  @override
  Widget build(BuildContext context) {

    return GCWMapView(
      points: points,
      polylines: polyGeodetics,
      isEditable: isEditable,
    );
  }
}
