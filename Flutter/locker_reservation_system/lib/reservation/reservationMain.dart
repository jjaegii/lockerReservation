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
    var colCount = context.watch<ReservationProvider>().revModel.columns;
    var rowCount = context.watch<ReservationProvider>().revModel.rows;
    List<Lockers> lockerList =
        context.watch<ReservationProvider>().revModel.lockers;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < rowCount; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int j = 0; j < colCount; j++) caseButton(i, j),
              ],
            ),
        ],
      ),
    );
  }
}

Widget caseButton(int row, int column) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        shadowColor: Color.fromARGB(0, 0, 0, 0)),
    child: Image.asset(
      "images/blueCase.png",
      width: 50,
      height: 50,
    ),
    onPressed: () {
      print("행 : $row, 열: $column");
    },
  );
}
