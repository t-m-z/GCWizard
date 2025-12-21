import 'dart:convert';
import 'dart:isolate';
import 'package:gc_wizard/application/theme/fixed_colors.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/distance_and_bearing/logic/distance_and_bearing.dart';
import 'package:latlong2/latlong.dart';
import 'package:xml/xml.dart';

class RescuePointJobData {
  final LatLng jobDataCenter;
  final int jobDataRadius;
  final String jobDataFilename;
  final int jobDataCount;


  RescuePointJobData({
    required this.jobDataCenter,
    required this.jobDataRadius,
    required this.jobDataFilename,
    required this.jobDataCount,
  });
}

Future<List<GCWMapPoint>> getRescuePointsAsync(
    GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! RescuePointJobData) return Future.value([]);

  var data = jobData!.parameters as RescuePointJobData;
  var output = await _getRescuePoints(
      data.jobDataCenter, data.jobDataRadius, data.jobDataFilename, data.jobDataCount,
      sendAsyncPort: jobData.sendAsyncPort);

  jobData.sendAsyncPort?.send(output);
  return Future.value(output);
}

Future<List<GCWMapPoint>> _getRescuePoints(
    LatLng center, int radius, String filename, int count,
    {SendPort? sendAsyncPort}) async {
  final bytes = await rootBundle.load(filename);

  var xmlDoc = XmlDocument.parse(utf8.decode(bytes.buffer.asUint8List()));
  int step = (count / 100).toInt();

  var parent = xmlDoc.getElement('gpx');
  if (parent != null) {
    var points = <GCWMapPoint>[];
    int index = 1;
    parent.findAllElements('wpt').forEach((xmlWpt) {
      var wpt = _readPoint(xmlWpt, center, radius);
      if (wpt != null) points.add(wpt);
      if (sendAsyncPort != null) {
        if (index % step == 0) {
          sendAsyncPort.send(index);
        }
      }
      index++;
    });
    return points;
  }
  return [];
}

bool _inRange(LatLng coord1, LatLng coord2, int distance) {
  return (distanceBearing(coord1, coord2, Ellipsoid.WGS84).distance <=
      distance);
}

GCWMapPoint? _readPoint(XmlElement xmlElement, LatLng center, int radius) {
  var lat = xmlElement.getAttribute('lat');
  var lon = xmlElement.getAttribute('lon');

  if (lat != null && lon != null) {
    if (_inRange(
        LatLng(double.parse(lat), double.parse(lon)), center, radius)) {
      var wpt = GCWMapPoint(
          point: LatLng(double.tryParse(lat) ?? 0, double.tryParse(lon) ?? 0),
          isEditable: true);
      var name = xmlElement.getElement('name')?.innerText ?? '';
      var desc = xmlElement.getElement('desc')?.innerText ?? '';
      var src = xmlElement.getElement('src')?.innerText ?? '';

      wpt.markerText = name + '\n' + desc + '\n' + src;
      wpt.color = COLOR_MAP_POINT;

      return wpt;
    }
  }
  return null;
}
