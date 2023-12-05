import 'package:flutter/material.dart';
import '../owner_screens/room_model.dart';
import './main_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../login_signup/ipconfig.dart';
import 'roomlist.dart';

class EditHouse extends StatefulWidget {
  RoomData data;
  int index;
  TextEditingController email;
  EditHouse({this.data,this.index,this.email});
  @override
  State<EditHouse> createState() => _EditHouseState();
}

class _EditHouseState extends State<EditHouse> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  TextEditingController houseName = TextEditingController();
  TextEditingController roomNo = TextEditingController();
  TextEditingController floorNo = TextEditingController();
  TextEditingController roomType = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController genderPref = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController imageUrl = TextEditingController();

  bool editMode = false;
  var items = ["booked", "vacant"];

  var add = new Ipconfig();
  get ip => add.ip;

  Future<void> editRoom() async {
    final url = Uri.parse('http://$ip/userdata/editRoom.php');
    final headers = {"Content-type": "application/json"};
    final json = {
      "houseName": houseName.text,
      "roomNo": int.parse(roomNo.text),
      "floorNo": int.parse(floorNo.text),
      "roomType": roomType.text,
      "address": address.text,
      "genderPref": genderPref.text,
      "price": int.parse(price.text),
      "description": description.text,
      "status": status.text,
      "imageUrl": imageUrl.text
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(json));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RoomDetails(email: widget.email,)));
  }
  final _formKey = GlobalKey<FormState>();
  var icon;

  @override
  void initState()
  {
    if(widget.index!=null){
      editMode = true ;
      houseName.text = widget.data.houseName;
      roomNo.text = widget.data.roomNo;
      floorNo.text = widget.data.floorNo;
      roomType.text = widget.data.roomType;
      address.text = widget.data.address;
      genderPref.text = widget.data.genderPref;
      price.text = widget.data.price;
      description.text = widget.data.description;
      status.text = widget.data.status;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'House Form';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        drawer: MainDrawer(email: widget.email,),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Picture of room",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 280,
                        height: 190,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Color.fromARGB(255, 202, 15, 15)
                                    .withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                           fit: BoxFit.cover,
                          image: NetworkImage(widget.data.imageUrl)),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.green,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: houseName,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.house),
                    hintText: 'Enter House name',
                    labelText: 'House Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter House name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: roomNo,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.room),
                    hintText: 'Enter Room',
                    labelText: 'Room No',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Room No';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: floorNo,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.room),
                    hintText: 'Enter Floor No',
                    labelText: 'Floor No',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Floor No';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: roomType,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.category_outlined),
                    hintText: 'Enter Room Type',
                    labelText: 'Room type',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Room type';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: address,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.location_city),
                    hintText: 'Enter Address',
                    labelText: 'Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.description),
                    hintText: 'Enter Description',
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: genderPref,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.male),
                    hintText: 'Enter Gender Preferences',
                    labelText: 'Gender Preferences',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Gender Preferences';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: price,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.money_outlined),
                    hintText: 'Enter Price',
                    labelText: 'Rent per month',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter room rent per month';
                    }
                    return null;
                  },
                ),
                TextField(
                  controller: status,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.app_registration),
                    labelText: " Status ",
                    suffixIcon: PopupMenuButton<String>(
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (String value) {
                        status.text = value;
                        print(status.text);
                      },
                      itemBuilder: (BuildContext context) {
                        return items.map<PopupMenuItem<String>>(
                                (String value) {
                              return new PopupMenuItem(
                                  child: new Text(value), value: value);
                            }).toList();
                      },
                    ),
                  ),
                ),
                new Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                    child: new ElevatedButton(
                      child: const Text('Update'),
                      onPressed: () {
                          setState(() {
                            editRoom();
                          });
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
