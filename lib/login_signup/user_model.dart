
import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
