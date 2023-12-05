import 'package:flutter/material.dart';
import 'package:room_details_page/screen/room_model.dart';
import '../../../login_signup/ipconfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestForm extends StatefulWidget {
  RoomData room;
  RequestForm({this.room});
  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Application Form for Booking';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(appTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        body: MyCustomForm(room: widget.room),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  RoomData room;
  MyCustomForm({this.room});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {

  final houseName = TextEditingController();
  final roomNo = TextEditingController();
  final floorNo = TextEditingController();
  final roomType = TextEditingController();
  final price = TextEditingController();
  final Name = TextEditingController();
  final StudentID = TextEditingController();
  final Email = TextEditingController();
  final ContactNo = TextEditingController();
  final ownerEmail = TextEditingController();

  @override
  void initState()
  {
    houseName.text = widget.room.houseName;
    roomNo.text = widget.room.roomNo;
    floorNo.text = widget.room.floorNo;
    roomType.text = widget.room.roomType;
    price.text = widget.room.price;
    ownerEmail.text = widget.room.email;
    super.initState();
  }


  var add = new Ipconfig();
  get ip => add.ip;

  get onPressed => null;

  Future<void> requestRoom() async {
    final url = Uri.parse('http://$ip/userdata/requestRoom.php');
    final headers = {"Content-type": "application/json"};
    final json = {
      "houseName": houseName.text,
      "roomNo": roomNo.text,
      "roomType": roomType.text,
      "floorNo": floorNo.text,
      "price": price.text,
      "Name": Name.text,
      "StudentID": StudentID.text,
      "Email": Email.text,
      "ContactNo": ContactNo.text,
      'ownerEmail': ownerEmail.text,
    };
    final response =
    await http.post(url, headers: headers, body: jsonEncode(json));
    print(response.body);
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
              height: 30,
            ),
            TextFormField(
              controller: houseName,
              enabled: false,
              decoration: const InputDecoration(
                icon: const Icon(Icons.house),
                labelText: 'House Name',
              ),

            ),
            TextFormField(
              controller: roomNo,
              enabled: false,
              decoration: const InputDecoration(
                icon: const Icon(Icons.room),
                labelText: 'Room No',
              ),
            ),
            TextFormField(
              controller: floorNo,
              enabled: false,
              decoration: const InputDecoration(
                icon: const Icon(Icons.location_city),
                labelText: 'Floor No',
              ),
            ),
            TextFormField(
              controller: price,
              enabled: false,
              decoration: const InputDecoration(
                icon: const Icon(Icons.money),
                labelText: 'Price',
              ),
            ),
            TextFormField(
              controller: ownerEmail,
              enabled: false,
              decoration: const InputDecoration(
                icon: const Icon(Icons.email),
                labelText: 'Owner Email',
              ),
            ),
            TextFormField(
              controller: Name,
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter Your name',
                labelText: 'Your Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Your Name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: StudentID,
              decoration: const InputDecoration(
                icon: const Icon(Icons.category),
                hintText: 'Enter Your StudentID',
                labelText: 'StudentID',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'StudentID';
                }
                return null;
              },
            ),
            TextFormField(
              controller: Email,
              decoration: const InputDecoration(
                icon: const Icon(Icons.email),
                hintText: 'Enter Your Email',
                labelText: 'Your Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Your Email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: ContactNo,
              decoration: const InputDecoration(
                icon: const Icon(Icons.phone),
                hintText: 'Enter Your ContactNo',
                labelText: 'Your ContactNo',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Your ContactNo';
                }
                return null;
              },
            ),
            new Container(
                padding: const EdgeInsets.only(left: 100.0, top: 40.0),
                child: new RaisedButton(
                  color:Colors.teal,
                  child: const Text('Request For Room Allocation'),
                  onPressed: () {
                    requestRoom();
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
