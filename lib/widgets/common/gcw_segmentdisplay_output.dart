import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';

import 'base/gcw_iconbutton.dart';
import 'gcw_exported_file_dialog.dart';
import 'gcw_text_divider.dart';

class GCWSegmentDisplayOutput extends StatefulWidget {
  final bool upsideDownButton;
  final NSegmentDisplay Function(Map<String, bool>, bool) segmentFunction;
  final List<List<String>> segments;
  final bool readOnly;
  final Widget trailing;
  final bool showZoomButtons;

  const GCWSegmentDisplayOutput(
      {Key key,
      this.upsideDownButton: false,
      this.segmentFunction,
      this.segments,
      this.readOnly,
      this.trailing,
      this.showZoomButtons: true})
      : super(key: key);

  @override
  _GCWSegmentDisplayOutputState createState() => _GCWSegmentDisplayOutputState();
}

class _GCWSegmentDisplayOutputState extends State<GCWSegmentDisplayOutput> {
  var _currentUpsideDown = false;
  List<NSegmentDisplay> _displays;

  @override
  void initState() {
    super.initState();

    _currentUpsideDown = widget.upsideDownButton;
  }

  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_PORTRAIT)
        : Prefs.get(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_LANDSCAPE);

    return Column(children: <Widget>[
      GCWTextDivider(
        text: i18n(context, 'segmentdisplay_displayoutput'),
        trailing: Row(
          children: <Widget>[
            widget.upsideDownButton
                ? Container(
                    child: GCWIconButton(
                      icon: Icons.rotate_left,
                      size: IconButtonSize.SMALL,
                      onPressed: () {
                        setState(() {
                          _currentUpsideDown = !_currentUpsideDown;
                        });
                      },
                    ),
                  )
                : Container(),
            Container(
              child: GCWIconButton(
                size: IconButtonSize.SMALL,
                icon: Icons.save,
                iconColor: (widget.segments == null) || (widget.segments.length == 0) ? themeColors().inActive() : null,
                onPressed: () async {
                  await buildSegmentDisplayImage(countColumns, _displays, _currentUpsideDown).then((image) {
                    if (image != null)
                      image.toByteData(format: ui.ImageByteFormat.png).then((data) {
                        _exportFile(context, data.buffer.asUint8List());
                      });
                  });
                },
              ),
              padding: EdgeInsets.only(right: 10.0),
            ),
            if (widget.showZoomButtons)
              GCWIconButton(
                size: IconButtonSize.SMALL,
                icon: Icons.zoom_in,
                onPressed: () {
                  setState(() {
                    int newCountColumn = max(countColumns - 1, 1);
                    mediaQueryData.orientation == Orientation.portrait
                        ? Prefs.setInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_PORTRAIT, newCountColumn)
                        : Prefs.setInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_LANDSCAPE, newCountColumn);
                  });
                },
              ),
            if (widget.showZoomButtons)
              GCWIconButton(
                size: IconButtonSize.SMALL,
                icon: Icons.zoom_out,
                onPressed: () {
                  setState(() {
                    int newCountColumn = countColumns + 1;
                    mediaQueryData.orientation == Orientation.portrait
                        ? Prefs.setInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_PORTRAIT, newCountColumn)
                        : Prefs.setInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_LANDSCAPE, newCountColumn);
                  });
                },
              ),
          ],
        ),
      ),
      _buildDigitalOutput(countColumns, widget.segments)
    ]);
  }

  Widget _buildDigitalOutput(int countColumns, List<List<String>> segments) {
    var list = _currentUpsideDown ? segments.reversed : segments;

    _displays = list.where((character) => character != null).map((character) {
      var displayedSegments = Map<String, bool>.fromIterable(character, key: (e) => e, value: (e) => true);
      return widget.segmentFunction(displayedSegments, widget.readOnly);
    }).toList();

    var viewList = !_currentUpsideDown
        ? _displays
        : _displays.map((display) {
            return Transform.rotate(angle: _currentUpsideDown ? pi : 0, child: display);
          }).toList();
    return buildSegmentDisplayOutput(countColumns, viewList);
  }
}

_exportFile(BuildContext context, Uint8List data) async {
  var value =
      await saveByteDataToFile(context, data, 'img_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');

  if (value != null) showExportedFileDialog(context, fileType: FileType.PNG, contentWidget: Image.memory(data));
}
