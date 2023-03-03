import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkMananger {
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String url) async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      print("statusCode : $statusCode, 작업 실패");
      return;
    }
    var responseData = json.decode(utf8.decode(response.bodyBytes));
    print('StatusCode : $statusCode, 작업 성공');
    return responseData;
  }

  static Future<bool> logoutReq(String url) async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      print("statusCode : $statusCode, 로그아웃 실패");
      return false;
    }
    print('StatusCode : $statusCode, 로그아웃 성공');
    return true;
  }

  Future<Map<String, dynamic>> post(String url, dynamic data) async {
    http.Response response =
        await http.post(Uri.parse(url), body: data, headers: headers);
    final int statusCode = response.statusCode;
    Map<String, dynamic> ret = {'status': statusCode, 'data': null};

    if (statusCode < 200 || statusCode > 400 || json == null) {
      print("statusCode : $statusCode, 작업 실패");
      return ret;
    }

    var responseData = json.decode(utf8.decode(response.bodyBytes));
    print('StatusCode : $statusCode, 작업 성공');
    ret['data'] = responseData;
    return ret;
  }

  Future<int> registerPost(String url, dynamic data) async {
    http.Response response =
        await http.post(Uri.parse(url), body: data, headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      print("statusCode : $statusCode, 회원가입 실패");
      return statusCode;
    }
    print('statusCode : $statusCode, 회원가입 성공');
    return statusCode;
  }
}
