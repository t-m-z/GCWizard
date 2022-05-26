import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/images_and_files/adventure_labs.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

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
        GCWSubmitButton(
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
    print('_showAdventuresOutput');
    _outData = output;

    if (_outData == null) {
      showToast(
          i18n(context, 'common_loadfile_exception_notloaded'),
          duration: 30);
    } else {
      _adventureList = _outData['adventures'].AdventureList;
      _adventureList.forEach((element) {
        print(element);
        _currentAdventureList.add(element.Title);
      });
      print(_currentAdventureList);
    } // outData != null

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  _buildOutput(){
    return Column(
      children: [
        GCWDropDownSpinner(
          index: _currentAdventure,
          items: _currentAdventureList,
          onChanged: (value) {
            setState(() {
              _currentAdventure = value;
            });
          },
        )
      ],
    );
  }
}
