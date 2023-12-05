import 'package:flutter/material.dart';
import './main_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../login_signup/ipconfig.dart';

class HouseForm extends StatefulWidget {
  TextEditingController email;
  HouseForm({this.email});
  @override
  State<HouseForm> createState() => _HouseFormState();
}

class _HouseFormState extends State<HouseForm> {
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
        body: MyCustomForm(email: widget.email),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  TextEditingController email;
  MyCustomForm({this.email});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
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


  var add = new Ipconfig();
  get ip => add.ip;

  Future<void> addRoom() async {
    final url = Uri.parse('http://$ip/userdata/addRoom.php');
    final headers = {"Content-type": "application/json"};
    final json = {
      "houseName": houseName.text,
      "roomNo": int.parse(roomNo.text),
      "floorNo": int.parse(floorNo.text),
      "roomType": roomType.text,
      "address": address.text,
      "genderPref": genderPref.text,
      "email": widget.email.text,
      "price": int.parse(price.text),
      "description": description.text,
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(json));
  }


  final _formKey = GlobalKey<FormState>();
  var icon;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
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
                      //image: DecorationImage(
                      //  fit: BoxFit.cover,
                      // image: NetworkImage())
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
            new Container(
                padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                child: new ElevatedButton(
                  child: const Text('Post'),
                  onPressed: () {
                    addRoom();
                    // It returns true if the form is valid, otherwise returns false
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Data is in processing.')));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
