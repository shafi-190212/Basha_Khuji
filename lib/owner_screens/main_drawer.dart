import 'package:flutter/material.dart';
import 'package:room_details_page/owner_screens/dashboard.dart';
import 'package:room_details_page/owner_screens/details_screen.dart';
import 'package:room_details_page/owner_screens/ownerProfile.dart';
import '../owner_screens/house_form.dart';
import '../login_signup/login.dart';
import 'roomlist.dart';
import 'house_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'owner_profile.dart';
import 'owner_model.dart';
import 'package:http/http.dart' as http;
import '../login_signup/ipconfig.dart';
import '../user_screens/settings.dart';
import 'dart:convert';
import 'waiting_room_approve.dart';

class MainDrawer extends StatefulWidget {
  TextEditingController email;
  MainDrawer({this.email});
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var add = new Ipconfig();
  get ip => add.ip;
  Future<List<OwnerData>> getData() async {
    var url = Uri.parse('http://$ip/userdata/getOwner.php/');
    final headers = {"Content-type": "application/json"};
    final json = {
      "email": widget.email.text
    };
    var response = await http.post(url, headers: headers, body: jsonEncode(json));
    return ownerDataFromJson(response.body);
  }

  @override
  void initState(){
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        //backgroundColor: Colors.teal[100],
        child: FutureBuilder(
          future: getData(),
          builder: (context,snapshot) {
            if(snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index){
                  OwnerData api = snapshot.data[index];
                  return Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom:30,top: 20),
                        color: Colors.teal,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://doy2mn9upadnk.cloudfront.net/uploads/default/original/4X/1/0/e/10e6c0a439e17280a6f3fa6ae059819af5517efd.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                '${api.name}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                widget.email.text,
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.dashboard),
                        title: Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Get.to(() => Dashboard(email: widget.email));
                        },
                      ),
                      Divider(height: 0.01),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Get.to(() => OwnerProfile(owner: api,email: widget.email));
                        },
                      ),
                      Divider(height: 0.01),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.circlePlus),
                        title: Text(
                          'Add Room',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HouseForm(email: widget.email)),
                          );
                        },
                      ),
                      Divider(height: 0.01),
                      ListTile(
                        leading: Icon(Icons.home_outlined),
                        title: Text(
                          'Room List',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RoomDetails(email: widget.email)),
                          );
                        },
                      ),
                      Divider(height: 0.01),
                      ListTile(
                        leading: Icon(Icons.home_outlined),
                        title: Text(
                          'Waiting for Approval',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WaitingRoomDetails(email: widget.email)),
                          );
                        },
                      ),
                      Divider(height: 0.01),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                SettingsScreen()),
                          );
                        },
                      ),
                      Divider(height: 0.01),
                      ListTile(
                        leading: Icon(Icons.logout_outlined),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              );
            }
            else
              return Center(child: CircularProgressIndicator(),);
          }
        ),
      ),
    );
  }
}
