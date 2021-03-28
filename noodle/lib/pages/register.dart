import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  static const String routeName = '/register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Register'),
    );
  }
}
