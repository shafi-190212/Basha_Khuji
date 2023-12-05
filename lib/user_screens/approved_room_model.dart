import 'dart:convert';

List<ApprovedRoomData> approvedroomDataFromJson(String str) =>
    List<ApprovedRoomData>.from(
        json.decode(str).map((x) => ApprovedRoomData.fromJson(x)));

String approvedroomDataToJson(List<ApprovedRoomData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApprovedRoomData {
  ApprovedRoomData({
    this.index,
    this.houseName,
    this.roomNo,
    this.floorNo,
    this.userName,
    this.ownerName,
    this.StudentID,
    this.userEmail,
    this.ownerEmail,
    this.ContactNo,
    this.price,
  });

  String index;
  String houseName;
  String roomNo;
  String floorNo;
  String price;
  String userName;
  String ownerName;
  String StudentID;
  String userEmail;
  String ContactNo;
  String ownerEmail;

  factory ApprovedRoomData.fromJson(Map<String, dynamic> json) =>
      ApprovedRoomData(
        index: json["index"],
        houseName: json["houseName"],
        roomNo: json["roomNo"],
        floorNo: json["floorNo"],
        price: json["price"],
        userName: json["userName"],
        ownerName: json["ownerName"],
        StudentID: json["StudentID"],
        userEmail: json["userEmail"],
        ContactNo: json["ContactNo"],
        ownerEmail: json["ownerEmail"],
      );

  Map<String, dynamic> toJson() => {
    "index": index,
    "houseName": houseName,
    "roomNo": roomNo,
    "floorNo": floorNo,
    "price": price,
    "userName": userName,
    "ownerName": userName,
    "StudentID": StudentID,
    "userEmail": userEmail,
    "ownerEmail": ownerEmail,
    "ContactNo": ContactNo,
  };
}
