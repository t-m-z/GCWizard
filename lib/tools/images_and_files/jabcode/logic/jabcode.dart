// ported from https://github.com/jabcode/jabcode

import 'dart:math';
import 'dart:typed_data';

import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:image/image.dart' as Image;

part 'package:gc_wizard/tools/images_and_files/jabcode/logic/binarizer.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/decoder.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/decoder_tables.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/detector.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/encoder.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/encoder_tables.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/interleave.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/jab_types.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/ldpc.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/mask.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/pseudo_random.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/sample.dart';
part 'package:gc_wizard/tools/images_and_files/jabcode/logic/transform.dart';



Future<({String? Data, String? DecodeStatus})?> scanBytes(Uint8List bytes) async {
  final bitmap = _readImage(bytes);
  if (bitmap == null) return null;

  var result = decodeJABCode(bitmap, _DecodeMode.Normal);
  if (result.DecodedData?.data == null) {
    final compatibleResult = decodeJABCode(bitmap, _DecodeMode.Compatible);
    if (compatibleResult.DecodedData?.data == null) {
      result = compatibleResult;
    }
  }

  final decodedBytes = result.DecodedData?.data;
  if (decodedBytes == null) {
    // reportError("Decoding JABCode failed");
    return (Data: null, DecodeStatus: result.Result.toString());
  }

  //output warning if the code is only partly decoded with COMPATIBLE_DECODE mode
  if (result.Result == DecodeResult.PartlyDecodedWithCompatibleDecodeMode) {
    return (
      Data: null,
      DecodeStatus: "The code is only partly decoded. Some slave symbols have not been decoded and are ignored."
    );
  }
  return (Data: String.fromCharCodes(decodedBytes), DecodeStatus: '');
}

Future<Uint8List?> generateJabCode(String code, {int moduleSize = 12, int colorCount = _defaultColorNumber,
  int eccLevel = _defaultEccLevel, int border = 10}) async {
  if (code.isEmpty) return null;

  final enc = _createEncode(moduleSize, colorCount, _defaultSymbolNumber, eccLevel);
  final result = generateJABCode(enc, _JabData.fromBytes(Uint8List.fromList(code.codeUnits)));
  if (result != _EncodeResult.Success) return null;
  border = max(border, 0);

  return _createImage(enc.bitmap!, border);
}

Future<Uint8List?> _createImage(_JabBitmap bitmap, int border) async {
  const white = Image.ConstColorRgb8(255, 255, 255);
  final image = Image.Image(width: bitmap.width + 2 * border, height: bitmap.height + 2 * border);
  image.clear(white);
  final bytesPerPixel = bitmap.bitsPerPixel ~/ 8;

  for (int y = 0; y < bitmap.height; y++) {
    for (int x = 0; x < bitmap.width; x++) {
      final o = (y * bitmap.width + x) * bytesPerPixel;
      image.setPixelRgba(x + border, y + border,
          bitmap.pixel[o], bitmap.pixel[o + 1], bitmap.pixel[o + 2], bitmap.pixel[o + 3]);
    }
  }
  return encodeTrimmedPng(image);
}

_JabBitmap? _readImage(Uint8List image) {
  var _image = Image.decodeImage(image);
  if (_image == null) return null;

  if (_image.data!.numChannels < 3) {
    _image = _image.convert(numChannels: 3);
  }

  return _JabBitmap(
    width: _image.width,
    height: _image.height,
    pixel: _image.getBytes(),
    bitsPerChannel: _image.bitsPerChannel,
    channelCount: _image.numChannels,
    bitsPerPixel: _image.bitsPerChannel * _image.numChannels,
  );
}
