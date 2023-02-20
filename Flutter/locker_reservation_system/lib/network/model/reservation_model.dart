import 'dart:ffi';

class ReservationModel {
  final String studentID;
  final Char location;
  final int row;
  final int column;

  ReservationModel({required this.studentID, required this.location, required this.row, required this.column});

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      studentID: json['studentID'],
      location: json['location'],
      row: json['row'],
      column: json['column'],
    );
  }
}
