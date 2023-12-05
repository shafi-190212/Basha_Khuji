// To parse this JSON data, do
//
//     final ownerData = ownerDataFromJson(jsonString);

import 'dart:convert';

List<OwnerData> ownerDataFromJson(String str) => List<OwnerData>.from(json.decode(str).map((x) => OwnerData.fromJson(x)));

String ownerDataToJson(List<OwnerData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OwnerData {
  OwnerData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.address,
    this.nationalId,
    this.gender,
  });

  String id;
  String name;
  String email;
  String phone;
  String password;
  String address;
  String nationalId;
  String gender;

  factory OwnerData.fromJson(Map<String, dynamic> json) => OwnerData(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    address: json["address"],
    nationalId: json["national_id"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "password": password,
    "address": address,
    "national_id": nationalId,
    "gender": gender,
  };
}
