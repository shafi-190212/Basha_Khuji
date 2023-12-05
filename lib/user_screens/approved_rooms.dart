import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'approved_room_api.dart';
import 'approved_room_model.dart';
import '../screen/detail/widget/payment.dart';

class ApprovedRoomDetails extends StatefulWidget {
  TextEditingController email;
  ApprovedRoomDetails({this.email});
  @override
  State<ApprovedRoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<ApprovedRoomDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('Waiting Room List'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
          future: fetchApprovedRoom(widget.email.text),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            int cnt = 0;
            return (snapshot.hasData)
                ? ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                ApprovedRoomData api = snapshot.data[index];
                ApprovedRoomData del = snapshot.data[index];
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
                            Text("Confirmed by: ${api.ownerName}"),
                            Text("Contact no: ${api.ContactNo}\n"),

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
                                      left: 1.0, top: 15.0),
                                  child: new RaisedButton(
                                    //     icon : FontAwesomeIcons.
                                    child: const Text('  Make  \nPayment'),
                                    color:Colors.teal,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Payment(email: widget.email,price: api.price,)),
                                      );
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
