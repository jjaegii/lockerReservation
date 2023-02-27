import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkMananger {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String url) async {
    print('get() url: $url');
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      print("statusCode : $statusCode, 작업 실패");
      return;
    }
    var responseData = json.decode(utf8.decode(response.bodyBytes));
    print('StatusCode : $statusCode, 작업 성공');
    print('Response Data : $responseData');
    return responseData;
  }

  Future<bool> logoutReq(String url) async {
    // print('get() url: $url');
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      print("statusCode : $statusCode, 로그아웃 실패");
      return false;
    }
    print('StatusCode : $statusCode, 로그아웃 성공');
    return true;
  }

  Future<int> post(String url, dynamic data) async {
    // print('post() url: $url');
    print(data);
    http.Response response =
        await http.post(Uri.parse(url), body: data, headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      print("statusCode : $statusCode, 작업 실패");
      return statusCode;
    }
    var responseData = json.decode(utf8.decode(response.bodyBytes));
    print('StatusCode : $statusCode, 작업 성공');
    // 로그인 성공 시 회원의 정보를 저장하여야 함
    // 승균이형과 상의할 것
    print('Response Data : $responseData');
    return statusCode;
  }

  Future<int> registerPost(String url, dynamic data) async {
    // print('post() url: $url');
    http.Response response =
        await http.post(Uri.parse(url), body: data, headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      print("statusCode : $statusCode, 회원가입 실패");
      return statusCode;
    }
    var responseData = json.decode(utf8.decode(response.bodyBytes));
    print('StatusCode : $statusCode, 회원가입 성공');
    print('Response Data : $responseData');
    return statusCode;
  }
}
