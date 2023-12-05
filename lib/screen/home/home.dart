import 'package:flutter/material.dart';
import 'package:room_details_page/screen/home/widget/categories.dart';
import 'package:room_details_page/screen/home/widget/custom_app_bar.dart';
import 'package:room_details_page/screen/home/widget/recommended_house.dart';
import 'package:room_details_page/screen/home/widget/search_input.dart';
import 'package:room_details_page/screen/home/widget/welcome_text.dart';

class Home extends StatefulWidget {
  TextEditingController email;
  Home({this.email});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeText(),
            SearchInput(),
            Categories(),
            RecommendedHouse(),
          ],
        ),
      ),
    );
  }
}
