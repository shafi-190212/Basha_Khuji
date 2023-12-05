import 'owner_model.dart';
import 'package:http/http.dart' as http;
import '../login_signup/ipconfig.dart';

var add = new Ipconfig();
get ip => add.ip;

Future<List<OwnerData>> getData() async {
  var url = Uri.parse('http://$ip/userdata/getOwner.php/');
  var response = await http.get(url);
  return ownerDataFromJson(response.body);
}
