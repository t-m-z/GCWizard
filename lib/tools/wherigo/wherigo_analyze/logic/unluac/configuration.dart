import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';

enum Mode {DECOMPILE, DISASSEMBLE, ASSEMBLE}

enum VariableMode {NODEBUG, DEFAULT, FINDER}

class Configuration {
  late bool rawstring;
  late Mode mode;
  late VariableMode variable;
  late bool strict_scope;
  late String? opmap;
  late String? output;

  Configuration() {
    this.rawstring = false;
    this.mode = Mode.DECOMPILE;
    this.variable = VariableMode.DEFAULT;
    this.strict_scope = false;
    this.opmap = null;
    this.output = null;
  }

  Output getOutput() {
    if (this.output != null) {
        return new Output(new FileOutputProvider(new FileOutputStream(this.output)));

    } else {
      return new Output();
    }
  }
}

