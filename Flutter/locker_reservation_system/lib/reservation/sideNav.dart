import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:locker_reservation_system/providers/snum_prv.dart';

class SideNav extends StatelessWidget {
  // Room Number List
  List<int> list = [1, 2, 3, 4];
  List<String> imageList = [
    "images/113.png",
    "images/114.png",
    "images/214.png",
    "images/219_front.png",
    "images/219_next.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          imageList[context.watch<SnumProvider>().roomState],
          width: 250,
          height: 250,
        ),
        for (int i = 0; i < list.length; i++) roomButton(list[i], i, context),
      ],
    );
  }
}

Widget roomButton(int roomNum, int index, BuildContext context) {
  return ElevatedButton(
    child: Text("$roomNum"),
    onPressed: () {
      context.read<SnumProvider>().selectRoom(index);
      print("$roomNum 번 방을 선택하셨습니다.");
    },
  );
}
