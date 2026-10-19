List<List<String>> evaluateRegExPattern(String input, String pattern, {bool multiLine = true, bool caseSensitive = true, bool uniCode = false, bool dotAll = false}) {
  if (pattern.isEmpty) {
    return [
      [input]
    ];
  }

  List<List<String>> result = [];

  final regex = RegExp(pattern, multiLine: multiLine, caseSensitive: caseSensitive, unicode: uniCode, dotAll: dotAll);
  result = regex
      .allMatches(input)
      .map((m) => m.groupCount == 0
      ? [m.group(0)!]
      : List<String>.generate(m.groupCount, (i) => m.group(i + 1) ?? ''))
      .toList();

  return result;

}
