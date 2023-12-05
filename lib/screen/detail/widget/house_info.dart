import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../room_model.dart';

class HouseInfo extends StatefulWidget {
  RoomData room;
  HouseInfo({this.room});
  @override
  State<HouseInfo> createState() => _HouseInfoState();
}

class _HouseInfoState extends State<HouseInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              MenuInfo(
                  imageUrl: 'assets/icons/bedroom.svg',
                  content: 'Floor no.\n    ${widget.room.floorNo}'),
              MenuInfo(
                  imageUrl: 'assets/icons/bedroom.svg',
                  content: 'Room no.\n ${widget.room.roomNo}'),
              MenuInfo(
                  imageUrl: 'assets/icons/bedroom.svg',
                  content: 'Room Type.\n ${widget.room.roomType}'),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              MenuInfo(
                  imageUrl: 'assets/icons/contact.svg',
                  content: 'Contact No\n${widget.room.phone}'),
              MenuInfo(
                  imageUrl: 'assets/icons/contact.svg',
                  content: 'E-mail of House Owner\n${widget.room.email}'),
            ],
          )
        ],
      ),
    );
  }
}

class MenuInfo extends StatefulWidget {
  final String imageUrl;
  final String content;
  const MenuInfo({@required this.imageUrl, @required this.content});

  @override
  State<MenuInfo> createState() => _MenuInfoState();
}

class _MenuInfoState extends State<MenuInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Row(
          children: [
            SvgPicture.asset(widget.imageUrl),
            SizedBox(width: 20),
            Text(
              widget.content,
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
