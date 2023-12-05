import 'user_model.dart';
import 'package:http/http.dart' as http;
import 'ipconfig.dart';
import 'dart:convert';

var add = new Ipconfig();
get ip => add.ip;

Future fetchUser(String email) async {
  var url =
  Uri.parse('http://$ip/userdata/getUser.php/');
  final headers = {"Content-type": "application/json"};
  final json = {
    "email": email,
  };
  var response = await http.post(url, headers: headers, body: jsonEncode(json));
  final userData = userFromJson(response.body);
  print(userData[0].email);
  return userFromJson(response.body);
}
