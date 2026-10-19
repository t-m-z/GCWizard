part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

// ignore: unused_element
const String _jabVersion = '2.0.0';

const int _maxSymbolNumber = 61;
const int _jabEncodingModes = 6;
const int _encMax = 1000000;
const int _numberOfMaskPatterns = 8; // NUMBER_OF_MASK_PATTERNS

const int _defaultSymbolNumber = 1;
const int _defaultModuleSize = 12;
const int _defaultColorNumber = 8;
const int _defaultModuleColorMode = 2;
const int _defaultEccLevel = 3;
const int _defaultMaskingReference = 7;

const int _distanceToBorder = 4;
const int _colorPaletteNumber = 4;

const int _bitmapBitsPerPixel = 32;
const int _bitmapBitsPerChannel = 8;
const int _bitmapChannelCount = 4;

enum _Status {
  Failure,
  Success,
  DecodeMetadataFailed,
  FatalError
}

enum _EncodeResult {
  Success,
  Failure,
  NoInputData,
  InvalidSymbolVersion,
  InputDataToLong
}

enum DecodeResult {
  NotDetectable,
  NotDecodable,
  PartlyDecodedWithCompatibleDecodeMode,
  FullyDecoded,
}

enum _DecodeMode {
  Normal,
  Compatible
}

int _version2size(int x) => x * 4 + 17;
int _size2version(int x) => (x - 17) ~/ 4;

class _JabVector2d {
  int x;
  int y;
  _JabVector2d(this.x, this.y);

  @override
  String toString() => 'JabVector2d($x, $y)';
}

class _JabPoint {
  double x;
  double y;
  _JabPoint(this.x, this.y);
}

class _JabData {
  int length;
  Uint8List data;

  _JabData(this.length, this.data);

  factory _JabData.fromBytes(Uint8List bytes) => _JabData(bytes.length, bytes);
}

class _JabBitmap {
  int width;
  int height;
  int bitsPerPixel;
  int bitsPerChannel;
  int channelCount;
  Uint8List pixel;

  _JabBitmap({
    required this.width,
    required this.height,
    this.bitsPerPixel = _bitmapBitsPerPixel,
    this.bitsPerChannel = _bitmapBitsPerChannel,
    this.channelCount = _bitmapChannelCount,
    Uint8List? pixel,
  }) : pixel = pixel ?? Uint8List(width * height * channelCount);

  _JabBitmap.gray(int width, int height)
      : this(width: width, height: height, bitsPerChannel: 8, bitsPerPixel: 8, channelCount: 1);
}

class _JabSymbol {
  int index = 0;
  _JabVector2d sideSize = _JabVector2d(0, 0);
  int host = -1;
  List<int> slaves = List.filled(4, -1);
  List<int> wcwr = List.filled(2, 0);
  _JabData? data;
  Uint8List? dataMap;
  _JabData? metadata;
  Uint8List? matrix;
}

class _JabEncode {
  int colorNumber;
  int symbolNumber;
  int moduleSize;
  int masterSymbolWidth = 0;
  int masterSymbolHeight = 0;

  Uint8List? palette;

  List<_JabVector2d> symbolVersions = [];
  List<int> symbolEccLevels = [];
  List<int> symbolPositions = [];
  List<_JabSymbol> symbols = [];
  _JabBitmap? bitmap;

  _JabEncode({required this.colorNumber, required this.symbolNumber, this.moduleSize = _defaultModuleSize});
}

class _JabMetadata {
  bool defaultMode = false;
  int nc = 0;
  int maskType = 0;
  int dockedPosition = 0;
  _JabVector2d sideVersion = _JabVector2d(0, 0);
  _JabVector2d ecl = _JabVector2d(0, 0);
}

class _JabDecodedSymbol {
  int index = 0;
  int hostIndex = -1;
  int hostPosition = -1;
  _JabVector2d sideSize = _JabVector2d(0, 0);
  double moduleSize = 0;
  List<_JabPoint> patternPositions = List.generate(4, (_) => _JabPoint(0, 0));
  _JabMetadata metadata = _JabMetadata();
  List<_JabMetadata> slaveMetadata = List.generate(4, (_) => _JabMetadata());
  Uint8List? palette;
  _JabData? data;
}