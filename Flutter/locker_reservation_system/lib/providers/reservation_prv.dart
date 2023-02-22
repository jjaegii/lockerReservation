import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:locker_reservation_system/network/model/reservation_model.dart';
import 'package:locker_reservation_system/network/network.dart';

// ViewModel 역할
class ReservationProvider with ChangeNotifier {
  int _roomState = 0;
  int get roomState => _roomState;

  int _visitor = 0;
  int get visitor => _visitor;

  // roomCode
  List<String> roomCodeList = ['a', 'b', 'c', 'd', 'e'];

  // NetworkMananger
  NetworkMananger nm = NetworkMananger();
  String getLockersURL = 'http://180.189.89.108:8000/state?location=';
  String reserveURL = "http://180.189.89.108:8000/state";

  // 모델을 가지고 있음
  // 모델 초기화
  ReservationModel revModel =
      ReservationModel(rows: 0, columns: 0, myLocker: null, lockers: []);

  // 예약 관련 메서드
  void selectRoom(int roomIndex) {
    _roomState = roomIndex;
    notifyListeners();
  }

  void getLockers(int index) async {
    String url = getLockersURL + roomCodeList[index];
    var jsonData = await nm.get(url);
    revModel = ReservationModel.fromJson(jsonData);
    print('revModel: ${revModel.lockers.first.row}');

    notifyListeners();
  }

  void setVisitor() {
    if (visitor < revModel.lockers.length) {
      _visitor++;
    }
    if (visitor == revModel.lockers.length) {
      _visitor = 0;
    }
    print("현재 비지터 : $visitor");
    notifyListeners();
  }

  void reserveLocker(String stdID, String loc, int row, int column) async {
    var returnStatusCode = await nm.post(
        reserveURL,
        json.encode({
          "studentID": stdID,
          "location": loc,
          "row": row,
          "column": column
        }));

    print("예약하기 StatusCode : $returnStatusCode");

    if (returnStatusCode == 201) {
      print("예약 성공!");
    } else if (returnStatusCode == 401) {
      print("잘못된 요청");
    } else if (returnStatusCode == 409) {
      print("이미 사용중인 사물함 입니다.");
    } else {
      print("작업 실패");
    }
  }
}
