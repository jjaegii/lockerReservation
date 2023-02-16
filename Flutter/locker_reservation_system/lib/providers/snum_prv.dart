import 'package:flutter/material.dart';

class SnumProvider with ChangeNotifier {
  String snum = '';
  bool isLogin = false;

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
