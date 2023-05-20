import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';

class ImagesAndFilesSelection extends GCWSelection {
  const ImagesAndFilesSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList =
        registeredTools.where((element) => element.categories.contains(ToolCategory.IMAGES_AND_FILES)).toList();

    _toolList.sort((a, b) => sortToolList(a, b));

    return GCWToolList(toolList: _toolList);
  }
}
