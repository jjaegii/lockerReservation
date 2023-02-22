import 'dart:html';

import 'package:flutter/material.dart';
import 'package:locker_reservation_system/network/model/reservation_model.dart';
import 'package:provider/provider.dart';
import 'package:locker_reservation_system/providers/snum_prv.dart';
import 'package:locker_reservation_system/network/network.dart';
import 'package:locker_reservation_system/providers/reservation_prv.dart';

class ReservationMain extends StatefulWidget {
  ReservationMain({super.key});

  @override
  State<ReservationMain> createState() => _ReservationMainState();
}

class _ReservationMainState extends State<ReservationMain> {
  @override
  Widget build(BuildContext context) {
    int colCount = context.watch<ReservationProvider>().revModel.columns;
    int rowCount = context.watch<ReservationProvider>().revModel.rows;
    int nowRoomState = context.watch<ReservationProvider>().roomState;
    String loc =
        context.watch<ReservationProvider>().roomCodeList[nowRoomState];

    List<Locker> lockerList =
        context.watch<ReservationProvider>().revModel.lockers;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < rowCount; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int j = 0; j < colCount; j++)
                  caseButton(i, j, loc, context),
              ],
            ),
        ],
      ),
    );
  }
}

Widget caseButton(int row, int column, String loc, BuildContext context) {
  // Locker 정보 불러오기
  Locker? myLocker = context.watch<ReservationProvider>().revModel.myLocker;
  List<Locker> lockerList =
      context.watch<ReservationProvider>().revModel.lockers;

  // 해당 값에 따른 색상 지정
  List<String> caseColorList = [
    "images/blueCase.png",
    "images/greyCase.png",
    "images/redCase.png",
  ];
  int colorPicker = 0;
  int visitor = context.watch<ReservationProvider>().visitor;

  if (myLocker != null && myLocker.column == column && myLocker.row == row) {
    colorPicker = 2;
  }

  if (lockerList[visitor].column == column && lockerList[visitor].row == row) {
    colorPicker = 1;
    context.read<ReservationProvider>().setVisitor();
  }

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        shadowColor: Color.fromARGB(0, 0, 0, 0)),
    child: Image.asset(
      caseColorList[colorPicker],
      width: 50,
      height: 50,
    ),
    onPressed: () {
      context
          .read<ReservationProvider>()
          .reserveLocker("21812096", loc, row, column);
      print("행 : $row, 열: $column");
    },
  );
}
