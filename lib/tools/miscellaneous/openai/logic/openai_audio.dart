part of 'package:gc_wizard/tools/miscellaneous/openai/logic/openai.dart';

final BASE_URL_CHATGPT_AUDIO_TRANSLATE = 'https://api.openai.com/v1/audio/translations';
final BASE_URL_CHATGPT_AUDIO_TRANSCRIBE = 'https://api.openai.com/v1/audio/transcriptions';

Map<OPENAI_TASK, String> AUDIO_URL = {
  OPENAI_TASK.AUDIO_TRANSCRIBE: BASE_URL_CHATGPT_AUDIO_TRANSCRIBE,
  OPENAI_TASK.AUDIO_TRANSLATE: BASE_URL_CHATGPT_AUDIO_TRANSLATE,
};

Future<OpenAItaskOutput> _OpenAIgetAudioAsync(
    String APIkey, String model, String prompt, double temperature, String size, bool imageUrl, OPENAI_TASK task,
    {SendPort? sendAsyncPort}) async {
  String httpCode = '';
  String httpMessage = '';
  String textData = '';
  OPENAI_TASK_STATUS status = OPENAI_TASK_STATUS.ERROR;

  try {

    /*

        final dio = Dio(BaseOptions(
      baseUrl: BASE_URL_OPENAI_SPEECH,
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + APIkey,
      },
    ));

    Response response = await dio.post(
      uri,
      data: OPENAI_SPEECH_BODY,
    );
    httpCode = response.statusCode.toString();
    httpMessage = response.statusMessage.toString();
    print(response.data.runtimeType);
    textData = response.data as String;

     */

    final Map<String, String> OPENAI_AUDIO_HEADERS = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ' + APIkey,
    };

    final CHATGPT_AUDIO_BODY_TRANSCRIBE = {
      'model': 'whisper-1',
      'response_format': 'text',
    };

    final body = jsonEncode(CHATGPT_AUDIO_BODY_TRANSCRIBE);
    print(body);
    final uri = AUDIO_URL[task];
    final http.Response responseImage = await http.post(
      Uri.parse(uri!),
      headers: OPENAI_AUDIO_HEADERS,
      body: body,
    );
    httpCode = responseImage.statusCode.toString();
    httpMessage = responseImage.reasonPhrase.toString();
    textData = responseImage.body;
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

  return OpenAItaskOutput(
      status: status,
      httpCode: httpCode,
      httpMessage: httpMessage,
      imageData: '',
      imageDataType: OPENAI_IMAGE_DATATYPE.NULL,
      textData: '',
      audioData: Uint8List.fromList([]));
}
