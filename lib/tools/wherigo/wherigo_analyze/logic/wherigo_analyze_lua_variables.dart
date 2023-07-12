part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';
<<<<<<< HEAD
=======

List<WherigoVariableData> _analyzeAndExtractVariableSectionData(List<String> lines) {
  List<WherigoVariableData> result = [];
  List<String> _declaration = [];

  for (int i = 0; i < lines.length; i++) {
    if (i < lines.length - 1) {
      if (lines[i + 1].trim().startsWith('buildervar')) {
        _declaration = lines[i]
            .replaceAll(_CartridgeLUAName + '.ZVariables', '')
            .replaceAll('{', '')
            .replaceAll('}', '')
            .split('=');

        result.add(// content not obfuscated
            WherigoVariableData(
                VariableLUAName: _declaration[1].trim(), VariableName: _declaration[2].replaceAll('"', '')));
        break;
      }
    }
    if (!lines[i].startsWith(_CartridgeLUAName + '.ZVariables')) {
      _declaration = lines[i].trim().replaceAll(',', '').split(' = ');
      if (_declaration.length == 2) {
        result.add( // content not obfuscated
            WherigoVariableData(
                VariableLUAName: _declaration[0].trim(), VariableName: _declaration[1].replaceAll('"', '')));
      } else {
        result.add(WherigoVariableData(VariableLUAName: _declaration[0].trim(), VariableName: ''));
      }
    }
  }

  return result;
}
>>>>>>> 05ad593f1ef25550d7cffee8a14d8c1246eab8e2
