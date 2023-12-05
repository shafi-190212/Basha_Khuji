import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:convert';
import '../login_signup/ipconfig.dart';
import 'waiting_room_approve.dart';
import 'waiting_room_model.dart';

class ViewWatingRoom extends StatefulWidget {
  WaitingRoomData data;
  int index;
  ViewWatingRoom({this.data, this.index});
  @override
  State<ViewWatingRoom> createState() => _EditHouseState();
}

class _EditHouseState extends State<ViewWatingRoom> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  TextEditingController houseName = TextEditingController();
  TextEditingController roomNo = TextEditingController();
  TextEditingController floorNo = TextEditingController();
  TextEditingController roomType = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController StudentID = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController ContactNo = TextEditingController();
  TextEditingController ownerEmail = TextEditingController();

  bool editMode = false;
  get onPressed => null;

  var add = new Ipconfig();
  get ip => add.ip;

  Future sendEmail() async{
    final smtpServer = gmail(ownerEmail.text, 'eryx@9516');
    final message = Message()
      ..from = Address(ownerEmail.text, Name.text)
      ..recipients = [Email.text]
      ..subject = 'Confirmation of Booking Request'
      ..text = 'Your Booking request for the room is approved. Your room details is:\n '
        'House Name: ${houseName.text}\n '
          'Room no: ${roomNo.text} \n '
          'Floor no: ${floorNo.text} \n'
          'Please pay the payment amount to confirm booking\n\n '
          'Booking Confirmed by: ${ownerEmail.text}';
    try{
      final sendReport = await send(message, smtpServer);
      print('Message sent: '+ sendReport.toString());
    }on MailerException catch(e){
        print('Message not sent');
        for (var p in e.problems){
          print('Problem: ${p.code}: ${p.msg}');
        }
    }
  }

  Future<void> addApprovedRoom() async {
    final url = Uri.parse('http://$ip/userdata/addApprovedRooms.php');
    final headers = {"Content-type": "application/json"};
    final json = {
      "houseName": houseName.text,
      "roomNo": roomNo.text,
      "floorNo": floorNo.text,
      "roomType": roomType.text,
      "price": price.text,
      "Name": Name.text,
      "StudentID": StudentID.text,
      "Email": Email.text,
      "ownerEmail": ownerEmail.text,
      "ContactNo": ContactNo.text,
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(json));
    Navigator.of(context).pop();
    print(response.body);
  }

  final _formKey = GlobalKey<FormState>();
  var icon;

  @override
  void initState() {
    if (widget.index != null) {
      editMode = true;
      houseName.text = widget.data.houseName;
      roomNo.text = widget.data.roomNo;
      floorNo.text = widget.data.floorNo;
      roomType.text = widget.data.roomType;
      price.text = widget.data.price;
      Name.text = widget.data.Name;
      StudentID.text = widget.data.StudentID;
      Email.text = widget.data.Email;
      ContactNo.text = widget.data.ContactNo;
      ownerEmail.text = widget.data.ownerEmail;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Full Application Form';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(appTitle),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },),
        ),
        // drawer: MainDrawer(),
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
                    "Picture of Applicant",
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
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://doy2mn9upadnk.cloudfront.net/uploads/default/original/4X/1/0/e/10e6c0a439e17280a6f3fa6ae059819af5517efd.png",
                            ))),
                  ),
                    ],
                  ),
                ),
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
                    icon: const Icon(Icons.room_preferences_rounded),
                    labelText: 'Room No',
                  ),
                ),
                TextFormField(
                  controller: floorNo,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.meeting_room_outlined),
                    labelText: 'Floor No',
                  ),
                  enabled: false,
                ),
                TextFormField(
                  controller: price,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.money_sharp),
                    labelText: 'Price',
                  ),
                  enabled: false,
                ),
                TextFormField(
                  cursorWidth: 10,
                  controller: Name,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    labelText: 'Applicant Name',
                  ),
                  enabled: false,
                ),
                TextFormField(
                  controller: StudentID,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.category_outlined),
                    labelText: 'Student ID',
                  ),
                  enabled: false,
                ),
                TextFormField(
                  controller: Email,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.email),
                    hintText: 'Email',
                    labelText: 'Email',
                  ),
                  enabled: false,
                ),
                TextFormField(
                  controller: ContactNo,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone),
                    hintText: 'ContactNo',
                    labelText: 'ContactNo',
                  ),
                  enabled: false,
                ),
                new Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                    child: new RaisedButton(
                      child: const Text('Approve'),
                      color: Colors.teal,
                      onPressed: () {
                        addApprovedRoom();
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
