import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'dart:convert';

class OwnerSignUpPage extends StatefulWidget {
  @override
  State<OwnerSignUpPage> createState() => _OwnerSignUpPageState();
}

bool _validate = false;

class _OwnerSignUpPageState extends State<OwnerSignUpPage> {
  var items = ["Male", "Female"];
  TextEditingController _controller = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController nid = TextEditingController();
  Future register() async {
    var url = Uri.parse('https://shafi12.xyz/userdata/ownerSignup.php');
    final headers = {"Content-type": "application/json"};
    var response = await http.post(url,headers: headers, body: jsonEncode({
      "name": name.text,
      "email": email.text,
      "phone": phone.text,
      "password": password.text,
      "address": address.text,
      "national_id": nid.text,
      "gender": _controller.text,
    }));
    var data = json.decode(response.body);
    print(data);
  }

  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
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
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            reverse: true,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: MediaQuery.of(context).size.height - 40,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Sign up as House Owner",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Create an account, It's free ",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            inputFile(label: "Name", controller: name),
                            inputFile(label: "Email", controller: email),
                            inputFile(label: "Phone", controller: phone),
                            inputFile(
                                label: "Password",
                                controller: password,
                                isPassword: true),
                            inputFile(
                                label: "Address", controller: address),
                            inputFile(label: "National id", controller: nid),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: "Select your gender",
                                labelText: "Gender",
                                suffixIcon: PopupMenuButton<String>(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onSelected: (String value) {
                                    _controller.text = value;
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
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 0, left: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 40,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Request submitted')),
                              );
                            }
                            register();
                          },
                          color: Color(0xff0095FF),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already have an account?"),
                          // Text(
                          //   " Login",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w600, fontSize: 18),
                          // )
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              'Login', //title
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ].reversed.toList(),
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
