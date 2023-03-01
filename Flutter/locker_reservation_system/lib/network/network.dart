import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:locker_reservation_system/network/model/user_model.dart'; // 응답 내용을 JSON Map으로 변환

class NetworkMananger {
  Map<String, String> headers = {
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
    print('Response Data : $responseData');
    return responseData;
  }

  Future<bool> logoutReq(String url) async {
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
    print(data);
    http.Response response = await http.post(Uri.parse(url),
        body: data, headers: headers);
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
    var responseData = json.decode(utf8.decode(response.bodyBytes));
    print('회원가입 성공');
    print('Response Data : $responseData');
    return statusCode;
  }
}
