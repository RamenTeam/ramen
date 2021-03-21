import 'package:flutter/material.dart';

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
      ),
    );
  }
}
