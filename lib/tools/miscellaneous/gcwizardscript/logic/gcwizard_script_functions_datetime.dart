part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

String _date() {
  return DateFormat('yyyy/MM/dd').format(DateTime.now());
}

String _time() {
  return DateFormat('HH:mm:ss').format(DateTime.now());
}
