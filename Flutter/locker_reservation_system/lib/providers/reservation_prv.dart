import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:locker_reservation_system/network/model/reservation_model.dart';
import 'package:locker_reservation_system/network/network.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  String? serverUrl = dotenv.env['SERVER_URL'] ?? "localhost:8000";
  String getLockersAPI = '/state?location=';
  String reserveAPI = "/state";

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
    String url = serverUrl! + getLockersAPI + roomCodeList[index];
    var jsonData = await nm.get(url);
    revModel = ReservationModel.fromJson(jsonData);
    print('revModel Count: ${revModel.lockers.length}');

    notifyListeners();
  }

  void setVisitor() {
    if (visitor < revModel.lockers.length) {
      _visitor++;
    }
    if (visitor == revModel.lockers.length) {
      _visitor = 0;
    }
  }

  Future<AlertDialog> reserveLocker(
      String stdID, String loc, int row, int column) async {
    String? message;

    var returnStatusCode = await nm.post(
        serverUrl! + reserveAPI,
        json.encode({
          "studentID": stdID,
          "location": loc,
          "row": row,
          "column": column
        }));
    print("예약하기 StatusCode : $returnStatusCode");

    if (returnStatusCode == 201) {
      message = "예약(취소) 성공!";
    } else if (returnStatusCode == 401) {
      message = "잘못된 요청";
    } else if (returnStatusCode == 409) {
      message = "이미 사용중인 사물함 입니다.";
    } else {
      message = "작업 실패";
    }

    return AlertDialog(
      content: Text(message),
      insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
      actions: [],
    );
  }
}
