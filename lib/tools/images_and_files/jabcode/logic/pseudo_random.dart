part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

BigInt _lcg64Seed = BigInt.from(42);
const int _mask32 = 0xFFFFFFFF;
final BigInt _lcgMultiplier = BigInt.parse('6364136223846793005');
final BigInt _lcgIncrement = BigInt.one;

int _temper(int x) {
  x &= _mask32;
  x ^= (x >> 11);
  x ^= (x << 7) & 0x9D2C5680;
  x ^= (x << 15) & 0xEFC60000;
  x ^= (x >> 18);
  return x & _mask32;
}

int _lcg64Temper() {
  _lcg64Seed = (_lcgMultiplier * _lcg64Seed + _lcgIncrement).toUnsigned(64);
  final upper32 = (_lcg64Seed >> 32).toInt();
  return _temper(upper32);
}

void _setSeed(int seed) {
  _lcg64Seed = BigInt.from(seed);
}