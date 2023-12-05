// To parse this JSON data, do
//
//     final roomData = roomDataFromJson(jsonString);

import 'dart:convert';

List<RoomData> roomDataFromJson(String str) => List<RoomData>.from(json.decode(str).map((x) => RoomData.fromJson(x)));

String roomDataToJson(List<RoomData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomData {
  RoomData({
    this.houseName,
    this.roomNo,
    this.floorNo,
    this.roomType,
    this.address,
    this.email,
    this.genderPref,
    this.price,
    this.description,
    this.imageUrl,
    this.status
  });

  String houseName;
  String roomNo;
  String floorNo;
  String roomType;
  String address;
  String email;
  String genderPref;
  String price;
  String description;
  String imageUrl;
  String status;

  factory RoomData.fromJson(Map<String, dynamic> json) => RoomData(
    houseName: json["houseName"],
    roomNo: json["roomNo"],
    floorNo: json["floorNo"],
    roomType: json["roomType"],
    address: json["address"],
    email: json["email"],
    genderPref: json["genderPref"],
    price: json["price"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    status: json["status"]
  );

  Map<String, dynamic> toJson() => {
    "houseName": houseName,
    "roomNo": roomNo,
    "floorNo": floorNo,
    "roomType": roomType,
    "address": address,
    "email": email,
    "genderPref": genderPref,
    "price": price,
    "description": description,
    "imageUrl": imageUrl,
    "status": status,
  };
}
