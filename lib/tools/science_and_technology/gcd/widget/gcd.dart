import 'package:flutter/material.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';

<<<<<<< HEAD:lib/tools/science_and_technology/gcd_lcm/widget/gcd_lcm.dart
class GCDLCM extends StatefulWidget {
  const GCDLCM({Key? key}) : super(key: key);
=======
class GCD extends StatefulWidget {
  const GCD({Key? key}) : super(key: key);
>>>>>>> 05ad593f1ef25550d7cffee8a14d8c1246eab8e2:lib/tools/science_and_technology/gcd/widget/gcd.dart

  @override
  GCDState createState() => GCDState();
}

class GCDState extends State<GCD> {
  int _currentInputA = 0;
  int _currentInputB = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          value: _currentInputA,
          onChanged: (value) {
            setState(() {
              _currentInputA = value;
            });
          },
        ),
        GCWIntegerSpinner(
          value: _currentInputB,
          onChanged: (value) {
            setState(() {
              _currentInputB = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    return GCWDefaultOutput(
<<<<<<< HEAD:lib/tools/science_and_technology/gcd_lcm/widget/gcd_lcm.dart
      child: GCWColumnedMultilineOutput(
        data: [
          [i18n(context, 'gcd_lcm_gcd'), gcd(_currentInputA, _currentInputB).toString()],
          [i18n(context, 'gcd_lcm_lcm'), lcm(_currentInputA, _currentInputB).toString()]
        ],
      ),
=======
      child: gcd(_currentInputA, _currentInputB).toString(),
>>>>>>> 05ad593f1ef25550d7cffee8a14d8c1246eab8e2:lib/tools/science_and_technology/gcd/widget/gcd.dart
    );
  }
}
