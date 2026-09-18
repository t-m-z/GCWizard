List<int> calculateLueneburgTable(Map<String, bool> data, bool add) {
  Map<String, int> summands = _calculateSummands(data) ;
  int a = summands['L']!;
  int b = summands['R']!;
  int r = add ? a + b : a - b;
  return _roman(r);
}

const _letters = {
  'M' : 1000,
  'D' : 500,
  'C' : 100,
  'L' : 50,
  'X' : 10,
  'V' : 5,
  'I' : 1,
};

Map<String, int> _calculateSummands(Map<String, bool> data){
  Map<String, int> summands = {'L': 0, 'R': 0};
  String identifier = '';
  for (String summand in ['L', 'R']) {
    _letters.forEach((key, value) {
      for (String digit in ['1', '2', '3', '4','5']) {
        identifier = key + summand + digit;
        if (data[identifier] != null) {
          summands[summand] = summands[summand]! + value;
        }
      }
    });
  }
  return summands;
}

List<int> _roman(int r){
  List<int> result = [0, 0, 0, 0, 0, 0, 0];
  while (r >= 1000) { r = r - 1000; result[0]++; }
  while (r >= 500) { r = r - 500; result[1]++; }
  while (r >= 100) { r = r - 100; result[2]++; }
  while (r >= 50) { r = r - 50; result[3]++; }
  while (r >= 10) { r = r - 10; result[4]++; }
  while (r >= 5) { r = r - 5; result[5]++; }
  while (r >= 1) { r = r - 1; result[6]++; }
  return result;
}