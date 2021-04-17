import 'dart:math';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/container.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/component.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/variables.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/commands.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/program.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/basic_data.dart';

class Computer {
  List<Container> stacks;
  List<Container> ouputs;
  Map<String, Program> programs;
  Program program;
  bool valid;
  bool exception;
  List<String> error;
  List<String> meal;

  Computer(Map<String, Program> programs, Program mainprogram, List<Container> mbowls, List<Container> bdishes) {
    this.valid = true;
    this.exception = false;
    this.meal = new List<String>();
    this.error = new List<String>();
    this.programs = programs;
    //start with at least 1 mixing bowl.
    int maxbowl = 0, maxdish = -1;
    this.program = mainprogram;
    if (this.program.getCommands() != null) {
      this.program.getCommands().forEach((m) {
        if (m.output != null && m.output > maxdish) maxdish = m.output;
        if (m.stack != null && m.stack > maxbowl) maxbowl = m.stack;
      });

      this.stacks = new List<Container>(mbowls == null ? maxbowl + 1 : max(maxbowl + 1, mbowls.length));
      for (int i = 0; i < this.stacks.length; i++) this.stacks[i] = new Container(null);
      if (mbowls != null) {
        for (int i = 0; i < mbowls.length; i++) {
          this.stacks[i] = new Container(mbowls[i]);
        }
      }

      this.ouputs = new List<Container>(bdishes == null ? maxdish + 1 : max(maxdish + 1, bdishes.length));
      for (int i = 0; i < this.ouputs.length; i++) this.ouputs[i] = new Container(null);
      if (bdishes != null) {
        for (int i = 0; i < bdishes.length; i++) {
          this.ouputs[i] = new Container(bdishes[i]);
        }
      }
    } else {
      valid = false;
      error.addAll([
        'basic_interpreter_error_structure_recipe',
        'basic_interpreter_error_structure_recipe_methods',
        'basic_interpreter_error_syntax_method',
        ''
      ]);
    }
  }

  Container run(String additionalVariables, int depth) {
    int ingredientIndex = 0;
    List<String> input = additionalVariables.split(' ');

    Map<String, Variable> variables = program.getVariables();
    List<Command> commands = program.getCommands();
    var loops = List<_LoopData>();
    Component c;
    int i = 0;
    bool deepfrozen = false;
    bool exceptionArose = false;
    methodloop:
    while (i < commands.length && !deepfrozen && !exceptionArose) {
      Command m = commands[i];
      switch (m.type) {
        case Type.INVALID:
          valid = false;
          error.addAll([
            'basic_interpreter_error_syntax_method',
            m.variable,
            'basic_interpreter_error_syntax_method_unsupported',
            ''
          ]);
          return null;
          break;
        case Type.INPUT:
        case Type.PUSH:
        case Type.POP:
        case Type.ADD:
        case Type.SUB:
        case Type.MULT:
        case Type.DIV:
        case Type.TOCHAR:
        case Type.StirInto:
        case Type.Verb:
          if (variables[m.variable] == null) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_method_step',
              m.n.toString() + ' : ' + m.type.toString(),
              'basic_interpreter_error_runtime_ingredient_not_found',
              m.variable,
              ''
            ]);
            return null;
          }
      }
      switch (m.type) {
        case Type.INPUT:
          if ((input.join('') != '') && (ingredientIndex <= input.length - 1)) {
            variables[m.variable].setValue(double.parse(input[ingredientIndex]));
            ingredientIndex++;
          } else {
            valid = false;
            error.addAll(
                ['basic_interpreter_error_runtime', 'basic_interpreter_error_runtime_missing_input', '']);
            return null;
          }
          break;

        case Type.PUSH:
          stacks[m.stack].push(Component.Contructor1(variables[m.variable]));
          break;

        case Type.POP:
          if (stacks[m.stack].size() == 0) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_folded_from_empty_mixing_bowl',
              'basic_interpreter_error_runtime_method_step',
              m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.stack + 1).toString(),
              ''
            ]);
            return null;
          }
          c = stacks[m.stack].pop();
          variables[m.variable].setValue(c.getValue());
          variables[m.variable].setDataType(c.getDataType());
          break;

        case Type.ADD:
          if (stacks[m.stack].size() == 0) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_add_to_empty_mixing_bowl',
              'basic_interpreter_error_runtime_method_step',
              m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.stack + 1).toString(),
              ''
            ]);
            return null;
          }
          c = stacks[m.stack].peek();
          c.setValue(c.getValue() + variables[m.variable].getValue());
          break;

        case Type.SUB: // ingredient.amount from mixingbowl
          if (stacks[m.stack].size() == 0) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_remove_from_empty_mixing_bowl',
              'basic_interpreter_error_runtime_method_step',
              m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.stack + 1).toString(),
              ''
            ]);
            return null;
          }
          c = stacks[m.stack].peek(); // returns top of m.mixingbowl
          c.setValue(c.getValue() - variables[m.variable].getValue());
          break;

        case Type.MULT:
          if (stacks[m.stack].size() == 0) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_combine_with_empty_mixing_bowl',
              'basic_interpreter_error_runtime_method_step',
              m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.stack + 1).toString(),
              ''
            ]);
            return null;
          }
          c = stacks[m.stack].peek();
          c.setValue(c.getValue() * variables[m.variable].getValue());
          break;

        case Type.DIV:
          if (stacks[m.stack].size() == 0) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_divide_from_empty_mixing_bowl',
              'basic_interpreter_error_runtime_method_step',
              m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.stack + 1).toString()
            ]);
            return null;
          }
          c = stacks[m.stack].peek();
          c.setValue((c.getValue() / variables[m.variable].getValue()));
          break;

        case Type.AddDry:
          double sum = 0;
          variables.forEach((key, value) {
            if (value.getDataType() == DataType.DOUBLE) sum += value.getValue();
          });
          stacks[m.stack].push(new Component(sum, DataType.DOUBLE, ''));
          break;

        case Type.TOCHAR:
          variables[m.variable].toChar();
          break;

        case Type.ToCharStack:
          stacks[m.stack].liquefy();
          break;

        case Type.Stir:
          if (stacks[m.stack].size() == 0) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_stir_empty_mixing_bowl',
              'basic_interpreter_error_runtime_method_step',
              m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.stack + 1).toString()
            ]);
            return null;
          }
          stacks[m.stack].stir(m.time);
          break;

        case Type.StirInto:
          if (stacks[m.stack].size() == 0) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_stir_in_empty_mixing_bowl',
              'basic_interpreter_error_runtime_method_step',
              m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.stack + 1).toString()
            ]);
            return null;
          }
          stacks[m.stack].stir(variables[m.variable].getValue().round());
          break;

        case Type.Mix:
          if (stacks[m.stack].size() == 0) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_mix_empty_mixing_bowl',
              'basic_interpreter_error_runtime_method_step',
              m.n.toString() + ' : ' + m.type.toString() + ' => ' + (m.stack + 1).toString()
            ]);
            return null;
          }
          stacks[m.stack].shuffle();
          break;

        case Type.CLEAR:
          stacks[m.stack].clean();
          break;

        case Type.Write:
          ouputs[m.output].combine(stacks[m.stack]);
          break;

        case Type.Verb:
          int end = i + 1;
          for (; end < commands.length; end++) {
            if (_sameVerb(m.verb, commands[end].verb) &&
                (commands[end].type == Type.VerbUntil)) {
              break;
            }
          }
          if (end == commands.length) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_method_loop',
              m.n.toString() + ' : ' + m.type.toString()
            ]);
            return null;
          }
          if (variables[m.variable].getValue() <= 0) {
            i = end + 1;
            continue methodloop;
          } else
            loops.insertAll(0, {_LoopData(i, end, m.verb)});
          break;

        case Type.VerbUntil:
          if (!_sameVerb(loops[0].verb, m.verb)) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_method_loop_end',
              m.n.toString() + ' : ' + m.type.toString()
            ]);
            return null;
          }
          if (variables[m.variable] != null)
            variables[m.variable].setValue((variables[m.variable].getValue() - 1) * 1.0);
          i = loops[0].from;
          loops.removeAt(0);
          continue methodloop;

        case Type.BREAK:
          if (loops.length == 0) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_method_loop_aside',
              m.n.toString() + ' : ' + m.type.toString()
            ]);
            return null;
          } else {
            i = loops[0].to + 1;
            loops.removeAt(0);
            continue methodloop;
          }
          break;

        case Type.GOSUB:
          if (programs[m.auxprogram.toLowerCase()] == null) {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_method_aux_recipe',
              m.n.toString() + ' : ' + m.type.toString() + ' => ' + m.auxprogram
            ]);
            return null;
          }
          try {
            Computer k = new Computer(programs, programs[m.auxprogram.toLowerCase()], stacks, ouputs);
            Container con = k.run(additionalVariables, depth + 1);
            if (k.exception) {
              valid = false;
              exception = true;
              exceptionArose = true;
              //error.removeRange(0, error.length-1);
              error.addAll(k.error);
              continue methodloop;
            } else if (con != null)
              stacks[0].combine(con);
            else {
              valid = false;
              error.addAll([
                'basic_interpreter_error_runtime',
                'basic_interpreter_error_runtime_method_aux_recipe',
                'basic_interpreter_error_runtime_method_aux_recipe_return'
              ]);
              return null;
            }
          } catch (e) {
            valid = false;
            exception = true;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_runtime_exception',
              'basic_interpreter_error_runtime_serving_aux',
              e.toString(),
              ' at depth ' + depth.toString()
            ]);
            exceptionArose = true;
            continue methodloop;
          }
          break;

        case Type.Refrigerate:
          if (m.time > 0) {
            _serve(m.time);
          }
          deepfrozen = true;
          break;

        case Type.Remember:
          break;
        default:
          {
            valid = false;
            error.addAll([
              'basic_interpreter_error_runtime',
              'basic_interpreter_error_syntax_method_unsupported',
              m.n.toString() + ' : ' + m.type.toString()
            ]);
            return null;
          }
      }
      i++;
    } // end of MethodLoop - all is done
    if (!exceptionArose) {
      if (program.getOutput() > 0 && !deepfrozen) {
        _serve(program.getOutput());
      }
      if (stacks.length > 0) {
        return stacks[0];
      } // end of auxiliary recipe
      //return null;  // end of mainrecipe
    }
  } // cook

  bool _sameVerb(String imp, verb) {
    if (verb == null || imp == null) return false;
    verb = verb.toLowerCase();
    imp = imp.toLowerCase();
    int L = imp.length;
      return verb == (imp + "n") || //shake ~ shaken
          verb == (imp + "d") || //prepare ~ prepared
          verb == (imp + "ed") || //monitor ~ monitored
          verb == (imp + (imp[L - 1]) + "ed") || //stir ~ stirred
          (imp[L - 1] == 'y' && verb == (imp.substring(0, L - 1) + "ied")); //carry ~ carried
  }

  void _serve(int n) {
    for (int i = 0; i < n && i < ouputs.length; i++) {
      meal.add(ouputs[i].serve());
    }
  }
}

class _LoopData {
  int from, to;
  String verb;

  _LoopData(int from, int to, String verb) {
    this.from = from;
    this.to = to;
    this.verb = verb;
  }
}
