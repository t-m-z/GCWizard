part of 'package:gc_wizard/tools/miscellaneous/openai/logic/openai.dart';

final _BASE_URL_OPENAI_SPEECH = 'https://api.openai.com/v1/audio/speech';

Map<String, String> OPEN_AI_SPEECH_VOICE = {
  'alloy': 'alloy',
  'echo': 'echo',
  'fable': 'fable',
  'onyx': 'onyx',
  'nova': 'nova',
  'shimmer': 'shimmer',
};

Future<OpenAItaskOutput> _OpenAIgetSpeechAsync(String APIkey, String model, String prompt, double speed, String voice,
    {SendPort? sendAsyncPort}) async {
  String httpCode = '';
  String httpMessage = '';
  String uri = '';
  Uint8List audioData = Uint8List.fromList([]);

  OPENAI_TASK_STATUS status = OPENAI_TASK_STATUS.ERROR;

  final Map<String, String> OPENAI_SPEECH_HEADERS = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + APIkey,
  };

  final OPENAI_SPEECH_BODY = {
    'model': 'tts-1',
    'input': prompt,
    'speed': speed,
    'voice': voice,
  };

  try {
    uri = _BASE_URL_OPENAI_SPEECH;

    final http.Response response = await http.post(
      Uri.parse(uri),
      headers: OPENAI_SPEECH_HEADERS,
      body: jsonEncode(OPENAI_SPEECH_BODY),
    );
    httpCode = response.statusCode.toString();
    httpMessage = response.reasonPhrase.toString();

    if (httpCode != '200') {
      status = OPENAI_TASK_STATUS.ERROR;
      audioData = Uint8List.fromList([]);
    } else {
      status = OPENAI_TASK_STATUS.OK;
      audioData = Uint8List.fromList(response.body.codeUnits);
    }

  } catch (exception, stackTrace) {
    status = OPENAI_TASK_STATUS.ERROR;
    httpCode = exception.toString();
    httpMessage = stackTrace.toString();
    audioData = Uint8List.fromList([]);
  }

  return OpenAItaskOutput(
      status: status,
      httpCode: httpCode,
      httpMessage: httpMessage,
      textData: '',
      imageData: '',
      imageDataType: OPENAI_IMAGE_DATATYPE.NULL,
      audioFile: GCWFile(bytes: audioData, name: ''));
}
