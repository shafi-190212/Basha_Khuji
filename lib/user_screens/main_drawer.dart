import 'package:flutter/material.dart';
import '../user_screens/edit_profile.dart';
import '../login_signup/login.dart';
import 'settings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../login_signup/ipconfig.dart';
import 'dart:convert';
import 'user_model.dart';

class MainDrawer extends StatefulWidget {
  TextEditingController email;
  MainDrawer({this.email});
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  var add = new Ipconfig();
  get ip => add.ip;
  Future<List<UserData>> getData() async {
    var url = Uri.parse('http://$ip/userdata/getUser.php/');
    final headers = {"Content-type": "application/json"};
    final json = {
      "email": widget.email.text
    };
    var response = await http.post(url, headers: headers, body: jsonEncode(json));
    print(response.body);
    return userDataFromJson(response.body);
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        child: FutureBuilder(
            future: getData(),
            builder: (context,snapshot) {
              if(snapshot.hasError) print(snapshot.error);
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index){
                      UserData api = snapshot.data[index];
                      return Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            color: Theme.of(context).primaryColor,
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
                                    '${api.email}',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.account_circle_rounded),
                            title: Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditProfilePage(email: widget.email,user: api,)),
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
                              Get.to(()=>SettingsScreen());
                            },
                          ),
                          Divider(height: 0.01),
                          SizedBox(
                            height: 260,
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
                              //Navigator.of(context).pop();
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                          ),
                          Divider(height: 0.01),
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
