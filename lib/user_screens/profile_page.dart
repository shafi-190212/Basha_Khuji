import 'package:flutter/material.dart';
import '../login_signup/login.dart';
import 'main_drawer.dart';
import 'user_model.dart';
import 'dart:convert';
import '../login_signup/ipconfig.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  TextEditingController email;
  ProfilePage({this.email});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.9,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                AssetImage("images/background.png"), // <-- BACKGROUND IMAGE
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black54,
                      size: 31,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                    MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              title: Text('Profile Page',
                  style: TextStyle(fontSize: 25, color: Colors.black54)),
            ),
            body: FutureBuilder(
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
                            children: [
                              Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                          height: 160,
                          width: 120,
                          decoration: BoxDecoration(
                          //borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            "https://doy2mn9upadnk.cloudfront.net/uploads/default/original/4X/1/0/e/10e6c0a439e17280a6f3fa6ae059819af5517efd.png",),
                          )
                          // color: Colors.orange[100],
                          ),
                          ),
                          ),
                          ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80, //80% of width,
                            child: Center(
                              child: Text(
                                "${api.name}",
                                style: TextStyle(
                                    color: Colors.teal.shade900,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                              SizedBox(
                                height: 5,
                              ),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical:5,horizontal: 5),
                            child: ListTile(
                              leading:
                              Icon(Icons.category,size: 25,color: Colors.teal,),
                              title:Text(
                                'Discipline: ${api.disciplineName}',
                                style: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                            child: ListTile(
                              leading:
                              Icon(Icons.perm_identity_outlined,size: 25,color: Colors.teal,),
                              title:Text(
                                'Student Id: ${api.studentId}',
                                style: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                            child: ListTile(
                              leading:Icon(Icons.email,size: 25,color: Colors.teal,),
                              title:Text(
                                '${api.email}',
                                style: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                            child: ListTile(
                              leading:
                              Icon(Icons.phone,size: 25,color: Colors.teal,),
                              title:Text(
                                '${api.phone}',
                                style: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Container(
                                width:200,
                                color: Colors.blueAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Logout",
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                            ]);
                        }
                    );
                  }
                  else
                    return Center(child: CircularProgressIndicator(),);
                }
            ),
            drawer: MainDrawer(email: widget.email,),
          ),
        ],
      ),
    );
  }
}



