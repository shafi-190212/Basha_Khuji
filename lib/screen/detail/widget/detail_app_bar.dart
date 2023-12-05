import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../room_model.dart';
import '../../../login_signup/ipconfig.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailAppBar extends StatefulWidget {
  RoomData room;
  DetailAppBar({@required this.room});

  @override
  State<DetailAppBar> createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {

  var add = new Ipconfig();
  get ip => add.ip;

  Future<void> addRoom() async {
    final url = Uri.parse('http://$ip/userdata/addWishlist.php/');
    final headers = {"Content-type": "application/json"};
    final json = {
      "houseName": widget.room.houseName,
      "roomNo": int.parse(widget.room.roomNo),
      "floorNo": int.parse(widget.room.floorNo),
      "roomType": widget.room.roomType,
      "address": widget.room.address,
      "genderPref": widget.room.genderPref,
      "email": widget.room.email,
      "price": int.parse(widget.room.price),
      "description": widget.room.description,
      "imageUrl": widget.room.imageUrl
    };
    final response =
    await http.post(url, headers: headers, body: jsonEncode(json));
    print(response.body);
    print("Add to WishList successfully");
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(
        children: [
          Image.network(
            widget.room.imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 35,
                    width: 70,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                    child: SvgPicture.asset('assets/icons/arrow.svg'),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    addRoom();
                  },
                  child: Container(
                    height: 38,
                    width: 60,
                    //color: Colors.transparent,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        //color: Theme.of(context).colorScheme.secondary,
                        color: Colors.white,
                        shape: BoxShape.circle),
                    child: SvgPicture.asset(
                        'assets/icons/love-heart-svgrepo-com.svg'),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
