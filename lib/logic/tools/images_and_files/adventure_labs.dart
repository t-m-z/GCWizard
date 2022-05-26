// https://github.com/adv-lab/geocaching-adventure-labs-doc
// https://labs-api.geocaching.com/swagger/ui/index#!/Adventures/Adventures_SearchV3
// https://github.com/mirsch/lab2gpx/blob/master/index.php

import 'dart:convert';
import 'dart:isolate';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

enum ANALYSE_RESULT_STATUS { OK, ERROR_HTTP, NONE}
final Map<String, String> HTTP_STATUS = {
  '200': 'wherigo_http_code_200', // ok
  '400': 'wherigo_http_code_400',
  '401': 'wherigo_http_code_401', // Unauthorized
  '404': 'wherigo_http_code_404', // Not found
  '413': 'wherigo_http_code_413',
  '500': 'wherigo_http_code_500',
  '503': 'wherigo_http_code_503',
};

final CONSUMER_KEY = 'A01A9CA1-29E0-46BD-A270-9D894A527B91';
final SEARCH_ADDRESSV3 = 'https://labs-api.geocaching.com/Api/Adventures/SearchV3';
final SEARCH_ADDRESSV4 = 'https://labs-api.geocaching.com/Api/Adventures/SearchV4';
final DETAIL_ADDRESS = 'https://labs-api.geocaching.com/api/Adventures/';
final Map<String,String> HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json',
  'X-Consumer-Key': CONSUMER_KEY,
};

class Adventures {
  final List<AdventureData> AdventureList;
  final String httpCode;
  final String httpMessage;

  Adventures({
    this.AdventureList,
    this.httpCode,
    this.httpMessage,
  });
}

class AdventureData {
  final String AdventureGuid;
  final String Id;
  final String Title;
  final String KeyImageUrl;
  final String DeepLink;
  final String Description;
  final String OwnerPublicGuid;
  final String RatingsAverage;
  final String RatingsTotalCount;
  final String Latitude;
  final String Longitude;
  final List<AdventureStages> Stages;
  AdventureData(
      {
        this.AdventureGuid = '',
        this.Id = '',
        this.Title = '',
        this.KeyImageUrl = '',
        this.DeepLink = '',
        this.Description = '',
        this.OwnerPublicGuid = '',
        this.RatingsAverage = '',
        this.RatingsTotalCount = '',
        this.Latitude = '',
        this.Longitude = '',
        this.Stages,
  });
}

class AdventureStages {
  final String ID;

  AdventureStages({
    this.ID = '',

});

}

Future<Map<String, dynamic>> getAdventureDataAsync(dynamic jobData) async {
  var output = await getAdventureData(
      jobData.parameters["coordinate"],
      jobData.parameters["radius"],
      sendAsyncPort: jobData.sendAsyncPort);

  if (jobData.sendAsyncPort != null) {
    jobData.sendAsyncPort.send(output);
  }
  return output;
}

Future<Map<String, dynamic>> getAdventureData(LatLng coordinate, int radius, {SendPort sendAsyncPort}) async {
  var out = Map<String, dynamic>();

  String httpCode = '';
  String httpMessage = '';

  try {
    print('TRY getAdventureData(coordinate, radius)');
    print(coordinate.latitude);
    print(coordinate.longitude);
    print(radius);
    final response = await http.get(
      Uri.parse(
        SEARCH_ADDRESSV3 +
            '?radiusMeters=' + radius.toString() +
            '&origin.latitude=' + coordinate.latitude.toString() +
            '&origin.longitude=' + coordinate.longitude.toString()),
      headers: HEADERS,
    );
    final Map<String, dynamic> responseJson = json.decode(response.body) as Map<String, dynamic>;
print(response.statusCode.toString());
print(response.reasonPhrase);
print(responseJson);
print('----------------------------------------------------------------------------------------------------------');
    httpCode = response.statusCode.toString();
    httpMessage = response.reasonPhrase;

    if (response.statusCode == 200) {
      List<AdventureData> AdventureList = [];
      int totalCount = responseJson["TotalCount"];
      String id = '';
      print(totalCount);
      print( responseJson["Items"]);
      print( responseJson["Items"][0]);
      print( responseJson["Items"][1]);
      print( responseJson["Items"][2]);
      for (int i = 0; i < totalCount; i++) {
        print('######################################################################################################');
        print( responseJson["Items"][i]);
        id = responseJson["Items"][i]["Id"];
        // get Details for LabCache with ID

        AdventureList.add(
          AdventureData(
            AdventureGuid: responseJson["Items"][i]["AdventureGuid"],
            Id: responseJson["Items"][i]["Id"],
            Title: responseJson["Items"][i]["Title"],
            KeyImageUrl: responseJson["Items"][i]["KeyImageUrl"],
            DeepLink: responseJson["Items"][i]["DeepLink"],
            Description: responseJson["Items"][i]["Description"],
            OwnerPublicGuid: responseJson["Items"][i]["OwnerPublicGuid"],
            RatingsAverage: responseJson["Items"][i]["RatingsAverage"],
            RatingsTotalCount: responseJson["Items"][i]["RatingsTotalCount"],
            Latitude: responseJson["Items"][i]["Latitude"],
            Longitude: responseJson["Items"][i]["Longitude"],
            Stages: [],
          )
        );
      }
      out.addAll({
        'adventures': Adventures(
            AdventureList: AdventureList,
            httpCode: httpCode,
            httpMessage: httpMessage)
      });
    }
    else {
      out.addAll({
        'adventures': Adventures(
            AdventureList: [],
            httpCode: httpCode,
            httpMessage: httpMessage)
      });
    }
  } catch (exception) {
    httpCode = '503';
    httpMessage = exception.toString();
    out.addAll({
      'adventures': Adventures(
          AdventureList: [],
          httpCode: httpCode,
          httpMessage: httpMessage)
    });
  } // end catch exception
  print(out);
  print(out['adventures']);
  print(out['adventures'].AdventureList);
  return out;
}