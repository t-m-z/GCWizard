import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/irrational_numbers/irrational_numbers.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class IrrationalNumbersSearch extends StatefulWidget {
  final IrrationalNumber irrationalNumber;

  const IrrationalNumbersSearch({Key key, this.irrationalNumber}) : super(key: key);

  @override
  IrrationalNumbersSearchState createState() => IrrationalNumbersSearchState();
}

class IrrationalNumbersSearchState extends State<IrrationalNumbersSearch> {
  var _currentInput = '';
  IrrationalNumberCalculator _calculator;
  var _hasWildCards = false;

  var _totalCurrentSolutions = 0;
  var _currentSolution = 0;
  var _controller;

  var _errorMessage;

  List<IrrationalNumberDecimalOccurence> _solutions = [];

  @override
  void initState() {
    super.initState();
    _calculator = IrrationalNumberCalculator(irrationalNumber: widget.irrationalNumber);
    _controller = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _controller,
          onChanged: (ret) {
            setState(() {
              _currentInput = ret;
              try {
                _solutions = _calculator.decimalOccurences(_currentInput.toString());
                _errorMessage = null;
              } catch (e) {
                _errorMessage = e.message;
              }
              _hasWildCards = !isOnlyNumerals(_currentInput);
              _currentSolution = 0;
            });
          },
        ),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  _calculateOutput() {
    if (_errorMessage != null) return i18n(context, _errorMessage);

    if (_currentInput.isEmpty) return '';

    _totalCurrentSolutions = _solutions.length;

    if (_solutions.length == 0) return '';

    var selector = (_totalCurrentSolutions != null && _totalCurrentSolutions > 1)
        ? Container(
            child: Row(
              children: [
                GCWIconButton(
                  icon: Icons.arrow_back_ios,
                  onPressed: () {
                    setState(() {
                      _currentSolution = (_currentSolution - 1 + _totalCurrentSolutions) % _totalCurrentSolutions;
                    });
                  },
                ),
                Expanded(
                  child: GCWText(
                      align: Alignment.center,
                      text:
                          '${_currentSolution + 1}/${_totalCurrentSolutions}' // + (_currentSolutions.length >= _MAX_SOLUTIONS ? ' *' : ''),
                      ),
                ),
                GCWIconButton(
                  icon: Icons.arrow_forward_ios,
                  onPressed: () {
                    setState(() {
                      _currentSolution = (_currentSolution + 1) % _totalCurrentSolutions;
                    });
                  },
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 5 * DOUBLE_DEFAULT_MARGIN))
        : Container();

    var _solution = _solutions[_currentSolution];

    var output = columnedMultiLineOutput(context, [
      _hasWildCards ? [i18n(context, 'common_value'), _solution.value] : null,
      [i18n(context, 'common_start'), _solution.start],
      [i18n(context, 'common_end'), _solution.end]
    ], flexValues: [
      2,
      3
    ]);

    return Column(children: [
      selector,
      Column(
        children: output,
      )
    ]);
  }
}
