import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:locker_reservation_system/network/model/user_model.dart';
import 'package:locker_reservation_system/network/network.dart';

class SidProvider with ChangeNotifier {
  late UserModel user = UserModel(studentID: 'sid', name: 'name');
  String sid = '';
  bool isLogin = false;

  Future<int> login(String sid, String pw) async {
    var returnValue = await NetworkMananger().post(
        "/login", json.encode({'studentID': sid, 'password': pw}));
    if (returnValue['status'] == 200) {
      this.sid = sid;
      user = UserModel.fromJson(returnValue['data']);
      isLogin = true;
      notifyListeners();
    }
    return returnValue['status'];
  }

  void logout() async {
    var returnValue = await NetworkMananger.logoutReq("/logout");
    if (returnValue == true) {
      sid = '';
      isLogin = false;
    }
    notifyListeners();
  }
}
