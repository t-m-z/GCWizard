import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit.dart';

class Typography extends Unit {
  late double Function(double) toDTPPt;
  late double Function(double) fromDTPPt;

  Typography({
    required String name,
    required String symbol,
    bool isReference = false,
    required double inDTPPt,
  }) : super(name, symbol, isReference, (e) => e * inDTPPt, (e) => e / inDTPPt) {
    toDTPPt = toReference;
    fromDTPPt = fromReference;
  }
}

final TYPOGRAPHY_DTPPOINT =
    Typography(name: 'common_unit_typography_pt_name', symbol: 'pt', inDTPPt: 1.0, isReference: true);

final _TYPOGRAPHY_SCALEDPOINT =
    Typography(name: 'common_unit_typography_sp_name', symbol: 'sp', inDTPPt: 1.0 / 65536.0);

final _TYPOGRAPHY_BIGPOINT =
    Typography(name: 'common_unit_typography_bp_name', symbol: 'bp', inDTPPt: 25.4 / 72.0 / 0.3528);

final _TYPOGRAPHY_DIDOT = Typography(name: 'common_unit_typography_dd_name', symbol: 'dd', inDTPPt: 0.375 / 0.3528);

final _TYPOGRAPHY_CICERO = Typography(name: 'common_unit_typography_cc_name', symbol: 'cc', inDTPPt: 4.5 / 0.3528);

final _TYPOGRAPHY_DTPPICA = Typography(name: 'common_unit_typography_pc_name', symbol: 'pc', inDTPPt: 12.0);

final _TYPOGRAPHY_PICA = Typography(name: 'common_unit_typography_p_name', symbol: 'p', inDTPPt: 12.0);

final _TYPOGRAPHY_INCH = Typography(name: 'common_unit_typography_in_name', symbol: 'in', inDTPPt: 72.0);

final TYPOGRAPHY_CENTIMETER = Typography(name: 'common_unit_typography_cm_name', symbol: 'cm', inDTPPt: 10.0 / 0.3528);

final _TYPOGRAPHY_MILLIMETER = Typography(name: 'common_unit_typography_mm_name', symbol: 'mm', inDTPPt: 1.0 / 0.3528);

final List<Typography> typographies = [
  _TYPOGRAPHY_MILLIMETER,
  TYPOGRAPHY_CENTIMETER,
  _TYPOGRAPHY_INCH,
  TYPOGRAPHY_DTPPOINT,
  _TYPOGRAPHY_SCALEDPOINT,
  _TYPOGRAPHY_BIGPOINT,
  _TYPOGRAPHY_DIDOT,
  _TYPOGRAPHY_CICERO,
  _TYPOGRAPHY_DTPPICA,
  _TYPOGRAPHY_PICA
];
