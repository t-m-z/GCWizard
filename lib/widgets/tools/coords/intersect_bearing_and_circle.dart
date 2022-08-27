import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/intersect_geodetic_and_circle.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_distance.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:latlong2/latlong.dart';

class IntersectGeodeticAndCircle extends StatefulWidget {
  @override
  IntersectBearingAndCircleState createState() => IntersectBearingAndCircleState();
}

class IntersectBearingAndCircleState extends State<IntersectGeodeticAndCircle> {
  var _currentIntersections = [];

  var _currentCoordsFormatStart = defaultCoordFormat();
  var _currentCoordsStart = defaultCoordinate;
  var _currentBearingStart = {'text': '', 'value': 0.0};

  var _currentCoordsFormatCircle = defaultCoordFormat();
  var _currentCoordsCircle = defaultCoordinate;
  var _currentRadiusCircle = 0.0;

  var _currentOutputFormat = defaultCoordFormat();
  List<String> _currentOutput = [];

  var _currentMapPoints = <GCWMapPoint>[];
  var _currentMapPolylines = <GCWMapPolyline>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, "coords_intersectbearingcircle_geodetic"),
          coordsFormat: _currentCoordsFormatStart,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormatStart = ret['coordsFormat'];
              _currentCoordsStart = ret['value'];
            });
          },
        ),
        GCWBearing(
          onChanged: (value) {
            setState(() {
              _currentBearingStart = value;
            });
          },
        ),
        GCWCoords(
          title: i18n(context, "coords_intersectbearingcircle_circle"),
          coordsFormat: _currentCoordsFormatCircle,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormatCircle = ret['coordsFormat'];
              _currentCoordsCircle = ret['value'];
            });
          },
        ),
        GCWDistance(
          hintText: i18n(context, "common_radius"),
          onChanged: (value) {
            setState(() {
              _currentRadiusCircle = value;
            });
          },
        ),
        GCWCoordsOutputFormat(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentOutputFormat = value;
            });
          },
        ),
        _buildSubmitButton(),
        GCWCoordsOutput(outputs: _currentOutput, points: _currentMapPoints, polylines: _currentMapPolylines),
      ],
    );
  }

  _getEndPoint() {
    var mapPoint = GCWMapPoint(
        point: projection(
            _currentCoordsStart,
            _currentBearingStart['value'],
            max<double>(distanceBearing(_currentCoordsStart, _currentCoordsCircle, defaultEllipsoid()).distance,
                    _currentRadiusCircle) *
                2.5,
            defaultEllipsoid()),
        isVisible: false);

    _currentMapPoints.add(mapPoint);

    return mapPoint;
  }

  Widget _buildSubmitButton() {
    return GCWSubmitButton(onPressed: () async {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              child: GCWAsyncExecuter(
                isolatedFunction: intersectGeodeticAndCircleAsync,
                parameter: _buildJobData(),
                onReady: (data) => _showOutput(data),
                isOverlay: true,
              ),
              height: 220,
              width: 150,
            ),
          );
        },
      );
    });
  }

  Future<GCWAsyncExecuterParameters> _buildJobData() async {
    return GCWAsyncExecuterParameters(IntersectGeodeticAndCircleJobData(
        startGeodetic: _currentCoordsStart,
        bearingGeodetic: _currentBearingStart['value'],
        centerPoint: _currentCoordsCircle,
        radiusCircle: _currentRadiusCircle,
        ells: defaultEllipsoid()));
  }

  _showOutput(List<LatLng> output) {
    if (output == null) {
      _currentIntersections = [];

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
      return;
    }

    _currentIntersections = output;

    _currentMapPoints = [
      GCWMapPoint(
          point: _currentCoordsStart,
          markerText: i18n(context, 'coords_intersectbearingcircle_geodetic'),
          coordinateFormat: _currentCoordsFormatStart),
      GCWMapPoint(
        point: _currentCoordsCircle,
        markerText: i18n(context, 'coords_intersectbearingcircle_circle'),
        coordinateFormat: _currentCoordsFormatCircle,
        circleColorSameAsPointColor: false,
        circle: GCWMapCircle(radius: _currentRadiusCircle),
      )
    ];

    if (_currentIntersections == null || _currentIntersections.isEmpty) {
      _currentOutput = [i18n(context, "coords_intersect_nointersection")];
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
      return;
    }

    _currentMapPoints.addAll(_currentIntersections
        .map((intersection) => GCWMapPoint(
            point: intersection,
            color: COLOR_MAP_CALCULATEDPOINT,
            markerText: i18n(context, 'coords_common_intersection'),
            coordinateFormat: _currentOutputFormat))
        .toList());

    _currentOutput = _currentIntersections
        .map((intersection) => formatCoordOutput(intersection, _currentOutputFormat, defaultEllipsoid()))
        .toList();

    _currentMapPolylines = [
      GCWMapPolyline(points: [_currentMapPoints[0], _getEndPoint()])
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }
}
