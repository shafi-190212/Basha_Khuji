import 'package:flutter/material.dart';
import '../../room_model.dart';
class About extends StatefulWidget {
  RoomData room;
  About({this.room});
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.room.address,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
          ),
          SizedBox(height: 10,),
          Text(
            'About',
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.room.description,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
