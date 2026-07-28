import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/selector_lists/ellipsoid_triangles_circles_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/ellipsoid_triangles_specialpoints_selection.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/coords/triangles/area/widget/ellipsoidtriangle_area.dart';
import 'package:gc_wizard/tools/coords/triangles/medians/widget/ellipsoidtriangle_medians.dart';

class EllipsoidTrianglePointsSelection extends GCWSelection {
  const EllipsoidTrianglePointsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        EllipsoidTrianglePointsCirclesSelection,
        EllipsoidTriangleArea,
        EllipsoidTriangleMedians,
        EllipsoidTrianglePointsSpecialPointsSelection
      });

    return GCWToolList(toolList: _toolList);
  }
}
