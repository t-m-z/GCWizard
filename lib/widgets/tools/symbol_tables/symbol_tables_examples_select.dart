import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_symbol_matrix.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_tables_examples.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:prefs/prefs.dart';

const _LOGO_NAME = 'logo.png';
const _ALERT_COUNT_SELECTIONS = 50;

class SymbolTableExamplesSelect extends StatefulWidget {
  const SymbolTableExamplesSelect({Key key}) : super(key: key);

  @override
  SymbolTableExamplesSelectState createState() => SymbolTableExamplesSelectState();
}

class SymbolTableExamplesSelectState extends State<SymbolTableExamplesSelect> {
  List<Map<String, SymbolData>> images = [];
  List<String> selectedSymbolTables = [];

  @override
  void initState() {
    super.initState();

    _initializeImages();
  }

  String _pathKey() {
    return SYMBOLTABLES_ASSETPATH;
  }

  String _symbolKey(String path) {
    var regex = RegExp(SYMBOLTABLES_ASSETPATH + r'(.*)/' + _LOGO_NAME);

    var matches = regex.allMatches(path);
    return matches.first.group(1);
  }

  Future _initializeImages() async {
    //AssetManifest.json holds the information about all asset files
    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths =
        manifestMap.keys.where((String key) => key.contains(_pathKey()) && key.contains(_LOGO_NAME)).toList();

    if (imagePaths.isEmpty) return;

    for (String imagePath in imagePaths) {
      final data = await DefaultAssetBundle.of(context).load(imagePath);
      var key = _symbolKey(imagePath);

      images.add({
        key: SymbolData(
            path: imagePath, bytes: data.buffer.asUint8List(), displayName: i18n(context, 'symboltables_${key}_title'))
      });
    }

    images.sort((a, b) {
      return a.values.first.displayName.compareTo(b.values.first.displayName);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (images == null || images.isEmpty) return Container();

    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_PORTRAIT)
        : Prefs.get(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_LANDSCAPE);

    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'symboltablesexamples_selecttables'),
          suppressTopSpace: true,
        ),
        Row(
          children: [
            Expanded(
                child: GCWButton(
              text: i18n(context, 'symboltablesexamples_selectall'),
              margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
              onPressed: () {
                setState(() {
                  images.forEach((image) {
                    var data = image.values.first;
                    data.primarySelected = true;
                    selectedSymbolTables.add(_symbolKey(data.path));
                  });
                });
              },
            )),
            Container(width: DOUBLE_DEFAULT_MARGIN),
            Expanded(
                child: GCWButton(
              text: i18n(context, 'symboltablesexamples_deselectall'),
              margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
              onPressed: () {
                setState(() {
                  images.forEach((image) {
                    var data = image.values.first;
                    data.primarySelected = false;
                    selectedSymbolTables = <String>[];
                  });
                });
              },
            )),
          ],
        ),
        Expanded(
            child: GCWSymbolTableSymbolMatrix(
          imageData: images,
          countColumns: countColumns,
          mediaQueryData: mediaQueryData,
          onChanged: () => setState(() {}),
          selectable: true,
          overlayOn: false,
          onSymbolTapped: (String tappedText, SymbolData imageData) {
            if (imageData.primarySelected) {
              selectedSymbolTables.add(_symbolKey(imageData.path));
            } else {
              selectedSymbolTables.remove(_symbolKey(imageData.path));
            }
          },
        )),
        GCWButton(
          text: i18n(context, 'symboltablesexamples_submitandnext'),
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          onPressed: () {
            if (selectedSymbolTables.length <= _ALERT_COUNT_SELECTIONS) {
              _openInSymbolSearch();
            } else {
              showGCWAlertDialog(
                  context,
                  i18n(context, 'symboltablesexamples_manyselections_title'),
                  i18n(context, 'symboltablesexamples_manyselections_text', parameters: [selectedSymbolTables.length]),
                  () => _openInSymbolSearch(),
                  cancelButton: true);

              return;
            }
          },
        )
      ],
    );
  }

  _openInSymbolSearch() {
    Navigator.push(
        context,
        NoAnimationMaterialPageRoute(
            builder: (context) => GCWTool(
                  tool: SymbolTableExamples(
                    symbolKeys: selectedSymbolTables,
                  ),
                  autoScroll: false,
                  i18nPrefix: 'symboltablesexamples',
                )));
  }
}
