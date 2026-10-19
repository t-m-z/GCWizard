part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

const int _interleaveSeed = 226759;
const int _uint32Max = 4294967295;

void _interleaveData(_JabData data) {
  _setSeed(_interleaveSeed);
  final length = data.length;
  final buf = data.data;
  for (int i = 0; i < length; i++) {
    final pos = (_lcg64Temper() / _uint32Max * (length - i)).toInt();
    final tmp = buf[length - 1 - i];
    buf[length - 1 - i] = buf[pos];
    buf[pos] = tmp;
  }
}

void _deinterleaveData(_JabData data) {
  final length = data.length;
  final index = List<int>.generate(length, (i) => i);

  _setSeed(_interleaveSeed);
  for (int i = 0; i < length; i++) {
    final pos = (_lcg64Temper() / _uint32Max * (length - i)).toInt();
    final tmp = index[length - 1 - i];
    index[length - 1 - i] = index[pos];
    index[pos] = tmp;
  }

  final tmpData = Uint8List.fromList(data.data.sublist(0, length));
  for (int i = 0; i < length; i++) {
    data.data[index[i]] = tmpData[i];
  }
}