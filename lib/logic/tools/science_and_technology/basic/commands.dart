import 'package:gc_wizard/logic/tools/science_and_technology/basic/basic_data.dart';

class Command {
  String variable;
  String variableOp1;
  String variableOp2;
  int stack;
  int output;
  String auxprogram;
  int time; //'Refrigerate for number of hours' / 'Stir for number of minutes'
  String verb;
  Type type;
  int n;

  Command(String line, int n) {
    line = line.trim();
    this.n = n;
    type = Type.INVALID;
    variable = line;
print('inside command '+line+' '+n.toString());
    if (matchers[0].hasMatch(line)) {
      // input
      variable = matchers[0].firstMatch(line).group(1);
      type = Type.INPUT;
    }
    if (matchers[1].hasMatch(line)) {
      // push | pop  RegExp(r'^(push|pop) ([a-z0-9]+)(( to| from)?( (\d+)(nd|rd|th|st))? stack)?$')
      if (matchers[1].firstMatch(line).group(1) == 'push')
        type = Type.PUSH;
      else
        type = Type.POP;
      variable = matchers[1].firstMatch(line).group(2);
      stack = (matchers[1].firstMatch(line).group(6) == null
              ? 1
              : int.parse(matchers[1].firstMatch(line).group(6))) -
          1;
    }
    if (matchers[2].hasMatch(line)) {
      // add | sub | mult | div
      switch (matchers[2].firstMatch(line).group(1)) {
        case 'add':
          type = Type.ADD;
          break;
        case 'sub':
          type = Type.SUB;
          break;
        case 'mult':
          type = Type.MULT;
          break;
        case 'div':
          type = Type.DIV;
          break;
      }
      variable = matchers[2].firstMatch(line).group(3);
      stack = (matchers[2].firstMatch(line).group(8) == null
              ? 1
              : int.parse(matchers[2].firstMatch(line).group(8))) -
          1;
    }
    if (matchers[3].hasMatch(line)) {
      //to Char stack
      type = Type.ToCharStack;
      stack = (matchers[3].firstMatch(line).group(3) == null
              ? 1
              : int.parse(matchers[3].firstMatch(line).group(3))) -
          1;
    }
    if (matchers[4].hasMatch(line)) {
      //to Char
      type = Type.TOCHAR;
      variable = matchers[4].firstMatch(line).group(2);
    }
    if (matchers[5].hasMatch(line)) {
      // stir the
      type = Type.Stir;
      stack = (matchers[5].firstMatch(line).group(4) == null
              ? 1
              : int.parse(matchers[5].firstMatch(line).group(4))) -
          1;
      time = int.parse(matchers[5].firstMatch(line).group(6));
    }
    if (matchers[6].hasMatch(line)) {
      // stir into
      type = Type.StirInto;
      variable = matchers[6].firstMatch(line).group(2);
      stack = (matchers[6].firstMatch(line).group(5) == null
              ? 1
              : int.parse(matchers[6].firstMatch(line).group(5))) -
          1;
    }
    if (matchers[7].hasMatch(line)) {
      // mix
      type = Type.Mix;
      stack = (matchers[7].firstMatch(line).group(4) == null
              ? 1
              : int.parse(matchers[7].firstMatch(line).group(4))) -
          1;
    }
    if (matchers[8].hasMatch(line)) {
      // clear
      type = Type.CLEAR;
      stack = (matchers[8].firstMatch(line).group(3) == null
              ? 1
              : int.parse(matchers[8].firstMatch(line).group(3))) -
          1;
    }
    if (matchers[9].hasMatch(line)) {
      // write stack to ouput
      type = Type.Write;
      stack = (matchers[9].firstMatch(line).group(2) == null
              ? 1
              : int.parse(matchers[9].firstMatch(line).group(2))) - 1;
      output = (matchers[9].firstMatch(line).group(5) == null
              ? 1
              : int.parse(matchers[9].firstMatch(line).group(5))) - 1;
    }
    if (matchers[10].hasMatch(line)) {
      // break loop
      type = Type.BREAK;
    }
    if (matchers[11].hasMatch(line)) {
      // halt
      type = Type.HALT;
      time = matchers[11].firstMatch(line).group(2) == null
          ? 0
          : int.parse(matchers[11].firstMatch(line).group(2));
    }
    if (matchers[12].hasMatch(line)) {
      // gosub subroutine
      type = Type.GOSUB;
      auxprogram = matchers[12].firstMatch(line).group(2);
    }
    if (matchers[13].hasMatch(line)) {
      // xxx (the) variable until yyyed
      type = Type.VerbUntil;
      verb = matchers[13].firstMatch(line).group(5);
      variable = matchers[13].firstMatch(line).group(4);
    }
    if (matchers[14].hasMatch(line)) {
      // yyy (the) variable
      type = Type.Verb;
      verb = matchers[14].firstMatch(line).group(1);
      variable = matchers[14].firstMatch(line).group(3);
    }
    if (matchers[15].hasMatch(line)) {
      // print
      type = Type.PRINT;
      variable = matchers[15].firstMatch(line).group(1);
    }
    if (matchers[16].hasMatch(line)) {
      // + | - | * | / | div | mod |
      switch (matchers[16].firstMatch(line).group(6)) {
        case '+':
          type = Type.MATHPLUS;
          break;
        case '-':
          type = Type.MATHMINUS;
          break;
        case '*':
          type = Type.MATHMULT;
          break;
        case '/':
          type = Type.MATHDIV;
          break;
        case 'div':
          type = Type.MATHINTDIV;
          break;
        case 'mod':
          type = Type.MATHMOD;
          break;
      }
      variable = matchers[16].firstMatch(line).group(1);
      variableOp1 = matchers[16].firstMatch(line).group(4);
      variableOp2 = matchers[16].firstMatch(line).group(8);
    }
    if (matchers[17].hasMatch(line)) {
      // sin | cos | tan | sqrt | ln | log
      switch (matchers[17].firstMatch(line).group(6)) {
        case 'sin':
          type = Type.MATHSIN;
          break;
        case 'cos':
          type = Type.MATHCOS;
          break;
        case 'tan':
          type = Type.MATHTAN;
          break;
        case 'sqrt':
          type = Type.MATHSQRT;
          break;
        case 'ln':
          type = Type.MATHLN;
          break;
        case 'log':
          type = Type.MATHLOG;
          break;
      }
      variable = matchers[17].firstMatch(line).group(1);
      variableOp1 = matchers[17].firstMatch(line).group(4);
    }
    if (matchers[18].hasMatch(line)) {
      // pow
      switch (matchers[18].firstMatch(line).group(4)) {
        case 'pow':
          type = Type.MATHPOW;
          break;
      }
      variable = matchers[18].firstMatch(line).group(1);
      variableOp1 = matchers[18].firstMatch(line).group(6);
      variableOp2 = matchers[18].firstMatch(line).group(8);
    }

  }
}
