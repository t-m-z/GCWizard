import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/gcw_mapview.dart';
import 'package:gc_wizard/tools/coords/rescue_points/logic/rescue_points_map.dart';

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
          max: 3000,
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
              _getRescuePointsAsync();
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
        point.point.latitude.toString().padRight(10, '0').substring(0, 10) + '\n' +
        point.point.longitude.toString().padRight(10, '0').substring(0, 10),
      ]);
    }
    return result;
  }

  List<GCWMapPoint> _normalizedMapPoints(List<GCWMapPoint> points) {
    List<GCWMapPoint> result = [];
    for (GCWMapPoint point in points) {
      result.add(
          GCWMapPoint(point: point.point,
              markerText: point.markerText?.split('\n')[0],
              color: point.color,
              isEditable: point.isEditable));
    }
    return result;
  }

  Widget _buildOutput() {
    return GCWDefaultOutput(
        child: Column(children: [
      GCWColumnedMultilineOutput(
        data: _pointsToList(),
        flexValues: [8, 3],
      ),
      GCWButton(
        text: i18n(context, 'coords_show_on_map'),
        onPressed: () {
          openInMap(context, _normalizedMapPoints(points), isCommonMap: true);
        },
      ),
    ]));
  }

  void _getRescuePointsAsync() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: GCW_ASYNC_EXECUTER_INDICATOR_HEIGHT,
            width: GCW_ASYNC_EXECUTER_INDICATOR_WIDTH,
            child: GCWAsyncExecuter<List<GCWMapPoint>>(
              isolatedFunction: getRescuePointsAsync,
              parameter: _buildRescuePointsJobData,
              onReady: (data) => _showRescuePointsOutput(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters?> _buildRescuePointsJobData() async {
    return GCWAsyncExecuterParameters(RescuePointJobData(
        jobDataCenter: _currentCoords,
        jobDataRadius: _currentRange,
        jobDataFilename: _ASSET_PATH,
    ));
  }

  void _showRescuePointsOutput(List<GCWMapPoint> output) {

    points = output;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      showSnackBar(i18n(context, 'rescue_points_message'), context);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

}
