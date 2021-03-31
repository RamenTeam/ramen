import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameField = TextField(
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        hintText: 'Enter username'),
  );
  final passwordField = TextField(
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        hintText: 'Enter password'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/logo.png'),
          Text('Welcome to Ramen'),
          Text('Please login'),
          userNameField,
          passwordField,
        ],
      ),
    ));
  }
}
