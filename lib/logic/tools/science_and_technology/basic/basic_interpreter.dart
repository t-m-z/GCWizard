
// http://dunkels.com/adam/ubasic/
//
// The code is available at github: https://github.com/adamdunkels/ubasic.
//
// uBASIC is released under an open source 3-clause BSD-style license. The full license text is here.
//
// Copyright (c) 2006, Adam Dunkels
// All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. The name of the author may not be used to endorse or promote
//    products derived from this software without specific prior
//    written permission.
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR `AS IS' AND ANY EXPRESS
// OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'dart:math';

final MAX_NUMLEN = 6;
final MAX_GOSUB_STACK_DEPTH = 10;
List<int> gosub_stack = new List<int>(MAX_GOSUB_STACK_DEPTH);
int gosub_stack_ptr;
final MAX_STRINGLEN = 40;
String string;
final MAX_VARNUM = 26;
List<int> variables = new List<int>(MAX_VARNUM);

class forState {
  int line_after_for;
  int for_variable;
  int to;

  forState(this.line_after_for, this.for_variable, this.to);
}


final MAX_FOR_STACK_DEPTH = 4;
List<forState> for_stack = new List(MAX_FOR_STACK_DEPTH);
int for_stack_ptr;

const TOKENIZER_ERROR = 0;
const TOKENIZER_ENDOFINPUT = 1;
const TOKENIZER_NUMBER = 10;
const TOKENIZER_STRING = 11;
const TOKENIZER_VARIABLE = 12;
const TOKENIZER_LET = 20;
const TOKENIZER_PRINT = 21;
const TOKENIZER_IF = 22;
const TOKENIZER_THEN = 23;
const TOKENIZER_ELSE = 24;
const TOKENIZER_FOR = 25;
const TOKENIZER_TO = 26;
const TOKENIZER_NEXT = 27;
const TOKENIZER_GOTO = 28;
const TOKENIZER_GOSUB = 29;
const TOKENIZER_RETURN = 30;
const TOKENIZER_CALL = 31;
const TOKENIZER_REM = 32;
const TOKENIZER_END = 35;
const TOKENIZER_COMMA = 40;
const TOKENIZER_SEMICOLON = 41;
const TOKENIZER_PLUS = 50;
const TOKENIZER_MINUS = 51;
const TOKENIZER_AND = 52;
const TOKENIZER_OR = 53;
const TOKENIZER_ASTR = 54;
const TOKENIZER_SLASH = 55;
const TOKENIZER_MOD = 56;
const TOKENIZER_HASH = 57;
const TOKENIZER_LEFTPAREN = 58;
const TOKENIZER_RIGHTPAREN = 59;
const TOKENIZER_LT = 60;
const TOKENIZER_GT = 61;
const TOKENIZER_EQ = 62;
const TOKENIZER_CR = 63;

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

int tokenizer_variable_num(){
  return ptr.codeUnitAt(0) - 65;
}

int strchr(String text, search){
  int r = -1;
  for (int i = 0; i < text.length; i++)
    if (text[i] == search)
      return i;
  return r;
}

tokenizer_string(String dest, int len){
  int string_end;
  int string_len;

  if(tokenizer_token() != TOKENIZER_STRING) {
    return;
  }
  string_end = strchr(ptr.substring(ptrIndex + 1), '"');
  if(string_end == -1) {
    return;
  }
  string_len = string_end - ptrIndex - 1;
  if(len < string_len) {
    string_len = len;
  }
  string = ptr.substring(ptrIndex + 1, string_len);
}

String tokenizer_pos() {
  return ptr;
}

void tokenizer_error_print() {
  print("tokenizer_error_print: '%s" + ptr);
}

void tokenizer_next() {
  if (tokenizer_finished()) {
    return;
  }

  print("tokenizer_next: %p " + nextptr);
  ptr = nextptr;

  while (ptr[ptrIndex] == ' ') {
    ++ptrIndex;
  }
  current_token = get_next_token();

  if (current_token == TOKENIZER_REM) {
    while (nextptr[nextptrIndex] != '\n' || tokenizer_finished()) {
      ++nextptrIndex;
    }
    if (nextptr[nextptrIndex] == '\n') {
      ++nextptrIndex;
    }
    tokenizer_next();
  }

  print("tokenizer_next: '%s' %d " + ptr + ' ' + current_token.toString());
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
    print("Token not what was expected (expected %d, got %d) " +
        token.toString() +
        ' ' +
        tokenizer_token().toString());
    tokenizer_error_print();
    ended = 1;
  }
  print("Expected %d, got it " + token.toString());
  tokenizer_next();
}

int varfactor(){
  int r;
  print("varfactor: obtaining %d from variable %d" + variables[tokenizer_variable_num()].toString() + tokenizer_variable_num().toString());
  r = ubasic_get_variable(tokenizer_variable_num());
  accept(TOKENIZER_VARIABLE);
  return r;
}

int factor(){
  int r;

  print("factor: token %d" + tokenizer_token().toString());
  switch(tokenizer_token()) {
    case TOKENIZER_NUMBER:
      r = tokenizer_num();
      print("factor: number %d " + r.toString());
      accept(TOKENIZER_NUMBER);
      break;
    case TOKENIZER_LEFTPAREN:
      accept(TOKENIZER_LEFTPAREN);
      r = expr();
      accept(TOKENIZER_RIGHTPAREN);
      break;
    default:
      r = varfactor();
      break;
  }
  return r;
}

int term(){
  int f1, f2;
  int op;

  f1 = factor();
  op = tokenizer_token();
  print("term: token %d " + op.toString());
  while(op == TOKENIZER_ASTR || op == TOKENIZER_SLASH || op == TOKENIZER_MOD) {
    tokenizer_next();
    f2 = factor();
    print("term: %d %d %d " + ' ' + f1.toString() + ' ' + op.toString() + ' ' + f2.toString());
    switch(op) {
      case TOKENIZER_ASTR:
        f1 = f1 * f2;
        break;
      case TOKENIZER_SLASH:
        f1 = (f1 / f2).round();
        break;
      case TOKENIZER_MOD:
        f1 = f1 % f2;
        break;
    }
    op = tokenizer_token();
  }
  print("term: %d " + f1.toString());
  return f1;
}

int expr(){
  int t1, t2;
  int op;

  t1 = term();
  op = tokenizer_token();
  print("expr: token %d " + op.toString());
  while(op == TOKENIZER_PLUS || op == TOKENIZER_MINUS || op == TOKENIZER_AND || op == TOKENIZER_OR) {
    tokenizer_next();
    t2 = term();
    print("expr: %d %d %d" + ' ' + t1.toString() + ' ' + op.toString()  + ' ' + t2.toString());
    switch(op) {
      case TOKENIZER_PLUS:
        t1 = t1 + t2;
        break;
      case TOKENIZER_MINUS:
        t1 = t1 - t2;
        break;
      case TOKENIZER_AND:
        t1 = t1 & t2;
        break;
      case TOKENIZER_OR:
        t1 = t1 | t2;
        break;
    }
    op = tokenizer_token();
  }
  print("expr: %d\n" + t1.toString());
  return t1;
}

int relation(){
  int r1, r2;
  int op;

  r1 = expr();
  op = tokenizer_token();
  print("relation: token %d " + op.toString());
  while(op == TOKENIZER_LT || op == TOKENIZER_GT || op == TOKENIZER_EQ) {
    tokenizer_next();
    r2 = expr();
    print("relation: %d %d %d " + r1.toString() + ' ' + op.toString() + ' ' + r2.toString());
    switch(op) {
      case TOKENIZER_LT:
        if (r1 < r2)
          r1 = 1;
        else
          r1 = 0;
        break;
      case TOKENIZER_GT:
        if (r1 > r2)
          r1 = 1;
        else
          r1 = 0;
        break;
      case TOKENIZER_EQ:
        if (r1 == r2)
          r1 = 1;
        else
          r1 = 0;
        break;
    }
    op = tokenizer_token();
  }
  return r1;
}

void jump_linenum(int linenum){
  String pos = index_find(linenum);
  if(pos != null) {
    print("jump_linenum: Going to line %d. " + linenum.toString());
    tokenizer_goto(pos);
  } else {
    /* We'll try to find a yet-unindexed line to jump to. */
    print("jump_linenum: Calling jump_linenum_slow. " + linenum.toString());
    jump_linenum_slow(linenum);
  }
}

void jump_linenum_slow(int linenum){
  tokenizer_init(program_ptr);
  while(tokenizer_num() != linenum) {
    do {
      do {
        tokenizer_next();
      } while(tokenizer_token() != TOKENIZER_CR && tokenizer_token() != TOKENIZER_ENDOFINPUT);
      if(tokenizer_token() == TOKENIZER_CR) {
        tokenizer_next();
      }
    } while(tokenizer_token() != TOKENIZER_NUMBER);
    print("jump_linenum_slow: Found line %d " + tokenizer_num().toString());
  }
}

void return_statement(){
  accept(TOKENIZER_RETURN);
  if(gosub_stack_ptr > 0) {
    gosub_stack_ptr--;
    jump_linenum(gosub_stack[gosub_stack_ptr]);
  } else {
    print("return_statement: non-matching return");
  }
}

void for_statement(){
  int for_variable, to;

  accept(TOKENIZER_FOR);
  for_variable = tokenizer_variable_num();
  accept(TOKENIZER_VARIABLE);
  accept(TOKENIZER_EQ);
  ubasic_set_variable(for_variable, expr());
  accept(TOKENIZER_TO);
  to = expr();
  accept(TOKENIZER_CR);

  if(for_stack_ptr < MAX_FOR_STACK_DEPTH) {
    for_stack[for_stack_ptr].line_after_for = tokenizer_num();
    for_stack[for_stack_ptr].for_variable = for_variable;
    for_stack[for_stack_ptr].to = to;
    print("for_statement: new for, var %d to %d "+ ' ' + for_stack[for_stack_ptr].for_variable.toString() + ' ' + for_stack[for_stack_ptr].to.toString());

    for_stack_ptr++;
  } else {
    print("for_statement: for stack depth exceeded");
  }
}

void gosub_statement(){
  int linenum;
  accept(TOKENIZER_GOSUB);
  linenum = tokenizer_num();
  accept(TOKENIZER_NUMBER);
  accept(TOKENIZER_CR);
  if(gosub_stack_ptr < MAX_GOSUB_STACK_DEPTH) {
    gosub_stack[gosub_stack_ptr] = tokenizer_num();
    gosub_stack_ptr++;
    jump_linenum(linenum);
  } else {
    print("gosub_statement: gosub stack exhausted ");
  }
}

void print_statement (){
  accept(TOKENIZER_PRINT);
  String line = '';
  do {
    print("Print loop ");
    if(tokenizer_token() == TOKENIZER_STRING) {
      tokenizer_string(string, string.length);
      print("%s"+ string);
      line = line + string;
      tokenizer_next();
    } else if(tokenizer_token() == TOKENIZER_COMMA) {
      print(" ");
      line = line + ',';
      tokenizer_next();
    } else if(tokenizer_token() == TOKENIZER_SEMICOLON) {
      line = line + ';';
      tokenizer_next();
    } else if(tokenizer_token() == TOKENIZER_VARIABLE || tokenizer_token() == TOKENIZER_NUMBER) {
      print("%d" + expr().toString());
      line = line + expr().toString();
    } else {
      break;
    }
  } while(tokenizer_token() != TOKENIZER_CR && tokenizer_token() != TOKENIZER_ENDOFINPUT);
  STDOUT.add(line);
  print("\n");
  print("End of print\n");
  tokenizer_next();
}

void goto_statement(){
  accept(TOKENIZER_GOTO);
  jump_linenum(tokenizer_num());
}

void if_statement(){
  int r;
  accept(TOKENIZER_IF);
  r = relation();
  print("if_statement: relation %d " + r.toString());
  accept(TOKENIZER_THEN);
  if(r == 1) {
    statement();
  } else {
    do {
      tokenizer_next();
    } while(tokenizer_token() != TOKENIZER_ELSE && tokenizer_token() != TOKENIZER_CR && tokenizer_token() != TOKENIZER_ENDOFINPUT);
    if(tokenizer_token() == TOKENIZER_ELSE) {
      tokenizer_next();
      statement();
    } else if(tokenizer_token() == TOKENIZER_CR) {
      tokenizer_next();
    }
  }
}

void next_statement(){
  int variable;

  accept(TOKENIZER_NEXT);
  variable = tokenizer_variable_num();
  accept(TOKENIZER_VARIABLE);
  if(for_stack_ptr > 0 &&  variable == for_stack[for_stack_ptr - 1].for_variable) {
    ubasic_set_variable(variable, ubasic_get_variable(variable) + 1);
    if(ubasic_get_variable(variable) <= for_stack[for_stack_ptr - 1].to) {
      jump_linenum(for_stack[for_stack_ptr - 1].line_after_for);
    } else {
      for_stack_ptr--;
      accept(TOKENIZER_CR);
    }
  } else {
    print("next_statement: non-matching next (expected %d, found %d) " + for_stack[for_stack_ptr - 1].for_variable.toString() + ' ' + variable.toString());
    accept(TOKENIZER_CR);
  }
}

void end_statement(){
  accept(TOKENIZER_END);
  ended = 1;
}

void let_statement(){
  int variable;

  variable = tokenizer_variable_num();

  accept(TOKENIZER_VARIABLE);
  accept(TOKENIZER_EQ);
  ubasic_set_variable(variable, expr());
  print("let_statement: assign %d to %d " + variables[variable].toString() + ' ' + variable.toString());
  accept(TOKENIZER_CR);
}

void statement() {
  int token;

  token = tokenizer_token();

  switch (token) {
    case TOKENIZER_PRINT:
      print_statement();
      break;
    case TOKENIZER_IF:
      if_statement();
      break;
    case TOKENIZER_GOTO:
      goto_statement();
      break;
    case TOKENIZER_GOSUB:
      gosub_statement();
      break;
    case TOKENIZER_RETURN:
      return_statement();
      break;
    case TOKENIZER_FOR:
      for_statement();
      break;
    case TOKENIZER_NEXT:
      next_statement();
      break;
    case TOKENIZER_END:
      end_statement();
      break;
    case TOKENIZER_LET:
      accept(TOKENIZER_LET);
      let_statement();
      break;
    case TOKENIZER_VARIABLE:
      let_statement();
      break;
    default:
      print("ubasic.c: statement(): not implemented %d " + token.toString());
      ended = 1;
  }
}

void line_statement() {
  print("----------- Line number %d ---------\n" + tokenizer_num().toString());
  index_add(tokenizer_num(), tokenizer_pos());
  accept(TOKENIZER_NUMBER);
  statement();
  return;
}

void ubasic_init(String program) {
  program_ptr = program;
  for_stack_ptr = gosub_stack_ptr = 0;
  index_free();
  tokenizer_init(program);
  ended = 0;
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

void ubasic_set_variable(int varnum, int value){
  if(varnum >= 0 && varnum <= MAX_VARNUM) {
    variables[varnum] = value;
  }
}

int ubasic_get_variable(int varnum){
  if(varnum >= 0 && varnum <= MAX_VARNUM) {
    return variables[varnum];
  }
  return 0;
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
int ended = 0;
int current_token = 0;

List<String> interpretMiniBasic(String program, String STDIN) {
  print('start interpreting');
  ubasic_init(program);
  do {
    ubasic_run();
  } while (!ubasic_finished());
  return STDOUT;
}
