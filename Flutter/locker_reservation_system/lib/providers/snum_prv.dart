import 'package:flutter/material.dart';

class SnumProvider with ChangeNotifier {
  String snum = '';
  bool isLogin = false;

  // 회원 관리 메서드
  void login(String snum) {
    this.snum = snum;
    isLogin = true;
    notifyListeners();
  }

  void logout() {
    snum = '';
    isLogin = false;
    notifyListeners();
  }
}
