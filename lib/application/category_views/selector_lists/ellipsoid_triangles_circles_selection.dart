import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/coords/triangles/circles/excircles/widget/ellipsoidtriangle_excircles.dart';
import 'package:gc_wizard/tools/coords/triangles/circles/incircle/widget/ellipsoidtriangle_incircle.dart';
import 'package:gc_wizard/tools/coords/triangles/circles/circumcircle/widget/circumcircle.dart';

class EllipsoidTrianglePointsCirclesSelection extends GCWSelection {
  const EllipsoidTrianglePointsCirclesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        EllipsoidTriangleIncircle,
        EllipsoidTriangleCircumCircle,
        EllipsoidTriangleExcircles
      });

    return GCWToolList(toolList: _toolList);
  }
}
