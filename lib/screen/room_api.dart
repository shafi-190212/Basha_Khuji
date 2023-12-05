import 'room_model.dart';
import 'package:http/http.dart' as http;
import '../login_signup/ipconfig.dart';

var add = new Ipconfig();
get ip => add.ip;

Future<List<RoomData>> fetchData() async {
  var url = Uri.parse('http://$ip/userdata/roomMergeOwner.php/');
  var response = await http.get(url);
  return roomDataFromJson(response.body);
}
