import 'package:locker_reservation_system/network/network.dart';

class ReservationModel {
  final int rows;
  final int columns;
  final Lockers lockers;

  ReservationModel({
    required this.rows,
    required this.columns,
    required this.lockers
  });
}

class Lockers {
  final String location;
  final int row;
  final int column;

  Lockers({
    required this.location,
    required this.row,
    required this.column
  });
}