import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  static const String routeName = '/register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final userNameField = TextField(
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        hintText: 'Enter username'),
  );
  final emailField = TextField(
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        hintText: 'Enter email'),
  );
  final passwordField = TextField(
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        hintText: 'Enter password'),
    obscureText: true,
  );
  final reTypePasswordfField = TextField(
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        hintText: 're type password'),
    obscureText: true,
  );
  final phoneField = TextField(
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        hintText: 'Enter phone number'),
    keyboardType: TextInputType.phone,
    textAlign: TextAlign.center,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/logo.png'),
          Text('Welcome to Ramen'),
          userNameField,
          emailField,
          passwordField,
          phoneField
        ],
      ),
    ));
  }
}
