import 'dart:convert';
import 'dart:typed_data';

part 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/reader.dart';
part 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/writer.dart';
part 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/wire_format.dart';
part 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/varint.dart';
part 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer_decode.dart';
part 'package:gc_wizard/tools/crypto_and_encodings/protocolbuffer/logic/protocolbuffer_encode.dart';


Map<String, String> encryptProtolBuffer(List<String> input){
  return _encodeProtocolBuffer(input);
}

Map<String, String>  decryptProtocolBuffer(String input){
  return _decodeProtocolBuffer(input);
}

