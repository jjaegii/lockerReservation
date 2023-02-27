import 'dart:html';

import 'package:locker_reservation_system/network/network.dart';

class ReservationModel {
  final int rows;
  final int columns;
  Locker? myLocker;
  final List<Locker> lockers;

  ReservationModel(
      {required this.rows,
      required this.columns,
      required this.myLocker,
      required this.lockers});

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    var list = json['lockers'] as List;
    List<Locker> lockerList = list.map((i) => Locker.fromJson(i)).toList();
    Locker myLocker = Locker.fromJson(json['myLocker']);
    return ReservationModel(
        rows: json['rows'],
        columns: json['columns'],
        myLocker: myLocker,
        lockers: lockerList);
  }
}

class Locker {
  final String location;
  final int row;
  final int column;

  Locker({required this.location, required this.row, required this.column});

  factory Locker.fromJson(Map<String, dynamic> json) {
    return Locker(
        location: json['location'], row: json['row'], column: json['column']);
  }
}
