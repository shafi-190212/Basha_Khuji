import 'package:flutter/material.dart';
import 'package:room_details_page/screen/detail/widget/about.dart';
import 'package:room_details_page/screen/detail/widget/content_intro.dart';
import 'package:room_details_page/screen/detail/widget/detail_app_bar.dart';
import 'package:room_details_page/screen/detail/widget/house_info.dart';
import '../room_model.dart';
import 'widget/requestRoom.dart';

class DetailPage extends StatefulWidget {
  RoomData room;
  TextEditingController email;
  DetailPage({this.room,this.email});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailAppBar(room: widget.room),
        SizedBox(height: 20),
        ContentIntro(room: widget.room),
        SizedBox(height: 20),
        HouseInfo(room: widget.room),
        SizedBox(height: 20),
        About(room: widget.room),
        SizedBox(height: 25),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (builder) => Payment(price: widget.room.price,email:widget.email)));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => RequestForm(room: widget.room)));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  primary: Theme.of(context).primaryColorDark,
                ),
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Request for Booking',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)))))
      ],
    )));
  }
}
