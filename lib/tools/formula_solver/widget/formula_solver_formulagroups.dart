import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/application/theme/fixed_colors.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_paste_button.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_dialog.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_divider.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_checkbox.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_formula_list_editor.dart';
import 'package:gc_wizard/common_widgets/gcw_popup_menu.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_parser.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/gcw_mapview.dart';
import 'package:gc_wizard/tools/coords/variable_coordinate/persistence/json_provider.dart' as var_coords_provider;
import 'package:gc_wizard/tools/coords/variable_coordinate/persistence/model.dart' as var_coords_model;
import 'package:gc_wizard/tools/coords/variable_coordinate/widget/variable_coordinate.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/substitution/logic/substitution.dart';
import 'package:gc_wizard/tools/formula_solver/logic/formula_painter.dart';
import 'package:gc_wizard/tools/formula_solver/logic/formula_parser.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/json_provider.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/utils/json_utils.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:gc_wizard/utils/persistence_utils.dart';
import 'package:gc_wizard/utils/string_utils.dart';
import 'package:gc_wizard/utils/variable_string_expander.dart';
import 'package:prefs/prefs.dart';

part 'package:gc_wizard/tools/formula_solver/widget/formula_replace_dialog.dart';
part 'package:gc_wizard/tools/formula_solver/widget/formula_solver_formulas.dart';
part 'package:gc_wizard/tools/formula_solver/widget/formula_solver_values.dart';
part 'package:gc_wizard/tools/formula_solver/widget/formula_value_type_key_value_input.dart';
part 'package:gc_wizard/tools/formula_solver/widget/formula_value_type_key_value_item.dart';

class FormulaSolverFormulaGroups extends StatefulWidget {
  const FormulaSolverFormulaGroups({Key? key}) : super(key: key);

  @override
  _FormulaSolverFormulaGroupsState createState() => _FormulaSolverFormulaGroupsState();
}

class _FormulaSolverFormulaGroupsState extends State<FormulaSolverFormulaGroups> {

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
            text: i18n(context, 'formulasolver_groups_newgroup'),
            trailing: GCWPasteButton(iconSize: IconButtonSize.SMALL, onSelected: _importFromClipboard)),
        GCWFormulaListEditor(
          formulaList: formulaGroups,
          buildGCWTool: (id) => _buildNavigateGCWTool(id),
          onAddEntry: (name) => _addNewGroup(name),
          onListChanged: () => updateFormulaGroups(),
          newEntryHintText: i18n(context, 'formulasolver_groups_newgroup_hint'),
          middleWidget: GCWTextDivider(text: i18n(context, 'formulasolver_groups_currentgroups')),
          formulaGroups: true,
        ),
      ],
    );
  }

  String _createImportGroupName(String currentName) {
    var baseName = '[${i18n(context, 'common_import')}] $currentName';

    var existingNames = formulaGroups.map((f) => f.name).toList();

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
      var group = FormulaGroup.fromJson(asJsonMap(jsonDecode(data)));
      group.name = _createImportGroupName(group.name);

      setState(() {
        insertGroup(group);
      });
      showToast(i18n(context, 'formulasolver_groups_imported'));
    } catch (e) {
      showToast(i18n(context, 'formulasolver_groups_importerror'));
    }
  }

  void _addNewGroup(String name) {
    if (name.isNotEmpty) {
      var group = FormulaGroup(name);
      insertGroup(group);
    }
  }

<<<<<<< HEAD
  void _updateGroup() {
    updateFormulaGroups();
  }

  void _removeGroup(FormulaGroup group) {
    deleteGroup(group.id);
  }

  void _exportGroup(FormulaGroup group) {
    var mode = TextExportMode.QR;
    String text = jsonEncode(group.toMap()).toString();
    text = normalizeCharacters(text);
    var contentWidget = GCWTextExport(
      text: text,
      onModeChanged: (value) {
        mode = value;
      },
    );
    showGCWDialog(
        context,
        i18n(context, 'formulasolver_groups_exportgroup'),
        contentWidget,
        [
          GCWDialogButton(
            text: i18n(context, 'common_exportfile_saveoutput'),
            onPressed: () {
              exportFile(text, mode, context);
            },
          ),
          const GCWDialogButton(
            text: 'OK',
          )
        ],
        cancelButton: false);
  }

  Column _buildGroupList(BuildContext context) {
    var odd = true;
    var rows = formulaGroups.map((group) {
      var formulaTool = GCWTool(
        tool: _FormulaSolverFormulas(group: group),
        toolName: '${group.name} - ${i18n(context, 'formulasolver_formulas')}',
        helpSearchString: 'formulasolver_formulas',
        defaultLanguageToolName: '${group.name} - ${i18n(context, 'formulasolver_formulas', useDefaultLanguage: true)}',
        id: '',
      );

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
                child: _currentEditId == group.id
                    ? Padding(
                        padding: const EdgeInsets.only(
                          right: 2,
                        ),
                        child: GCWTextField(
                          controller: _editGroupController,
                          autofocus: true,
                          onChanged: (text) {
                            setState(() {
                              _currentEditedName = text;
                            });
                          },
                        ),
                      )
                    : IgnorePointer(
                        child: Column(
                        children: <Widget>[
                          GCWText(text: group.name),
                          Container(
                            padding: const EdgeInsets.only(left: DEFAULT_DESCRIPTION_MARGIN),
                            child: GCWText(
                              text: '${group.formulas.length} ' +
                                  i18n(context,
                                      group.formulas.length == 1 ? 'formulasolver_formula' : 'formulasolver_formulas'),
                              style: gcwDescriptionTextStyle(),
                            ),
                          )
                        ],
                      )),
              ),
              _currentEditId == group.id
                  ? GCWIconButton(
                      icon: Icons.check,
                      onPressed: () {
                        group.name = _currentEditedName;
                        _updateGroup();

                        setState(() {
                          _currentEditId = null;
                          _editGroupController.clear();
                        });
                      },
                    )
                  : Container(),
              GCWPopupMenu(
                  iconData: Icons.settings,
                  menuItemBuilder: (context) => [
                        GCWPopupMenuItem(
                            child: iconedGCWPopupMenuItem(context, Icons.edit, 'formulasolver_groups_editgroup'),
                            action: (index) => setState(() {
                                  _currentEditId = group.id;
                                  _currentEditedName = group.name;
                                  _editGroupController.text = group.name;
                                })),
                        GCWPopupMenuItem(
                            child: iconedGCWPopupMenuItem(context, Icons.delete, 'formulasolver_groups_removegroup'),
                            action: (index) => showDeleteAlertDialog(context, group.name, () {
                                  _removeGroup(group);
                                  setState(() {});
                                })),
                        GCWPopupMenuItem(
                            child: iconedGCWPopupMenuItem(context, Icons.forward, 'formulasolver_groups_exportgroup'),
                            action: (index) => _exportGroup(group)),
                      ])
            ],
          ),
          onTap: () {
            _navigateToSubPage(context);
          });

      if (odd) {
        output = Container(color: _themeColors.outputListOddRows(), child: row);
      } else {
        output = Container(child: row);
      }
      odd = !odd;

      return output;
    }).toList();

    if (rows.isNotEmpty) {
      rows.insert(0, GCWTextDivider(text: i18n(context, 'formulasolver_groups_currentgroups')));
=======
  GCWTool? _buildNavigateGCWTool(int id) {
    var entry = formulaGroups.firstWhereOrNull((formula) => formula.id == id);

    if (entry != null) {
      return GCWTool(
        tool: _FormulaSolverFormulas(group: entry),
        toolName: '${entry.name} - ${i18n(context, 'formulasolver_formulas')}',
        helpSearchString: 'formulasolver_formulas',
        defaultLanguageToolName:
        '${entry.name} - ${i18n(context, 'formulasolver_formulas', useDefaultLanguage: true)}',
        id: '',);
    } else {
      return null;
>>>>>>> 05ad593f1ef25550d7cffee8a14d8c1246eab8e2
    }
  }
}
