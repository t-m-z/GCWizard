part of 'package:gc_wizard/tools/miscellaneous/openai/logic/openai.dart';

final BASE_URL_OPENAI_SPEECH = 'https://api.openai.com/v1/audio/speech';

Map<String, String> OPEN_AI_SPEECH_VOICE = {
  'alloy' : 'alloy',
  'echo' : 'echo',
  'fable' : 'fable',
  'onyx' : 'onyx',
  'nova' : 'nova',
  'shimmer' : 'shimmer',
};

Future<OpenAItaskOutput> _OpenAIgetSpeechAsync(String APIkey, String model, String prompt, double speed, String voice, {SendPort? sendAsyncPort}) async {
  String httpCode = '';
  String httpMessage = '';
  String textData = '';
  String uri = '';
  OPENAI_TASK_STATUS status = OPENAI_TASK_STATUS.ERROR;

  final Map<String, String> OPENAI_SPEECH_HEADERS = {
    'Content-Type': 'application/json',
    'Authorization' : 'Bearer '+APIkey,
  };

  final OPENAI_SPEECH_BODY = {
    'model': 'tts-1',
    'input': prompt,
    'speed': speed,
    'voice': voice,
  };

  try {
    uri = BASE_URL_OPENAI_SPEECH;
    final http.Response responseChat = await http.post(
      Uri.parse(uri),
      headers: OPENAI_SPEECH_HEADERS,
      body: jsonEncode(OPENAI_SPEECH_BODY),
    );
    httpCode = responseChat.statusCode.toString();
    httpMessage = responseChat.reasonPhrase.toString();
    textData = responseChat.body;
    if (httpCode != '200') {
      print('ERROR    ----------------------------------------------------------------');
      print(httpCode);
      print(httpMessage);
      print(textData);
    } else {
      status = OPENAI_TASK_STATUS.OK;
      print('CORECT    ----------------------------------------------------------------');
      print(httpCode);
      print(httpMessage);
      print(textData);
    }
  } catch (e) {
    print(e.toString());
  }

  return OpenAItaskOutput(status: status, httpCode: httpCode, httpMessage: httpMessage, textData: textData, imageData: '', imageDataType: OPENAI_IMAGE_DATATYPE.NULL, );
}