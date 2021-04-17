import 'package:gc_wizard/logic/tools/science_and_technology/basic/commands.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/variables.dart';
import 'package:intl/intl.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/basic_data.dart';

class Program {
  String title;
  Map<String, Variable> variables;
  String comment;
  List<Command> commands;
  int serves;
  bool error;
  List<String> errorList;

  Program(String title) {
    this.title = title;
    this.comment = '';
    this.serves = 0;
    this.error = false;
    this.errorList = new List<String>();
  }

  void setVariables(String Input) {
    print('inside setVariables');
    var f = new NumberFormat('###');
    this.variables = Map<String, Variable>();
    var i = 0;
    List<String> variablesInput = Input.split('\n');
    variablesInput.forEach((variableLine) {
      //Clearing the 'Ingredients.' header
      if (i > 0) {
        print('set '+variableLine);
        Variable ing = new Variable(variableLine);
        print('res '+ing.toString());
        if (ing.getName() == 'INVALID') {
          error = true;
          this.errorList.add('basic_interpreter_error_syntax');
          this.errorList.add('basic_interpreter_error_syntax_ingredient');
          this.errorList.add('basic_interpreter_error_syntax_ingredient_name');
          this.errorList.add(f.format(i).toString() + ' : ' + variableLine);
          this.errorList.add('');
          return;
        } else {
          error = false;
          this.variables.addAll({ing.getName().toLowerCase(): ing});
        }
      }
      i++;
    });
  }

  void setComments(String comment) {
    this.comment = comment;
  }

  void setCommands(String command) {
    var f = new NumberFormat('###');
    this.commands = List<Command>();
    List<String> commandList =
        command.replaceAll("\n", " ").replaceAll(". ", ".").split('.');
    for (int i = 1; i < commandList.length - 1; i++) {
      var m = new Command(commandList[i], i);
      if (m.type == Type.INVALID) {
        this.error = true;
        this.errorList.add('basic_interpreter_error_syntax');
        this.errorList.add('basic_interpreter_error_syntax_method');
        this.errorList.add(f.format(i).toString() + ' : ' + commandList[i]);
        this.errorList.add('');
      } else {
        this.commands.add(m);
      }
    }
  }

  void setOutput(String output) {
    if (RegExp(r'^(output )(\d*)(\.)$').hasMatch(output)) {
      this.serves = int.parse(RegExp(r'^(output )(\d*)(\.)$').firstMatch(output).group(2));
    } else {
      this.error = true;
      errorList.add('basic_interpreter_error_syntax');
      errorList.add('basic_interpreter_error_syntax_serves');
      errorList.add('basic_interpreter_error_syntax_serves_without_number');
      errorList.add(output);
      errorList.add('');
    }
  }

  int getOutput() {
    return serves;
  }

  String getTitle() {
    return title;
  }

// double getVariableValue(String s) {
//    return variables[s].getValue();
//  }

//  void setVariableValue(String s, double n) {
//    variables[s].setValue(n);
//  }

  Command getCommand(int i) {
    return commands[i];
  }

  List<Command> getCommands() {
    return commands;
  }

  Map<String, Variable> getVariables() {
    return variables;
  }
}
