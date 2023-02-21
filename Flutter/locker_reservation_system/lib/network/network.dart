import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert'; // 응답 내용을 JSON Map으로 변환

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

  Future<dynamic> post(String url, dynamic data) async {
    print('post() url: $url');
    http.Response response =
        await http.post(Uri.parse(url), body: data, headers: headers);

    final int statusCode = response.statusCode;
    var responseData = json.decode(utf8.decode(response.bodyBytes));
    print('StatusCode : $statusCode, 작업 성공');
    print('Response Data : $responseData');

    return statusCode;
  }
}
