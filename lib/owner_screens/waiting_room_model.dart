import 'dart:convert';

List<WaitingRoomData> waitingroomDataFromJson(String str) =>
    List<WaitingRoomData>.from(
        json.decode(str).map((x) => WaitingRoomData.fromJson(x)));

String waitingroomDataToJson(List<WaitingRoomData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WaitingRoomData {
  WaitingRoomData({
    this.index,
    this.houseName,
    this.roomNo,
    this.floorNo,
    this.roomType,
    this.price,
    this.Name,
    this.StudentID,
    this.Email,
    this.ContactNo,
    this.ownerEmail,
  });

  String index;
  String houseName;
  String roomNo;
  String floorNo;
  String roomType;
  String price;
  String Name;
  String StudentID;
  String Email;
  String ContactNo;
  String ownerEmail;

  factory WaitingRoomData.fromJson(Map<String, dynamic> json) =>
      WaitingRoomData(
        index: json["index"],
        houseName: json["houseName"],
        roomNo: json["roomNo"],
        floorNo: json["floorNo"],
        roomType: json["roomType"],
        price: json["price"],
        Name: json["Name"],
        StudentID: json["StudentID"],
        Email: json["Email"],
        ContactNo: json["ContactNo"],
        ownerEmail: json["ownerEmail"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "houseName": houseName,
        "roomNo": roomNo,
        "floorNo": floorNo,
        "roomType": roomType,
        "price": price,
        "Name": Name,
        "StudentID": StudentID,
        "Email": Email,
        "ContactNo": ContactNo,
        "ownerEmail": ownerEmail,
      };
}
