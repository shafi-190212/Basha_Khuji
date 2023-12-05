import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import '../user_screens/approved_rooms.dart';
import 'profile_page.dart';
import '../screen/home/home.dart';
import 'wishlist.dart';
import '../login_signup/getUser.dart';

class HomePage extends StatefulWidget {
  TextEditingController email;
  HomePage({this.email});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final _pageController = PageController();

  TextStyle customStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: Colors.blueGrey,
  );

  @override
  Widget build(BuildContext context) {
    //final user = fetchUser(widget.email.text);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Home(email: widget.email,),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage("images/background.png"), // <-- BACKGROUND IMAGE
                fit: BoxFit.cover,
              ),
            ),
            child: WishList(email: widget.email,),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image:
          //           AssetImage("images/background.png"), // <-- BACKGROUND IMAGE
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          //   child: Center(
          //     child: Text(
          //       'Inbox',
          //       style: customStyle,
          //     ),
          //   ),
          // ),
          ApprovedRoomDetails(email: widget.email,),
          ProfilePage(email: widget.email,),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  BottomBar buildBottomBar() {
    return BottomBar(
      selectedIndex: _currentPage,
      showActiveBackgroundColor: true,
      onTap: (int index) {
        _pageController.jumpToPage(index);
        setState(() => _currentPage = index);
      },
      items: <BottomBarItem>[
        BottomBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: Colors.blue,
        ),
        BottomBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Wishlists'),
          activeColor: Colors.red,
          darkActiveColor: Colors.red.shade400,
        ),
        BottomBarItem(
          icon: Icon(Icons.message_sharp),
          title: Text('Inbox'),
          activeColor: Colors.greenAccent.shade700,
          darkActiveColor: Colors.greenAccent.shade400,
        ),
        BottomBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
          activeColor: Colors.orangeAccent.shade700,
          darkActiveColor: Colors.orangeAccent.shade400,
        ),
      ],
    );
  }
}
