import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class StarwarsCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'starwars',
      apiUrl: 'https://swapi.dev/api/people',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic test1(dynamic response) => getJsonField(
        response,
        r'''$.results[1,2]''',
        true,
      );
  static dynamic test2(dynamic response) => getJsonField(
        response,
        r'''$.results..name''',
        true,
      );
  static dynamic test3(dynamic response) => getJsonField(
        response,
        r'''$.results[?(@.gender=='male')]''',
        true,
      );
}

class ClovaCall {
  static Future<ApiCallResponse> call({
    String? text =
        '‘남사친’은 듬직한 남자 사람 친구 처럼 여자들과 대화해 주는 30살 헬스 트레이너 남자 입니다. 상대방은 남사친을 지성민 으로 부릅니다. 남사친은 듬직한 말투를 사용합니다. 남사친은 가볍게 조언하거나, 가르치려 들지 않고, 상대방의 입장을 공감해 주고 들어주는 것에 집중 합니다. 너무 무섭지 않게 대화 합니다. 상대방의 대화 내용에 맞게, 남사친의 대답을 만들어주세요. 남사친의 대답을 만들 때 질문도 자주 해주세요. 남사친의 대답을 만들 때 5글자 이상으로 길게 만들어주세요. 남사친은 상대방의 관심사에 따라 이야기 합니다. \\n남사친 : 안녕~ ㅋㅋ \\n남사친 : 운동좋아해? \\n상대방 : ㅋㅋㅋㅋㅋㅋ 잘생겼네? \\n남사친 : ',
  }) {
    final body = '''
{
  "topK" : 0,
  "includeProbs" : false,
  "includeTokens" : false,
  "restart" : "",
  "includeAiFilters" : true,
  "maxTokens" : 50,
  "temperature" : 0.7,
  "start" : "",
  "stopBefore" : ["상대방"],
  "text" : "${text}",
  "repeatPenalty" : 5.0,
  "topP" : 0.8
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'clova',
      apiUrl:
          'https://clovastudio.apigw.ntruss.com/testapp/v1/completions/LK-D',
      callType: ApiCallType.POST,
      headers: {
        'X-NCP-CLOVASTUDIO-API-KEY':
            'NTA0MjU2MWZlZTcxNDJiY2s9pyn8+OZS4KSMyBNLBVMEwc+HeN+4e2bVH5ctVL88AvtXUA1Gaa4TAMXkz/xpewEkHC9a4KK/zA2o5VC73Kqxbc3Rqnd03pgy3jrVuT3GrKC436zp0G4p2d2/608fu8FVI1KSYWZUc3mg2ue1FO9eZuorggQD3iKT19Tne8QDqSOhd6Yw7Y3GhnIx7FOz69EVWEaadL39zCI5Fv2jYPc=',
        'X-NCP-APIGW-API-KEY': 'AzPNSrwDXhbKN7MOf0uSafeQ4mJ289XATaV552Uw',
        'X-NCP-CLOVASTUDIO-REQUEST-ID': '63c880175cc74ce68128ee69baa5f65e',
        'Content-Type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
