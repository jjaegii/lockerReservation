import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:locker_reservation_system/providers/reservation_prv.dart';

class SideNav extends StatefulWidget {
  SideNav({super.key});

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  // Room Number List
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
          imageList[context.watch<ReservationProvider>().roomState],
          width: 250,
          height: 250,
        ),
        for (int i = 0; i < list.length; i++) roomButton(list[i], i, context),
      ],
    );
  }
}

Widget roomButton(String roomName, int index, BuildContext context) {
  return ElevatedButton(
    child: Text(roomName),
    onPressed: () {
      context.read<ReservationProvider>().selectRoom(index);
      print("$roomName 번 방을 선택하셨습니다.");
      context.read<ReservationProvider>().getLockers(index);
    },
  );
}
