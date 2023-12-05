import 'package:http/http.dart' as http;
import '../login_signup/ipconfig.dart';
import 'approved_room_model.dart';
import 'dart:convert';

var add = new Ipconfig();
get ip => add.ip;

Future<List<ApprovedRoomData>> fetchApprovedRoom(String email) async {
  var url = Uri.parse('http://$ip/userdata/approved_room_api.php/');
  final headers = {"Content-type": "application/json"};
  final json = {
    "email": email,
  };
  final response =
  await http.post(url, headers: headers, body: jsonEncode(json));
  return approvedroomDataFromJson(response.body);
}