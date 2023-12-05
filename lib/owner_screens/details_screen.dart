import 'package:flutter/material.dart';
import 'main_drawer.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/detais_screen';
  TextEditingController email;
  DetailsScreen({this.email});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      drawer: MainDrawer(email: widget.email),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('We are in the Details Page now.',style:TextStyle(fontSize: 22),),
            FloatingActionButton(child: Icon(Icons.arrow_back),onPressed: (){
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  }
}
