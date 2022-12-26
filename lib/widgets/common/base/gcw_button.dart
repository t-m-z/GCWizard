import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class GCWButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final TextStyle textStyle;
  final EdgeInsetsGeometry margin;

  const GCWButton({Key key, this.text, this.onPressed, this.textStyle, this.margin}) : super(key: key);

  @override
  _GCWButtonState createState() => _GCWButtonState();
}

class _GCWButtonState extends State<GCWButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: themeColors().accent()),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: widget.textStyle ?? gcwTextStyle().copyWith(color: themeColors().dialogText()),
        ),
      ),
    );
  }
}
