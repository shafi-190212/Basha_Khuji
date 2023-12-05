import 'package:http/http.dart' as http;
import '../login_signup/ipconfig.dart';
import 'waiting_room_model.dart';
import 'dart:convert';

var add = new Ipconfig();
get ip => add.ip;

Future<List<WaitingRoomData>> fetchData(String email) async {
  print(email);
  var url = Uri.parse('http://$ip/userdata/waiting_room_api.php/');
  final headers = {"Content-type": "application/json"};
  final json = {
    "email": email,
  };
  var response = await http.post(url, headers: headers, body: jsonEncode(json));
  return waitingroomDataFromJson(response.body);
}