import 'dart:math';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/computer.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/program.dart';


bool isValid(String input) {
  bool flag = true;
  if (input == null || input == '') return true;
  List<String> numbers = input.split(' ');
  numbers.forEach((element) {
    if (int.tryParse(element) == null) {
      flag = false;
    }
  });
  return flag;
}

List<String> interpretBasic(String program, input) {
  if (program == null || program == '') return new List<String>();

  return decodeBasic(program, input);
}

List<String> decodeBasic(String program, additionalIngredients) {
  Basic interpreter = Basic(program);
  if (interpreter.valid) {
    interpreter.interpret(additionalIngredients);
    if (interpreter.valid)
      return interpreter.meal;
    else // runtime error
      return interpreter.error;
  } else {
    // invalid recipe
    return interpreter.error;
  }
}

class Basic {
  Map<String, Program> programs;
  Program mainprogram;
  List<String> error;
  bool valid;
  List<String> meal;

  Basic(String program) {
    this.meal = new List<String>();
    valid = true;
    error = new List<String>();
    programs = new Map<String, Program>();
    int progress = 0;
    Program r = null;
    String title = '';
    String line = '';
    bool mainprogramFound = false;
    bool progressError = false;
    bool variablesFound = false;
    bool commandsFound = false;
    bool outputFound = false;
    bool haltFound = false;
    bool titleFound = false;

    program.split("\n\n").forEach((element) {
print('for each: analyse '+element);
      line = element.trim();
      if (line.startsWith("variables")) {
        print('variables found, progress = '+progress.toString());
        if (progress > 3) {
          print('error progress');
          valid = false;
          _addError(2, progress);
          return '';
        }
        progress = 3;
        r.setVariables(line);
        variablesFound = true;
        if (r.error) {
          this.error.addAll(r.errorList);
          valid = false;
          return '';
        }
      } else if (line.startsWith("commands")) {
        print('commands found, progress = '+progress.toString());
        if (progress > 4) {
          print('error progress');
          valid = false;
          _addError(3, progress);
          return '';
        }
        progress = 4;
        print('progress = 4');
        r.setCommands(line);
        print('r.setcommands');
        commandsFound = true;
        print('commandsfound = true');
        if (line.contains('halt')) haltFound = true;
        if (r.error) {
          print('r has errors');
          this.error.addAll(r.errorList);
          this.valid = false;
          return '';
        }
      } else if (line.startsWith("output")) {
        print('output found, progress = '+progress.toString());
        if (progress != 4) {
          print('error progress');
          valid = false;
          _addError(4, progress);
          return '';
        }
        progress = 0;
        r.setOutput(line);
        outputFound = true;
        if (r.error) {
          this.error.addAll(r.errorList);
          this.valid = false;
          return '';
        }
      } else {
        if (progress == 0 || progress >= 4) {
          print('title found, progress = '+progress.toString());
          title = _parseTitle(line);
          titleFound = true;
          r = new Program(line);
          if (mainprogram == null) {
            mainprogram = r;
            mainprogramFound = true;
          }
          progress = 1;
          programs.addAll({title: r});
        } else if (progress == 1) {
          print('comments found, progress = '+progress.toString());
          progress = 2;
          r.setComments(line);
        } else {
          valid = false;
          if (!progressError) {
            progressError = true;
            if (mainprogramFound) {
              error.add('basic_interpreter_error_structure_subrecipe');
            }
            error.addAll([
              'basic_interpreter_error_structure_recipe_read_unexpected_comments_title',
              _progressToExpected(progress),
              'basic_interpreter_hint_recipe_hint',
              _structHint(progress),
              ''
            ]);
          }
          return '';
        }
      }
    });
    if (mainprogram == null) {
      valid = false;
      error.addAll([
        'basic_interpreter_error_structure_recipe',
        'basic_interpreter_error_structure_recipe_empty_missing_title',
        ''
      ]);
      return;
    }
    if (!titleFound) {
      valid = false;
      error.addAll([
        'basic_interpreter_error_structure_recipe',
        'basic_interpreter_error_structure_recipe_missing_title',
        ''
      ]);
      return;
    }
    if (!variablesFound) {
      valid = false;
      error.addAll([
        'basic_interpreter_error_structure_recipe',
        'basic_interpreter_error_structure_recipe_empty_ingredients',
        ''
      ]);
      return;
    }
    if (!commandsFound) {
      valid = false;
      error.addAll([
        'basic_interpreter_error_structure_recipe',
        'basic_interpreter_error_structure_recipe_empty_methods',
        ''
      ]);
      return;
    }
    if (!outputFound && !haltFound) {
      valid = false;
      error.addAll([
        'basic_interpreter_error_structure_recipe',
        'basic_interpreter_error_structure_recipe_empty_serves',
        ''
      ]);
      return;
    }
  } // chef

  String _parseTitle(String title) {
    if (title.endsWith('.')) {
      title = title.substring(0, title.length - 1);
    }
    return title.toLowerCase();
  }

  void _addError(int progressToExpected, int progress) {
    error.add('basic_interpreter_error_structure_recipe');
    if (progressToExpected >= 0) {
      error.addAll([
        'basic_interpreter_error_structure_recipe_read_unexpected',
        _progressToExpected(progressToExpected),
        'basic_interpreter_error_structure_recipe_expecting',
        _progressToExpected(progress),
        ''
      ]);
    } else {
      error.addAll([
        'basic_interpreter_error_structure_recipe_read_unexpected_comments_title',
        _progressToExpected(progress),
        'basic_interpreter_hint_recipe_hint',
        _structHint(progress)
      ]);
    }
    error.add('');
  }

  String _structHint(int progress) {
    switch (progress) {
      case 2:
        return 'basic_interpreter_hint_recipe_ingredients';
      case 3:
        return 'basic_interpreter_hint_recipe_methods';
      case 4:
        return 'basic_interpreter_hint_recipe_oven_temperature';
    }
    return 'basic_interpreter__hint_no_hint_available';
  }

  String _progressToExpected(int progress) {
    String output = '';
    switch (progress) {
      case 0:
        output = 'basic_interpreter_error_structure_recipe_title';
        break;
      case 1:
        output = 'basic_interpreter_error_structure_recipe_comments';
        break;
      case 2:
        output = 'basic_interpreter_error_structure_recipe_ingredient_list';
        break;
      case 3:
        output = 'basic_interpreter_error_structure_recipe_cooking_time';
        break;
      case 4:
        output = 'basic_interpreter_error_structure_recipe_oven_temperature';
        break;
      case 5:
        output = 'basic_interpreter_error_structure_recipe_methods';
        break;
      case 6:
        output = 'basic_interpreter_error_structure_recipe_serve_amount';
        break;
    }
    return output;
  }

  void interpret(additionalIngredients) {
    Computer k = new Computer(this.programs, this.mainprogram, null, null);
    if (k.valid) {
      k.run(additionalIngredients, 1);
    }
    this.valid = k.valid;
    this.meal = k.meal;
    this.error = k.error;
  }
}
