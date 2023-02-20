import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:locker_reservation_system/providers/reservation_prv.dart';
import 'package:locker_reservation_system/network/network.dart';

class SideNav extends StatelessWidget {
  // Room Number List
  // 2023.02.16 하드코딩 상태
  // 필요시 데이터베이스와 연결
  List<String> list = [
    "1층 113호 앞",
    "1층 114호 앞",
    "2층 214호 앞",
    "2층 219호 앞",
    "2층 219호 옆"
  ];

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
          imageList[context.watch<ResrvationProvider>().roomState],
          width: 250,
          height: 250,
        ),
        for (int i = 0; i < list.length; i++) roomButton(list[i], i, context),
      ],
    );
  }
}

Widget roomButton(String roomName, int index, BuildContext context) {
  NetworkMananger nm = NetworkMananger();

  return ElevatedButton(
    child: Text(roomName),
    onPressed: () {
      context.read<ResrvationProvider>().selectRoom(index);
      print("$roomName 번 방을 선택하셨습니다.");
      nm.get("http://180.189.89.108:8000/state?location=a");
    },
  );
}