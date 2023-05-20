import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_switch.dart';

enum GCWSwitchPosition { left, right }

class GCWTwoOptionsSwitch extends StatefulWidget {
  final void Function(GCWSwitchPosition) onChanged;
  final String? title;
  final String? leftValue;
  final String? rightValue;
  final GCWSwitchPosition? value;
  final bool alternativeColor;
  final bool notitle;

  const GCWTwoOptionsSwitch(
      {Key? key,
      required this.onChanged,
      this.title,
      this.leftValue,
      this.rightValue,
      required this.value,
      this.alternativeColor = false,
      this.notitle = false})
      : super(key: key);

  @override
  _GCWTwoOptionsSwitchState createState() => _GCWTwoOptionsSwitchState();
}

class _GCWTwoOptionsSwitchState extends State<GCWTwoOptionsSwitch> {
  @override
  Widget build(BuildContext context) {
    var _currentValue = widget.value ?? GCWSwitchPosition.left;
    ThemeColors colors = themeColors();

    var textStyle = gcwTextStyle();
    if (widget.alternativeColor) textStyle = textStyle.copyWith(color: colors.dialogText());

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
                    child: GCWText(
                      text: widget.leftValue ?? i18n(context, 'common_encrypt'),
                      align: Alignment.center,
                      style: textStyle,
                    )),
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
                    child: GCWText(
                      text: widget.rightValue ?? i18n(context, 'common_decrypt'),
                      align: Alignment.center,
                      style: textStyle,
                    ))
              ],
            ))
      ],
    );
  }
}
