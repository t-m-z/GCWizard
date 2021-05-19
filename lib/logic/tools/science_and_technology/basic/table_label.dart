// Defines label table entries.
class Label {
  String name; // label
  int loc; // index of label's location in source file
  Label(String n, int i) {name = n; loc = i;}
}

class TreeMap {
  Map<String, int> _contents;

  TreeMap(){
    _contents = new Map<String, int>();
  }

  int put(String key, int value){
    if (_contents[key] == null){
      _contents[key] = value;
      return null;
    } else
      return -1;
  }

  int get(String key){
    return _contents[key];
  }

  void clear(){
    _contents.clear();
  }
}