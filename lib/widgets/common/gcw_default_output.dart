import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';

class GCWDefaultOutput extends StatefulWidget {
  final dynamic child;
  final bool suppressCopyButton;
  final String copyText;

  const GCWDefaultOutput({Key key, this.child, this.suppressCopyButton: false, this.copyText}) : super(key: key);

  @override
  _GCWDefaultOutputState createState() => _GCWDefaultOutputState();
}

class _GCWDefaultOutputState extends State<GCWDefaultOutput> {

  @override
  Widget build(BuildContext context) {
    return GCWOutput(
      title: i18n(context, 'common_output'),
      child: widget.child ?? '',
      suppressCopyButton: widget.suppressCopyButton,
      copyText: widget.copyText,
    );
  }
}