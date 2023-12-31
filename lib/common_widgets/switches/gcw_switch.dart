import 'package:flutter/material.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';

class GCWSwitch extends StatefulWidget {
  final void Function(bool) onChanged;
  final bool value;
  final Color? inactiveTrackColor;
  final Color? inactiveThumbColor;
  final Color? activeThumbColor;
  final Color? activeTrackColor;

  const GCWSwitch(
      {Key? key,
      this.value = false,
      required this.onChanged,
      this.inactiveThumbColor,
      this.inactiveTrackColor,
      this.activeThumbColor,
      this.activeTrackColor})
      : super(key: key);

  @override
  _GCWSwitchState createState() => _GCWSwitchState();
}

class _GCWSwitchState extends State<GCWSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: widget.value,
        onChanged: (bool value) {
          setState(() {
            widget.onChanged(value);
          });
        },
        activeColor: widget.activeThumbColor,
        activeTrackColor: widget.activeTrackColor,
        inactiveTrackColor: widget.inactiveTrackColor,
        inactiveThumbColor: widget.inactiveThumbColor,
        trackOutlineColor: MaterialStateProperty.resolveWith ((Set  states) {
          if (states.contains(MaterialState.disabled)) {
            return themeColors().primaryBackground();
          }
          return themeColors().primaryBackground();
        }),);
  }
}
