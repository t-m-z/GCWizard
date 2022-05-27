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
  final String AdventureThemes;
  final String OwnerUsername;
  final String OwnerId;
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
        this.AdventureThemes = '',
        this.OwnerUsername,
        this.OwnerId,
        this.Stages,
  });
}

class AdventureStages {
  final String Id;
  final String Title;
  final String Description;
  final String KeyImageUrl;
  final String Latitude;
  final String Longitude;
  final String AwardImageUrl;
  final String AwardVideoYouTubeId;
  final String CompletionAwardMessage;
  final String GeofencingRadius;
  final String Question;
  final String CompletionCode;
  final String MultiChoiceOptions;
  final String KeyImage;

  AdventureStages({
    this.Id = '',
    this.Title = '',
    this.Description = '',
    this.KeyImageUrl = '',
    this.Latitude = '',
    this.Longitude = '',
    this.AwardImageUrl = '',
    this.AwardVideoYouTubeId = '',
    this.CompletionAwardMessage = '',
    this.GeofencingRadius = '',
    this.Question = '',
    this.CompletionCode = '',
    this.MultiChoiceOptions = '',
    this.KeyImage = '',
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
  String httpCodeStages = '';
  String httpMessage = '';
  String httpMessageStages = '';

  List<AdventureStages> Stages = [];

  try {
    final response = await http.get(
      Uri.parse(
        SEARCH_ADDRESSV3 +
            '?radiusMeters=' + radius.toString() +
            '&origin.latitude=' + coordinate.latitude.toString() +
            '&origin.longitude=' + coordinate.longitude.toString()),
      headers: HEADERS,
    );
    final Map<String, dynamic> responseJson = json.decode(response.body) as Map<String, dynamic>;
    httpCode = response.statusCode.toString();
    httpMessage = response.reasonPhrase;

    if (httpCode == '200') {
      List<AdventureData> AdventureList = [];
      int totalCount = responseJson["TotalCount"];
      List<dynamic> responseItems = responseJson["Items"];
      for (int i = 0; i < totalCount; i++) {
        Map<String, dynamic> item = responseItems[i];
        print(item);
        var AdventureGuid = item["AdventureGuid"].toString();
        var Id = item["Id"].toString();
        var Title = item["Title"].toString();
        var Description = item["Description"].toString();
        var KeyImageUrl = item["KeyImageUrl"].toString();
        var DeepLink = item["DeepLink"].toString();
        var OwnerPublicGuid = item["OwnerPublicGuid"].toString();
        var RatingsAverage = item["RatingsAverage"].toString();
        var RatingsTotalCount = item["RatingsTotalCount"].toString();
        var Latitude = item["Location"]["Latitude"].toString();
        var Longitude = item["Location"]["Longitude"].toString();
        var AdventureThemes = item["AdventureThemes"].join(', ');
        var OwnerUsername = '';
        var OwnerId = '';

        // get Details for LabCache with ID
        final responseStages = await http.get(
          Uri.parse(DETAIL_ADDRESS + Id),
          headers: HEADERS,
        );
        final Map<String, dynamic> responseJsonStages = json.decode(responseStages.body) as Map<String, dynamic>;
        httpCodeStages = responseStages.statusCode.toString();
        httpMessageStages = responseStages.reasonPhrase;
print(responseJsonStages);
        if (httpCodeStages == '200') {
          Description = responseJsonStages["Description"].toString();
          OwnerUsername = responseJsonStages["OwnerUsername"].toString();
          OwnerId = responseJsonStages["OwnerId"].toString();

          responseJsonStages["GeocacheSummaries"].forEach((stage) {
            print(stage);
            Stages.add(
                AdventureStages(
                  Id: stage["Id"].toString(),
                  Title: stage["Title"].toString(),
                  AwardImageUrl: stage["AwardImageUrl"].toString(),
                  AwardVideoYouTubeId: stage["AwardVideoYouTubeId"].toString(),
                  CompletionAwardMessage: stage["CompletionAwardMessage"].toString(),
                  CompletionCode: stage["CompletionCode"].toString(),
                  GeofencingRadius: stage["GeofencingRadius"].toString(),
                  KeyImage: stage["KeyImage"].toString(),
                  KeyImageUrl: stage["KeyImageUrl"].toString(),
                  Latitude: stage["Location"]["Latitude"].toString(),
                  Longitude: stage["Location"]["Longitude"].toString(),
                  MultiChoiceOptions: stage["MultiChoiceOptions"].toString(),
                )
            );
          });
        }

        AdventureList.add(
          AdventureData(
            AdventureGuid: AdventureGuid,
            Id: Id,
            Title: Title,
            KeyImageUrl: KeyImageUrl,
            DeepLink: DeepLink,
            Description: Description,
            OwnerPublicGuid: OwnerPublicGuid,
            RatingsAverage: RatingsAverage,
            RatingsTotalCount: RatingsTotalCount,
            Latitude: Latitude,
            Longitude: Longitude,
            AdventureThemes: AdventureThemes,
            OwnerId: OwnerId,
            OwnerUsername: OwnerUsername,
            Stages: Stages,
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
  return out;
}