import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userNameField = TextField(
    decoration: InputDecoration(
        border: OutlineInputBorder(), hintText: 'Enter username'),
  );
  final passwordField = TextField(
    decoration: InputDecoration(
        border: OutlineInputBorder(), hintText: 'Enter password'),
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
