import 'dart:convert';

import 'package:gc_wizard/persistence/multi_decoder/model.dart';
import 'package:gc_wizard/persistence/utils.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:prefs/prefs.dart';

void refreshMultiDecoderTools() {
  var tools = Prefs.getStringList(PREFERENCE_MULTIDECODER_TOOLS);
  if (tools == null || tools.length == 0) return;

  multiDecoderTools = tools.where((tool) => tool.length > 0).map((tool) {
    return MultiDecoderTool.fromJson(jsonDecode(tool));
  }).toList();
}

_saveData() {
  var jsonData = multiDecoderTools.map((tool) => jsonEncode(tool.toMap())).toList();
  Prefs.setStringList(PREFERENCE_MULTIDECODER_TOOLS, jsonData);
}

int insertMultiDecoderTool(MultiDecoderTool tool) {
  tool.name = tool.name ?? '';
  var id = newID(multiDecoderTools.map((group) => group.id).toList());
  tool.id = id;
  multiDecoderTools.insert(0, tool);

  _saveData();

  return id;
}

void deleteMultiDecoderTool(int toolId) {
  multiDecoderTools.removeWhere((tool) => tool.id == toolId);

  _saveData();
}

void clearMultiDecoderTools() {
  multiDecoderTools.clear();

  _saveData();
}

int moveMultiDecoderToolUp(int toolId) {
  var index = multiDecoderTools.indexWhere((tool) => tool.id == toolId);
  if (index == 0) return index;

  var tool = multiDecoderTools.removeAt(index);
  multiDecoderTools.insert(index - 1, tool);

  _saveData();

  return index;
}

int moveMultiDecoderToolDown(int toolId) {
  var index = multiDecoderTools.indexWhere((tool) => tool.id == toolId);
  if (index == multiDecoderTools.length - 1) return index;

  var tool = multiDecoderTools.removeAt(index);
  multiDecoderTools.insert(index + 1, tool);

  _saveData();

  return index;
}

void updateMultiDecoderTools() {
  _saveData();
}

void updateMultiDecoderTool(MultiDecoderTool tool) {
  multiDecoderTools = multiDecoderTools.map((currentTool) {
    if (currentTool.id == tool.id) return tool;

    return currentTool;
  }).toList();

  _saveData();
}
