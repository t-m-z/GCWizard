import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_zoom_buttons.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_replacer/symbol_replacer.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class GCWSymbolTableSymbolMatrix extends StatefulWidget {
  final int countColumns;
  final MediaQueryData mediaQueryData;
  final Iterable<Map<String, SymbolData>> imageData;
  final bool selectable;
  final Function onChanged;
  final Function onSymbolTapped;
  final bool overlayOn;
  final String symbolKey;
  final bool fixed;

  const GCWSymbolTableSymbolMatrix(
      {Key key,
      this.imageData,
      this.countColumns,
      this.mediaQueryData,
      this.onChanged,
      this.selectable: false,
      this.onSymbolTapped,
      this.fixed: false,
      this.overlayOn: true,
      this.symbolKey})
      : super(key: key);

  @override
  GCWSymbolTableSymbolMatrixState createState() => GCWSymbolTableSymbolMatrixState();
}

class GCWSymbolTableSymbolMatrixState extends State<GCWSymbolTableSymbolMatrix> {
  var _currentShowOverlayedSymbols = true;
  Iterable<Map<String, SymbolData>> _imageData;

  @override
  void initState() {
    super.initState();
    _currentShowOverlayedSymbols = widget.overlayOn;
  }

  @override
  Widget build(BuildContext context) {
    var _symbolTableSwitchPartWidth = (MediaQuery.of(context).size.width - 40) / 3;
    var _decryptionSwitchWidth = (MediaQuery.of(context).size.width - 40 - 57 - 20);
    var _decryptionSwitchPartWidth = (_symbolTableSwitchPartWidth / _decryptionSwitchWidth * 100).toInt();

    _imageData = widget.imageData;

    return Column(children: [
      Row(
        children: <Widget>[
          Expanded(
              child: GCWOnOffSwitch(
                value: _currentShowOverlayedSymbols,
                title: i18n(context, 'symboltables_showoverlay'),
                flexValues: [
                  _decryptionSwitchPartWidth,
                  _decryptionSwitchPartWidth,
                  max(100 - 2 * _decryptionSwitchPartWidth, 0)
                ],
                onChanged: (value) {
                  setState(() {
                    _currentShowOverlayedSymbols = value;
                  });
                },
              ),
              flex: 4),
          widget.symbolKey == null
              ? Container(width: 20)
              : GCWIconButton(
                  icon: Icons.app_registration,
                  onPressed: () {
                    openInSymbolReplacer(context, widget.symbolKey, widget.imageData);
                  }),
          Container(width: 15),
          GCWSymbolTableZoomButtons(
              countColumns: widget.countColumns, mediaQueryData: widget.mediaQueryData, onChanged: widget.onChanged)
        ],
      ),
      widget.fixed
          ? _buildDecryptionButtonMatrix(widget.countColumns, widget.selectable, widget.onSymbolTapped)
          : Expanded(
              child: SingleChildScrollView(
                  child: _buildDecryptionButtonMatrix(widget.countColumns, widget.selectable, widget.onSymbolTapped)))
    ]);
  }

  _showSpaceSymbolInOverlay(text) {
    return text == ' ' ? String.fromCharCode(9251) : text;
  }

  _buildDecryptionButtonMatrix(int countColumns, bool selectable, Function onSymbolTapped) {
    if (_imageData == null) return Container();

    var rows = <Widget>[];
    var countRows = (_imageData.length / countColumns).floor();

    ThemeColors colors = themeColors();

    var symbolTexts = _imageData.map((element) => element.values.first.displayName ?? element.keys.first).toList();
    var images = _imageData.map((element) => element.values.first).toList();
    for (var i = 0; i <= countRows; i++) {
      var columns = <Widget>[];

      for (var j = 0; j < countColumns; j++) {
        var widget;
        var imageIndex = i * countColumns + j;

        if (imageIndex < _imageData.length) {
          var symbolText = symbolTexts[imageIndex];
          var image = images[imageIndex];

          widget = InkWell(
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                GCWSymbolContainer(
                  borderColor:
                      image.primarySelected ? colors.dialog() : (image.secondarySelected ? colors.focused() : null),
                  borderWidth: image.primarySelected || image.secondarySelected ? 5.0 : null,
                  symbol: Image.memory(image.bytes),
                ),
                _currentShowOverlayedSymbols
                    ? Opacity(
                        child: Container(
                          //TODO: Using GCWText instead: Currently it would expand the textfield width to max.
                          child: AutoSizeText(
                            _showSpaceSymbolInOverlay(symbolText),
                            style: gcwTextStyle().copyWith(color: colors.dialogText(), fontWeight: FontWeight.bold),
                            maxLines: 2,
                            minFontSize: 9.0,
                          ),
                          height: defaultFontSize() + 5,
                          decoration: ShapeDecoration(
                              color: colors.dialog(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(ROUNDED_BORDER_RADIUS)),
                              )),
                        ),
                        opacity: 0.85)
                    : Container()
              ],
            ),
            onTap: () {
              setState(() {
                if (selectable) {
                  image.primarySelected = !image.primarySelected;
                  image.secondarySelected = false;
                }

                onSymbolTapped(symbolText, image);
              });
            },
          );
        } else {
          widget = Container();
        }

        columns.add(Expanded(
            child: Container(
          child: widget,
          padding: EdgeInsets.all(3),
        )));
      }

      rows.add(Row(
        children: columns,
      ));
    }

    return Column(
      children: rows,
    );
  }

  openInSymbolReplacer(BuildContext context, String symbolKey, List<Map<String, SymbolData>> imageData) {
    Navigator.push(
        context,
        NoAnimationMaterialPageRoute(
            builder: (context) => GCWTool(
                tool: SymbolReplacer(imageData: imageData, symbolKey: symbolKey),
                toolName: i18n(context, 'symbol_replacer_title'),
                i18nPrefix: '')));
  }
}
