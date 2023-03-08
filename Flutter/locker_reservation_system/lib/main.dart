import 'package:flutter/material.dart';
import 'package:locker_reservation_system/network/network.dart';
import 'package:locker_reservation_system/reservation/reservationMain.dart';
import 'package:locker_reservation_system/router.dart';
import 'package:provider/provider.dart';
import 'package:locker_reservation_system/providers/sid_prv.dart';
import 'package:locker_reservation_system/providers/reservation_prv.dart';
import 'package:locker_reservation_system/navbar.dart';
import 'package:locker_reservation_system/reservation/sideNav.dart';
import 'package:url_strategy/url_strategy.dart';

void main(){
  setPathUrlStrategy();
  MyRouter.setupRouters();
  NetworkMananger.logoutReq("/logout");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SidProvider()),
        ChangeNotifierProvider(create: (context) => ReservationProvider()),
      ],
      child: MaterialApp(
        title: '컴퓨터공학과 사물함 예약 시스템',
        onGenerateRoute: MyRouter.router.generator,
        initialRoute: '/',
        home: MainPage(title: '컴퓨터공학과 사물함 예약 시스템'),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        appBar: AppBar(),
        title: widget.title,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SideNav(),
            ),
            Expanded(
              flex: 4,
              child: ReservationMain(),
            ),
          ],
        ),
      ),
    );
  }
}
