import 'package:flutter/material.dart';

class SnumProvider with ChangeNotifier {
  String snum = '';
  bool isLogin = false;
  int _roomState = 0;
  int get roomState => _roomState;

  // 예약 관련 메서드
  void selectRoom(int roomIndex) {
    _roomState = roomIndex;
    notifyListeners();
  }

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
