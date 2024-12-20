import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';

enum GCWRadioButtonLabelPosition { top, left, right }

class GCWTwoRadioButtons extends StatefulWidget {
  final void Function(GCWSwitchPosition) onChanged;
  final String? title;
  final Object? leftValue;
  final Object? rightValue;
  final GCWSwitchPosition? value;
  final bool alternativeColor;
  final bool notitle;
  final GCWRadioButtonLabelPosition labelPosition;

  const GCWTwoRadioButtons(
      {Key? key,
      this.title,
      this.leftValue,
      this.rightValue,
      required this.value,
      required this.onChanged,
      this.alternativeColor = false,
      this.notitle = false,
      this.labelPosition = GCWRadioButtonLabelPosition.top})
      : super(key: key);

  @override
  _GCWTwoRadioButtonsState createState() => _GCWTwoRadioButtonsState();
}

class _GCWTwoRadioButtonsState extends State<GCWTwoRadioButtons> {
  var _currentValue = GCWSwitchPosition.left;
  var _textStyle = gcwTextStyle();

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

  @override
  Widget build(BuildContext context) {
    _currentValue = widget.value ?? GCWSwitchPosition.left;
    ThemeColors colors = themeColors();

    if (widget.alternativeColor) _textStyle = _textStyle.copyWith(color: colors.dialogText());

    if (widget.labelPosition == GCWRadioButtonLabelPosition.top) {
      return _buildWidgetTop();
    } else {
      return _buildWidgetLeftRight();
    }
  }

  Widget _buildWidgetTop() {
    return Column(
      children: [
        widget.notitle
            ? Container()
            : GCWText(
          text: (widget.title ?? i18n(context, 'common_mode')) + ':',
          style: _textStyle,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Ink(
                          padding: const EdgeInsets.symmetric(horizontal: DOUBLE_DEFAULT_MARGIN),
                          decoration: ShapeDecoration(
                              color: _currentValue == GCWSwitchPosition.left ? Colors.orange : Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(ROUNDED_BORDER_RADIUS)),
                              )),
                          child: Column(children: [
                            widget.leftValue == null
                                ? Text(i18n(context, 'common_encrypt'), style: TextStyle(color: _currentValue == GCWSwitchPosition.left ? Colors.black : Colors.white),)
                                : Text((widget.leftValue as String), style: TextStyle(color: _currentValue == GCWSwitchPosition.left ? Colors.black : Colors.white),),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _currentValue = GCWSwitchPosition.left;
                                  widget.onChanged(_currentValue);
                                });
                              },
                              icon: _currentValue == GCWSwitchPosition.left ? const Icon(Icons.circle) : const Icon(Icons.circle_outlined),
                              color: _currentValue == GCWSwitchPosition.left ? Colors.black : Colors.white,
                            )
                          ]),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Ink(
                          padding: const EdgeInsets.symmetric(horizontal: DOUBLE_DEFAULT_MARGIN),
                          decoration: ShapeDecoration(
                              color: _currentValue == GCWSwitchPosition.right ? Colors.orange : Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(ROUNDED_BORDER_RADIUS)),
                              )),
                          child: Column(children: [
                            widget.rightValue == null
                                ? Text(i18n(context, 'common_decrypt'), style: TextStyle(color: _currentValue == GCWSwitchPosition.right ? Colors.black : Colors.white),)
                                : Text((widget.leftValue as String),style: TextStyle(color: _currentValue == GCWSwitchPosition.right ? Colors.black : Colors.white),),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _currentValue = GCWSwitchPosition.right;
                                  widget.onChanged(_currentValue);
                                });
                              },
                              icon: _currentValue == GCWSwitchPosition.right ? const Icon(Icons.circle) : const Icon(Icons.circle_outlined),
                              color: _currentValue == GCWSwitchPosition.right ? Colors.black : Colors.white,
                            )
                          ]),
                        ),
                      ),
                    ]
                ),
              )
              ,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetLeftRight() {
    return Column(children: <Widget>[
      widget.notitle
          ? Container()
          : GCWText(
              text: (widget.title ?? i18n(context, 'common_mode')) + ':',
              style: _textStyle,
            ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: (widget.leftValue == null || widget.leftValue is String)
                            ? ElevatedButton.icon(
                                label: widget.leftValue == null
                                    ? Text(i18n(context, 'common_encrypt'))
                                    : Text((widget.leftValue as String)),
                                icon: _currentValue == GCWSwitchPosition.left
                                    ? const Icon(Icons.circle)
                                    : const Icon(Icons.circle_outlined),
                                iconAlignment: widget.labelPosition == GCWRadioButtonLabelPosition.left
                                    ? IconAlignment.start
                                    : IconAlignment.end,
                                style: _currentValue == GCWSwitchPosition.left ? _activeStyle() : _inActiveStyle(),
                                onPressed: () {
                                  setState(() {
                                    _currentValue = GCWSwitchPosition.left;
                                    widget.onChanged(_currentValue);
                                  });
                                },
                              )
                            : widget.leftValue as Widget),
                    Expanded(
                        flex: 1,
                        child: (widget.rightValue == null || widget.rightValue is String)
                            ? ElevatedButton.icon(
                                label: widget.rightValue == null
                                    ? Text(i18n(context, 'common_decrypt'))
                                    : Text(
                                        (widget.rightValue as String),
                                      ),
                                icon: _currentValue == GCWSwitchPosition.right
                                    ? const Icon(Icons.circle)
                                    : const Icon(Icons.circle_outlined),
                                iconAlignment: widget.labelPosition == GCWRadioButtonLabelPosition.left
                                    ? IconAlignment.start
                                    : IconAlignment.end,
                                style: _currentValue == GCWSwitchPosition.right ? _activeStyle() : _inActiveStyle(),
                                onPressed: () {
                                  setState(() {
                                    _currentValue = GCWSwitchPosition.right;
                                    widget.onChanged(_currentValue);
                                  });
                                },
                              )
                            : widget.rightValue as Widget),
                  ],
                ))
          ],
        ),
      )
    ]);
  }
}
