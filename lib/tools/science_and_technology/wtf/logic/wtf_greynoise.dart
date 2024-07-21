part of 'package:gc_wizard/tools/science_and_technology/wtf/logic/wtf.dart';

Map<String, String> WTF_GREYNOISE_RESULT_CODES = {
  '200' : "wtf_result_greynoise_200",
  '400' : "wtf_result_greynoise_400",
  '401' : "wtf_result_greynoise_401",
  '404' : "wtf_result_greynoise_404",
  '429' : "wtf_result_greynoise_429",
  '500' : "wtf_result_greynoise_500",
};

class WTFGreyNoise200 {
  late String ip;
  late bool noise;
  late bool riot;
  late String classification;
  late String name;
  late String link;
  late String lastSeen;
  late String message;

  WTFGreyNoise200({
    required this.ip,
    required this.noise,
    required this.riot,
    required this.classification,
    required this.name,
    required this.link,
    required this.lastSeen,
    required this.message});

  WTFGreyNoise200.fromJson(Map<String, dynamic> json) {
    ip = json['ip'].toString();
    noise = json['noise'] as bool;
    riot = json['riot'] as bool;
    classification = json['classification'].toString();
    name = json['name'].toString();
    link = json['link'].toString();
    lastSeen = json['last_seen'].toString();
    message = json['message'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ip'] = ip;
    data['noise'] = noise;
    data['riot'] = riot;
    data['classification'] = classification;
    data['name'] = name;
    data['link'] = link;
    data['last_seen'] = lastSeen;
    data['message'] = message;
    return data;
  }
}

class WTFGreyNoise404 {
  late String ip;
  late bool noise;
  late bool riot;
  late String message;

  WTFGreyNoise404({
    required this.ip,
    required this.noise,
    required this.riot,
    required this.message});

  WTFGreyNoise404.fromJson(Map<String, dynamic> json) {
    ip = json['ip'].toString();
    noise = json['noise'] as bool;
    riot = json['riot'] as bool;
    message = json['message'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ip'] = ip;
    data['noise'] = noise;
    data['riot'] = riot;
    data['message'] = message;
    return data;
  }
}

class WTFGreyNoise429 {
  late String plan;
  late String rateLimit;
  late String planUrl;
  late String message;

  WTFGreyNoise429({
    required this.plan,
    required this.rateLimit,
    required this.planUrl,
    required this.message});

  WTFGreyNoise429.fromJson(Map<String, dynamic> json) {
    plan = json['plan'].toString();
    rateLimit = json['rate-limit'].toString();
    planUrl = json['plan_url'].toString();
    message = json['message'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan'] = plan;
    data['rate-limit'] = rateLimit;
    data['plan_url'] = planUrl;
    data['message'] = message;
    return data;
  }
}
