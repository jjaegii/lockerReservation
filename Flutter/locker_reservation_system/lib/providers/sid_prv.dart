import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:locker_reservation_system/network/network.dart';

class SidProvider with ChangeNotifier {
  String sid = '';
  bool isLogin = false;

  // Future<bool> loginPost(String url, String sid, String pw) async {
  //   print('post() url: $url');
  //   http.Response response = await http.post(Uri.parse(url),
  //       body: json.encode({'studentID':sid, 'password':pw}), headers: headers);
  //   final int statusCode = response.statusCode;
  //   if (statusCode < 200 || statusCode > 400 || json == null) {
  //     print("statusCode : $statusCode, 로그인 실패");
  //     return false;
  //   }
  //   var responseData = json.decode(utf8.decode(response.bodyBytes));
  //   print('StatusCode : $statusCode, 로그인 성공');
  //   print('Response Data : $responseData');
  //   return true;
  // }

  Future<int> login(String sid, String pw) async {
    var returnValue = await NetworkMananger().post(
        "http://180.189.89.108:8000/login",
        json.encode({'studentID': sid, 'password': pw}));
    if (returnValue == 200) {
      this.sid = sid;
      isLogin = true;
      notifyListeners();
    }
    // else {
    //   this.sid = '';
    //   isLogin = false;
    //   return returnValue;
    // }
    
    return returnValue;
  }

  void logout() async {
    var returnValue =
        await NetworkMananger().logoutReq("http://180.189.89.108:8000/logout");
    print(returnValue);
    if (returnValue == true) {
      sid = '';
      isLogin = false;
    }
    print('isLogin: $isLogin');
    notifyListeners();
  }
}
