import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_export_dialog.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_mapview.dart';
import 'package:latlong2/latlong.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/tools/images_and_files/adventure_labs.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';

class AdventureLabs extends StatefulWidget {
  @override
  AdventureLabsState createState() => AdventureLabsState();
}

class AdventureLabsState extends State<AdventureLabs> {
  var _currentCoords = defaultCoordinate;
  var _currentCoordsFormat = defaultCoordFormat();
  var _currentRadius = 1000;
  List<AdventureData> _adventureList = [];
  var _currentAdventure = 0;
  var _currentAdventureList = [];

  Map<String, dynamic> _outData;

  List<String> _currentOutput = <String>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'adventure_labs_start'),
          coordsFormat: _currentCoordsFormat,
          showMap: true,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'adventure_labs_radius'),
        ),
        GCWIntegerSpinner(
          min: 0,
          max: 9999,
          value: _currentRadius,
          onChanged: (value) {
            setState(() {
              _currentRadius = value;
            });
          },        ),
        GCWButton(
          text: i18n(context, 'adventure_labs_search'),
          onPressed: () {
            setState(() {
              _getAdventureDataAsync();
            });
          },
        ),
        GCWDefaultOutput(),
        _buildOutput(),
      ],
    );
  }

  _getAdventureDataAsync() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            child: GCWAsyncExecuter(
              isolatedFunction: getAdventureDataAsync,
              parameter: _buildJobData(),
              onReady: (data) => _showAdventuresOutput(data),
              isOverlay: true,
            ),
            height: 220,
            width: 150,
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters> _buildJobData() async {
    return GCWAsyncExecuterParameters(
        {'coordinate': _currentCoords,
         'radius': _currentRadius}
        );
  }

  _showAdventuresOutput(Map<String, dynamic> output) {
    _outData = output;

    if (_outData == null) {
      showToast(
          i18n(context, 'common_loadfile_exception_notloaded'),
          duration: 30);
    } else {
      _adventureList = _outData['adventures'].AdventureList;
      _currentAdventureList.clear();
      _adventureList.forEach((element) {
        _currentAdventureList.add(element.Title);
      });
    } // outData != null

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  List<List<dynamic>> _outputAdventureData(AdventureData adventure){
    List<List<dynamic>> result = [
      [i18n(context, 'adventure_labs_lab_id'), adventure.Id],
      [i18n(context, 'adventure_labs_lab_keyImageUrl'), adventure.KeyImageUrl],
      [i18n(context, 'adventure_labs_lab_deeplink'), adventure.DeepLink],
      [i18n(context, 'adventure_labs_lab_description'), adventure.Description],
      [i18n(context, 'adventure_labs_lab_ownerusername'), adventure.OwnerUsername],
      [i18n(context, 'adventure_labs_lab_ratingsaverage'), adventure.RatingsAverage],
      [i18n(context, 'adventure_labs_lab_ratingstotalcount'), adventure.RatingsTotalCount],
      [i18n(context, 'adventure_labs_lab_location'),
        formatCoordOutput(
          LatLng(double.parse(adventure.Latitude), double.parse(adventure.Longitude)),
          {'format': Prefs.get('coord_default_format')},
          defaultEllipsoid())
      ],
      [i18n(context, 'adventure_labs_lab_adventurethemes'), adventure.AdventureThemes],
    ];

    return result;
  }

  List<List<dynamic>> _outputAdventureStageData(AdventureStages stage){
    List<List<dynamic>> result = [
      [i18n(context, 'adventure_labs_lab_id'), stage.Id],
      [i18n(context, 'adventure_labs_lab_description'), stage.Description],
      [i18n(context, 'adventure_labs_lab_location'),
        formatCoordOutput(
            LatLng(double.parse(stage.Latitude), double.parse(stage.Longitude)),
            {'format': Prefs.get('coord_default_format')},
            defaultEllipsoid())
      ],
      [i18n(context, 'adventure_labs_lab_stages_question'), stage.Question],
      [i18n(context, 'adventure_labs_lab_stages_completionawardmessage'), stage.CompletionAwardMessage],
      [i18n(context, 'adventure_labs_lab_stages_awardimageurl'), stage.AwardImageUrl],
      [i18n(context, 'adventure_labs_lab_stages_awardvideoyoutubeid'), stage.AwardVideoYouTubeId],
      [i18n(context, 'adventure_labs_lab_stages_geofencingradius'), stage.GeofencingRadius],
      [i18n(context, 'adventure_labs_lab_stages_completioncode'), stage.CompletionCode],
      [i18n(context, 'adventure_labs_lab_stages_multichoiceoptions'), stage.MultiChoiceOptions],
      [i18n(context, 'adventure_labs_lab_stages_keyimage'), stage.KeyImage],
      [i18n(context, 'adventure_labs_lab_keyImageUrl'), stage.KeyImageUrl],
    ];
    return result;
  }

  Widget _buildOutputAdventureStages(List<AdventureStages> stages){
    List<Widget> result = [];
    result.add(
        GCWTextDivider(
          text: i18n(context, 'adventure_labs_lab_stages'),
        ));
    stages.forEach((stage) {
      result.add(
        GCWExpandableTextDivider(
          expanded: false,
          text: stage.Title,
          child: Column(
              children: columnedMultiLineOutput(
                  context, _outputAdventureStageData(stage),
                  flexValues: [1, 3]),),
        ),
      );
    });
    return Column(
      children: result,
    );
  }

  _openInMap(List<GCWMapPoint> points) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GCWTool(
                tool: GCWMapView(
                  points: List<GCWMapPoint>.from(points),
                  isEditable: false, // false: open in Map
                  // true:  open in FreeMap
                ),
                i18nPrefix: 'coords_map_view',
                autoScroll: false,
                suppressToolMargin: true)));
  }

  List<GCWMapPoint> _getPoints(AdventureData adventure){
    List<GCWMapPoint> result = [];
    result.add(
        GCWMapPoint(
            uuid: 'OriginalPoint',
            markerText: adventure.Title,
            point: LatLng(double.parse(adventure.Latitude), double.parse(adventure.Longitude)),
            color: Colors.red)
    );
    adventure.Stages.forEach((stage) {
      result.add(
          GCWMapPoint(
              uuid: 'StagePoint',
              markerText: stage.Title,
              point: LatLng(double.parse(stage.Latitude), double.parse(stage.Longitude)),
              color: Colors.black)
      );
    });

    return result;
  }

  Future<bool> _exportCoordinates(BuildContext context, List<GCWMapPoint> points) async {
    showCoordinatesExportDialog(context, points, []);
  }

  Widget _buildOutputAdventureMain(AdventureData adventure){
    List<Widget> result = [];
    result.add(
        GCWTextDivider(
          text: i18n(context, 'adventure_labs_lab_location'),
          trailing: Row(children: <Widget>[
            GCWIconButton(
              icon: Icons.my_location,
              size: IconButtonSize.SMALL,
              iconColor: themeColors().mainFont(),
              onPressed: () {
                _openInMap(_getPoints(adventure));
              },
            ),
            GCWIconButton(
              icon: Icons.save,
              size: IconButtonSize.SMALL,
              iconColor: themeColors().mainFont(),
              onPressed: () {
                _exportCoordinates(context, _getPoints(adventure));
              },
            ),          ]),
        ));
    result.add(
      GCWExpandableTextDivider(
        expanded: false,
        text: i18n(context, 'adventure_labs_lab'),
        child: Column(
          children: columnedMultiLineOutput(
              context, _outputAdventureData(adventure),
              flexValues: [1, 3]),),
      ),
    );

    return Column(
      children:
        result,
    );
  }

  _buildOutput(){
    return Column(
      children: [
        if (_currentAdventureList.isNotEmpty)
          Column(
            children: <Widget>[
              GCWDropDownSpinner(
                index: _currentAdventure,
                items: _currentAdventureList.map((item) => Text(item.toString(), style: gcwTextStyle())).toList(),
                onChanged: (value) {
                  setState(() {
                    _currentAdventure = value;
                  });
                },
              ),
              _buildOutputAdventureMain(_adventureList[_currentAdventure]),
              _buildOutputAdventureStages(_adventureList[_currentAdventure].Stages),
            ]
          )
        else
          Container()
      ],
    );
  }
}
