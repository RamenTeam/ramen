import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final userNameField = Padding(
    padding: EdgeInsets.all(16.0),
    child: TextField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          hintText: 'Enter username'),
    ),
  );
  final emailField = Padding(
    padding: EdgeInsets.all(16.0),
    child: TextField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          hintText: 'Enter email'),
    ),
  );
  final passwordField = Padding(
    padding: EdgeInsets.all(16.0),
    child: TextField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          hintText: 'Enter password'),
      obscureText: true,
    ),
  );
  final confirmPasswordfField = Padding(
    padding: EdgeInsets.all(16.0),
    child: TextField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          hintText: 'confirm password'),
      obscureText: true,
    ),
  );
  final phoneField = Padding(
    padding: EdgeInsets.all(16.0),
    child: TextField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          hintText: 'Enter phone number'),
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.center,
    ),
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
          confirmPasswordfField,
          phoneField
        ],
      ),
    ));
  }
}
