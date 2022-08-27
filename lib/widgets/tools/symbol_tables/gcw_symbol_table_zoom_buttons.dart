import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:prefs/prefs.dart';

class GCWSymbolTableZoomButtons extends StatefulWidget {
  final int countColumns;
  final MediaQueryData mediaQueryData;
  final Function onChanged;

  const GCWSymbolTableZoomButtons({Key key, this.countColumns, this.mediaQueryData, this.onChanged}) : super(key: key);

  @override
  GCWSymbolTableZoomButtonsState createState() => GCWSymbolTableZoomButtonsState();
}

class GCWSymbolTableZoomButtonsState extends State<GCWSymbolTableZoomButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GCWIconButton(
          icon: Icons.zoom_in,
          onPressed: () {
            setState(() {
              int newCountColumn = max(widget.countColumns - 1, 1);

              widget.mediaQueryData.orientation == Orientation.portrait
                  ? Prefs.setInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_PORTRAIT, newCountColumn)
                  : Prefs.setInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_LANDSCAPE, newCountColumn);

              widget.onChanged();
            });
          },
        ),
        GCWIconButton(
          icon: Icons.zoom_out,
          onPressed: () {
            setState(() {
              int newCountColumn = widget.countColumns + 1;

              widget.mediaQueryData.orientation == Orientation.portrait
                  ? Prefs.setInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_PORTRAIT, newCountColumn)
                  : Prefs.setInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_LANDSCAPE, newCountColumn);

              widget.onChanged();
            });
          },
        )
      ],
    );
  }
}
