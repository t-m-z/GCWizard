part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _ParseStateLFunction {
  _LString? name;
  int lineBegin = 0;
  int lineEnd = 0;
  int lenUpvalues = 0;
  int lenParameter = 0;
  int vararg = 0;
  int maximumStackSize = 0;
  int length = 0;
  List<int> code = const [];
  _BList<_LObject>? constants;
  _BList<_LFunction>? functions;
  _BList<_BInteger>? lines;
  _BList<_LLocal>? locals;
  List<_LUpvalue> upvalues = const [];
}

class _LFunctionType extends _BObjectType<_LFunction> {
  static final _LFunctionType type50 = _LFunctionType50();
  static final _LFunctionType type51 = _LFunctionType._();
  static final _LFunctionType type52 = _LFunctionType52();
  static final _LFunctionType type53 = _LFunctionType53();

  _LFunctionType._();

  @override
  _LFunction parse(_ByteReader buffer, _BHeader header) {
    final s = _ParseStateLFunction();
    parseMain(buffer, header, s);
    final lfunc = _LFunction(
      s.code,
      s.locals!.asList(),
      s.constants!.asList(),
      s.upvalues,
      s.functions!.asList(),
      s.maximumStackSize,
      s.lenUpvalues,
      s.lenParameter,
      s.vararg,
    );
    lfunc.header = header;
    for (final child in lfunc.functions) {
      child.parent = lfunc;
    }
    if (s.lines!.length == 0 && s.locals!.length == 0) {
      lfunc.stripped = true;
    }
    return lfunc;
  }

  void parseMain(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    s.name = header.string.parse(buffer, header);
    s.lineBegin = header.integer.parse(buffer, header).asInt();
    s.lineEnd = header.integer.parse(buffer, header).asInt();
    s.lenUpvalues = buffer.get() & 0xFF;
    s.lenParameter = buffer.get() & 0xFF;
    s.vararg = buffer.get() & 0xFF;
    s.maximumStackSize = buffer.get() & 0xFF;
    parseCode(buffer, header, s);
    parseConstants(buffer, header, s);
    parseUpvalues(buffer, header, s);
    parseDebug(buffer, header, s);
  }

  void parseCode(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    s.length = header.integer.parse(buffer, header).asInt();
    s.code = List<int>.generate(s.length, (_) => buffer.getUint32());
  }

  void parseConstants(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    s.constants = header.constant.parseList(buffer, header);
    s.functions = header.function.parseList(buffer, header);
  }

  void parseDebug(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    s.lines = header.integer.parseList(buffer, header);
    s.locals = header.local.parseList(buffer, header);
    final upvalueNames = header.string.parseList(buffer, header);
    for (var i = 0; i < upvalueNames.length; i++) {
      s.upvalues[i].name = upvalueNames.get(i).deref();
    }
  }

  void parseUpvalues(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    s.upvalues = List<_LUpvalue>.generate(s.lenUpvalues, (_) => _LUpvalue());
  }
}

class _LFunctionType52 extends _LFunctionType {
  _LFunctionType52() : super._();

  @override
  void parseMain(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    s.lineBegin = header.integer.parse(buffer, header).asInt();
    s.lineEnd = header.integer.parse(buffer, header).asInt();
    s.lenParameter = buffer.get() & 0xFF;
    s.vararg = buffer.get() & 0xFF;
    s.maximumStackSize = buffer.get() & 0xFF;
    parseCode(buffer, header, s);
    parseConstants(buffer, header, s);
    parseUpvalues(buffer, header, s);
    parseDebug(buffer, header, s);
  }

  @override
  void parseDebug(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    s.name = header.string.parse(buffer, header);
    super.parseDebug(buffer, header, s);
  }

  @override
  void parseUpvalues(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    final upvalues = header.upvalue.parseList(buffer, header);
    s.lenUpvalues = upvalues.length;
    s.upvalues = upvalues.asList();
  }
}

class _LFunctionType53 extends _LFunctionType {
  _LFunctionType53() : super._();

  @override
  void parseMain(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    s.name = header.string.parse(buffer, header);
    s.lineBegin = header.integer.parse(buffer, header).asInt();
    s.lineEnd = header.integer.parse(buffer, header).asInt();
    s.lenParameter = buffer.get() & 0xFF;
    s.vararg = buffer.get() & 0xFF;
    s.maximumStackSize = buffer.get() & 0xFF;
    parseCode(buffer, header, s);
    s.constants = header.constant.parseList(buffer, header);
    parseUpvalues(buffer, header, s);
    s.functions = header.function.parseList(buffer, header);
    parseDebug(buffer, header, s);
  }

  @override
  void parseUpvalues(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    final upvalues = header.upvalue.parseList(buffer, header);
    s.lenUpvalues = upvalues.length;
    s.upvalues = upvalues.asList();
  }
}

class _LFunctionType50 extends _LFunctionType {
  _LFunctionType50() : super._();

  @override
  void parseMain(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    s.name = header.string.parse(buffer, header);
    s.lineBegin = header.integer.parse(buffer, header).asInt();
    s.lineEnd = 0;
    s.lenUpvalues = buffer.get() & 0xFF;
    s.upvalues = List<_LUpvalue>.generate(s.lenUpvalues, (_) => _LUpvalue());
    s.lenParameter = buffer.get() & 0xFF;
    s.vararg = buffer.get() & 0xFF;
    s.maximumStackSize = buffer.get() & 0xFF;
    parseDebug(buffer, header, s);
    parseConstants(buffer, header, s);
    parseCode(buffer, header, s);
  }

  @override
  void parseUpvalues(_ByteReader buffer, _BHeader header, _ParseStateLFunction s) {
    final upvalues = header.upvalue.parseList(buffer, header);
    s.lenUpvalues = upvalues.length;
    s.upvalues = upvalues.asList();
  }
}
