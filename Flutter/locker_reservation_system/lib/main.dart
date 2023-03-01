import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:locker_reservation_system/network/network.dart';
import 'package:locker_reservation_system/reservation/reservationMain.dart';
import 'package:locker_reservation_system/router.dart';
import 'package:provider/provider.dart';
import 'package:locker_reservation_system/providers/sid_prv.dart';
import 'package:locker_reservation_system/providers/reservation_prv.dart';
import 'package:locker_reservation_system/navbar.dart';
import 'package:locker_reservation_system/reservation/sideNav.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  MyRouter.setupRouters();
  String serverUrl = dotenv.env['SERVER_URL'] ?? "http://localhost:8000";
  NetworkMananger.logoutReq("$serverUrl/logout");
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
        title: 'Locker Reservation Service',
        onGenerateRoute: MyRouter.router.generator,
        initialRoute: '/',
        home: MainPage(title: '사물함 예약 시스템'),
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
  // @override
  // void initState() {
  //   String serverUrl = dotenv.env['SERVER_URL'] ?? "http://localhost:8000";
  //   NetworkMananger().logoutReq("$serverUrl/logout");
  //   super.initState();
  // }

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
