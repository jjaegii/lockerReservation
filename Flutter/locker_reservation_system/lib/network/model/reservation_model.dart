import 'package:locker_reservation_system/network/network.dart';

class ReservationModel {
  final int rows;
  final int columns;
  final List<Lockers> lockers;

  ReservationModel({
    required this.rows,
    required this.columns,
    required this.lockers
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    var list = json['lockers'] as List;
    List<Lockers> lockerList = list.map((i) => Lockers.fromJson(i)).toList();
    
    return ReservationModel(
      rows: json['rows'],
      columns: json['columns'],
      lockers: lockerList
    );
  }
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

  factory Lockers.fromJson(Map<String, dynamic> json) {
    return Lockers(
      location: json['location'],
      row: json['row'],
      column: json['column']
    );
  }
}