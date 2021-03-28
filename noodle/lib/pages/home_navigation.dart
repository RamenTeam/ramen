import 'package:flutter/material.dart';
import 'package:noodle/pages/home.dart';
import 'package:noodle/pages/profile.dart';

class HomeNavigation extends StatefulWidget {
  HomeNavigation({Key key, this.username}) : super(key: key);
  final String username;

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int tabIndex = 0;
  final List<Widget> tabs = [
    Home(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    return SafeArea(
      child: Scaffold(
        body: tabs[tabIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.yellow,
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            setState(() {
              tabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
