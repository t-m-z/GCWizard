// Support for GOSUB



class StackGosub {
  List<int> _contents;

  StackGosub() {
    _contents = new List<int>();
  }

  void push(int element){
    if (element != null) _contents.add(element);
  }

  int pop(){
    if (_contents.length != 0) {
      var element = _contents.removeAt(_contents.length - 1);
      return element;
    }
  }

  int size() {
    return _contents.length;
  }
}