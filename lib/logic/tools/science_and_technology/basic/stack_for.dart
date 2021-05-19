// Support for FOR loops.

class ForInfo {
  int variable; // counter variable
  double target; // target value
  int loc; // index in source code to loop to
}


class StackForInfo {
  List<ForInfo> _contents;

  StackForInfo() {
    _contents = new List<ForInfo>();
  }

  void push(ForInfo element){
    if (element != null) _contents.add(element);
  }

  void clear(){
    _contents.clear();
  }

  ForInfo pop(){
    if (_contents.length != 0) {
      var element = _contents.removeAt(_contents.length - 1);
      return element;
    }
  }

  int size() {
    return _contents.length;
  }
}