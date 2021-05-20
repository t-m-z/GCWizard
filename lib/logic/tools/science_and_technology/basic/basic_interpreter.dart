//  https://gist.githubusercontent.com/pmachapman/1310bf5ca01120e4fdac/raw/ce701e3c4b39e13d527688f96366d34064ec01bf/SBasic.java
//
// Small Basic Interpreter from Herbert Schildt's The Art of Java

import 'dart:core';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/stack_for.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/stack_gosub.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic/table_label.dart';

class BASICOutput {
  String STDOUT;
  String Error;

  BASICOutput(this.STDOUT, this.Error);
}

// The Small Basic interpreter.
final int PROG_SIZE = 10000; // maximum program size

// These are the token types.
const int NONE = 0;
const int DELIMITER = 1;
const int VARIABLE = 2;
const int NUMBER = 3;
const int COMMAND = 4;
const int QUOTEDSTR = 5;

// These are the types of errors.
const int SYNTAX = 0;
const int UNBALPARENS = 1;
const int NOEXP = 2;
const int DIVBYZERO = 3;
const int EQUALEXPECTED = 4;
const int NOTVAR = 5;
const int LABELTABLEFULL = 6;
const int DUPLABEL = 7;
const int UNDEFLABEL = 8;
const int THENEXPECTED = 9;
const int TOEXPECTED = 10;
const int NEXTWITHOUTFOR = 11;
const int RETURNWITHOUTGOSUB = 12;
const int MISSINGQUOTE = 13;
const int FILENOTFOUND = 14;
const int FILEIOERROR = 15;
const int INPUTIOERROR = 16;

// Internal representation of the Small Basic keywords.
const int UNKNCOM = 0;
const int PRINT = 1;
const int INPUT = 2;
const int IF = 3;
const int THEN = 4;
const int FOR = 5;
const int NEXT = 6;
const int TO = 7;
const int GOTO = 8;
const int GOSUB = 9;
const int RETURN = 10;
const int END = 11;
const int EOL = 12;

// This token indicates end-of-program.
const String EOP = "\0";

// Codes for double-operators, such as <=.
const String LE = '1';
const String GE = '2';
const String NE = '3';

// Exceptions
final List<String> err = [
  "basic_interpreter_syntax_error",
  "basic_interpreter_unbalanced_parentheses",
  "basic_interpreter_no_expression_present",
  "basic_interpreter_division_by_zero",
  "basic_interpreter_equal_sign_expected",
  "basic_interpreter_not_a_variable",
  "basic_interpreter_label_table_full",
  "basic_interpreter_duplicate_label",
  "basic_interpreter_undefined_label",
  "basic_interpreter_then_expected",
  "basic_interpreter_to expected",
  "basic_interpreter_next_without_for",
  "basic_interpreter_return_without_gosub",
  "basic_interpreter_closing_quotes_needed",
  "basic_interpreter_file_not_found",
  "basic_interpreter_io_error_while_loading_file",
  "basic_interpreter_io_error_on_input_statement"
];

// Array for variables.
List<double> vars = new List<double>(26);

// Output
String STDOUT = '';

// Input
List<String> STDIN = new List<String>();
int inputIdx = 0;

// Error
String Error = '';
bool Exception = false;

// This class links keywords with their keyword tokens.
class Keyword {
  String keyword; // string form
  int keywordTok; // internal representation

  Keyword(String str, int t) {keyword = str; keywordTok = t;}
}

// Table of keywords with their internal representation. All keywords must be entered lowercase.
List<Keyword> kwTable = [
  Keyword("print", PRINT), // in this table.
  Keyword("input", INPUT),
  Keyword("if", IF),
  Keyword("then", THEN),
  Keyword("goto", GOTO),
  Keyword("for", FOR),
  Keyword("next", NEXT),
  Keyword("to", TO),
  Keyword("gosub", GOSUB),
  Keyword("return", RETURN),
  Keyword("end", END)
];

String prog; // refers to program array
int progIdx; // current index into program

String token; // holds current token
int tokType;  // holds token's type

int kwToken; // internal representation of a keyword

// Stack for FOR loops.
StackForInfo fStack = new StackForInfo();

// A map for labels.
TreeMap labelTable = new TreeMap();

// Stack for gosubs.
StackGosub gStack = new StackGosub();

// Relational operators.
List<String> rops = [GE, NE, LE, '<', '>', '='];

// Create a string containing the relational operators in order to make checking for them more convenient.
String relops = rops.join('');


bool isCharacter(String c){
  return (65 <= c.toUpperCase().codeUnitAt(0) && 91 <= c.toUpperCase().codeUnitAt(0));
}

bool isDigit(String c){
  return (int.tryParse(c) != null);
}

// Assign a variable a value.
void assignment(){
  int variable;
  double value;
  String vname;

  // Get the variable name.
  getToken();
  vname = token[0];

  if (!isCharacter(vname)) {
    handleErr(NOTVAR);
    return;
  }

  // Convert to index into variable table.
  variable = vname.toUpperCase().codeUnitAt(0) - 65;

  // Get the equal sign.
  getToken();
  if (token != "=") {
    handleErr(EQUALEXPECTED);
    return;
  }

  // Get the value to assign.
  value = evaluate();

  // Assign the value.
 vars[variable] = value;
}

// Execute a simple version of the PRINT statement.
void print(){
  double result;
  int len=0, spaces;
  String lastDelim = "";

  do {
    getToken(); // get next list item
    if (kwToken==EOL || token == EOP) break;

    if (tokType==QUOTEDSTR) { // is string
      STDOUT = STDOUT + token;
      len += token.length;
      getToken();
    } else { // is expression
      putBack();
      result = evaluate();
      getToken();
      STDOUT = STDOUT + result.toString();

      // Add length of output to running total.
      double t = result;
      len += t.toString().length; // save length
    }
    lastDelim = token;

    // If comma, move to next tab stop.
    if (lastDelim == ",") {
      // compute number of spaces to move to next tab
      spaces = 8 - (len % 8);
      len += spaces; // add in the tabbing position
      while(spaces != 0) {
        STDOUT = STDOUT + " ";
        spaces--;
      }
    } else if (token == ";") {
      STDOUT = STDOUT + " ";
      len++;
    } else if (kwToken != EOL && token != EOP)
      handleErr(SYNTAX);
  } while (lastDelim == ";" || lastDelim == ",");

  if (kwToken==EOL || token == EOP) {
    if (lastDelim != ";" && lastDelim != ",")
      STDOUT = STDOUT + '\n';
  } else
    handleErr(SYNTAX);
}

// Execute a GOTO statement.
void execGoto(){
  int loc;

  getToken(); // get label to go to

  // Find the location of the label.
  loc = labelTable.get(token);

  if (loc == null)
    handleErr(UNDEFLABEL); // label not defined
  else // start program running at that loc
    progIdx = labelTable.get(token);
}

// Execute an IF statement.
void execif (){
  double result;

  result = evaluate(); // get value of expression

  /* If the result is true (non-zero),
       process target of IF. Otherwise move on
       to next line in the program. */
  if (result != 0.0) {
    getToken();
    if (kwToken != THEN) {
      handleErr(THENEXPECTED);
      return;
   } // else, target statement will be executed
  } else
    findEOL(); // find start of next line
}

// Execute a FOR loop.
void execFor(){
  ForInfo stckvar = new ForInfo();
  double value;
  String vname;

  getToken(); // read the control variable
  vname = token[0];
  if (!isCharacter(vname)) {
    handleErr(NOTVAR);
    return;
  }

  // Save index of control var.
  stckvar.variable = vname.toUpperCase().codeUnitAt(0) - 65;

  getToken(); // read the equal sign
  if (token[0] != '=') {
  handleErr(EQUALEXPECTED);
  return;
  }

  value = evaluate(); // get initial value

  vars[stckvar.variable] = value;

  getToken(); // read and discard the TO
  if (kwToken != TO) handleErr(TOEXPECTED);

  stckvar.target = evaluate(); // get target value

  /* If loop can execute at least once,
       push info on stack. */
  if (value >= vars[stckvar.variable]) {
  stckvar.loc = progIdx;
  fStack.push(stckvar);
  }
  else // otherwise, skip loop code altogether
  while(kwToken != NEXT) getToken();
  }

// Execute a NEXT statement.
void next(){
  ForInfo stckvar;

  // Retrieve info for this For loop.
  stckvar = fStack.pop();
  if (stckvar == null)
    handleErr(NEXTWITHOUTFOR);

  vars[stckvar.variable]++; // increment control var

  // If done, return.
  if (vars[stckvar.variable] > stckvar.target) return;

  // Otherwise, restore the info.
  fStack.push(stckvar);
  progIdx = stckvar.loc;  // loop
}

// Execute a simple form of INPUT.
void input(){
  int variable;
  double val = 0.0;
  String str;

  getToken(); // see if prompt string is present
  if (tokType == QUOTEDSTR) {
  // if so, print it and check for comma
//  System.out.print(token);
    getToken();
    if (token !=",")
      handleErr(SYNTAX);
    getToken();
  }
  //else System.out.print("? "); // otherwise, prompt with ?

  // get the input var
  variable =  token.toUpperCase().codeUnitAt(0) - 65;

  str = STDIN[inputIdx];
  inputIdx++;
  if (double.tryParse(str) == null) // read the value
    handleErr(INPUTIOERROR);
  else
    val = double.parse(str);

  vars[variable] = val; // store it
}

// Execute a GOSUB.
void gosub(){
  int loc;

  getToken();

  // Find the label to call.
  loc = labelTable.get(token);

  if (loc == null)
    handleErr(UNDEFLABEL); // label not defined
  else {
  // Save place to return to.
    gStack.push(progIdx);

  // Start program running at that loc.
    progIdx = labelTable.get(token);
  }
}

// Return from GOSUB.
void greturn(){
  int t;

  // Restore program index.
  t = gStack.pop();
  if (t = null)
    handleErr(RETURNWITHOUTGOSUB);
  else
    progIdx = t;
}

// **************** Expression Parser ****************

// Parser entry point.
double evaluate(){
  double result = 0.0;

  getToken();
  if (token == EOP)
    handleErr(NOEXP); // no expression present

  // Parse and evaluate the expression.
  result = evalExp1();

  putBack();

  return result;
}

// Process relational operators.
double evalExp1() {
  double l_temp, r_temp, result;
  String op;

  result = evalExp2();
  // If at end of program, return.
  if (token == EOP) return result;

  op = token[0];

  if (isRelop(op)) {
    l_temp = result;
    getToken();
    r_temp = evalExp1();
    switch(op) { // perform the relational operation
      case '<':
        if (l_temp < r_temp) result = 1.0;
        else result = 0.0;
        break;
      case LE:
        if (l_temp <= r_temp) result = 1.0;
        else result = 0.0;
        break;
      case '>':
        if (l_temp > r_temp) result = 1.0;
        else result = 0.0;
        break;
      case GE:
        if (l_temp >= r_temp) result = 1.0;
        else result = 0.0;
        break;
      case '=':
        if (l_temp == r_temp) result = 1.0;
        else result = 0.0;
        break;
      case NE:
        if (l_temp != r_temp) result = 1.0;
        else result = 0.0;
        break;
    }
  }
  return result;
}

// Add or subtract two terms.
double evalExp2(){
  String op;
  double result;
  double partialResult;

  result = evalExp3();

  while((op = token[0]) == '+' || op == '-') {
    getToken();
    partialResult = evalExp3();
    switch(op) {
      case '-':
        result = result - partialResult;
        break;
      case '+':
        result = result + partialResult;
        break;
    }
  }
  return result;
}

// Multiply or divide two factors.
double evalExp3(){
  String op;
  double result;
  double partialResult;

  result = evalExp4();

  while((op = token[0]) == '*' ||  op == '/' || op == '%') {
    getToken();
    partialResult = evalExp4();
    switch(op) {
      case '*':
        result = result * partialResult;
        break;
      case '/':
        if (partialResult == 0.0)
          handleErr(DIVBYZERO);
        result = result / partialResult;
        break;
      case '%':
        if (partialResult == 0.0)
          handleErr(DIVBYZERO);
        result = result % partialResult;
      break;
    }
  }
  return result;
}

// Process an exponent.
double evalExp4(){
  double result;
  double partialResult;
  double ex;
  int t;

  result = evalExp5();

  if (token == "^") {
    getToken();
    partialResult = evalExp4();
    ex = result;
    if (partialResult == 0.0) {
      result = 1.0;
    } else
      for (int t=partialResult.toInt() - 1; t > 0; t--)
        result = result * ex;
  }
  return result;
}

// Evaluate a unary + or -.
double evalExp5(){
  double result;
  String  op;

  op = "";
  if ((tokType == DELIMITER) && token == "+" || token == "-") {
    op = token;
    getToken();
  }
  result = evalExp6();

  if (op == "-")
    result = -result;

  return result;
}

// Process a parenthesized expression.
double evalExp6(){
  double result;

  if (token == "(") {
    getToken();
    result = evalExp2();
    if (token != ")")
       handleErr(UNBALPARENS);
    getToken();
  } else
    result = atom();

  return result;
}

// Get the value of a number or variable.
double atom(){
  double result = 0.0;

  switch(tokType) {
    case NUMBER:
      if (double.tryParse(token) == null)
        handleErr(SYNTAX);
      else
        result = double.parse(token);
      getToken();
      break;
    case VARIABLE:
      result = findVar(token);
      getToken();
      break;
    default:
      handleErr(SYNTAX);
      break;
  }
  return result;
}

// Return the value of a variable.
double findVar(String vname){
  if (!isCharacter(vname[0])){
    handleErr(SYNTAX);
    return 0.0;
  }
  return vars[vname[0].toUpperCase().codeUnitAt(0) - 65];
}

// Return a token to the input stream.
void putBack(){
  if (token == EOP)
    return;
  for(int i=0; i < token.length; i++)
    progIdx--;
}

// Handle an error.
void handleErr(int error) {
  Error = err[error];
  Exception = true;
}

// Obtain the next token.
void getToken(){
    String ch;

    tokType = NONE;
    token = "";
    kwToken = UNKNCOM;

    // Check for end of program.
    if (progIdx == prog.length) {
      token = EOP;
      return;
    }

    // Skip over white space.
    while(progIdx < prog.length && isSpaceOrTab(prog[progIdx]))
      progIdx++;

    // Trailing whitespace ends program.
    if (progIdx == prog.length) {
      token = EOP;
      tokType = DELIMITER;
      return;
    }

    if (prog[progIdx] == '\r') { // handle crlf
      progIdx += 2;
      kwToken = EOL;
      token = "\r\n";
      return;
    }

    // Check for relational operator.
    ch = prog[progIdx];
    if (ch == '<' || ch == '>') {
      if (progIdx+1 == prog.length) handleErr(SYNTAX);

      switch(ch) {
        case '<':
          if (prog[progIdx+1] == '>') {
            progIdx += 2;
            token = NE;
          } else if (prog[progIdx+1] == '=') {
            progIdx += 2;
            token = LE;
          } else {
            progIdx++;
            token = "<";
          }
          break;
        case '>':
          if (prog[progIdx+1] == '=') {
            progIdx += 2;
            token = GE;
          } else {
            progIdx++;
            token = ">";
          }
          break;
      }
      tokType = DELIMITER;
      return;
    }

    if (isDelim(prog[progIdx])) {
      // Is an operator.
      token += prog[progIdx];
      progIdx++;
      tokType = DELIMITER;
    } else if (isCharacter(prog[progIdx])) {
      // Is a variable or keyword.
      while(!isDelim(prog[progIdx])) {
        token += prog[progIdx];
        progIdx++;
        if (progIdx >= prog.length)
          break;
      }

      kwToken = lookUp(token);
      if (kwToken==UNKNCOM)
        tokType = VARIABLE;
      else
        tokType = COMMAND;
    } else if (isDigit(prog[progIdx])) {
      // Is a number.
      while(!isDelim(prog[progIdx])) {
        token += prog[progIdx];
        progIdx++;
        if (progIdx >= prog.length)
          break;
      }
      tokType = NUMBER;
    } else if (prog[progIdx] == '"') {
      // Is a quoted string.
      progIdx++;
      ch = prog[progIdx];
      while(ch !='"' && ch != '\r') {
        token += ch;
        progIdx++;
        ch = prog[progIdx];
      }
      if (ch == '\r')
        handleErr(MISSINGQUOTE);
      progIdx++;
      tokType = QUOTEDSTR;
    } else { // unknown character terminates program
      token = EOP;
      return;
    }
}

// Return true if c is a delimiter.
bool isDelim(String c){
  if ((" \r,;<>+-/*%^=()".indexOf(c) != -1))
    return true;
  else
    return false;
}

// Return true if c is a space or a tab.
bool isSpaceOrTab(String c){
  if (c == ' ' || c =='\t')
    return true;
  else
    return false;
}

// Return true if c is a relational operator.
bool isRelop(String c) {
  if (relops.indexOf(c) != -1)
    return true;
  else
    return false;
}

// Look up a token's internal representation in the token table.
int lookUp(String s){
  int i;

  // Convert to lowercase.
  s = s.toLowerCase();

  // See if token is in table.
  for(i=0; i < kwTable.length; i++)
    if (kwTable[i].keyword == s)
      return kwTable[i].keywordTok;
  return UNKNCOM; // unknown keyword
}

// Find the start of the next line.
void findEOL() {
  while(progIdx < prog.length && prog[progIdx] != '\n')
    ++progIdx;
  if (progIdx < prog.length)
    progIdx++;
}

BASICOutput interpretBasic(String program, input){
  if (program == null || program == '')
    return BASICOutput('', '');
  // Initialize for new program run.

  prog = program;
  fStack.clear();
  labelTable.clear();
  gStack.clear();
  progIdx = 0;
  STDIN = input.split(' ');
  inputIdx = 0;

  // find all labels
  int i;
  Object result;

  // See if the first token in the file is a label.
  getToken();
  if (tokType == NUMBER)
    labelTable.put(token, progIdx);

  findEOL();

  do {
    getToken();
    if (tokType == NUMBER) {// must be a line number
      result = labelTable.put(token, progIdx);
      if (result != null)
        handleErr(DUPLABEL);
    }

    // If not on a blank line, find next line.
    if (kwToken != EOL)
      findEOL();
  } while(token != EOP);
  progIdx = 0; // reset index to start of program

  // execute - this is the interpreter's main loop.
    do {
      getToken();
      // Check for assignment statement.
      if (tokType == VARIABLE) {
        putBack(); // return the var to the input stream
        assignment(); // handle assignment statement
      } else // is keyword
        switch(kwToken) {
          case PRINT:  print();     break;
          case GOTO:   execGoto();  break;
          case IF:     execif ();   break;
          case FOR:    execFor();   break;
          case NEXT:   next();      break;
          case INPUT:  input();     break;
          case GOSUB:  gosub();     break;
          case RETURN: greturn();   break;
          case END:    token = EOP; break;
        }
    } while (token != EOP || !Exception);

  return BASICOutput(STDOUT, Error);
}