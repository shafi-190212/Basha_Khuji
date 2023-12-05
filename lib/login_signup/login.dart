import 'package:flutter/material.dart';
import 'package:room_details_page/owner_screens/dashboard.dart';
import '../owner_screens/ownerProfile.dart';
import 'beforeSignUp.dart';
import '../user_screens/HomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'user_data.dart';
import 'package:get/get.dart';
import '../main.dart';
import 'ipconfig.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var items = ["House Owner", "User"];
  bool success = false;
  var add = new Ipconfig();
  get ip => add.ip;
  Future login() async {
    print(ip);
    var url;
    if (_controller.text == "User") {
      url = Uri.parse('http://$ip/userdata/login.php');
      var response = await http.post(url, body: {
        "email": email.text,
        "password": password.text,
      });
      var data = json.decode(response.body);
      if (data == 'success') {
        success = true;
        print("Login Successful");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(email: email)));
      } else {
        print("Incorrect username or password");
      }
    } else {
      url = Uri.parse('http://$ip/userdata/login2.php');
      var response = await http.post(url, body: {
        "email": email.text,
        "password": password.text,
      });
      var data = json.decode(response.body);
      if (data == 'success') {
        success = true;
        print("Login Successful");
        Get.to(() => Dashboard(email: email));
      } else {
        print("Incorrect username or password");
      }
    }
    if (success == false) {
      var msg = _controller.text;
      Alert(
        context: context,
        type: AlertType.error,
        title: "Incorrect $msg Details",
        desc: "Please try again",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => {
              password.text = '',
              _controller.text = "",
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage())),
            },
            width: 100,
          )
        ],
      ).show();
    }
  }

  bool obscurePassword = true;
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/background.png"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Get.to(() => CoverPage());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Login to your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: <Widget>[
                            inputFile(label: "Email", controller: email),
                            inputFile(
                                label: "Password",
                                isPassword: true,
                                controller: password),
                            TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: "Select your Role",
                                labelText: "Login As",
                                suffixIcon: PopupMenuButton<String>(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onSelected: (String value) {
                                    _controller.text = value;
                                    print(_controller.text);
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
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.only(top: 0, left: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            onPressed: () {
                              login();
                            },
                            color: Color(0xff0095FF),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          // Text(
                          //   " Sign up",
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w600,
                          //     fontSize: 18,
                          //   ),
                          // )
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BeforeSignUp()));
                              //Get.to(UserData());
                            },
                            child: Text(
                              'Sign up', //title
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // we will be creating a widget for text field
  Widget inputFile({label, controller, bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: controller,
          obscureText: isPassword ? obscurePassword : false,
          decoration: InputDecoration(
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(Icons.remove_red_eye_rounded,
                          color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    )
                  : null,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              errorText: _validate ? 'Value can\'t be empty' : null,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]))),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
