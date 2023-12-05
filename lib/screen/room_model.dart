// To parse this JSON data, do
//
//     final roomData = roomDataFromJson(jsonString);

import 'dart:convert';

List<RoomData> roomDataFromJson(String str) => List<RoomData>.from(json.decode(str).map((x) => RoomData.fromJson(x)));

String roomDataToJson(List<RoomData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomData {
  RoomData({
    this.owner_name,
    this.email,
    this.phone,
    this.houseName,
    this.roomNo,
    this.floorNo,
    this.roomType,
    this.address,
    this.genderPref,
    this.price,
    this.description,
    this.imageUrl,
    this.status,
  });

  String owner_name;
  String email;
  String phone;
  String houseName;
  String roomNo;
  String floorNo;
  String roomType;
  String address;
  String genderPref;
  String price;
  String description;
  String imageUrl;
  String status;

  factory RoomData.fromJson(Map<String, dynamic> json) => RoomData(
    owner_name: json["owner_name"],
    email: json["email"],
    phone: json["phone"],
    houseName: json["houseName"],
    roomNo: json["roomNo"],
    floorNo: json["floorNo"],
    roomType: json["roomType"],
    address: json["address"],
    genderPref: json["genderPref"],
    price: json["price"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "owner_name": owner_name,
    "email": email,
    "phone": phone,
    "houseName": houseName,
    "roomNo": roomNo,
    "floorNo": floorNo,
    "roomType": roomType,
    "address": address,
    "genderPref": genderPref,
    "price": price,
    "description": description,
    "imageUrl": imageUrl,
    "status": status,
  };
}
