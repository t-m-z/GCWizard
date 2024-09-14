import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_dialog.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_text_export.dart';
import 'package:gc_wizard/tools/coords/_common/logic/gpx_kml_gpx_export.dart' as coordinatesExport;
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';

void showCoordinatesExportDialog(BuildContext context, List<GCWMapPoint> points, List<GCWMapPolyline> polylines,
    {String? json}) {
  showGCWDialog(context, i18n(context, 'common_savefile'), Text(i18n(context, 'coords_export_fileformat')), [
    json != null
        ? GCWDialogButton(
            text: 'JSON',
            onPressed: () async {
              var possibleExportMode =
                  json.length < MAX_QR_TEXT_LENGTH_FOR_EXPORT ? PossibleExportMode.BOTH : PossibleExportMode.TEXTONLY;
              showGCWDialog(
                  context,
                  'JSON ' + i18n(context, 'common_text'),
                  GCWTextExport(
                    text: json,
                    initMode:
                    TextExportMode.TEXT,
                    possibleExportMode: possibleExportMode,
                    addSaveButton: true,
                    saveFilenamePrefix: 'coords',
                    saveFileType: FileType.JSON,
                  ),
                  [GCWDialogButton(text: i18n(context, 'common_ok'))],
                  cancelButton: false);
            },
          )
        : Container(),
    GCWDialogButton(
      text: 'GPX',
      onPressed: () async {
        coordinatesExport.exportCoordinates(context, points, polylines).then((bool value) {
          _showExportedFileDialog(context, FileType.GPX);
        });
      },
    ),
    GCWDialogButton(
      text: 'KML',
      onPressed: () async {
        coordinatesExport.exportCoordinates(context, points, polylines, kmlFormat: true).then((bool value) {
          if (value) _showExportedFileDialog(context, FileType.KML);
        });
      },
    )
  ]);
}

void _showExportedFileDialog(BuildContext context, FileType type) {
  showExportedFileDialog(context);
}
