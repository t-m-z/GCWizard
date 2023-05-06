part of 'package:gc_wizard/tools/science_and_technology/wtf/logic/wtf.dart';

/*
{
  "ip": "91.51.104.238",
  "success": "true",
  "type": "IPv4",
  "continent": "Europe",
  "continent_code": "EU",
  "country": "Germany",
  "country_code": "DE",
  "region": "Hesse",
  "region_code": "HE",
  "city": "Darmstadt",
  "latitude": "49.8728253",
  "longitude": "8.6511929",
  "is_eu": "true",
  "postal": "64283",
  "calling_code": "49",
  "capital": "Berlin",
  "borders": "AT,BE,CH,CZ,DK,FR,LU,NL,PL",
  "flag": {
    "img": "https:\/\/cdn.ipwhois.io\/flags\/de.svg",
    "emoji": "\ud83c\udde9\ud83c\uddea",
    "emoji_unicode": "U+1F1E9 U+1F1EA"
    },
  "connection":{
    "asn": "3320",
    "org": "Deutsche Telekom AG",
    "isp": "Deutsche Telekom AG",
    "domain": "telekom3.de"
    },
  "timezone":{
    "id":"Europe\/Berlin",
    "abbr":"CET",
    "is_dst":"false",
    "offset":"3600",
    "utc":"+01:00",
    "current_time":"2022-11-05T12:03:46+01:00"
    }
}
 */

class WTFIPWhoIs {
  late String ip;
  late bool success;
  late String type;
  late String continent;
  late String continentCode;
  late String country;
  late String countryCode;
  late String region;
  late String regionCode;
  late String city;
  late String latitude;
  late String longitude;
  late String isEu;
  late String postal;
  late String callingCode;
  late String capital;
  late String borders;
  late WTFIPWhoIsFlag flag;
  late WTFIPWhoIsConnection connection;
  late WTFIPWhoIsTimezone timezone;

  WTFIPWhoIs({
    required this.ip,
      required this.success,
      required this.type,
      required this.continent,
      required this.continentCode,
      required this.country,
      required this.countryCode,
      required this.region,
      required this.regionCode,
      required this.city,
      required this.latitude,
      required this.longitude,
      required this.isEu,
      required this.postal,
      required this.callingCode,
      required this.capital,
      required this.borders,
      required this.flag,
      required this.connection,
      required this.timezone});

  WTFIPWhoIs.fromJson(Map<String, dynamic> json) {
    ip = json['ip'].toString();
    success = json['success'] as bool;
    type = json['type'].toString();
    continent = json['continent'].toString();
    continentCode = json['continent_code'].toString();
    country = json['country'].toString();
    countryCode = json['country_code'].toString();
    region = json['region'].toString();
    regionCode = json['region_code'].toString();
    city = json['city'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    isEu = json['is_eu'].toString();
    postal = json['postal'].toString();
    callingCode = json['calling_code'].toString();
    capital = json['capital'].toString();
    borders = json['borders'].toString();
    flag = (json['flag'] != null ? WTFIPWhoIsFlag.fromJson(json['flag'] as Map<String, dynamic>) : null)!;
    connection = (json['connection'] != null ? WTFIPWhoIsConnection.fromJson(json['connection'] as Map<String, dynamic>) : null)!;
    timezone = (json['timezone'] != null ? WTFIPWhoIsTimezone.fromJson(json['timezone'] as Map<String, dynamic>) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ip'] = ip;
    data['success'] = success;
    data['type'] = type;
    data['continent'] = continent;
    data['continent_code'] = continentCode;
    data['country'] = country;
    data['country_code'] = countryCode;
    data['region'] = region;
    data['region_code'] = regionCode;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_eu'] = isEu;
    data['postal'] = postal;
    data['calling_code'] = callingCode;
    data['capital'] = capital;
    data['borders'] = borders;
    data['flag'] = flag.toJson();
    data['connection'] = connection.toJson();
    data['timezone'] = timezone.toJson();
    return data;
  }
}

class WTFIPWhoIsFlag {
  late String img;
  late String emoji;
  late String emojiUnicode;

  WTFIPWhoIsFlag({required this.img, required this.emoji, required this.emojiUnicode});

  WTFIPWhoIsFlag.fromJson(Map<String, dynamic> json) {
    img = json['img'].toString();
    emoji = json['emoji'].toString();
    emojiUnicode = json['emoji_unicode'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img'] = img;
    data['emoji'] = emoji;
    data['emoji_unicode'] = emojiUnicode;
    return data;
  }
}

class WTFIPWhoIsConnection {
  late String asn;
  late String org;
  late String isp;
  late String domain;

  WTFIPWhoIsConnection({required this.asn, required this.org, required this.isp, required this.domain});

  WTFIPWhoIsConnection.fromJson(Map<String, dynamic> json) {
    asn = json['asn'].toString();
    org = json['org'].toString();
    isp = json['isp'].toString();
    domain = json['domain'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asn'] = asn;
    data['org'] = org;
    data['isp'] = isp;
    data['domain'] = domain;
    return data;
  }
}

class WTFIPWhoIsTimezone {
  late String id;
  late String abbr;
  late String isDst;
  late String offset;
  late String utc;
  late String currentTime;

  WTFIPWhoIsTimezone(
      {required this.id,
      required this.abbr,
      required this.isDst,
      required this.offset,
      required this.utc,
      required this.currentTime});

  WTFIPWhoIsTimezone.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    abbr = json['abbr'].toString();
    isDst = json['is_dst'].toString();
    offset = json['offset'].toString();
    utc = json['utc'].toString();
    currentTime = json['current_time'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['abbr'] = abbr;
    data['is_dst'] = isDst;
    data['offset'] = offset;
    data['utc'] = utc;
    data['current_time'] = currentTime;
    return data;
  }
}
