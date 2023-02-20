import 'package:flutter/material.dart';
import 'package:locker_reservation_system/network/model/reservation_model.dart';
import 'package:locker_reservation_system/network/network.dart';

// ViewModel 역할
class ReservationProvider with ChangeNotifier {
  int _roomState = 0;
  int get roomState => _roomState;

  // roomCode
  List<String> roomCodeList = [
    'a',
    'b',
    'c',
    'd',
    'e'
  ];

  // NetworkMananger
  NetworkMananger nm = NetworkMananger();
  String getLockersURL = 'http://180.189.89.108:8000/state?location=';

  // 모델을 가지고 있음
  // 모델 초기화
  ReservationModel revModel = ReservationModel(rows: 0, columns: 0, lockers: Lockers(location: 'z', row: 0, column: 0));

  // 예약 관련 메서드
  void selectRoom(int roomIndex) {
    _roomState = roomIndex;
    notifyListeners();
  }

  void getLockers(int index) async {
    String url = getLockersURL + roomCodeList[index];
    var rawData = await nm.get(url);
    print('rawData : $rawData');

    notifyListeners();
  }
}