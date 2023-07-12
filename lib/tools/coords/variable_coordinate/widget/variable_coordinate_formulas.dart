import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_paste_button.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_formula_list_editor.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/variable_coordinate/persistence/json_provider.dart';
import 'package:gc_wizard/tools/coords/variable_coordinate/persistence/model.dart';
import 'package:gc_wizard/tools/coords/variable_coordinate/widget/variable_coordinate.dart';
import 'package:gc_wizard/utils/json_utils.dart';
import 'package:gc_wizard/utils/string_utils.dart';

class VariableCoordinateFormulas extends StatefulWidget {
  const VariableCoordinateFormulas({Key? key}) : super(key: key);

  @override
  _VariableCoordinateFormulasState createState() => _VariableCoordinateFormulasState();
}

class _VariableCoordinateFormulasState extends State<VariableCoordinateFormulas> {

  @override
  void initState() {
    super.initState();

    refreshFormulas();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
            text: i18n(context, 'coords_variablecoordinate_newformula'),
            trailing: GCWPasteButton(iconSize: IconButtonSize.SMALL, onSelected: _importFromClipboard)),
        GCWFormulaListEditor(
          formulaList: formulas,
          buildGCWTool: (id) => _buildNavigateGCWTool(id),
          onAddEntry: (name) => _addNewFormula(name),
          onListChanged: () => updateFormulas(),
          newEntryHintText: i18n(context, 'coords_variablecoordinate_newformula_hint'),
          middleWidget: GCWTextDivider(text: i18n(context, 'coords_variablecoordinate_currentformulas')),
        ),
      ],
    );
  }
  String _createImportName(String currentName) {
    var baseName = '[${i18n(context, 'common_import')}] $currentName';

    var existingNames = formulas.map((f) => f.name).toList();

    int i = 1;
    var name = baseName;
    while (existingNames.contains(name)) {
      name = baseName + ' (${i++})';
    }

    return name;
  }

  void _importFromClipboard(String data) {
    try {
      data = normalizeCharacters(data);
      var formula = Formula.fromJson(asJsonMap(jsonDecode(data)));
      formula.name = _createImportName(formula.name);

      setState(() {
        insertFormula(formula);
      });
      showToast(i18n(context, 'formulasolver_groups_imported'));
    } catch (e) {
      showToast(i18n(context, 'formulasolver_groups_importerror'));
    }
  }

  void _addNewFormula(String name) {
    if (name.isNotEmpty) {
      var formula = Formula(name);
      insertFormula(formula);
    }
  }

  GCWTool? _buildNavigateGCWTool(int id) {
    var entry = formulas.firstWhereOrNull((formula) => formula.id == id);

    if (entry != null) {
      return GCWTool(
          tool: VariableCoordinate(formula: entry),
          toolName: '${entry.name} - ${i18n(context, 'coords_variablecoordinate_title')}',
          helpSearchString: 'coords_variablecoordinate_title',
          defaultLanguageToolName:
          '${entry.name} - ${i18n(context, 'coords_variablecoordinate_title', useDefaultLanguage: true)}',
          id: 'coords_variablecoordinate');
<<<<<<< HEAD

      Future<void> _navigateToSubPage(BuildContext context) async {
        Navigator.push(context, NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => formulaTool))
            .whenComplete(() {
          setState(() {});
        });
      }

      Widget output;

      var row = InkWell(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _currentEditId == formula.id
                    ? Padding(
                        padding: const EdgeInsets.only(
                          right: 2,
                        ),
                        child: GCWTextField(
                          controller: _editFormulaController,
                          autofocus: true,
                          onChanged: (text) {
                            setState(() {
                              _currentEditedName = text;
                            });
                          },
                        ),
                      )
                    : IgnorePointer(child: GCWText(text: formula.name)),
              ),
              _currentEditId == formula.id
                  ? GCWIconButton(
                      icon: Icons.check,
                      onPressed: () {
                        formula.name = _currentEditedName;
                        _updateFormula();

                        setState(() {
                          _currentEditId = null;
                          _editFormulaController.clear();
                        });
                      },
                    )
                  : GCWIconButton(
                      icon: Icons.edit,
                      onPressed: () {
                        setState(() {
                          _currentEditId = formula.id;
                          _currentEditedName = formula.name;
                          _editFormulaController.text = formula.name;
                        });
                      },
                    ),
              GCWIconButton(
                icon: Icons.remove,
                onPressed: () {
                  showDeleteAlertDialog(context, formula.name, () {
                    _removeFormula(formula);
                    setState(() {});
                  });
                },
              )
            ],
          ),
          onTap: () {
            _navigateToSubPage(context);
          });

      if (odd) {
        output = Container(color: themeColors().outputListOddRows(), child: row);
      } else {
        output = Container(child: row);
      }
      odd = !odd;

      return output;
    }).toList();

    if (rows.isNotEmpty) {
      rows.insert(0, GCWTextDivider(text: i18n(context, 'coords_variablecoordinate_currentformulas')));
=======
    } else {
      return null;
>>>>>>> 05ad593f1ef25550d7cffee8a14d8c1246eab8e2
    }
  }
}
