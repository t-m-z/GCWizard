import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/coords/triangles/special_points/centerofgravity/widget/ellipsoidtriangle_centerofgravity.dart';
import 'package:gc_wizard/tools/coords/triangles/special_points/gergonne/widget/ellipsoidtriangle_gergonne.dart';
import 'package:gc_wizard/tools/coords/triangles/special_points/napoleon/widget/ellipsoidtriangle_napoleon.dart';
import 'package:gc_wizard/tools/coords/triangles/special_points/orthocenter/widget/ellipsoidtriangle_orthocenter.dart';

class EllipsoidTrianglePointsSpecialPointsSelection extends GCWSelection {
  const EllipsoidTrianglePointsSpecialPointsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        EllipsoidTriangleCenterOfGravity,
        EllipsoidTriangleOrthocenter,
        EllipsoidTriangleNapoleonPoints,
        EllipsoidTriangleGergonnePoint
      });

    return GCWToolList(toolList: sortTools(_toolList));
  }
}
