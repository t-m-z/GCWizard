import 'dart:convert';
import 'dart:typed_data';

import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:id3_codec/id3_codec.dart';

part 'package:gc_wizard/tools/images_and_files/id3_tag/logic/id3_tag_classes.dart';
part 'package:gc_wizard/tools/images_and_files/id3_tag/logic/id3_tag_data.dart';

enum ID3_VERSION { NULL, V10, V11, V23, V24 }

ID3TagData ID3MetaInfoToDataSet(Uint8List bytes) {
  ID3v1Tag ID3v1data = EMPTY_ID3V1TAG;
  ID3v23Tag ID3v23data = EMPTY_ID3V23TAG;
  ID3v24Tag ID3v24data = EMPTY_ID3V24TAG;

  final decoder = ID3Decoder(bytes);
  final metadata = decoder.decodeSync();

  ID3_VERSION version = ID3_VERSION.NULL;

  Map<String, dynamic> dataJSON = metadata[0].toTagMap();

  if (dataJSON['Version'] != null) {
    switch (dataJSON['Version']) {
      case 'v1' : version = ID3_VERSION.V10; break;
      default: version = ID3_VERSION.V11;
    }
  } else if (dataJSON['Header'] != null) {
    switch (dataJSON['Header']['Version']) {
      case 'v2.3.0' : version = ID3_VERSION.V23; break;
      default: version = ID3_VERSION.V24;
    }
  }

  switch (version) {
    case ID3_VERSION.V10:
    case ID3_VERSION.V11:
        dataJSON.forEach((key, value) {
          ID3v1data.tags[key] = value.toString();
        });
        break;
    case ID3_VERSION.V23: break;
    case ID3_VERSION.V24: break;
    default: break;
  }

  return ID3TagData(
      version: version,
      ID3v1data: ID3v1data,
      ID3v23data: ID3v23data,
      ID3v24data: ID3v24data);
}

ID3TagList decodeID3MetaData(Uint8List bytes) {
  final decoder = ID3Decoder(bytes);
  final metadata = decoder.decodeSync();

  List<List<String>> _tableTagsHeader = [];
  ID3FrameTagList _tableTagsFrames = EMPTY_ID3FRAMELIST;
  List<List<String>> _tableTagsPadding = [];
  List<List<String>> _tableTagsMisc = [];

  for (var data in metadata) {
    Map<String, dynamic> dataJSON = data.toTagMap();
    dataJSON.forEach((key, value) {
      switch (key) {
        case "Version":
          break;
        case "Header":
          _tableTagsHeader =
              _buildTableTagsHeader(value as Map<dynamic, dynamic>);
          break;
        case "Frames":
          _tableTagsFrames = _buildTableTagsFrames(value as List<dynamic>);
          break;
        case "Padding":
          _tableTagsPadding =
              _buildTableTagsPadding(value as Map<dynamic, dynamic>);
          break;
        default:
          if (value is String) {
            _tableTagsMisc.add([key, value.toString(), '']);
          }
          //_tableTagsMisc = _buildTableTagsMisc(value as Map<dynamic, dynamic>);
          break;
      }
    });
  }

  return ID3TagList(
      tableTagsHeader: _tableTagsHeader,
      tableTagsFrames: _tableTagsFrames.tableTagsFrames,
      tableTagsPadding: _tableTagsPadding,
      tableTagsMisc: _tableTagsMisc,
      tableTagsImages: _tableTagsFrames.tableTagsImages);
}

List<List<String>> _buildTableTagsHeader(Map<dynamic, dynamic> data) {
  List<List<String>> result = [];
  data.forEach((key, value) {
    result.add([key.toString(), value.toString()]);
  });
  return result;
}

List<List<String>> _buildTableTagsPadding(Map<dynamic, dynamic> data) {
  List<List<String>> result = [];
  data.forEach((key, value) {
    result.add([key.toString(), value.toString()]);
  });
  return result;
}

ID3FrameTagList _buildTableTagsFrames(List<dynamic> data) {
  List<List<String>> resultFrames = [];
  List<List<String>> resultImages = [];

  for (var dataSet in data) {
    if (dataSet.runtimeType.toString() == 'LinkedMap<dynamic, dynamic>') {
      final dataMap = json.decode(json.encode(dataSet)) as Map<String, dynamic>;
      dataMap.forEach((key, value) {
        switch (key) {
          case 'Content':
            final valueMap =
                json.decode(json.encode(value)) as Map<String, dynamic>;
            valueMap.forEach((subKey, value) {
              switch (subKey) {
                case 'Base64':
                  resultImages.add([key, subKey, value.toString()]);
                  resultFrames.add([key, subKey, '<Image Data>']);
                  break;
                default:
                  resultFrames.add([key, subKey, value.toString()]);
              }
            });
            break;
          default:
            resultFrames.add([key, value.toString(), '']);
        }
      });
    }
  }

  return ID3FrameTagList(
    tableTagsFrames: resultFrames,
    tableTagsImages: resultImages,
  );
}

List<List<String>> _buildTableTagsMisc(Map<dynamic, dynamic> data) {
  List<List<String>> result = [];
  data.forEach((key, value) {
    result.add([key.toString(), value.toString()]);
  });
  return result;
}
