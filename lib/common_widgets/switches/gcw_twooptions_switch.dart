import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_switch.dart';

enum GCWSwitchPosition { left, right }
enum GCWSwitchstyle { slider, button }

class GCWTwoOptionsSwitch extends StatefulWidget {
  final void Function(GCWSwitchPosition) onChanged;
  final String? title;
  final Object? leftValue;
  final Object? rightValue;
  final GCWSwitchPosition? value;
  final bool alternativeColor;
  final bool notitle;
  final GCWSwitchstyle style;

  const GCWTwoOptionsSwitch(
      {Key? key,
      this.title,
      this.leftValue,
      this.rightValue,
      required this.value,
      required this.onChanged,
      this.alternativeColor = false,
      this.notitle = false,
      this.style = GCWSwitchstyle.slider})
      : super(key: key);

  @override
  _GCWTwoOptionsSwitchState createState() => _GCWTwoOptionsSwitchState();
}

class _GCWTwoOptionsSwitchState extends State<GCWTwoOptionsSwitch> {

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
    var _currentValue = widget.value ?? GCWSwitchPosition.left;
    ThemeColors colors = themeColors();

    var textStyle = gcwTextStyle();
    if (widget.alternativeColor) textStyle = textStyle.copyWith(color: colors.dialogText());

    switch (widget.style) {
      case GCWSwitchstyle.slider:
        return Row(
          children: <Widget>[
            widget.notitle
                ? Container()
                : Expanded(
                flex: 1,
                child: GCWText(
                  text: (widget.title ?? i18n(context, 'common_mode')) + ':',
                  style: textStyle,
                )),
            Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: (widget.leftValue == null || widget.leftValue is String)
                            ? GCWText(
                          text: widget.leftValue == null
                              ? i18n(context, 'common_encrypt')
                              : (widget.leftValue as String),
                          align: Alignment.center,
                          style: textStyle,
                        )
                            : widget.leftValue as Widget),
                    GCWSwitch(
                      value: _currentValue == GCWSwitchPosition.right,
                      onChanged: (value) {
                        setState(() {
                          _currentValue = value ? GCWSwitchPosition.right : GCWSwitchPosition.left;
                          widget.onChanged(_currentValue);
                        });
                      },
                      activeThumbColor: widget.alternativeColor ? colors.switchThumb1() : colors.switchThumb2(),
                      activeTrackColor: widget.alternativeColor ? colors.switchTrack1() : colors.switchTrack2(),
                      inactiveThumbColor: widget.alternativeColor ? colors.switchThumb1() : colors.switchThumb2(),
                      inactiveTrackColor: widget.alternativeColor ? colors.switchTrack1() : colors.switchTrack2(),
                    ),
                    Expanded(
                        flex: 1,
                        child: (widget.rightValue == null || widget.rightValue is String)
                            ? GCWText(
                          text: widget.rightValue == null
                              ? i18n(context, 'common_decrypt')
                              : (widget.rightValue as String),
                          align: Alignment.center,
                          style: textStyle,
                        )
                            : widget.rightValue as Widget),
                  ],
                ))
          ],
        );
      case GCWSwitchstyle.button:
        return Column(children: <Widget>[
          widget.notitle
              ? Container()
              : GCWText(
            text: (widget.title ?? i18n(context, 'common_mode')) + ':',
            style: textStyle,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: DOUBLE_DEFAULT_MARGIN),
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
                              icon: _currentValue == GCWSwitchPosition.left ? Icon(Icons.check_circle_outline) : null,
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
                              icon:
                              _currentValue == GCWSwitchPosition.right ? Icon(Icons.check_circle_outline) : null,
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
}
