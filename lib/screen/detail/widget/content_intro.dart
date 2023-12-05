import 'package:flutter/material.dart';
import '../../room_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentIntro extends StatefulWidget {
  RoomData room;
  ContentIntro({@required this.room});
  @override
  State<ContentIntro> createState() => _ContentIntroState();
}

class _ContentIntroState extends State<ContentIntro> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${widget.room.houseName}(${widget.room.roomNo})",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '${widget.room.price} Taka',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: ' per Month',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 14),
                  )
                ]),
              )
            ],
          ),
          SizedBox(width: 30,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Owner: ${widget.room.owner_name}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  IconButton(
                    icon: const Icon(Icons.phone,size: 30,),
                    tooltip: 'make a call',
                    onPressed: () {
                      launch('tel:${widget.room.phone}');
                    },
                  ),
                  SizedBox(width: 20,),
                  IconButton(
                    icon: const Icon(Icons.message,size: 30,),
                    tooltip: 'Send a sms',
                    onPressed: () {
                      launch('sms:${widget.room.phone}');
                    },
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
