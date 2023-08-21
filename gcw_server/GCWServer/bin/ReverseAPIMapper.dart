import 'package:gc_wizard/tools/crypto_and_encodings/reverse/logic/reverse.dart';

import 'APIMapper.dart';

class ReverseAPIMapper extends APIMapper {

  @override
  String doLogic() {
    var input = getWebParameter(WEBPARAMETER.input);
    if (input == null) {
      return '';
    }
    return reverse(input);
  }

  /// convert doLogic output to map
  @override
  Map<String, String> toMap(Object result) {
    return <String, String>{enumName(WEBPARAMETER.result.toString()) : result.toString()};
  }
}
