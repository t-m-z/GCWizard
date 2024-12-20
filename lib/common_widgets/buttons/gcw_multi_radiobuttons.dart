import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';

class GCWMultiRadioButtons extends StatefulWidget {
  final void Function(int) onChanged;
  final String? title;
  final List<String> labels;
  final int? position;
  final bool alternativeColor;
  final bool notitle;

  const GCWMultiRadioButtons(
      {Key? key,
        this.title,
        required this.labels,
        required this.position,
        required this.onChanged,
        this.alternativeColor = false,
        this.notitle = false})
      : super(key: key);

  @override
  _GCWMultiRadioButtonsState createState() => _GCWMultiRadioButtonsState();
}

class _GCWMultiRadioButtonsState extends State<GCWMultiRadioButtons> {
  var _currentValue = 0;
  List<bool> _currentStatus = [];

  ButtonStyle _inActiveStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: themeColors().inputBackground(),
      side: BorderSide(width: 2, color: themeColors().inputBackground()),
      textStyle: TextStyle(
        fontSize: defaultFontSize(),
      ),
    );
  }

  ButtonStyle _activeStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: themeColors().checkBoxHoverColor(),
      side: BorderSide(width: 2, color: themeColors().checkBoxHoverColor()),
      shadowColor: Colors.orange,
      elevation: DEFAULT_MARGIN,
      textStyle: TextStyle(
        fontSize: defaultFontSize(),
      ),
    );
  }

  int _calculateValue(List<bool> status){
    int result = 0;
    for (int i = 0; i < status.length; i++) {
      if (status[i]) {
        result = (result + pow(2, i)) as int;
      }
    }
    return result;
  }

  Widget _buildButtonSet() {
    List<Widget> buttons = [];
    for (int i = 0; i < widget.labels.length; i++) {
      _currentStatus.add(false);
    }

    for (int i = 0; i < widget.labels.length; i++) {
      Widget button = Ink(
        padding: const EdgeInsets.symmetric(horizontal: DOUBLE_DEFAULT_MARGIN),
        decoration: ShapeDecoration(
            color: _currentStatus[i] ? Colors.orange : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(ROUNDED_BORDER_RADIUS)),
            )),
        child: Column(children: [
          Text(
            widget.labels[i],
            style: TextStyle(color: _currentStatus[i] ? Colors.black : Colors.white),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _currentStatus[i] = !_currentStatus[i];
                _currentValue = _calculateValue(_currentStatus);
                widget.onChanged(_currentValue);
              });
            },
            icon: _currentStatus[i] ? const Icon(Icons.circle) : const Icon(Icons.circle_outlined),
            color: _currentStatus[i] ? Colors.black : Colors.white,
          )
        ]),
      );
      buttons.add(button);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeColors colors = themeColors();

    _currentValue = widget.position ?? 0;

    var textStyle = gcwTextStyle();
    if (widget.alternativeColor) textStyle = textStyle.copyWith(color: colors.dialogText());

    return Column(children: <Widget>[
      widget.notitle
          ? Container()
          : GCWText(
        text: (widget.title ?? i18n(context, 'common_mode')) + ':',
        style: textStyle,
      ),
      Container(
          padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN),
          child: Row(children: <Widget>[
            Expanded(
              flex: 3,
              child: _buildButtonSet(),
            )
          ]))
    ]);
  }
}
