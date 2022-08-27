import 'dart:convert';

import 'package:gc_wizard/persistence/formula_solver/model.dart' as formula_model;
import 'package:gc_wizard/persistence/utils.dart';
import 'package:gc_wizard/persistence/variable_coordinate/model.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:prefs/prefs.dart';

void refreshFormulas() {
  var formulasList = Prefs.getStringList(PREFERENCE_COORD_VARIABLECOORDINATE_FORMULAS);
  if (formulasList == null || formulasList.length == 0) return;

  formulas = formulasList.where((formula) => formula.length > 0).map((formula) {
    return Formula.fromJson(jsonDecode(formula));
  }).toList();
}

_saveData() {
  var jsonData = formulas.map((formula) => jsonEncode(formula.toMap())).toList();

  Prefs.setStringList(PREFERENCE_COORD_VARIABLECOORDINATE_FORMULAS, jsonData);
}

void updateFormulas() {
  _saveData();
}

int insertFormula(Formula formula) {
  var id = newID(formulas.map((formula) => formula.id).toList());
  formula.id = id;
  formulas.add(formula);

  _saveData();

  return id;
}

void deleteFormula(int formulaId) {
  formulas.removeWhere((formula) => formula.id == formulaId);

  _saveData();
}

void updateFormula(Formula formula) {
  _updateFormula(formula);
  _saveData();
}

void _updateFormula(Formula formula) {
  formulas = formulas.map((f) {
    if (f.id == formula.id) return formula;

    return f;
  }).toList();
}

int insertFormulaValue(formula_model.FormulaValue formulaValue, Formula formula) {
  var id = newID(formula.values.map((value) => value.id).toList());
  formulaValue.id = id;
  formula.values.add(formulaValue);

  _updateFormula(formula);
  _saveData();

  return id;
}

void updateFormulaValue(formula_model.FormulaValue formulaValue, Formula formula) {
  formula.values = formula.values.map((value) {
    if (value.id == formulaValue.id) return formulaValue;

    return value;
  }).toList();

  _updateFormula(formula);
  _saveData();
}

void deleteFormulaValue(int formulaValueId, Formula formula) {
  formula.values.removeWhere((value) => value.id == formulaValueId);

  _updateFormula(formula);
  _saveData();
}
