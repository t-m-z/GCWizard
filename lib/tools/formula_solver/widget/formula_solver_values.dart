part of 'package:gc_wizard/tools/formula_solver/widget/formula_solver_formulagroups.dart';

class _FormulaSolverFormulaValues extends StatefulWidget {
  final FormulaGroup group;

  const _FormulaSolverFormulaValues({required this.group});

  @override
  _FormulaSolverFormulaValuesState createState() => _FormulaSolverFormulaValuesState();
}

class _FormulaSolverFormulaValuesState extends State<_FormulaSolverFormulaValues> {
  late TextEditingController _newKeyController;

  @override
  void initState() {
    super.initState();
    _newKeyController = TextEditingController(text: _maxLetter());
  }

  @override
  void dispose() {
    _newKeyController.dispose();

    super.dispose();
  }

  String _maxLetter() {
    int maxLetterIndex = 0;
    for (var value in widget.group.values) {
      if (value.key.length != 1) continue;
      var alphabetIndex = alphabet_AZ[value.key.toUpperCase()];
      if (alphabetIndex == null) continue;

      maxLetterIndex = max(maxLetterIndex, alphabetIndex);
    }

    if (alphabet_AZIndexes.keys.contains(maxLetterIndex + 1)) {
      return alphabet_AZIndexes[maxLetterIndex + 1]!;
    }

    return '';
  }

  void _addEntry(KeyValueBase entry) {
    if (!_checkValidKey(entry.key)) return;

    _checkForTextAndInsert(entry);
  }

  void _checkForTextAndInsert(KeyValueBase entry) {
    void _doInsertEntry(KeyValueBase entry) {
      if (entry is FormulaValue) {
        insertFormulaValue(entry, widget.group);
      }
      _newKeyController.text = _maxLetter();
    }

    var value = entry.value;

    if (!hasLetters(value)) {
      _doInsertEntry(entry);
      return;
    }

    var startChar = value[0];
    var endChar = value[value.length - 1];
    if (startChar == endChar && (startChar == "'" || startChar == '"')) {
      _doInsertEntry(entry);
      return;
    }

    showGCWDialog(
      context,
      i18n(context, 'formulasolver_values_alert_markastext_title'),
      Text(i18n(context, 'formulasolver_values_alert_markastext_text')),
      [
        GCWDialogButton(
          text: i18n(context, 'formulasolver_values_alert_markastext_changetotext'),
          onPressed: (){
            if (value.contains('"') && value.contains("'")) {
              showGCWAlertDialog(context,
                i18n(context, 'formulasolver_values_alert_markastext_notbothchars_title'),
                i18n(context, 'formulasolver_values_alert_markastext_notbothchars_text'),
                () {}
              );
              return;
            }

            var marker = "'";
            if (value.contains("'")) {
              marker = '"';
            }

            entry.value = marker + value + marker;
            setState(() {
              _doInsertEntry(entry);
            });
          }
        ),
        GCWDialogButton(
          text: i18n(context, 'formulasolver_values_alert_markastext_nochangetotext'),
          onPressed: (){
            setState(() {
              _doInsertEntry(entry);
            });
          }
        ),
      ],
      cancelButton: false
    );
  }

  void _updateEntry(KeyValueBase entry) {
    updateAndSave(widget.group);
  }

  bool _checkValidKey(String key) {
    if (!hasLetters(key)) {
      showGCWAlertDialog(context,
          i18n(context, 'formulasolver_values_alerts_keynumbers_title'),
          i18n(context, 'formulasolver_values_alerts_keynumbers_text'), () {});
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(text: i18n(context, 'formulasolver_values_newvalue')),
        GCWKeyValueEditor(
            keyHintText: i18n(context, 'formulasolver_values_key'),
            keyController: _newKeyController,
            valueHintText: i18n(context, 'formulasolver_values_value'),
            dividerText: i18n(context, 'formulasolver_values_currentvalues'),
            entries: widget.group.values,
            onAddEntry: (entry) => _addEntry(entry),
            onUpdateEntry: (entry) => _updateEntry(entry),
            onCreateInput: (Key? key) => _FormulaValueTypeKeyInput(key: key),
            onCreateNewItem: (entry, odd) => _createNewItem(entry, odd),
            validateEditedKey: (String key) => _checkValidKey(key),
            trailing: GCWIconButton(
              customIcon: Image.asset('lib/application/_common/assets/img/cgeo_logo.png'),
              size: IconButtonSize.SMALL,
              onPressed: () {
                var cgeoFormattedValues = widget.group.values.map((value) {
                  return '\$' + value.key + '=' + value.value;
                }).join(' | ');

                insertIntoGCWClipboard(context, cgeoFormattedValues);
              },
            )),
      ],
    );
  }

  GCWKeyValueItem _createNewItem(KeyValueBase entry, bool odd) {
    return _FormulaValueTypeKeyValueItem(
      keyValueEntry: entry,
      odd: odd,
      validateEditedKey: (String key) => _checkValidKey(key),
      validateEditedValue: null
    );
  }
}
