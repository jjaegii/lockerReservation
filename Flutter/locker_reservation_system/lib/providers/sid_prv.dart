import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:locker_reservation_system/network/model/user_model.dart';
import 'package:locker_reservation_system/network/network.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SidProvider with ChangeNotifier {
  late UserModel user;
  String sid = '';
  bool isLogin = false;

  Future<int> login(String sid, String pw) async {
    String serverUrl = dotenv.env['SERVER_URL'] ?? "http://localhost:8000";
    var returnValue = await NetworkMananger().post(
        "$serverUrl/login", json.encode({'studentID': sid, 'password': pw}));
    if (returnValue['status'] == 200) {
      this.sid = sid;
      user = UserModel.fromJson(returnValue['data']);
      isLogin = true;
      notifyListeners();
    }
    return returnValue['status'];
  }

  void logout() async {
    String serverUrl = dotenv.env['SERVER_URL'] ?? "http://localhost:8000";
    var returnValue = await NetworkMananger().logoutReq("$serverUrl/logout");
    if (returnValue == true) {
      sid = '';
      isLogin = false;
    }
    notifyListeners();
  }
}
