// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

List<UserData> userDataFromJson(String str) => List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
  UserData({
    this.studentId,
    this.name,
    this.password,
    this.email,
    this.gender,
    this.disciplineName,
    this.phone,
  });

  String studentId;
  String name;
  String password;
  String email;
  String gender;
  String disciplineName;
  String phone;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    studentId: json["student_id"],
    name: json["name"],
    password: json["password"],
    email: json["email"],
    gender: json["gender"],
    disciplineName: json["discipline_name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "name": name,
    "password": password,
    "email": email,
    "gender": gender,
    "discipline_name": disciplineName,
    "phone": phone,
  };
}
