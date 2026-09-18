List<int> calculateLueneburgTable(List<String> data, bool add) {
  int a = _calculateA(data);
  int b = _calculateB(data);
  int r = add ? a + b : a - b;
  return _roman(r);
}

int _calculateA(List<String> data){
  return 0;
}

int _calculateB(List<String> data){
  return 0;
}

List<int> _roman(int r){
  return [0, 0, 0, 0, 0, 0, 0];
}