import 'package:flutter/material.dart';
import 'package:noodle/screens/profile.dart';
import 'package:noodle/screens/loading.dart';
import 'package:noodle/utils/route_builder.dart';

class Home extends StatefulWidget {
  Home({Key key, this.username}) : super(key: key);
  final String username;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Text('Hi $username!'),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.pushReplacement(context, getRoute(Profile()));
        //   },
        // ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'profile')
          ],
        ),
      ),
    );
  }
}
