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
    String url = getLockersAPI + roomCodeList[index];
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

    var returnStatus = await nm.post(
        reserveAPI,
        json.encode({
          "studentID": stdID,
          "location": loc,
          "row": row,
          "column": column
        }));
    print("예약하기 StatusCode : ${returnStatus['status']}");

    if (returnStatus['status'] == 201) {
      message = "사물함 예약에 성공하였습니다!";
    } else if (returnStatus['status'] == 202) {
      message = "사물함 예약이 취소되었습니다.";
    } else if (returnStatus['status'] == 401) {
      message = "로그인 후 사물함 신청이 가능합니다.";
    } else if (returnStatus['status'] == 403) {
      message = "사물함 신청 기간이 아닙니다. 신청 기간을 확인하세요.";
    } else if (returnStatus['status'] == 409) {
      message = "이미 신청이 완료되었거나, 다른 사람이 사용 중인 사물함입니다.";
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
