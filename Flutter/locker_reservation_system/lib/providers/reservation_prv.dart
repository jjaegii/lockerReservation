import 'package:flutter/material.dart';

class ResrvationProvider with ChangeNotifier {
  int _roomState = 0;
  int get roomState => _roomState;

  // 예약 관련 메서드
  void selectRoom(int roomIndex) {
    _roomState = roomIndex;
    notifyListeners();
  }
}