import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:locker_reservation_system/providers/sid_prv.dart';
import 'package:locker_reservation_system/network/network.dart';

class ReservationMain extends StatefulWidget {
  ReservationMain({super.key});

  @override
  State<ReservationMain> createState() => _ReservationMainState();
}

class _ReservationMainState extends State<ReservationMain> {

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("여기가 메인임"),);
  }
}