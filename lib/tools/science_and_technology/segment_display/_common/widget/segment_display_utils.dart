part of 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/segmentdisplay_output.dart';

Future<ui.Image> buildSegmentDisplayImage(int countColumns, List<NSegmentDisplay> displays, bool upsideDown,
    {double? verticalPadding, double? horizontalPadding}) async {
  const double bounds = 3.0;
  var _verticalPadding = verticalPadding ?? 5.0;
  var _horizontalPadding = horizontalPadding ?? 5.0;

  var width = 0.0;
  var height = 0.0;
  var columnCounter = 0;
  var rowWidth = 0.0;
  var rowHeight = 0.0;
  var images = <ui.Image>[];
  var offset = const ui.Offset(0, bounds);

  // create images
  for (var i = 0; i < displays.length; i++) {
    images.add(await displays[i].renderedImage);
  }

  // calc image size
  for (var image in images) {
    rowWidth += image.width + 2 * _horizontalPadding;
    width = max(width, rowWidth);
    rowHeight = max(rowHeight, image.height.toDouble() + 2 * _verticalPadding);
    columnCounter++;

    if (columnCounter >= countColumns) {
      height += rowHeight;
      rowWidth = 0;
      rowHeight = 0;
      columnCounter = 0;
    }
  }

  width = width + 2 * bounds;
  height = height + rowHeight + 2 * bounds;

  final canvasRecorder = ui.PictureRecorder();
  final canvas = ui.Canvas(canvasRecorder, ui.Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

  var countRows = (images.length / countColumns).floor();

  for (var i = 0; i <= countRows; i++) {
    offset = ui.Offset(bounds, offset.dy);
    rowHeight = 0;

    for (var j = 0; j < countColumns; j++) {
      var imageIndex = i * countColumns + j;

      if (imageIndex < images.length) {
        var image = images[imageIndex];
        var middlePoint = ui.Offset(
            offset.dx + _horizontalPadding + image.width / 2, offset.dy + _verticalPadding + image.height / 2);
        if (upsideDown) {
          canvas.translate(middlePoint.dx, middlePoint.dy);
          canvas.rotate(pi);
          canvas.translate(-middlePoint.dx, -middlePoint.dy);
        }
        canvas.drawImage(image, offset.translate(_horizontalPadding, _verticalPadding), paint);
        if (upsideDown) {
          canvas.translate(middlePoint.dx, middlePoint.dy);
          canvas.rotate(pi);
          canvas.translate(-middlePoint.dx, -middlePoint.dy);
        }
        offset = offset.translate(image.width.toDouble() + 2 * _horizontalPadding, 0);
        rowHeight = max(rowHeight, image.height.toDouble() + 2 * _verticalPadding);
      }
    }
    offset = offset.translate(0, rowHeight);
  }
  return canvasRecorder.endRecording().toImage(width.toInt(), height.toInt());
}

Future<void> _exportFile(BuildContext context, Uint8List? data) async {
  if (data == null) return;
  await saveByteDataToFile(context, data, buildFileNameWithDate('img_', FileType.PNG)).then((value) {
    if (value) showExportedFileDialog(context, contentWidget: imageContent(context, data));
  });
}

Widget _buildSegmentDisplayOutput(int countColumns, List<Widget> displays,
    {double? verticalPadding, double? horizontalPadding}) {
  var _verticalPadding = verticalPadding ?? 5.0;
  var _horizontalPadding = horizontalPadding ?? 5.0;

  var rows = <Widget>[];
  var countRows = (displays.length / countColumns).floor();

  for (var i = 0; i <= countRows; i++) {
    var columns = <Widget>[];

    for (var j = 0; j < countColumns; j++) {
      Widget widget;
      var displayIndex = i * countColumns + j;

      if (displayIndex < displays.length) {
        var display = displays[displayIndex];

        widget = Container(
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: display,
        );
      } else {
        widget = Container();
      }

      columns.add(Expanded(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: _verticalPadding),
        child: widget,
      )));
    }

    rows.add(Row(
      children: columns,
    ));
  }

  return Column(
    children: rows,
  );
}
