import 'dart:io';
import 'dart:typed_data';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/tools/images_and_files/exif_reader.dart';
import 'package:gc_wizard/logic/tools/images_and_files/hidden_data.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/images_and_files/hidden_data.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/gcw_file.dart' as local;
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:image/image.dart' as Image;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:prefs/prefs.dart';

class ExifReader extends StatefulWidget {
  final local.GCWFile file;

  ExifReader({Key key, this.file}) : super(key: key);

  @override
  _ExifReaderState createState() => _ExifReaderState();
}

class _ExifReaderState extends State<ExifReader> {
  Map<String, List<List<dynamic>>> tableTags;
  local.GCWFile file;
  LatLng point;
  GCWImageViewData thumbnail;
  Image.Image image;

  var _fileLoaded = false;

  @override
  initState() {
    super.initState();

    if (widget.file != null) {
      file = widget.file;
      _readFile(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GCWOpenFile(
          supportedFileTypes: SUPPORTED_IMAGE_TYPES,
          onLoaded: (_file) {
            if (_file == null) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }

            _readFile(_file);
          },
        ),
        Container(),
        ..._buildOutput(tableTags)
      ],
    );
  }

  Future<void> _readFile(local.GCWFile _file) async {
    Image.Image _image;

    if (_file != null) _image = await _completeImageMetadata(_file);

    if (_file == null || _image == null) {
      showToast(i18n(context, 'common_loadfile_exception_notloaded'));
      _fileLoaded = false;
      return;
    }

    Map<String, IfdTag> tags = await parseExif(_file);

    GCWImageViewData _thumbnail;
    LatLng _point;
    Map _tableTags;
    try {
      if (tags != null) {
        _thumbnail = completeThumbnail(tags);
        _tableTags = buildTablesExif(tags);
        Map<String, dynamic> xmpTags = buildXmpTags(_file, _tableTags);
        _point = completeGPSData(tags);
        if (_point == null) {
          _point = completeGPSDataFromXmp(xmpTags);
        }
      }

      _fileLoaded = true;

      setState(() {
        file = _file;
        tableTags = _tableTags;
        point = _point; // GPS Point
        thumbnail = _thumbnail; // Thumbnail
        image = _image;
      });
    } catch (e) {
      // An error occured, but keep it silently to not pollute UI
    }
  }

  List _buildOutput(Map _tableTags) {
    if (!_fileLoaded) {
      return [GCWDefaultOutput()];
    }

    List<Widget> widgets = [];
    widgets.add(Container(
      child: GCWImageView(
        imageData: GCWImageViewData(file),
        suppressOpenInTool: {GCWImageViewOpenInTools.METADATA},
      ),
      padding: EdgeInsets.only(top: 10),
    ));
    _decorateFile(widgets, file);
    _decorateImage(widgets, image);
    _decorateFileTypeSpecific(widgets, file);
    _decorateThumbnail(widgets);
    _decorateExifSections(widgets, _tableTags);
    _decorateGps(widgets);
    _decorateHiddenData(widgets);
    return widgets;
  }

  ///
  /// Add Thumbnail section
  ///
  void _decorateThumbnail(List<Widget> widgets) {
    if (thumbnail != null && thumbnail.file != null && thumbnail.file.bytes.length > 0) {
      widgets.add(GCWOutput(
        title: i18n(context, 'exif_section_thumbnail'),
        child: GCWImageView(imageData: thumbnail),
        //suppressCopyButton: false,
      ));
    }
  }

  ///
  /// Add GPS section
  ///
  void _decorateGps(List<Widget> widgets) {
    if (point == null) return;

    var _currentCoordsFormat = defaultCoordFormat();
    List<String> _currentOutput = [
      formatCoordOutput(point, {'format': Prefs.get(PREFERENCE_COORD_DEFAULT_FORMAT)}, defaultEllipsoid()),
    ];

    widgets.add(
      GCWCoordsOutput(
        title: i18n(context, 'exif_gpscoordinates'),
        outputs: _currentOutput,
        points: [
          GCWMapPoint(point: point, coordinateFormat: _currentCoordsFormat),
        ],
      ),
    );
  }

  ///
  /// EXIF tags grouped by section
  ///
  void _decorateExifSections(List<Widget> widgets, Map<String, List<List<dynamic>>> _tableTags) {
    if (_tableTags != null) {
      _tableTags.forEach((section, tags) {
        widgets.add(GCWOutput(
            title: i18n(context, "exif_section_" + section) ?? section ?? '',
            child: Column(
              children: columnedMultiLineOutput(
                context,
                tags == null ? [] : tags,
              ),
            )));
      });
    }
  }

  ///
  /// Section file type specific
  ///
  void _decorateFileTypeSpecific(List<Widget> widgets, local.GCWFile platformFile) {
    if (platformFile == null) return;

    var data = <List<dynamic>>[];
    var fileType = getFileType(platformFile.bytes);

    switch (fileType) {
      case FileType.JPEG:
        var jpegData = Image.JpegData();
        jpegData.read(platformFile.bytes);

        if (jpegData.comment != null && jpegData.comment.isNotEmpty)
          data.add([i18n(context, 'exif_comment'), jpegData.comment]);
        if (jpegData.adobe != null) {
          var adobe = jpegData.adobe;
          if (adobe.version != null) data.add(['Adobe Version', adobe.version]);
          if (adobe.transformCode != null) data.add(['Adobe TransformCode', adobe.transformCode]);
          if (adobe.flags0 != null) data.add(['Adobe Flags 0', adobe.flags0]);
          if (adobe.flags1 != null) data.add(['Adobe Flags 1', adobe.flags1]);
        }
        break;
      default:
        return;
    }

    if (data.isNotEmpty) {
      widgets.add(GCWOutput(
          title: fileType.toString().split('.').last,
          child: Column(
            children: columnedMultiLineOutput(context, data),
          )));
    }
  }

  ///
  /// Section file
  ///
  void _decorateFile(List<Widget> widgets, local.GCWFile platformFile) {
    if (platformFile != null) {
      File _file;
      if (platformFile.path != null) {
        _file = File(platformFile.path);
      }

      var lastModified;
      try {
        lastModified = formatDate(_file?.lastModifiedSync());
      } catch (e) {}

      var lastAccessed;
      try {
        lastAccessed = formatDate(_file?.lastAccessedSync());
      } catch (e) {}

      widgets.add(GCWOutput(
          title: i18n(context, "exif_section_file"),
          child: Column(
              children: columnedMultiLineOutput(
            context,
            [
              [i18n(context, 'exif_filename'), platformFile.name ?? ''],
              [i18n(context, 'exif_filesize_bytes'), platformFile.bytes?.length ?? 0],
              [i18n(context, 'exif_filesize_kb'), (platformFile.bytes?.length / 1024).ceil() ?? 0],
              lastModified != null ? ['lastModified', formatDate(_file?.lastModifiedSync())] : null,
              lastAccessed != null ? ['lastAccessed', formatDate(_file?.lastAccessedSync())] : null,
              [i18n(context, 'exif_extension'), platformFile.extension ?? '']
            ],
          ))));
    }
  }

  void _decorateImage(List<Widget> widgets, Image.Image image) {
    if (image != null) {
      widgets.add(GCWOutput(
          title: i18n(context, 'exif_section_image'),
          child: Column(
              children: columnedMultiLineOutput(
            context,
            [
              [i18n(context, 'exif_width'), image.width ?? ''],
              [i18n(context, 'exif_height'), image.height ?? ''],
              ['Blend Method', image.blendMethod ?? ''],
              ['Channels', image.channels ?? ''],
              ['ICC Color Profile', image.iccProfile ?? ''],
              // Only for frames within an animation
              // [i18n(context, 'exif_duration'), image.duration ?? ''],
              // ['Offset X', image.xOffset ?? ''],
              // ['Offset Y', image.yOffset ?? ''],
              // image.exif
            ],
          ))));
    }
  }

  Future<Image.Image> _completeImageMetadata(local.GCWFile platformFile) async {
    Uint8List data = platformFile.bytes;
    Image.Image image;
    try {
      image = Image.decodeImage(data);
    } catch (e) {
      // Silent error
    }
    return image;
  }

  String formatDate(DateTime datetime) {
    String loc = Localizations.localeOf(context).toString();
    return (datetime == null) ? '' : DateFormat.yMd(loc).add_jms().format(datetime);
  }

  ///
  /// Section extra data
  ///
  Future<void> _decorateHiddenData(List<Widget> widgets) async {
    if (file == null) return;
    var _hiddenData = await hiddenData(file);

    if (_hiddenData == null || _hiddenData.length <= 1) return;

    widgets.add(GCWOutput(
        title: i18n(context, 'hiddendata_title'),
        child: GCWButton(
          text: i18n(context, 'exif_showhiddendata'),
          onPressed: () {
            openInHiddenData(context, file);
          },
        )));
  }
}

openInMetadataViewer(BuildContext context, local.GCWFile file) {
  Navigator.push(
      context,
      NoAnimationMaterialPageRoute(
          builder: (context) =>
              GCWTool(tool: ExifReader(file: file), toolName: i18n(context, 'exif_title'), i18nPrefix: '')));
}
