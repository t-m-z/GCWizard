import 'dart:math';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/computer.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/program.dart';

List<String> interpretBasic(String program, input) {
  if (program == null || program == '') return new List<String>();

  return decodeBasic(program, input);
}

List<String> decodeBasic(String program, input) {
  Basic interpreter = Basic(program);
  if (interpreter.valid) {
    interpreter.interpret(input);
    if (interpreter.valid)
      return interpreter.output;
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
  List<String> output;

  Basic(String program) {
    this.output = new List<String>();
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
      print('for each: analyse ' + element);
      line = element.trim();
      if (line.startsWith("variables")) {
        print('variables found, progress = ' + progress.toString());
        if (progress > 3) {
          print('error progress');
          valid = false;
          _addError(2, progress);
          return '';
        }
        progress = 3;
        print('progress = 3');
        r.setVariables(line);
        print('variables set done');
        variablesFound = true;
        if (r.error) {
          this.error.addAll(r.errorList);
          valid = false;
          return '';
        }
      } else if (line.startsWith("commands")) {
        print('commands found, progress = ' + progress.toString());
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
        print('output found, progress = ' + progress.toString());
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
          print('title found, progress = ' + progress.toString());
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
          print('comments found, progress = ' + progress.toString());
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

  void interpret(input) {
    Computer k = new Computer(this.programs, this.mainprogram, null, null);
    if (k.valid) {
      k.run(input, 1);
    }
    this.valid = k.valid;
    this.output = k.output;
    this.error = k.error;
  }
}

//******************************************************************************
final MAX_NUMLEN = 6;

final TOKENIZER_ERROR = 0;
final TOKENIZER_ENDOFINPUT = 1;
final TOKENIZER_NUMBER = 10;
final TOKENIZER_STRING = 11;
final TOKENIZER_VARIABLE = 12;
final TOKENIZER_LET = 20;
final TOKENIZER_PRINT = 21;
final TOKENIZER_IF = 22;
final TOKENIZER_THEN = 23;
final TOKENIZER_ELSE = 24;
final TOKENIZER_FOR = 25;
final TOKENIZER_TO = 26;
final TOKENIZER_NEXT = 27;
final TOKENIZER_GOTO = 28;
final TOKENIZER_GOSUB = 29;
final TOKENIZER_RETURN = 30;
final TOKENIZER_CALL = 31;
final TOKENIZER_REM = 32;
final TOKENIZER_PEEK = 33;
final TOKENIZER_POKE = 34;
final TOKENIZER_END = 35;
final TOKENIZER_COMMA = 40;
final TOKENIZER_SEMICOLON = 41;
final TOKENIZER_PLUS = 50;
final TOKENIZER_MINUS = 51;
final TOKENIZER_AND = 52;
final TOKENIZER_OR = 53;
final TOKENIZER_ASTR = 54;
final TOKENIZER_SLASH = 55;
final TOKENIZER_MOD = 56;
final TOKENIZER_HASH = 57;
final TOKENIZER_LEFTPAREN = 58;
final TOKENIZER_RIGHTPAREN = 59;
final TOKENIZER_LT = 60;
final TOKENIZER_GT = 61;
final TOKENIZER_EQ = 62;
final TOKENIZER_CR = 63;

class keywordToken {
  final String keyword;
  final int token;

  keywordToken(this.keyword, this.token);
}

List keyword_token = [
  keywordToken("let", TOKENIZER_LET),
  keywordToken("print", TOKENIZER_PRINT),
  keywordToken("if", TOKENIZER_IF),
  keywordToken("then", TOKENIZER_THEN),
  keywordToken("else", TOKENIZER_ELSE),
  keywordToken("for", TOKENIZER_FOR),
  keywordToken("to", TOKENIZER_TO),
  keywordToken("next", TOKENIZER_NEXT),
  keywordToken("goto", TOKENIZER_GOTO),
  keywordToken("gosub", TOKENIZER_GOSUB),
  keywordToken("return", TOKENIZER_RETURN),
  keywordToken("call", TOKENIZER_CALL),
  keywordToken("rem", TOKENIZER_REM),
  keywordToken("peek", TOKENIZER_PEEK),
  keywordToken("poke", TOKENIZER_POKE),
  keywordToken("end", TOKENIZER_END),
  keywordToken("NULL", TOKENIZER_ERROR)
];

int singlechar() {
  if (ptr == '\n') {
    return TOKENIZER_CR;
  } else if (ptr == ',') {
    return TOKENIZER_COMMA;
  } else if (ptr == ';') {
    return TOKENIZER_SEMICOLON;
  } else if (ptr == '+') {
    return TOKENIZER_PLUS;
  } else if (ptr == '-') {
    return TOKENIZER_MINUS;
  } else if (ptr == '&') {
    return TOKENIZER_AND;
  } else if (ptr == '|') {
    return TOKENIZER_OR;
  } else if (ptr == '*') {
    return TOKENIZER_ASTR;
  } else if (ptr == '/') {
    return TOKENIZER_SLASH;
  } else if (ptr == '%') {
    return TOKENIZER_MOD;
  } else if (ptr == '(') {
    return TOKENIZER_LEFTPAREN;
  } else if (ptr == '#') {
    return TOKENIZER_HASH;
  } else if (ptr == ')') {
    return TOKENIZER_RIGHTPAREN;
  } else if (ptr == '<') {
    return TOKENIZER_LT;
  } else if (ptr == '>') {
    return TOKENIZER_GT;
  } else if (ptr == '=') {
    return TOKENIZER_EQ;
  }
  return TOKENIZER_ERROR;
}

void tokenizer_goto(String program) {
  ptr = program;
  current_token = get_next_token();
}

int tokenizer_token() {
  return current_token;
}

void tokenizer_init(String program) {
  tokenizer_goto(program);
  current_token = get_next_token();
}

bool tokenizer_finished() {
  return (ptrIndex == 0 || current_token == TOKENIZER_ENDOFINPUT);
}

int tokenizer_num() {
  return int.parse(ptr);
}

String tokenizer_pos() {
  return ptr;
}

void tokenizer_error_print(){
print("tokenizer_error_print: '%s" + ptr);
}

void tokenizer_next() {
  if(tokenizer_finished()) {
    return;
  }

  print("tokenizer_next: %p " + nextptr);
  ptr = nextptr;

  while(ptr[ptrIndex] == ' ') {
    ++ptrIndex;
  }
  current_token = get_next_token();

  if(current_token == TOKENIZER_REM) {
    while(nextptr[nextptrIndex] != '\n' || tokenizer_finished()) {
        ++nextptrIndex;
    }
    if(nextptr[nextptrIndex] == '\n') {
      ++nextptrIndex;
    }
    tokenizer_next();
  }

  print ("tokenizer_next: '%s' %d " + ptr + ' ' + current_token.toString());
  return;
}

int get_next_token() {
  keywordToken kt;
  int i;

  print("get_next_token(): '%s'\n" + ptr);

  if (ptrIndex == 0) {
    return TOKENIZER_ENDOFINPUT;
  }

  if (int.tryParse(ptr[ptrIndex]) != null) {
    for (i = 0; i < MAX_NUMLEN; ++i) {
      if (int.tryParse(ptr[ptrIndex + 1 + i]) == null) {
        if (i > 0) {
          nextptrIndex = ptrIndex + i;
          return TOKENIZER_NUMBER;
        } else {
          print("get_next_token: error due to too short number");
          return TOKENIZER_ERROR;
        }
      }
      if (int.tryParse(ptr[ptrIndex + 1 + i]) == null) {
        print("get_next_token: error due to malformed number");
        return TOKENIZER_ERROR;
      }
    }
    print("get_next_token: error due to too long number\n");
    return TOKENIZER_ERROR;
  } else if (singlechar() != 0) {
    nextptrIndex = ptrIndex + 1;
    return singlechar();
  } else if (ptr[ptrIndex] == '"') {
    nextptr = ptr;
    do {
      ++nextptrIndex;
    } while (nextptr[nextptrIndex] != '"');
    ++nextptrIndex;
    return TOKENIZER_STRING;
  } else {
    keyword_token.forEach((element) {
      if (kt.keyword == ptr.substring(kt.keyword.length)) {
        nextptrIndex = ptrIndex + kt.keyword.length;
        return kt.token;
      }
    });
  }

  if (ptr[ptrIndex].codeUnitAt(0) >= 65 && ptr[ptrIndex].codeUnitAt(0) <= 92) {
    nextptrIndex = ptrIndex + 1;
    return TOKENIZER_VARIABLE;
  }

  return TOKENIZER_ERROR;
}

void index_free() {
  line_index_head = -1;
  line_index_current = -1;
  line_index.clear();
}

String index_find(int linenum) {
  int index = line_index_head;
  lineIndex lidx = line_index[index];
  while (index <= line_index_current && lidx.line_number != linenum) {
    lidx = line_index[index];
    index++;
  }
  if (index <= line_index_current && lidx.line_number == linenum) {
    print("index_find: Returning index for line %d." + linenum.toString());
    return lidx.program_text_position;
  }
  print("index_find: Returning NULL." + linenum.toString());
  return '';
}

void index_add(int linenum, String sourcepos) {
  if (line_index_head > -1 && index_find(linenum) != '') {
    return;
  }

  line_index.add(lineIndex(linenum, sourcepos));
  line_index_current++;

  print("index_add: Adding index for line %d: %d." +
      linenum.toString() +
      sourcepos);
}

void accept(int token) {
  if (token != tokenizer_token()) {
    print("Token not what was expected (expected %d, got %d) " + token.toString() + ' ' + tokenizer_token().toString());
    tokenizer_error_print();
    ended = 1;
  }
  print("Expected %d, got it "  + token.toString());
  tokenizer_next();
}

class lineIndex {
  int line_number;
  String program_text_position;

  lineIndex(this.line_number, this.program_text_position);
}

List<lineIndex> line_index = new List();
int line_index_head = -1;
int line_index_current = -1;

List<String> STDOUT = [''];
String program_ptr = '';
String ptr = '';
String nextptr = '';
int program_ptrIndex = 0;
int ptrIndex = 0;
int nextptrIndex = 0;
int for_stack_ptr = 0;
int gosub_stack_ptr = 0;
int ended = 0;
int current_token = 0;

void ubasic_init(String program) {
  program_ptr = program;
  for_stack_ptr = gosub_stack_ptr = 0;
  index_free();
  tokenizer_init(program);
  ended = 0;
}

void line_statement() {
  print("----------- Line number %d ---------\n" + tokenizer_num().toString());
  index_add(tokenizer_num(), tokenizer_pos());
  accept(TOKENIZER_NUMBER);
  statement();
  return;
}

void ubasic_run() {
  if (tokenizer_finished()) {
    print("uBASIC program finished");
    return;
  }
  line_statement();
}

bool ubasic_finished() {
  return (ended == 1 || tokenizer_finished());
}

List<String> interpretMiniBasic(String program, String STDIN) {
  ubasic_init(program);
  do {
    ubasic_run();
  } while (!ubasic_finished());
  return STDOUT;
}
