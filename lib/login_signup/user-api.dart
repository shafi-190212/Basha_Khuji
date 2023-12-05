import 'user_model.dart';
import 'package:http/http.dart' as http;
import 'ipconfig.dart';

var add = new Ipconfig();
get ip => add.ip;

Future<List<User>> fetchData() async {
  var url =
      Uri.parse('http://$ip/userdata/user-api.php/');
  var response = await http.get(url);
  print(response.body);
  return userFromJson(response.body);
}
