import 'package:flutter/material.dart';
import 'package:noodle/src/resources/pages/home.dart';
import 'package:noodle/src/resources/pages/profile.dart';

class HomeNavigation extends StatefulWidget {
  HomeNavigation({Key key}) : super(key: key);

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int tabIndex = 0;
  final List<Widget> tabs = [
    Home(),
    Profile(),
  ];

  void onTabSelected(index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: onTabSelected,
        ),
      ),
    );
  }
}
