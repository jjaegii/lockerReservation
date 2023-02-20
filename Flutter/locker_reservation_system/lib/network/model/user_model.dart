class UserModel {
  final String studentID;
  final String name;

  UserModel({required this.studentID, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      studentID: json['studentID'],
      name: json['name']
    );
  }
}
