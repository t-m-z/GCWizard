import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/widget/crosstotal_output.dart';

class CrossSum extends StatefulWidget {
  const CrossSum({Key? key}) : super(key: key);

  @override
 _CrossSumState createState() => _CrossSumState();
}

class _CrossSumState extends State<CrossSum> {
  var _currentValue = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          value: _currentValue,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
          },
        ),
        CrosstotalOutput(text: _currentValue.toString(), values: [_currentValue], suppressSums: true)
      ],
    );
  }
}
