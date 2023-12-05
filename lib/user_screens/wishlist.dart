import 'package:flutter/material.dart';
import '../screen/room_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'room_api.dart';
import '../screen/detail/detail.dart';

class WishList extends StatefulWidget {
  TextEditingController email;
  WishList({this.email});
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  Future<List<RoomData>> getRoomData() async {
    var url = Uri.parse('http://$ip/userdata/wishlists.php/');
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
        title: Text('WishList'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => DetailPage(email: widget.email,room:api)),
                                        );
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
                                          final url = Uri.parse('http://$ip/userdata/delWishlist.php');
                                          final headers = {"Content-type": "application/json"};
                                          final json = {
                                            "houseName": del.houseName,
                                            "roomNo": int.parse(del.roomNo),
                                          };
                                          final response =
                                          await http.post(url, headers: headers, body: jsonEncode(json));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => WishList(email: widget.email,)));
                                          print(response.body);
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


