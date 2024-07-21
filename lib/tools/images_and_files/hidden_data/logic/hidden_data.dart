import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart' as Audio;
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:image/image.dart' as Image;
import 'package:tuple/tuple.dart';

part 'package:gc_wizard/tools/images_and_files/hidden_data/logic/file_size.dart';

const HIDDEN_FILE_IDENTIFIER = '<<!!!HIDDEN_FILE!!!>>';

Future<List<GCWFile>> hiddenData(GCWFile data) async {
  data.children = null;
  return Future.value((await _hiddenData(data, 0)).item1);
}

Future<Tuple2<List<GCWFile>, int>> _hiddenData(GCWFile data, int fileIndexCounter) async {
  var result = await _splitFile(data, fileIndexCounter);
  var childrenList = <GCWFile>[];

  // unpack archives
  if (data.fileClass == FileClass.ARCHIVE) {
    // clone bytes (I have no idea why this is actually necessary)
    var children = await extractArchive(GCWFile(name: data.name, bytes: Uint8List.fromList(data.bytes.sublist(0))));
    //if (children != null) childrenList.addAll(children);
    _addFiles(childrenList, children);
  }
  // first add all children blocks
  _addFiles(childrenList, result.item1);

  // check for empty children (backup)
  _addChildren(data, childrenList);

  // recursive search in the children
  await Future.forEach(childrenList, (GCWFile data) async {
    result = await _hiddenData(data, result.item2);
  });

  // search for magic bytes (hidden files) in the parent block (e.g. thumbnails) (if not a archive)
  if (data.fileClass != FileClass.ARCHIVE) {
    // new file with correct size
    var dataClone = GCWFile(name: data.name, bytes: Uint8List.fromList(data.bytes.sublist(0, _fileSize(data.bytes))));
    result = await _searchMagicBytesHeader(dataClone, result.item2);
    _addChildren(data, dataClone.children);

    if (dataClone.children != null && dataClone.children!.isNotEmpty) {
      // check for hidden archives (other types are checked)
      await Future.forEach(dataClone.children!, (GCWFile data) async {
        if (data.fileClass == FileClass.ARCHIVE) {
          result = await _hiddenData(data, result.item2);
        }
      });
    }
  }

  return Future.value(Tuple2<List<GCWFile>, int>([data], result.item2));
}

/// split file into separate files
/// default is that the first block is not returned (only attachments) (ignored with onlyParent)
/// with checking whether it is a valid block
Future<Tuple2<List<GCWFile>, int>> _splitFile(GCWFile data, int fileIndexCounter, {bool onlyParent = false}) async {
  Uint8List? bytes = data.bytes;
  var resultList = <GCWFile>[];
  var parent = !onlyParent;

  while (bytes != null && bytes.isNotEmpty) {
    int? fileSize = _fileSize(bytes);

    Uint8List resultBytes;
    if ((fileSize != null) && (fileSize > 0) && (bytes.length > fileSize)) {
      resultBytes = bytes.sublist(0, fileSize);
      bytes = bytes.sublist(fileSize);
    } else {
      resultBytes = bytes;
      bytes = null;
    }

    if (resultBytes.isNotEmpty && !parent) {
      fileIndexCounter++;
      var fileName = HIDDEN_FILE_IDENTIFIER + '_$fileIndexCounter';
      var file = GCWFile(name: fileName, bytes: resultBytes);
      if (await _checkFileValid(file)) {
        resultList.add(file);
      } else {
        fileIndexCounter--;
      }
      if (onlyParent) break;
    }
    parent = false;
  }

  return Future.value(Tuple2<List<GCWFile>, int>(resultList, fileIndexCounter));
}

/// search on any position magic bytes
Future<Tuple2<List<GCWFile>, int>> _searchMagicBytesHeader(GCWFile data, int fileIndexCounter) async {
  var result = await _searchMagicBytes(data, _fileSizeCalculationAviable(), fileIndexCounter);
  _addChildren(data, result.item1);

  return Future.value(Tuple2<List<GCWFile>, int>([data], result.item2));
}

void _addChildren(GCWFile data, List<GCWFile>? children) {
  if (children != null && children.isNotEmpty) {
    if (data.children != null) {
      data.children!.addAll(children);
    } else {
      data.children = children;
    }
  }
}

void _addFiles(List<GCWFile> list, List<GCWFile>? files) {
  if (files == null) return;
  if (files.isNotEmpty) list.addAll(files);
}

/// search on any position (>0) magic bytes
Future<Tuple2<List<GCWFile>, int>> _searchMagicBytes(
    GCWFile data, List<FileType> fileTypeList, int fileIndexCounter) async {
  var resultList = <GCWFile>[];
  var bytes = data.bytes;

  await Future.forEach(fileTypeList, (FileType fileType) async {
    var magicBytesList = magicBytes(fileType) ?? [[]];
    await Future.forEach(magicBytesList, (List<int> magicBytes) async {
      for (int i = 1; i < bytes.length; i++) {
        if (bytes[i] == magicBytes[0] && ((i + magicBytes.length) <= bytes.length)) {
          var validMagicBytes = true;
          for (int offset = 1; offset < magicBytes.length; offset++) {
            if (bytes[i + offset] != magicBytes[offset]) {
              validMagicBytes = false;
              break;
            }
          }

          if (validMagicBytes) {
            var bytesOffset = magicBytesOffset(fileType) ?? 0;
            bytesOffset = i - bytesOffset;
            if (bytesOffset >= 0) {
              // extract data and check for completeness (only first block)
              var result =
                  await _splitFile(GCWFile(bytes: data.bytes.sublist(bytesOffset)), fileIndexCounter, onlyParent: true);
              if (bytesOffset == 14964) bytesOffset = bytesOffset;
              // append file as result, if it is a valid file
              _addFiles(resultList, result.item1);

              fileIndexCounter = result.item2;
            }
          }
        }
      }
    });
  });

  return Future.value(Tuple2<List<GCWFile>, int>(resultList, fileIndexCounter));
}

/// check, are the data a valid (complete) file or sound
Future<bool> _checkFileValid(GCWFile data) async {
  var result = true;
  try {
    var _fileClass = data.fileClass;
    if (_fileClass == FileClass.IMAGE) {
      result = Image.decodeImage(data.bytes) != null;
    } else if (_fileClass == FileClass.SOUND) {
      var advancedPlayer = Audio.AudioPlayer();
      await advancedPlayer.setSourceBytes(data.bytes);
      var duration = await advancedPlayer.getDuration();
      result = duration == null ? false : duration.inMilliseconds > 0;
    }
  } catch (e) {
    result = false;
  }

  return Future.value(result);
}

Uint8List? mergeFiles(List<Object>? data) {
  if (data == null) return null;
  var result = <int>[];

  for (var element in data) {
    if (element is Uint8List) {
      result.addAll(trimNullBytes(element));
    } else if (element is String) {
      result.addAll(Uint8List.fromList(element.toString().codeUnits));
    }
  }

  return trimNullBytes(Uint8List.fromList(result));
}
