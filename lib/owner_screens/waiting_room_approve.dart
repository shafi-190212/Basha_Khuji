import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'view_waiting_room.dart';
import 'waiting_room_api.dart';
import 'waiting_room_model.dart';

class WaitingRoomDetails extends StatefulWidget {
  TextEditingController email;
  WaitingRoomDetails({this.email});
  @override
  State<WaitingRoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<WaitingRoomDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waiting Room List'),
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white),
          onPressed: (){
            Navigator.pop(context);
          },),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
          future: fetchData(widget.email.text),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            int cnt = 0;
            return (snapshot.hasData)
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      WaitingRoomData api = snapshot.data[index];
                      WaitingRoomData del = snapshot.data[index];
                      cnt = cnt + 1;
                      return Table(
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(6),
                          2: FlexColumnWidth(4),
                        },
                        border: TableBorder.all(
                            width: 1.3, color: Colors.black45), //table border
                        children: [
                          TableRow(children: [
                            TableCell(
                                child: Center(
                              child: Text(
                                "\n\n$cnt",
                                textAlign: TextAlign.center,
                              ),
                            )),
                            TableCell(
                              child: Column(
                                children: <Widget>[
                                  Text("\nHouse Name: ${api.houseName}"),
                                  Text("Room no: ${api.roomNo}"),
                                  Text("Floor no: ${api.floorNo}"),
                                  Text("Name: ${api.Name}"),
                                  Text("StudentID: ${api.StudentID}"),
                                  Text("Email: ${api.Email}"),
                                  Text("ContactNo: ${api.ContactNo}"),
                                ],
                              ),
                            ),
                            TableCell(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 24.0),
                                        child: new RaisedButton(
                                          //     icon : FontAwesomeIcons.
                                          child: const Text('View'),
                                          color:
                                              Color.fromARGB(255, 10, 157, 241),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewWatingRoom(
                                                          data: api,
                                                          index: index,
                                                        )));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 24.0),
                                        child: new RaisedButton(
                                          //     icon : FontAwesomeIcons.
                                          child: const Text('Reject'),
                                          color:
                                              Color.fromARGB(255, 194, 79, 33),
                                          onPressed: () {
                                            Future<void>
                                                deleteWaitingRoom() async {
                                              final url = Uri.parse(
                                                  'http://$ip/userdata/deleteWaitingRooms.php');
                                              final headers = {
                                                "Content-type":
                                                    "application/json"
                                              };
                                              final json = {
                                                "houseName": del.houseName,
                                                "roomNo": int.parse(del.roomNo),
                                              };
                                              final response = await http.post(
                                                  url,
                                                  headers: headers,
                                                  body: jsonEncode(json));
                                            }
                                            setState(() {
                                              deleteWaitingRoom();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed, this.color});
  final IconData icon;
  final Function onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        color: Colors.black87,
      ),
      elevation: 0.0,
      shape: CircleBorder(),
      fillColor: color,
      constraints: BoxConstraints.tightFor(
        width: 40.0,
        height: 45.0,
      ),
      onPressed: onPressed,
    );
  }
}
