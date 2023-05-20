// https://www.heise.de/select/ct/2022/23/2226215025059009285
// https://www.heise.de/select/ct/2022/23/softlinks/y69m?wt_mc=pred.red.ct.ct232022.168.softlink.softlink
// https://github.com/pirxthepilot/wtfis
//
// Virustotal    https://www.virustotal.com/gui/join-us
// Passivetotal  https://community.riskiq.com/registration/wtfis
// whois         https://www.whois.com/whois/
// SHODAN        https://account.shodan.io/register
// IPWhoIs       https://ipwhois.io/documentation

import 'dart:convert';
import 'dart:isolate';

import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:http/http.dart' as http;

part 'package:gc_wizard/tools/science_and_technology/wtf/logic/wtf_greynoise.dart';
part 'package:gc_wizard/tools/science_and_technology/wtf/logic/wtf_ipwhois.dart';
part 'package:gc_wizard/tools/science_and_technology/wtf/logic/wtf_whois.dart';

enum WTFmode { DOMAIN, IPV4, IPV6, URL, NULL }

enum WTFstatus { OK, ERROR, NULL }

class WTFDetailedOutput {
  final WTFstatus result;
  final String httpCode;
  final String httpMessage;
  final String toolSpecificMessage;
  final Map<String, dynamic> data;

  WTFDetailedOutput(
      {this.result = WTFstatus.NULL,
      this.httpCode = '',
      this.httpMessage = '',
      this.toolSpecificMessage = '',
      required this.data});
}

class WTFoutput {
  final WTFstatus result;
  final String httpCode;
  final String httpMessage;
  final WTFDetailedOutput dataSHODAN;
  final WTFDetailedOutput dataVirusTotal;
  final WTFDetailedOutput dataPassiveTotal;
  final WTFDetailedOutput dataWhoIs;
  final WTFDetailedOutput dataIPWhoIs;
  final WTFDetailedOutput dataGreyNoise;

  WTFoutput(
      {required this.result,
      required this.httpCode,
      required this.httpMessage,
      required this.dataSHODAN,
      required this.dataPassiveTotal,
      required this.dataVirusTotal,
      required this.dataWhoIs,
      required this.dataIPWhoIs,
      required this.dataGreyNoise});
}

class WTFjobData {
  String WTFjobDataAdress;
  String WTFjobDataMode;
  String WTFjobDataShodan_api_key;
  String WTFjobDataVt_api_key;
  String WTFjobDataPt_api_key;
  String WTFjobDataWhois_api_key;
  String WTFjobDataGreynoise_api_key;

  WTFjobData({
    required this.WTFjobDataAdress,
    required this.WTFjobDataMode,
    required this.WTFjobDataShodan_api_key,
    required this.WTFjobDataVt_api_key,
    required this.WTFjobDataPt_api_key,
    required this.WTFjobDataWhois_api_key,
    required this.WTFjobDataGreynoise_api_key,
  });
}

Future<WTFoutput> WTFgetInformationAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! WTFjobData) {
    return Future.value(WTFoutput(
        result: WTFstatus.NULL,
        httpCode: '',
        httpMessage: '',
        dataSHODAN: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}),
        dataPassiveTotal: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}),
        dataVirusTotal: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}),
        dataWhoIs: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}),
        dataIPWhoIs: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}),
        dataGreyNoise: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {})));
  }
  var WTFjob = jobData!.parameters as WTFjobData;
  WTFoutput output = await getWTFInformation(
      WTFjob.WTFjobDataAdress,
      StringToWTFmode(WTFjob.WTFjobDataMode),
      WTFjob.WTFjobDataShodan_api_key,
      WTFjob.WTFjobDataVt_api_key,
      WTFjob.WTFjobDataPt_api_key,
      WTFjob.WTFjobDataWhois_api_key,
      WTFjob.WTFjobDataWhois_api_key,
      sendAsyncPort: jobData.sendAsyncPort);

  jobData.sendAsyncPort?.send(output);

  return output;
}

Future<WTFoutput> getWTFInformation(String address, WTFmode mode, String SHODAN_API_KEY, String VT_API_KEY,
    String PT_API_KEY, String WHOIS_API_KEY, String GREYNOISE_API_KEY,
    {SendPort? sendAsyncPort}) async {
  String base_url_SHODAN = 'https://api.shodan.io/';
  String base_url_VT = 'https://www.virustotal.com/api/v3/';
  String base_url_PT = 'https://api.riskiq.net/pt/v2';
  String base_url_whois = 'http://api.whoapi.com/?';
  String base_url_ipwhois = 'https://ipwho.is/';
  String base_url_greynoise = "https://api.greynoise.io/v3/community/";

  WTFDetailedOutput detailsSHODAN;
  WTFDetailedOutput detailsVT;
  WTFDetailedOutput detailsPT;
  WTFDetailedOutput detailsWhoIs;
  WTFDetailedOutput detailsIPWhoIs;
  WTFDetailedOutput detailsGreyNoise;

  String httpCode = '';
  String httpMessage = '';
  late Uri uri;
  List<Uri> uriList = [];
  http.Response response;

  final Map<String, String> VT_HEADERS = {
    //'Content-Type': 'application/json; charset=UTF-8',
    //'Accept': 'application/json',
    'x-apikey': VT_API_KEY,
  };

  final Map<String, String> PT_HEADERS = {
    'Content-Type': 'application/json',
    //'Accept': 'application/json',
    //'x-apikey': VT_API_KEY,
  };

  final Map<String, String> WHOIS_HEADERS = {
    'Content-Type': 'application/json; charset=UTF-8',
    //'Accept': 'application/json',
    //'x-apikey': VT_API_KEY,
  };

  final Map<String, String> GREYNOISE_HEADERS = {
    //'Content-Type': 'application/json; charset=UTF-8',
    'accept': 'application/json',
    'key': GREYNOISE_API_KEY,
  };

  try {
    // retrieve data from VirusTotal
    // https://developers.virustotal.com/reference/overview
    // domains/<address>
    // domains/<address>/resolutions
    // domains/<address>/historical_whois
    // ip_addresses/<address>
    // ip_addresses/<address>/historical_whois
    // urls/<address>

    if (mode == WTFmode.IPV4 || mode == WTFmode.IPV6 || mode == WTFmode.URL || mode == WTFmode.DOMAIN) {
      if (mode == WTFmode.IPV4 || mode == WTFmode.IPV6) {
        uriList = [
          Uri.parse(base_url_VT + 'ip_addresses/' + address),
          Uri.parse(base_url_VT + 'ip_addresses/' + address + '/resolutions'),
          Uri.parse(base_url_VT + 'ip_addresses/' + address + '/historical_whois'),
          Uri.parse(base_url_VT + 'ip_addresses/' + address + '/historical_ssl_certificates'),
          Uri.parse(base_url_VT + 'ip_addresses/' + address + '/comments'),
        ];
      } else if (mode == WTFmode.DOMAIN) {
        uriList = [
          Uri.parse(base_url_VT + 'domains/' + address),
          Uri.parse(base_url_VT + 'domains/' + address + '/resolutions'),
          Uri.parse(base_url_VT + 'domains/' + address + '/historical_whois'),
          Uri.parse(base_url_VT + 'domains/' + address + '/comments'),
        ];
      } else {
        uriList = [
          Uri.parse(base_url_VT + 'urls/' + address),
          Uri.parse(base_url_VT + 'urls/' + address + '/comments'),
          Uri.parse(base_url_VT + 'urls/' + address + '/network_location'),
        ];
      }

      response = await http.get(uriList[0], headers: VT_HEADERS);
      httpCode = response.statusCode.toString();
      httpMessage = response.reasonPhrase as String;
      if (response.statusCode == 200) {
        detailsVT = WTFDetailedOutput(
            result: WTFstatus.OK,
            httpCode: httpCode,
            httpMessage: httpMessage,
            data: json.decode(response.body) as Map<String, dynamic>);
      } else {
        detailsVT = WTFDetailedOutput(result: WTFstatus.ERROR, httpCode: httpCode, httpMessage: httpMessage, data: {});
      }
    } else {
      detailsVT = WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {});
    }

    // retrieve data from SHODAN
    // https://developer.shodan.io/api
    if (mode == WTFmode.IPV4 || mode == WTFmode.IPV6) {
      uri = Uri.parse(base_url_SHODAN + 'shodan/host/' + address + '?key=' + SHODAN_API_KEY);
      response = await http.get(uri);
      httpCode = response.statusCode.toString();
      httpMessage = response.reasonPhrase as String;
      if (response.statusCode == 200) {
        detailsSHODAN = WTFDetailedOutput(
            result: WTFstatus.OK,
            httpCode: httpCode,
            httpMessage: httpMessage,
            data: json.decode(response.body) as Map<String, dynamic>);
      } else {
        detailsSHODAN =
            WTFDetailedOutput(result: WTFstatus.ERROR, httpCode: httpCode, httpMessage: httpMessage, data: {});
      }
    } else {
      detailsSHODAN = WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {});
    }

    // retrieve data from WHOIS
    // https://whoapi.com/api-documentation/
    // r=whois             Whois API
    // r=taken             Domain Availability API
    // r=blacklist         Blacklist API
    // r=cert              SSL API
    // r=domainscore-check Domain Score API (check)
    // r=emailscore-check  Email Score API
    if (mode == WTFmode.DOMAIN) {
      uriList = [
        Uri.parse(base_url_whois + 'domain=' + address + '&r=whois&apikey=' + WHOIS_API_KEY),
        Uri.parse(base_url_whois + 'domain=' + address + '&r=taken&apikey=' + WHOIS_API_KEY),
        Uri.parse(base_url_whois + 'domain=' + address + '&r=blacklist&apikey=' + WHOIS_API_KEY),
        Uri.parse(base_url_whois + 'domain=' + address + '&r=cert&apikey=' + WHOIS_API_KEY),
        Uri.parse(base_url_whois + 'domain=' + address + '&r=domainscore-check&apikey=' + WHOIS_API_KEY),
        Uri.parse(base_url_whois + 'domain=' + address + '&r=emailscore-check&apikey=' + WHOIS_API_KEY),
      ];
      response = await http.get(uriList[0]);
      httpCode = response.statusCode.toString();
      //httpMessage = response.status_desc;
      if (response.statusCode == 200) {
        detailsWhoIs = WTFDetailedOutput(
            result: WTFstatus.OK,
            httpCode: httpCode,
            httpMessage: httpMessage,
            data: json.decode(response.body) as Map<String, dynamic>);
      } else {
        detailsWhoIs =
            WTFDetailedOutput(result: WTFstatus.ERROR, httpCode: httpCode, httpMessage: httpMessage, data: {});
      }
    } else {
      detailsWhoIs = WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {});
    }

    // retrieve data from IP WhoIs
    // https://ipwhois.io/documentation
    if (mode == WTFmode.IPV4 || mode == WTFmode.IPV6) {
      uri = Uri.parse(base_url_ipwhois + address);
      response = await http.get(uri);
      httpCode = response.statusCode.toString();
      if (response.statusCode == 200) {
        detailsIPWhoIs = WTFDetailedOutput(
            result: WTFstatus.OK,
            httpCode: httpCode,
            httpMessage: httpMessage,
            data: json.decode(response.body) as Map<String, dynamic>);
      } else {
        detailsIPWhoIs =
            WTFDetailedOutput(result: WTFstatus.ERROR, httpCode: httpCode, httpMessage: httpMessage, data: {});
      }
    } else {
      detailsIPWhoIs = WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {});
    }

    // retrieve data from PassiveTotal
    // https://api.riskiq.net/api/pt_started.html
    //
    if (mode == WTFmode.IPV4 || mode == WTFmode.IPV6 || mode == WTFmode.URL || mode == WTFmode.DOMAIN) {
      if (mode == WTFmode.IPV4 || mode == WTFmode.IPV6) {
        uri = Uri.parse(base_url_PT + 'ip_addresses/' + address);
      } else if (mode == WTFmode.DOMAIN) {
        uri = Uri.parse(base_url_PT + 'dns/passive/' + address);
      } else {
        uri = Uri.parse(base_url_PT + 'urls/' + address);
      }
      response = await http.get(uri, headers: PT_HEADERS);
      httpCode = response.statusCode.toString();
      httpMessage = response.reasonPhrase as String;
      if (response.statusCode == 200) {
        detailsPT = WTFDetailedOutput(
            result: WTFstatus.OK,
            httpCode: httpCode,
            httpMessage: httpMessage,
            data: json.decode(response.body) as Map<String, dynamic>);
      } else {
        detailsPT = WTFDetailedOutput(result: WTFstatus.ERROR, httpCode: httpCode, httpMessage: httpMessage, data: {});
      }
    } else {
      detailsPT = WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {});
    }

    detailsPT = WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {});

    // retrieve data from GreyNoise
    // https://docs.greynoise.io/docs/using-the-greynoise-community-api
    if (mode == WTFmode.IPV4) {
      uri = Uri.parse(base_url_greynoise + address);
      response = await http.get(uri, headers: GREYNOISE_HEADERS);
      httpCode = response.statusCode.toString();
      httpMessage = response.reasonPhrase as String;
      if (response.statusCode == 200) {
        detailsGreyNoise = WTFDetailedOutput(
            result: WTFstatus.OK,
            httpCode: httpCode,
            httpMessage: httpMessage,
            toolSpecificMessage: 'wtf_result_greynoise_200',
            data: json.decode(response.body) as Map<String, dynamic>);
      } else {
        detailsGreyNoise = WTFDetailedOutput(
            result: WTFstatus.ERROR,
            httpCode: httpCode,
            httpMessage: httpMessage,
            toolSpecificMessage: 'wtf_result_greynoise_' + httpCode,
            data: json.decode(response.body) as Map<String, dynamic>);
      }
    } else {
      detailsGreyNoise = WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {});
    }
  } catch (exception) {
    //SocketException: Connection timed out (OS Error: Connection timed out, errno = 110), address = 192.168.178.93, port = 57582
    return WTFoutput(
        result: WTFstatus.ERROR,
        httpCode: '503',
        httpMessage: exception.toString(),
        dataSHODAN: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}),
        dataPassiveTotal: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}),
        dataVirusTotal: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}),
        dataWhoIs: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}),
        dataIPWhoIs: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}),
        dataGreyNoise: WTFDetailedOutput(result: WTFstatus.NULL, httpCode: '', httpMessage: '', data: {}));
  } // end catch exception

  return WTFoutput(
    result: WTFstatus.OK,
    httpCode: httpCode,
    httpMessage: httpMessage,
    dataSHODAN: detailsSHODAN,
    dataVirusTotal: detailsVT,
    dataPassiveTotal: detailsPT,
    dataWhoIs: detailsWhoIs,
    dataIPWhoIs: detailsIPWhoIs,
    dataGreyNoise: detailsGreyNoise,
  );
}

bool testIPv4(String address) {
  RegExp ipv4Exp =
      RegExp(r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$", caseSensitive: false, multiLine: false);

  return ipv4Exp.hasMatch(address);
}

bool testIPv6(String address) {
  RegExp ipv6Exp =
      RegExp(r"^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$", caseSensitive: false, multiLine: false);

  return ipv6Exp.hasMatch(address);
}

bool testURL(String address) {
  RegExp urlExp = RegExp(r"(http|ftp|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?");

  return urlExp.hasMatch(address);
}

bool testDOMAIN(String address) {
  RegExp domainExp = RegExp(r"^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}$");

  return domainExp.hasMatch(address);
}

WTFmode WTFMode(String address) {
  if (testIPv4(address)) {
    return WTFmode.IPV4;
  } else if (testIPv6(address)) {
    return WTFmode.IPV6;
  } else if (testURL(address)) {
    return WTFmode.URL;
  } else if (testDOMAIN(address)) {
    return WTFmode.DOMAIN;
  } else {
    return WTFmode.NULL;
  }
}

String WTFmodeToString(WTFmode mode) {
  switch (mode) {
    case WTFmode.NULL:
      return 'NULL';
    case WTFmode.IPV4:
      return 'IPV4';
    case WTFmode.IPV6:
      return 'IPV6';
    case WTFmode.URL:
      return 'URL';
    case WTFmode.DOMAIN:
      return 'DOMAIN';
  }
}

WTFmode StringToWTFmode(String mode) {
  switch (mode) {
    case 'NULL':
      return WTFmode.NULL;
    case 'IPV4':
      return WTFmode.IPV4;
    case 'IPV6':
      return WTFmode.IPV6;
    case 'URL':
      return WTFmode.URL;
    case 'DOMAIN':
      return WTFmode.DOMAIN;
  }
  return WTFmode.NULL;
}
