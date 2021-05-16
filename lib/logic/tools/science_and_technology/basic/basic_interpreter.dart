//  https://gist.githubusercontent.com/pmachapman/1310bf5ca01120e4fdac/raw/ce701e3c4b39e13d527688f96366d34064ec01bf/SBasic.java
//
// Small Basic Interpreter from Herbert Schildt's The Art of Java


// Exception class for interpreter errors.
import 'dart:core';

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

  // Array for variables.
  List<double> vars = <double>[];

  // This class links keywords with their keyword tokens.
  class Keyword {
    String keyword; // string form
    int keywordTok; // internal representation

    Keyword(String str, int t) {keyword = str; keywordTok = t;}
  }

  /* Table of keywords with their internal representation.
     All keywords must be entered lowercase. */
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

  // Support for FOR loops.
  class ForInfo {
    int variable; // counter variable
    double target; // target value
    int loc; // index in source code to loop to
  }

  // Stack for FOR loops.
  Stack fStack;

  // Defines label table entries.
  class Label {
    String name; // label
    int loc; // index of label's location in source file
    Label(String n, int i) {name = n; loc = i;}
  }

  // A map for labels.
  TreeMap labelTable;

  // Stack for gosubs.
  Stack gStack;

  // Relational operators.
  String rops[] = {
  GE, NE, LE, '<', '>', '=', 0
  };

  /* Create a string containing the relational
     operators in order to make checking for
     them more convenient. */
  String relops = new String(rops);

  // Constructor for Small Basic.
  SBasic(String progName) {

    String tempbuf[] = new char[PROG_SIZE];
    int size;

    // Load the program to execute.
    size = loadProgram(tempbuf, progName);

    if (size != -1) {
    // Create a properly sized array to hold the program.
    prog = new char[size];

    // Copy the program into program array.
    System.arraycopy(tempbuf, 0, prog, 0, size);
    }
  }

  // Load a program.
  int loadProgram(char[] p, String fname){
  int size = 0;

  
  FileReader fr = new FileReader(fname);

  BufferedReader br = new BufferedReader(fr);

  size = br.read(p, 0, PROG_SIZE);

  fr.close();
  

  // If file ends with an EOF mark, backup.
  if (p[size-1] == (char) 26) size--;

  return size; // return size of program
  }

  // Execute the program.
  void run() {
  
    // Initialize for new program run.
    vars = new double[26];
    fStack = new Stack();
    labelTable = new TreeMap();
    gStack = new Stack();
    progIdx = 0;
    
    scanLabels(); // find the labels in the program
    sbInterp(); // execute
  }

  // Entry point for the Small Basic interpreter.
  void sbInterp(){
  
    // This is the interpreter's main loop.
    do {
      getToken();
      // Check for assignment statement.
      if (tokType==VARIABLE) {
        putBack(); // return the var to the input stream
        assignment(); // handle assignment statement
      } else // is keyword
        switch(kwToken) {
          case PRINT:  print();     break;
          case GOTO:   execGoto();  break;
          case IF:     execif ();    break;
          case FOR:    execFor();   break;
          case NEXT:   next();      break;
          case INPUT:  input();     break;
          case GOSUB:  gosub();     break;
          case RETURN: greturn();   break;
          case END:    return;
        }
    } while (token != EOP);
  }

  // Find all labels.
  void scanLabels(){
    int i;
    Object result;
  
    // See if the first token in the file is a label.
    getToken();
    if (tokType==NUMBER)
      labelTable.put(token, new int(progIdx));
  
    findEOL();
  
    do {
      getToken();
      if (tokType==NUMBER) {// must be a line number
        result = labelTable.put(token, new int(progIdx));
        if (result != null)
          handleErr(DUPLABEL);
      }
    
      // If not on a blank line, find next line.
      if (kwToken != EOL) 
        findEOL();
    } while(!token.equals(EOP));
    progIdx = 0; // reset index to start of program
  }

  // Find the start of the next line.
  void findEOL() {
    while(progIdx < prog.length && prog[progIdx] != '\n')
      ++progIdx;
    if (progIdx < prog.length) 
      progIdx++;
  }

  // Assign a variable a value.
  void assignment(){
    int variable;
    double value;
    String vname;
  
    // Get the variable name.
    getToken();
    vname = token[0];
  
    if (!Character.isLetter(vname)) {
      handleErr(NOTVAR);
      return;
    }
  
    // Convert to index into variable table.
    var = (int) Character.toUpperCase(vname) - 'A';
  
    // Get the equal sign.
    getToken();
    if (!token.equals("=")) {
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
  if (kwToken==EOL || token.equals(EOP)) break;

  if (tokType==QUOTEDSTR) { // is string
    System.out.print(token);
    len += token.length();
    getToken();
  } else { // is expression
  putBack();
  result = evaluate();
  getToken();
  System.out.print(result);

  // Add length of output to running total.
  Double t = new Double(result);
  len += t.toString().length(); // save length
  }
  lastDelim = token;

  // If comma, move to next tab stop.
  if (lastDelim.equals(",")) {
  // compute number of spaces to move to next tab
  spaces = 8 - (len % 8);
  len += spaces; // add in the tabbing position
  while(spaces != 0) {
  System.out.print(" ");
  spaces--;
  }
  }
  else if (token.equals(";")) {
  System.out.print(" ");
  len++;
  }
  else if (kwToken != EOL && !token.equals(EOP))
  handleErr(SYNTAX);
  } while (lastDelim.equals(";") || lastDelim.equals(","));

  if (kwToken==EOL || token.equals(EOP)) {
  if (!lastDelim.equals(";") && !lastDelim.equals(","))
  System.out.println();
  }
  else handleErr(SYNTAX);
  }

  // Execute a GOTO statement.
  void execGoto(){
  int loc;

  getToken(); // get label to go to

  // Find the location of the label.
  loc = (int) labelTable.get(token);

  if (loc == null)
  handleErr(UNDEFLABEL); // label not defined
  else // start program running at that loc
  progIdx = loc.intValue();
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
  }
  else findEOL(); // find start of next line
  }

  // Execute a FOR loop.
  void execFor(){
  ForInfo stckvar = new ForInfo();
  double value;
  String vname;

  getToken(); // read the control variable
  vname = token.charAt(0);
  if (!Character.isLetter(vname)) {
  handleErr(NOTVAR);
  return;
  }

  // Save index of control var.
  stckvar.var = Character.toUpperCase(vname) - 'A';

  getToken(); // read the equal sign
  if (token.charAt(0) != '=') {
  handleErr(EQUALEXPECTED);
  return;
  }

  value = evaluate(); // get initial value

  vars[stckvar.var] = value;

  getToken(); // read and discard the TO
  if (kwToken != TO) handleErr(TOEXPECTED);

  stckvar.target = evaluate(); // get target value

  /* If loop can execute at least once,
       push info on stack. */
  if (value >= vars[stckvar.var]) {
  stckvar.loc = progIdx;
  fStack.push(stckvar);
  }
  else // otherwise, skip loop code altogether
  while(kwToken != NEXT) getToken();
  }

  // Execute a NEXT statement.
  void next(){
  ForInfo stckvar;

  try {
  // Retrieve info for this For loop.
  stckvar = (ForInfo) fStack.pop();
  vars[stckvar.var]++; // increment control var

  // If done, return.
  if (vars[stckvar.var] > stckvar.target) return;

  // Otherwise, restore the info.
  fStack.push(stckvar);
  progIdx = stckvar.loc;  // loop
  } catch(EmptyStackException exc) {
  handleErr(NEXTWITHOUTFOR);
  }
  }

  // Execute a simple form of INPUT.
  void input(){
  int var;
  double val = 0.0;
  String str;

  BufferedReader br = new
  BufferedReader(new InputStreamReader(System.in));

  getToken(); // see if prompt string is present
  if (tokType == QUOTEDSTR) {
  // if so, print it and check for comma
  System.out.print(token);
  getToken();
  if (!token.equals(",")) handleErr(SYNTAX);
  getToken();
  }
  else System.out.print("? "); // otherwise, prompt with ?

  // get the input var
  var =  Character.toUpperCase(token.charAt(0)) - 'A';

  try {
  str = br.readLine();
  val = Double.parseDouble(str); // read the value
  } catch (IOException exc) {
  handleErr(INPUTIOERROR);
  } catch (NumberFormatException exc) {
  /* You might want to handle this error
         differently than the other interpreter
         errors. */
  System.out.println("Invalid input.");
  }

  vars[variable] = val; // store it
  }

  // Execute a GOSUB.
  void gosub(){
  int loc;

  getToken();

  // Find the label to call.
  loc = (int) labelTable.get(token);

  if (loc == null)
  handleErr(UNDEFLABEL); // label not defined
  else {
  // Save place to return to.
  gStack.push(new int(progIdx));

  // Start program running at that loc.
  progIdx = loc.intValue();
  }
  }

  // Return from GOSUB.
  void greturn(){
  int t;

  try {
  // Restore program index.
  t = (int) gStack.pop();
  progIdx = t.intValue();
  } catch(EmptyStackException exc) {
  handleErr(RETURNWITHOUTGOSUB);
  }

  }

  // **************** Expression Parser ****************

  // Parser entry point.
  double evaluate(){
  double result = 0.0;

  getToken();
  if (token.equals(EOP))
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
  if (token.equals(EOP)) return result;

  op = token.charAt(0);

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

  while((op = token.charAt(0)) == '+' || op == '-') {
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

  while((op = token.charAt(0)) == '*' ||
  op == '/' || op == '%') {
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

    if (token.equals("^")) {
      getToken();
      partialResult = evalExp4();
      ex = result;
      if (partialResult == 0.0) {
        result = 1.0;
      } else
        for(t=(int)partialResult-1; t > 0; t--)
          result = result * ex;
    }
    return result;
  }

  // Evaluate a unary + or -.
  double evalExp5(){
    double result;
    String  op;

    op = "";
    if ((tokType == DELIMITER) && token.equals("+") || token.equals("-")) {
      op = token;
      getToken();
    }
    result = evalExp6();

    if (op.equals("-"))
      result = -result;

    return result;
  }

  // Process a parenthesized expression.
  double evalExp6(){
    double result;

    if (token.equals("(")) {
      getToken();
      result = evalExp2();
      if (!token.equals(")"))
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
        try {
          result = Double.parseDouble(token);
        } catch (NumberFormatException exc) {
          handleErr(SYNTAX);
        }
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
    if (!Character.isLetter(vname.charAt(0))){
      handleErr(SYNTAX);
      return 0.0;
    }
    return vars[Character.toUpperCase(vname.charAt(0))-'A'];
  }

  // Return a token to the input stream.
  void putBack(){
    if (token == EOP)
      return;
    for(int i=0; i < token.length(); i++)
      progIdx--;
  }

  // Handle an error.
  void handleErr(int error)
  throws InterpreterException
  {
  String[] err = {
  "Syntax Error",
  "Unbalanced Parentheses",
  "No Expression Present",
  "Division by Zero",
  "Equal sign expected",
  "Not a variable",
  "Label table full",
  "Duplicate label",
  "Undefined label",
  "THEN expected",
  "TO expected",
  "NEXT without FOR",
  "RETURN without GOSUB",
  "Closing quotes needed",
  "File not found",
  "I/O error while loading file",
  "I/O error on INPUT statement"
  };

  throw new InterpreterException(err[error]);
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
            progIdx += 2;;
            token = String.valueOf(NE);
          } else if (prog[progIdx+1] == '=') {
            progIdx += 2;
            token = String.valueOf(LE);
          } else {
            progIdx++;
            token = "<";
          }
          break;
        case '>':
          if (prog[progIdx+1] == '=') {
            progIdx += 2;;
            token = String.valueOf(GE);
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
    } else if (Character.isLetter(prog[progIdx])) {
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
    } else if (Character.isDigit(prog[progIdx])) {
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

  /* Look up a token's internal representation in the
     token table. */
  int lookUp(String s){
    int i;

    // Convert to lowercase.
    s = s.toLowerCase();

    // See if token is in table.
    for(i=0; i < kwTable.length; i++)
    if (kwTable[i].keyword.equals(s))
    return kwTable[i].keywordTok;
    return UNKNCOM; // unknown keyword
  }


List<String> interpretBasic(String program, STDIN){
  return [];
}