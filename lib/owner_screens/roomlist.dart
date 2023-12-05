import 'package:flutter/material.dart';
import 'package:room_details_page/owner_screens/dashboard.dart';
import 'package:room_details_page/owner_screens/main_drawer.dart';
import 'ownerProfile.dart';
import 'room_model.dart';
import 'room_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'edit_house.dart';
import 'package:get/get.dart';

class RoomDetails extends StatefulWidget {
  TextEditingController email;
  RoomDetails({this.email});
  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  Future<List<RoomData>> getRoomData() async {
    var url = Uri.parse('http://$ip/userdata/customRoomApi.php/');
    final headers = {"Content-type": "application/json"};
    final json = {
      "email": widget.email.text
    };
    var response = await http.post(url, headers: headers, body: jsonEncode(json));
    return roomDataFromJson(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room List'),
        centerTitle: true,
      //   leading: IconButton(
      //   icon: Icon(
      //   Icons.arrow_back,
      //   color: Colors.white,
      //   ),
      //
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => Dashboard(email: widget.email,)));
      //     },
      // ),
      ),
      drawer: MainDrawer(email: widget.email,),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
          future: getRoomData(),
          builder: (context, snapshot) {
           if(snapshot.hasError) print(snapshot.error);
            int cnt =0;
            return (snapshot.hasData)?
              ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  RoomData api = snapshot.data[index];
                  RoomData del = snapshot.data[index];
                  cnt = cnt+1;
                  return Table(
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(6),
                      2: FlexColumnWidth(4),
                    },
                    border: TableBorder.all(width:1.3, color:Colors.black45), //table border
                    children: [
                      TableRow(
                          children: [
                            TableCell(child: Center(child: Text("\n\n$cnt",textAlign:TextAlign.center,),)),
                            TableCell(
                              child: Column(
                                children: <Widget>[
                                  Text("\nHouse Name: ${api.houseName}"),
                                  Text("Room no: ${api.roomNo}"),
                                  Text("Floor no: ${api.floorNo}"),
                                  Text("Room Type: ${api.roomType}"),
                                  Text("Price: ${api.price} taka\n"),
                                  //Text("About: ${api.description}"),
                                ],
                              ),
                            ),
                            TableCell(child:Column(
                              children: [
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RoundIconButton(
                                        icon: FontAwesomeIcons.solidEdit,
                                        onPressed: () {
                                          Navigator.push(context,MaterialPageRoute(builder:(context)=>EditHouse(data:api ,index: index,email: widget.email)));
                                        },
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RoundIconButton(
                                        icon: FontAwesomeIcons.solidTrashAlt,
                                        onPressed: () {
                                          Future<void> deleteRoom() async {
                                            final url = Uri.parse('http://$ip/userdata/deleteRoom.php');
                                            final headers = {"Content-type": "application/json"};
                                            final json = {
                                              "houseName": del.houseName,
                                              "roomNo": int.parse(del.roomNo),
                                            };
                                            final response =
                                            await http.post(url, headers: headers, body: jsonEncode(json));
                                            print(response.body);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => RoomDetails(email: widget.email,)));
                                          }
                                          setState(() {
                                            deleteRoom();
                                          });
                                        },
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),),
                          ]
                      ),
                    ],);
                },
              ):Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }

}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon,@required this.onPressed,this.color});
  final IconData icon;
  final Function onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon,color: Colors.black87,),
      elevation: 0.0,
      shape: CircleBorder(),
      fillColor:color,
      constraints:BoxConstraints.tightFor(
        width: 45.0,
        height: 45.0,
      ),
      onPressed: onPressed,
    );
  }
}


