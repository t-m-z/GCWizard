part of 'package:gc_wizard/tools/miscellaneous/openai/logic/openai.dart';

final BASE_URL_OPENAI_IMAGE = 'https://api.openai.com/v1/images/generations';

enum OPENAI_IMAGE_DATATYPE { URL, BASE64, NULL }

Map<String, String> OPEN_AI_IMAGE_SIZE = {
  '256x256': '256x256',
  '512x512': '512x512',
  '1024x1024': '1024x1024',
  '1024x1792': '1024x1792',
  '1792x1024': '1792x1024',
};

Future<OpenAItaskOutput> _OpenAIgetImageAsync(
    String APIkey, String model, String prompt, double temperature, String size, bool imageUrl,
    {SendPort? sendAsyncPort}) async {
  String httpCode = '';
  String httpMessage = '';
  String imageData = '';
  String textData =  '';
  OPENAI_TASK_STATUS status = OPENAI_TASK_STATUS.ERROR;

  try {
    final Map<String, String> CHATGPT_MODEL_HEADERS = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + APIkey,
    };

    final OPENAI_IMAGE_BODY = {
      //'model': 'dall-e-3',
      'prompt': prompt,
      'n': 1,
      'size': size,
      'response_format': imageUrl ? 'url' : 'b64_json',
    };

    final body = jsonEncode(OPENAI_IMAGE_BODY);
    final uri = BASE_URL_OPENAI_IMAGE;
    final http.Response responseImage = await http.post(
      Uri.parse(uri),
      headers: CHATGPT_MODEL_HEADERS,
      body: body,
    );
    httpCode = responseImage.statusCode.toString();
    httpMessage = responseImage.reasonPhrase.toString();
    imageData = responseImage.body;
    if (httpCode != '200') {
      OPENAI_TASK_STATUS.ERROR;
      var errorMessage = jsonDecode(imageData);
      textData = (errorMessage['error']['code'] as String) + '\n' + (errorMessage['error']['message'] as String);
    } else {
      status = OPENAI_TASK_STATUS.OK;
    }
  } catch (exception, stackTrace) {
    status = OPENAI_TASK_STATUS.ERROR;
    httpCode = exception.toString();
    httpMessage = stackTrace.toString();
  }

  return OpenAItaskOutput(
      status: status,
      httpCode: httpCode,
      httpMessage: httpMessage,
      imageData: imageData,
      imageDataType: OPENAI_IMAGE_DATATYPE.NULL,
      textData: textData,
      audioFile: GCWFile(bytes: Uint8List.fromList([]), name: ''));
}
