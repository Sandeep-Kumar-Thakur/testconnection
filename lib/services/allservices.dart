import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testconnection/services/homepage.dart';
import 'package:testconnection/services/profilepage.dart';
import 'package:testconnection/services/uploadstatus.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class Allservices extends StatefulWidget {
  const Allservices({Key? key}) : super(key: key);

  @override
  _AllservicesState createState() => _AllservicesState();
}

class _AllservicesState extends State<Allservices> {
  bool home = true;
  bool profile = false;
  bool uploaderpage = false;
  int active_index = 0;

  Future Logout() async {
    Future<SharedPreferences> _sharepreference =
        SharedPreferences.getInstance();
    final SharedPreferences session = await _sharepreference;
    session.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Visibility(
          child: HomePage(),
          visible: home,
        ),
        Visibility(
          child: Uploadstatus(),
          visible: uploaderpage,
        ),
        Visibility(
          child: Profilepage(),
          visible: profile,
        ),
      ]),

      // PageView(
      //   controller: _pageController,
      //   onPageChanged: (value) {
      //     setState(() {
      //       _currentpage = value;
      //     });
      //   },
      //   children: [
      //     HomePage(),
      //     Uploadstatus(),
      //     Profilepage(),
      //   ],
      // ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeIndex: active_index,
        activeColor: Colors.white,
        icons: [Icons.home, Icons.add, Icons.person],
        iconSize: 30,
        inactiveColor: Colors.white30,
        backgroundColor:
            Color.alphaBlend(Colors.blue.shade900, Colors.lightBlueAccent),
        gapLocation: GapLocation.none,
        leftCornerRadius: 23,
        rightCornerRadius: 23,
        onTap: (index) {
          setState(() {
            active_index = index;
            if (index == 0) {
              home = true;
              profile = false;
              uploaderpage = false;
            } else if (index == 1) {
              home = false;
              profile = false;
              uploaderpage = true;
            } else if (index == 2) {
              home = false;
              profile = true;
              uploaderpage = false;
            }
          });
        },
      ),
    );
  }
}
