import 'package:gc_wizard/logic/tools/science_and_technology/basic/basic_data.dart';

class Command {
  String variable;
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
    print('analyse >' + line + '<');
    List<RegExp> matchers = new List<RegExp>();
    matchers = matchersENG;
    if (matchers[0].hasMatch(line)) {
      // input
      variable = matchers[0].firstMatch(line).group(1);
      type = Type.INPUT;
      print(variable + ' ' + type.toString());
    } else if (matchers[1].hasMatch(line)) {
      // push | pop
      if (matchers[1].firstMatch(line).group(1) == 'push')
        type = Type.PUSH;
      else
        type = Type.POP;
      variable = matchers[1].firstMatch(line).group(2);
      stack = (matchers[1].firstMatch(line).group(6) == null
              ? 1
              : int.parse(matchers[1].firstMatch(line).group(6))) -
          1;
    } else if (matchers[2].hasMatch(line)) {
      // add dry variables
      type = Type.AddDry;
      stack = (matchers[2].firstMatch(line).group(5) == null
              ? 1
              : int.parse(matchers[2].firstMatch(line).group(5))) -
          1;
    } else if (matchers[3].hasMatch(line)) {
      // add | remove | combine | divide
      switch (matchers[3].firstMatch(line).group(1)) {
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
      variable = matchers[3].firstMatch(line).group(3);
      stack = (matchers[3].firstMatch(line).group(8) == null
              ? 1
              : int.parse(matchers[3].firstMatch(line).group(8))) -
          1;
    } else if (matchers[4].hasMatch(line)) {
      //liquefy contents
      type = Type.ToCharStack;
      stack = (matchers[4].firstMatch(line).group(3) == null
              ? 1
              : int.parse(matchers[4].firstMatch(line).group(3))) -
          1;
    } else if (matchers[5].hasMatch(line)) {
      //liquefy
      type = Type.TOCHAR;
      variable = matchers[5].firstMatch(line).group(2);
    } else if (matchers[6].hasMatch(line)) {
      // stir the
      type = Type.Stir;
      stack = (matchers[6].firstMatch(line).group(4) == null
              ? 1
              : int.parse(matchers[6].firstMatch(line).group(4))) -
          1;
      time = int.parse(matchers[6].firstMatch(line).group(6));
    } else if (matchers[7].hasMatch(line)) {
      // stir into
      type = Type.StirInto;
      variable = matchers[7].firstMatch(line).group(2);
      stack = (matchers[7].firstMatch(line).group(5) == null
              ? 1
              : int.parse(matchers[7].firstMatch(line).group(5))) -
          1;
    } else if (matchers[8].hasMatch(line)) {
      // mix
      type = Type.Mix;
      stack = (matchers[8].firstMatch(line).group(4) == null
              ? 1
              : int.parse(matchers[8].firstMatch(line).group(4))) -
          1;
    } else if (matchers[9].hasMatch(line)) {
      // clean
      type = Type.CLEAR;
      stack = (matchers[9].firstMatch(line).group(3) == null
              ? 1
              : int.parse(matchers[9].firstMatch(line).group(3))) -
          1;
    } else if (matchers[10].hasMatch(line)) {
      // pour
      type = Type.Write;
      stack = (matchers[10].firstMatch(line).group(4) == null
              ? 1
              : int.parse(matchers[10].firstMatch(line).group(4))) -
          1;
      output = (matchers[10].firstMatch(line).group(8) == null
              ? 1
              : int.parse(matchers[10].firstMatch(line).group(8))) -
          1;
      print(type.toString()+' '+stack.toString()+' '+output.toString());
    } else if (matchers[11].hasMatch(line)) {
      // set aside
      type = Type.BREAK;
    } else if (matchers[12].hasMatch(line)) {
      // refridgerate
      type = Type.Refrigerate;
      time = matchers[12].firstMatch(line).group(2) == null
          ? 0
          : int.parse(matchers[12].firstMatch(line).group(2));
    } else if (matchers[13].hasMatch(line)) {
      // serve with
      type = Type.GOSUB;
      auxprogram = matchers[13].firstMatch(line).group(2);
    } else if (matchers[14].hasMatch(line)) {
      // suggestion
      type = Type.Remember;
    } else if (matchers[15].hasMatch(line)) {
      // xxx (the) variable until yyyed
      type = Type.VerbUntil;
      verb = matchers[15].firstMatch(line).group(5);
      variable = matchers[15].firstMatch(line).group(4);
    } else if (matchers[16].hasMatch(line)) {
      // yyy (the) variable
      type = Type.Verb;
      verb = matchers[16].firstMatch(line).group(1);
      variable = matchers[16].firstMatch(line).group(3);
    } else {
      print('no match for ' + line);
      // invalid method
      type = Type.INVALID;
      variable = line;
    }
  }
}
