import 'package:flutter/material.dart';
import '../user_screens/settings.dart';
import 'package:room_details_page/owner_screens/house_form.dart';
import 'package:room_details_page/owner_screens/main_drawer.dart';
import 'package:room_details_page/owner_screens/ownerProfile.dart';
import 'package:room_details_page/owner_screens/roomlist.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  TextEditingController email;
  Dashboard({this.email});
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.teal[100],
      drawer: MainDrawer(email: widget.email,),
      body:Container(
        padding: EdgeInsets.all(10.0),
        child: GridView.count(
            crossAxisCount: 2,
          children: <Widget>[
            MyMenu(title: "Total Rooms",icon:Icons.house_outlined,color: Colors.green,onTap: (){
              Get.to(()=>RoomDetails(email: widget.email,));
            },),
            MyMenu(title: "Vacant Rooms",icon:Icons.room_preferences_sharp,color: Colors.teal,onTap: () {
            }
            ),
            MyMenu(title: "Booked Rooms",icon:Icons.meeting_room_sharp,color: Colors.red,onTap: () {
            }),
            MyMenu(title: "Add Room",icon:Icons.add_to_queue_sharp,color: Colors.brown,onTap: () {
              Get.to(() => HouseForm(email: widget.email,));
            }),
            MyMenu(title: "Profile",icon:Icons.person_outline_sharp,color: Colors.grey,onTap: () {
              Get.to(() => OwnerProfile(email: widget.email,));
            }),
            MyMenu(title: "Settings",icon:Icons.settings_applications_sharp,color: Colors.blueGrey,onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    SettingsScreen()),
              );
            }),
          ],
        ),
      ) ,
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title,this.icon,this.color,this.onTap});
  final String title;
  final IconData icon;
  final MaterialColor color;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent[100],
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: (){
          onTap();
        },
        splashColor: Colors.green,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon,size: 70.0,color: color,),
              Text(title,style: TextStyle(fontSize: 17.0,color: Colors.black87),)
            ],
          ),
        ),
      ),
    );
  }
}

