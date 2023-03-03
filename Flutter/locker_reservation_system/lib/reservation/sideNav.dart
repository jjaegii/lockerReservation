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
  List<String> roomNameList = [
    "1층 114호 앞",
    "1층 113호 앞",
    "2층 220호 앞",
    "2층 219호 앞",
    "2층 221호 앞"
  ];

  List<String> imageList = [
    "assets/images/a.jpg",
    "assets/images/b.jpg",
    "assets/images/c.jpg",
    "assets/images/d.jpg",
    "assets/images/e.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imageList[context.watch<ReservationProvider>().roomState],
            width: 250,
            height: 250,
          ),
          for (int i = 0; i < roomNameList.length; i++)
            roomButton(roomNameList[i], i, context),
        ],
      ),
    );
  }
}

Widget roomButton(String roomName, int index, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    height: 50,
    width: 250,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 59, 106, 186)),
      child: Text(
        roomName,
        textAlign: TextAlign.center,
      ),
      onPressed: () {
        context.read<ReservationProvider>().selectRoom(index);
        print("$roomName 번 방을 선택하셨습니다.");
        context.read<ReservationProvider>().getLockers(index);
      },
    ),
  );
}

Widget listview(List roomNameList) {
  final ScrollController _scrollController = ScrollController();
  return ListView.builder(
    scrollDirection: Axis.vertical,
    controller: _scrollController,
    physics: NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(8),
    itemCount: roomNameList.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        color: Colors.blue,
      );
    },
  );
}
