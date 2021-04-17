
enum Type {
  INPUT,
  PUSH,
  POP,
  ADD,
  SUB,
  MULT,
  DIV,
  AddDry,
  TOCHAR,
  ToCharStack,
  Stir,
  StirInto,
  Mix,
  CLEAR,
  Write,
  Verb,
  VerbUntil,
  BREAK,
  GOSUB,
  Refrigerate,
  Remember,
  INVALID,
}

final List<RegExp> matchersENG = [
  RegExp(r'^input ([a-z0-9]+)$'),
  RegExp(r'^(push|pop) ([a-z0-9]+)(( to| from)?( (\d+)(nd|rd|th|st))? stack)?$'),
  RegExp(r'^(add|subtract|mult|divide)( the)? ([a-z0-9 ]+?)( (to|into|from)( the)?( (\d+)(nd|rd|th|st))? stack)?$'),
  RegExp(r'^tochar ( (\d+)(nd|rd|th|st))? stack$'),
  RegExp(r'^tochar ([a-z0-9]+)$'),
  RegExp(r'^stir (((\d+)(nd|rd|th|st) )?stack )?for (\d+)$'),
  RegExp(r'^stir ([a-z0-9]+) into (the )?((\d+)(nd|rd|th|st) )?stack$'),
  RegExp(r'^mix( ((\d+)(nd|rd|th|st) )?stack)?( well)?$'),
  RegExp(r'^clear( (\d+)(nd|rd|th|st))? stack( well)?$'),
  RegExp(r'^write( (\d+)(nd|rd|th|st))? stack to( (\d+)(nd|rd|th|st))? output$'),
  RegExp(r'^break$'),
  RegExp(r'^halt( (\d+))?$'),
  RegExp(r'^gosub ([a-z0-9]+)$'),
  RegExp(r'^suggestion: (.*)$'),
  RegExp(r'^loop( ([a-z0-9]+))? until looped$'),
  RegExp(r'^loop ([a-z0-9]+)$')
];

final RegExp DataTypeDouble = RegExp(r'^double$');
final RegExp DataTypeInt = RegExp(r'^int$');
final RegExp DataTypeBool = RegExp(r'^bool');
final RegExp DataTypeChar = RegExp(r'^char$');
